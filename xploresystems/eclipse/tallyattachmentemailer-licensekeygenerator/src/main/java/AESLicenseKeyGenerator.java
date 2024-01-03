import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.GeneralSecurityException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.SecureRandom;
import java.util.Base64;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;

public class AESLicenseKeyGenerator {
	PublicKey publicKey;
	PrivateKey privKey;
	private Cipher cipher;
	Base64.Encoder encoder = Base64.getEncoder();
	static SecureRandom srandom = new SecureRandom();

	public static void main(String args[]) throws Exception {

		String app_package_dir = System.getProperty("user.dir");

		///home/latish/tally_attachment_emailer
		if (args.length > 0) {
			app_package_dir = args[0];
		}

		new AESLicenseKeyGenerator(app_package_dir);


	}

	public AESLicenseKeyGenerator(String app_package_dir) throws IOException, GeneralSecurityException {
		this.cipher = Cipher.getInstance("RSA");
		generateKeyPair();

		System.out.print("Creating license file.............");

  	    String licenseKeyFilePath = app_package_dir + File.separator + "package" + File.separator + "license.key";		
		generateLicenseKey(this.publicKey, licenseKeyFilePath	);
		
		System.out.println("Done");

		System.out.print("Saving license data.............");

		String inputLicDataFile=app_package_dir + File.separator + "config.ini";
		String outputLicDataFile = app_package_dir + File.separator + "package" + File.separator + "license.key.bin";
		doEncryptRSAWithAES(this.privKey,inputLicDataFile,outputLicDataFile);
		
		System.out.println("Done");

		
		   for(File f: new File(app_package_dir + File.separator +  "artifacts").listFiles()) {
			   System.out.println("Creating encrypted app file.......... " + f.getName());
				String inputAppFile=f.getAbsolutePath() ;
				String outputAppFile = app_package_dir + File.separator + "package" + File.separator + f.getName() + ".app";
				doEncryptRSAWithAES(this.privKey,inputAppFile,outputAppFile);
			   
		   }

		
		System.out.println("Done");
	}

	private void generateKeyPair() throws NoSuchAlgorithmException {

		// Creating KeyPair generator object
		KeyPairGenerator keyPairGen = KeyPairGenerator.getInstance("RSA");

		// Initializing the KeyPairGenerator
		keyPairGen.initialize(2048);

		// Generating the pair of keys
		KeyPair pair = keyPairGen.generateKeyPair();

		// Getting the private key from the key pair
		this.privKey = pair.getPrivate();

		// Getting the public key from the key pair
		this.publicKey = pair.getPublic();
		System.out.println("Keys generated");
	}

	private void generateLicenseKey(PublicKey publicKey, String licenseKeyFilePath)
			throws IOException {

		File f = new File(licenseKeyFilePath);
		f.getParentFile().mkdirs();
		FileOutputStream fos = new FileOutputStream(f);
		fos.write(publicKey.getEncoded());
		fos.flush();
		fos.close();



	}


	private void doEncryptRSAWithAES(PrivateKey pvt, String inputFile,String outFile) throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException, IOException, InvalidAlgorithmParameterException  {

		int index = 0;

		KeyGenerator kgen = KeyGenerator.getInstance("AES");
		kgen.init(128);
		SecretKey skey = kgen.generateKey();

		byte[] iv = new byte[128 / 8];
		srandom.nextBytes(iv);
		IvParameterSpec ivspec = new IvParameterSpec(iv);

		FileOutputStream out = new FileOutputStream(outFile);

		Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
		cipher.init(Cipher.ENCRYPT_MODE, pvt);
		byte[] b = cipher.doFinal(skey.getEncoded());
		out.write(b);
		//System.out.println("AES Key Length: " + b.length);

		out.write(iv);
		//System.out.println("IV Length: " + iv.length);

		Cipher ci = Cipher.getInstance("AES/CBC/PKCS5Padding");
		ci.init(Cipher.ENCRYPT_MODE, skey, ivspec);
		FileInputStream in = new FileInputStream(inputFile);
		processFile(ci, in, out);

		out.flush();
		out.close();
		in.close();

		


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