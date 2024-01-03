package licensing;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.security.GeneralSecurityException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
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

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class AppLicense {

	private Cipher cipher;
	Base64.Decoder decoder = Base64.getDecoder();
	private byte[] appByteData = null;
	String appFile;

	public byte[] getAppByteData() {
		return appByteData;
	}

	public void setAppByteData(byte[] appByteData) {
		this.appByteData = appByteData;
	}

	public AppLicense(String workingDir,String appFile) throws Exception {
		this.cipher = Cipher.getInstance("RSA");
		this.appFile = appFile;

		File licenseFile = new File(workingDir + File.separator + "license.key");
		String licenseDataFilePath = workingDir + File.separator + "license.key.bin";
		File licenseDataFileEnc = new File(licenseDataFilePath);

		if (licenseFile.exists() && licenseFile.isFile() && licenseDataFileEnc.exists()
				&& licenseDataFileEnc.isFile()) {

			PublicKey publicKey = getPublicKey(licenseFile.getPath());

			if (readLicenseData(licenseDataFilePath, publicKey)) {
				//byte[] app = decryptDataFile(workingDir + File.separator + "app.data",
				//		workingDir + File.separator + ".a", publicKey);
				String appDataFile = workingDir + File.separator + appFile;
				byte[] app = doDecryptRSAWithAES(publicKey,appDataFile).toByteArray();
				
				setAppByteData(app);

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

	/*
	 * public String decryptText(String msg, PublicKey publickKey) throws
	 * InvalidKeyException, UnsupportedEncodingException, IllegalBlockSizeException,
	 * BadPaddingException { this.cipher.init(Cipher.DECRYPT_MODE, publickKey);
	 * return new String(cipher.doFinal(decoder.decode(msg)), "UTF-8"); }
	 * 
	 * private byte[] decryptDataFile(String inputFile, String outputFile, PublicKey
	 * publickey) throws IOException, InvalidKeyException,
	 * IllegalBlockSizeException, BadPaddingException {
	 * 
	 * byte[] input = getFileInBytes(new File(inputFile));
	 * this.cipher.init(Cipher.DECRYPT_MODE, publickey); // String decText = new
	 * String(cipher.doFinal(input));
	 * 
	 * // byte[] input = getFileInBytes(new File(dataFile));
	 * 
	 * int byteCount2Copy = 128; byte[] output = new byte[0]; int inputPointer = 0;
	 * int loopCount = input.length / byteCount2Copy; int remainderByteCount =
	 * input.length % byteCount2Copy; for (int i = 0; i <= loopCount; ++i) { if (i
	 * == loopCount) { byteCount2Copy = remainderByteCount; }
	 * 
	 * if (byteCount2Copy > 0) { byte[] opArr = decryptBytesFromInput(input,
	 * byteCount2Copy, inputPointer); inputPointer = inputPointer + byteCount2Copy;
	 * output = ArrayUtils.addAll(output, opArr);
	 * 
	 * } }
	 * 
	 * // byte[] opArr =
	 * decryptBytesFromInput(input,remainderByteCount,inputPointer); // output =
	 * ArrayUtils.addAll(output, opArr);
	 * 
	 * // writeToFile(fOp, output); return output;
	 * 
	 * }
	 * 
	 *///	private byte[] decryptBytesFromInput(byte[] input, int byteCount2Copy, int startPosition)
//			throws IllegalBlockSizeException, BadPaddingException {
//		byte[] ipArr = new byte[byteCount2Copy];
//		for (int j = 0; j < ipArr.length; ++j) {
//			ipArr[j] = input[startPosition];
//			++startPosition;
//		}
//
//		return cipher.doFinal(ipArr);
//
//	}

	private boolean readLicenseData(String inputFile, PublicKey publickey)
			throws IOException, GeneralSecurityException, ParseException {

		boolean lic = false;

		
		byte[] decBytes = doDecryptRSAWithAES(publickey,inputFile).toByteArray();
		String decText = new String(decBytes);

		Map<String, String> mpLicenseData = loadLicenseData(decText);
		String strlicexpdate;
		strlicexpdate = mpLicenseData.get("license.expirydate");

		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Date dtlicexpDate = sdf.parse(strlicexpdate);

		if (new Date().before(dtlicexpDate)) {
			lic = true;

			
			System.out.println("Product: " + this.appFile);
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

//	public byte[] getFileInBytes(File f) throws IOException {
//		FileInputStream fis = new FileInputStream(f);
//		byte[] fbytes = new byte[(int) f.length()];
//		fis.read(fbytes);
//		fis.close();
//		return fbytes;
//	}

//	private void writeToFile(File output, byte[] toWrite)
//			throws IllegalBlockSizeException, BadPaddingException, IOException {
//		FileOutputStream fos = new FileOutputStream(output);
//		fos.write(toWrite);
//		fos.flush();
//		fos.close();
//	}

	private ByteArrayOutputStream doDecryptRSAWithAES(PublicKey pub, String inputFile)
			throws FileNotFoundException, IOException, NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, IllegalBlockSizeException, BadPaddingException, InvalidAlgorithmParameterException

	{

		int index = 0;

		FileInputStream in = new FileInputStream(inputFile);
		SecretKeySpec skey = null;

		Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
		cipher.init(Cipher.DECRYPT_MODE, pub);
		byte[] b = new byte[256];
		in.read(b);
		byte[] keyb = cipher.doFinal(b);
		skey = new SecretKeySpec(keyb, "AES");

		byte[] iv = new byte[128 / 8];
		in.read(iv);
		IvParameterSpec ivspec = new IvParameterSpec(iv);

		Cipher ci = Cipher.getInstance("AES/CBC/PKCS5Padding");
		ci.init(Cipher.DECRYPT_MODE, skey, ivspec);

		ByteArrayOutputStream out = new ByteArrayOutputStream();

		processFile(ci, in, out);
		
		

	return out;

	}

	private void processFile(Cipher ci, InputStream in, OutputStream out)
			throws javax.crypto.IllegalBlockSizeException, javax.crypto.BadPaddingException, java.io.IOException {
		byte[] ibuf = new byte[1024];
		int len;
		while ((len = in.read(ibuf)) != -1) {
			byte[] obuf = ci.update(ibuf, 0, len);
			if (obuf != null)
				out.write(obuf);
		}
		byte[] obuf = ci.doFinal();
		if (obuf != null)
			out.write(obuf);
	}
}
