package tallyattachmentemailer;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.StringReader;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import tallyattachmentemailer.email.SMTPEmailer;
import tallyattachmentemailer.util.AESUtils;
import tallyattachmentemailer.util.HexUtils;

public class FileScanner {
 Properties appConfig = new Properties();;
	
	public FileScanner(String workingDir) throws FileNotFoundException, IOException {
		// TODO Auto-generated constructor stub

		loadAppConfig(workingDir);
		startScan();
		System.out.println("Exiting application due to an error.");
	}
	
	private void loadAppConfig(String workingDir) throws FileNotFoundException, IOException {
		File appConfigFile = new File(workingDir + File.separator + "config.ini");
		System.out.println("Loading app config file -" + appConfigFile.getAbsolutePath());

		if (appConfigFile.exists() && appConfigFile.isFile() ) {
			//this.appConfig.load(new FileReader(appConfigFile));
			this.appConfig = loadProperties(appConfigFile);
			
			encEmailPasswordInProperties(appConfigFile);
			
			
		}
	}
	
	private void encEmailPasswordInProperties(File appConfigFile) throws IOException
    {
	
		String ps ="AASASKLSJDDJ34283DSJHSDNMSDnsdfsdfn23409w";
		
		if(this.appConfig.containsKey("password_encrypted") && this.appConfig.getProperty("password_encrypted").equals("true")) {
	        System.out.println("Email password already encrypted. " );
	        //Base64.Decoder decoder = Base64.getDecoder();
	        String emailPass = 	this.appConfig.getProperty("mail.smtp.password");
	        String decPass =HexUtils.convertHexToString(emailPass);
	        this.appConfig.setProperty("mail.smtp.password",decPass);
		  	
		}else {
			String emailPass = 	this.appConfig.getProperty("mail.smtp.password");
			//Base64.Encoder encoder = Base64.getEncoder();
			//String encPass =new String( encoder.encode(emailPass.getBytes()), StandardCharsets.UTF_8);
			String encPass = HexUtils.convertStringToHex(emailPass);
			//String encPass =
			this.appConfig.setProperty("mail.smtp.password",encPass );
			this.appConfig.setProperty("password_encrypted","true" );
			

	        FileOutputStream fr = new FileOutputStream(appConfigFile.getPath() );
	        this.appConfig.store(fr, "Properties");
	        fr.close();
	        System.out.println("Email password encrypted. " );
			
		}
		
    }
	
	private void startScan() throws FileNotFoundException, IOException {
		File fScanDir = new File((String) this.appConfig.get("attachment_scan_dir"));
		
		if(fScanDir.isDirectory() && fScanDir.exists()) {
			
			String archiveDir = fScanDir.getPath() +  File.separator  +"archive";
			File fArchiveDir = new File(archiveDir);
			fArchiveDir.mkdir();
		
		while(true) {
			System.out.println("Looking for attachments in - " + fScanDir.getAbsolutePath() );
			
			SMTPEmailer objSMTPEmailer = new SMTPEmailer(this.appConfig);
			
			for(File aFile:fScanDir.listFiles()) {
				if(aFile.getName().endsWith(".ini")) {
					System.out.print("Processing " + aFile.getName() + " ..............." );
					
					Properties emailIniFileProp = new Properties();
					//emailIniFileProp.load(new FileReader(aFile));
					emailIniFileProp = loadProperties(aFile);
					
					if(objSMTPEmailer.sendemail((Map)emailIniFileProp)) {
						System.out.println("Email sent." );

						System.out.println("Archiving file - " + aFile.getName() );
						File fArchive = new File(fArchiveDir.getPath() + File.separator +  aFile.getName()); 
						aFile.renameTo(fArchive);
						fArchive.delete();
						
						
					}else {
						System.out.println("Error in emailing. Will retry later." );

					}
				}
				
			}
			
			
			
			
			sleep();
		}
		
		
		}else {
			System.out.println("Invalid Scan directory - " + fScanDir.getPath() + " .Please check configuration");
		}
		
	}
	

	
	private void sleep() {
		try {
			System.out.println("Sleeping now.");
			int poll=60000;
			
			if(this.appConfig.containsKey("poll")) {
				poll = Integer.parseInt((String) this.appConfig.get("poll")) * 1000;
			}
			
			Thread.sleep(poll);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	private Properties loadProperties(File propFile) throws IOException {
		
		BufferedReader fr = new BufferedReader(new FileReader(propFile));
		String aLine="";
		Properties newProperties = new Properties();

		while((aLine=fr.readLine())!=null) {
			aLine = aLine.replace("\\", "\\\\").trim();
			if(aLine.contains("=")) {
				String [] aLineArr = aLine.split("=");
				String key="";
				String value="";

				if(aLineArr.length>0) {
					key=aLineArr[0].trim();
				}
				if(aLineArr.length>1) {
					value=aLineArr[1].trim();
				}
				
				

				newProperties.put(key, value);
			
				
			}
		}
		
		fr.close();
		return newProperties;

		
	}

	
}
