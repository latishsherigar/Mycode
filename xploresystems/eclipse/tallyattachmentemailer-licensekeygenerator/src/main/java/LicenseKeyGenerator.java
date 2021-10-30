import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Writer;
import java.nio.file.Path;
import java.security.GeneralSecurityException;
import java.security.InvalidKeyException;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Signature;
import java.security.SignatureException;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.NoSuchPaddingException;

public class LicenseKeyGenerator {
	PublicKey publicKey;
	PrivateKey privKey ;
	private Cipher cipher;
	 Base64.Encoder encoder = Base64.getEncoder();
	 
   public static void main(String args[]) throws Exception{
	   
	   String app_package_dir = args[0];
	   
	   if(!new File(app_package_dir).isDirectory()) {
		    
		   app_package_dir=System.getProperty("user.dir");
	   }
	   
    new LicenseKeyGenerator(app_package_dir);
      
      
      
      
//      String outFile = ...;
//    Writer out = new FileWriter(outFile + ".key");
//      out.write("-----BEGIN RSA PRIVATE KEY-----\n");
//      out.write(encoder.encodeToString(privKey.getEncoded()));
//      out.write("\n-----END RSA PRIVATE KEY-----\n");
//      out.close();
      

      
       
      
      
   }
   
   public LicenseKeyGenerator(String app_package_dir ) throws IOException, GeneralSecurityException {
	   this.cipher = Cipher.getInstance("RSA");
	   generateKeyPair();
	   byte[] encryptedLicenseData = encryptLicenseData(this.privKey,app_package_dir + File.separator +  "config.ini");
	   generateLicenseKey(this.publicKey,encryptedLicenseData,app_package_dir + File.separator  +  "license.key");
   
   }
   
   private void generateKeyPair() throws NoSuchAlgorithmException {
	   
	   //Creating KeyPair generator object
	      KeyPairGenerator keyPairGen = KeyPairGenerator.getInstance("RSA");
	      
	      //Initializing the KeyPairGenerator
	      keyPairGen.initialize(1024);
	      
	      //Generating the pair of keys
	      KeyPair pair = keyPairGen.generateKeyPair();
	      
	      //Getting the private key from the key pair
	      this.privKey = pair.getPrivate();   
	      
	      
	      //Getting the public key from the key pair
	      this.publicKey = pair.getPublic(); 
	      System.out.println("Keys generated");
   }
   
   

   
   private void generateLicenseKey(PublicKey publicKey,byte[] encryptedLicenseData,String licenseKey) throws IOException {
	  
	   
	   File f = new File(licenseKey);
		FileOutputStream fos = new FileOutputStream(f);
		f.getParentFile().mkdirs();

		fos.write(publicKey.getEncoded());
	    fos.flush();
		fos.close();
		
	    f = new File(licenseKey + ".bin");
	    fos = new FileOutputStream(f);
		f.getParentFile().mkdirs();

		fos.write(encryptedLicenseData);
	    fos.flush();
		fos.close();
		
   }
   
	private byte[] encryptLicenseData(PrivateKey key,String licenseDataFile) throws IOException, GeneralSecurityException {

		byte[] input = getFileInBytes(new File(licenseDataFile));
		this.cipher.init(Cipher.ENCRYPT_MODE, key);
		return cipher.doFinal(input);
		}
	
	public byte[] getFileInBytes(File f) throws IOException {
		FileInputStream fis = new FileInputStream(f);
		byte[] fbytes = new byte[(int) f.length()];
		fis.read(fbytes);
		fis.close();
		return fbytes;
	}

   

   
}