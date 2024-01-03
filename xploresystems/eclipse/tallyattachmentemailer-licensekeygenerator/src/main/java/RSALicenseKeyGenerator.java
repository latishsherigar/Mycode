import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.util.Base64;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;

import org.apache.commons.lang3.ArrayUtils;

public class RSALicenseKeyGenerator {
	PublicKey publicKey;
	PrivateKey privKey ;
	private Cipher cipher;
	 Base64.Encoder encoder = Base64.getEncoder();
	 
   public static void main(String args[]) throws Exception{
	   
	   String app_package_dir =System.getProperty("user.dir");
	   
	   ///home/latish/tally_attachment_emailer
	   if( args.length > 0) {
		   app_package_dir = args[0];   
	   }
	   
	   
    new RSALicenseKeyGenerator(app_package_dir);
      
      
      
      
//      String outFile = ...;
//    Writer out = new FileWriter(outFile + ".key");
//      out.write("-----BEGIN RSA PRIVATE KEY-----\n");
//      out.write(encoder.encodeToString(privKey.getEncoded()));
//      out.write("\n-----END RSA PRIVATE KEY-----\n");
//      out.close();
      

      
       
      
      
   }
   
   public RSALicenseKeyGenerator(String app_package_dir ) throws IOException, GeneralSecurityException {
	   this.cipher = Cipher.getInstance("RSA");
	   generateKeyPair();

	   System.out.print("Creating license file.............");
	   byte[] encryptedLicenseData = encryptDataFile(this.privKey,app_package_dir + File.separator +  "config.ini");
	   generateLicenseKey(this.publicKey,encryptedLicenseData,app_package_dir + File.separator  + "package" + File.separator + "license.key");
	   System.out.println("Done");
	   
	   for(File f: new File(app_package_dir + File.separator +  "artifacts").listFiles()) {
		   System.out.println("Creating encrypted app file.......... " + f.getName());
		   byte[] encryptedAppData = encryptDataFile(this.privKey,f.getCanonicalPath());
		   createEncryptedAppFile(app_package_dir + File.separator + "package" + File.separator + f.getName() + ".app",encryptedAppData);
		   
	   }
	   
	   System.out.println("Done");
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
	   f.getParentFile().mkdirs();
		FileOutputStream fos = new FileOutputStream(f);
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
   
private void createEncryptedAppFile( String appFile, byte[] encryptedLicenseData) throws IOException {
	  
	   


	    File f = new File(appFile);
	    f.getParentFile().mkdirs();
	    FileOutputStream fos = new FileOutputStream(f);
		

		fos.write(encryptedLicenseData);
	    fos.flush();
		fos.close();
		

}
  
   
	private byte[] encryptDataFile(PrivateKey key,String dataFile) throws IOException, GeneralSecurityException {

		byte[] input = getFileInBytes(new File(dataFile));
		this.cipher.init(Cipher.ENCRYPT_MODE, key);

		int byteCount2Copy =117;
		byte[] output=new byte[0];
		int inputPointer =0;
		int loopCount = input.length /byteCount2Copy;
		int remainderByteCount = input.length % byteCount2Copy;
		for( int i =0; i< loopCount;++i) {
			//System.out.println(i);
			byte[] opArr = encryptBytesFromInput(input,byteCount2Copy,inputPointer);
			inputPointer = inputPointer + byteCount2Copy ;
			output = ArrayUtils.addAll(output, opArr);
		}
		
		byte[] opArr = encryptBytesFromInput(input,remainderByteCount,inputPointer);
		output = ArrayUtils.addAll(output, opArr);
	
		return output;
		
//		return cipher.doFinal(input);
		}
	
	private byte[] encryptBytesFromInput(byte[] input,int byteCount2Copy,int startPosition) throws IllegalBlockSizeException, BadPaddingException {
		byte[] ipArr = new byte[byteCount2Copy];
		for(int j=0;j<ipArr.length;++j) {
			ipArr[j] = input[startPosition];
			++ startPosition;
		}
		
		return cipher.doFinal(ipArr);
		
	}
	
	public byte[] getFileInBytes(File f) throws IOException {
		FileInputStream fis = new FileInputStream(f);
		byte[] fbytes = new byte[(int) f.length()];
		fis.read(fbytes);
		fis.close();
		return fbytes;
	}

   

   
}