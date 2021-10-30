package tallyattachmentemailer.licensing;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.security.GeneralSecurityException;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;

public class AppLicense {

	private Cipher cipher;
	Base64.Decoder decoder = Base64.getDecoder();

	public AppLicense(String workingDir) throws Exception {
		this.cipher = Cipher.getInstance("RSA");

		File licenseFile = new File(workingDir + File.separator  + "license.key");
		File licenseDataFileEnc = new File(workingDir + File.separator  + "license.key.bin");
		File licenseDataFile = new File(workingDir + File.separator + "info.txt");

		if (licenseFile.exists() && licenseFile.isFile() && licenseDataFileEnc.exists()
				&& licenseDataFileEnc.isFile()) {

			PublicKey publicKey = getPublicKey(licenseFile.getPath());

			if (readLicenseData(licenseDataFileEnc, licenseDataFile, publicKey)) {

			} else {
				throw new LicenseException("License expired.");
			}

		} else {
			throw new LicenseException("License key missing");
		}

	}

	// https://docs.oracle.com/javase/8/docs/api/java/security/spec/PKCS8EncodedKeySpec.html
	public PrivateKey getPrivate(String filename) throws Exception {
		byte[] keyBytes = Files.readAllBytes(new File(filename).toPath());
		PKCS8EncodedKeySpec spec = new PKCS8EncodedKeySpec(keyBytes);
		KeyFactory kf = KeyFactory.getInstance("RSA");
		return kf.generatePrivate(spec);
	}

// https://docs.oracle.com/javase/8/docs/api/java/security/spec/X509EncodedKeySpec.html
	private PublicKey getPublicKey(String publicKeyFile) throws Exception {
		byte[] keyBytes = Files.readAllBytes(new File(publicKeyFile).toPath());
		X509EncodedKeySpec spec = new X509EncodedKeySpec(keyBytes);
		KeyFactory kf = KeyFactory.getInstance("RSA");
		return kf.generatePublic(spec);
	}

	public String decryptText(String msg, PublicKey publickKey)
			throws InvalidKeyException, UnsupportedEncodingException, IllegalBlockSizeException, BadPaddingException {
		this.cipher.init(Cipher.DECRYPT_MODE, publickKey);
		return new String(cipher.doFinal(decoder.decode(msg)), "UTF-8");
	}

	public boolean readLicenseData(File inputFile, File output, PublicKey publickey)
			throws IOException, GeneralSecurityException, ParseException {

		boolean lic = false;

		byte[] input = getFileInBytes(inputFile);
		this.cipher.init(Cipher.DECRYPT_MODE, publickey);
		String decText = new String(cipher.doFinal(input));

		Map<String, String> mpLicenseData = loadLicenseData(decText);
		String strlicexpdate;
		strlicexpdate = mpLicenseData.get("license.expirydate");

		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Date dtlicexpDate = sdf.parse(strlicexpdate);

		if (new Date().before(dtlicexpDate)) {
			lic = true;

			System.out.println("This product is licensed to " + mpLicenseData.get("license.owner"));
			System.out.println("License valid till " + strlicexpdate);
		}
		return lic;

	}

	public Map<String, String> loadLicenseData(String decText) {
		Map<String, String> attributeMap = new HashMap<String, String>();
		String attributeKeyVal = "";

		for (int i = 0; i < decText.length(); ++i) {
			String stringChar = decText.substring(i, i + 1);
			if (!stringChar.equals("\n")) {
				attributeKeyVal = attributeKeyVal + stringChar;
			} else {
				String[] attributeKeyValArr = attributeKeyVal.split("=");
				attributeMap.put(attributeKeyValArr[0].trim(), attributeKeyValArr[1].trim());
				attributeKeyVal = "";
			}

		}
		return attributeMap;
	}

	public byte[] getFileInBytes(File f) throws IOException {
		FileInputStream fis = new FileInputStream(f);
		byte[] fbytes = new byte[(int) f.length()];
		fis.read(fbytes);
		fis.close();
		return fbytes;
	}

	private void writeToFile(File output, byte[] toWrite)
			throws IllegalBlockSizeException, BadPaddingException, IOException {
		FileOutputStream fos = new FileOutputStream(output);
		fos.write(toWrite);
		fos.flush();
		fos.close();
	}

}
