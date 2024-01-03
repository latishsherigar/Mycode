package tallyattachmentemailer;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.internet.MimeBodyPart;

import tallyattachmentemailer.email.SMTPEmailer;
import tallyattachmentemailer.ui.server.UIServer;
import tallyattachmentemailer.util.HexUtils;
import tallyattachmentemailer.util.log.Logger;

public class FileScanner {
 Properties appConfig = new Properties();;
	
 	public static void main(String[] args) throws FileNotFoundException, IOException, InterruptedException {
 		
 		String workingDir="";

		if(args.length > 0) {
			workingDir = args[0];
		}else {
			workingDir = System.getProperty("workingDir");
		}
		
		System.out.println("Working directory - " +  System.getProperty("workingDir"));
		
		final String threadWorkingDir = workingDir;

		
		
		Thread thread = new Thread(){
		    public void run(){
		    	try {
		    		//System.out.println("Starting UI service...");
					UIServer objUiServer = new UIServer(threadWorkingDir);
					

			        
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		    }
		  };

		  thread.start();	
		
		
 	 new FileScanner(workingDir);	
 	}
 
	public FileScanner(String workingDir) throws FileNotFoundException, IOException, InterruptedException {
		// TODO Auto-generated constructor stub
		//Logger objLogger = new Logger(workingDir + File.separator + "app.log");
		Logger.init(workingDir + File.separator + "logs",true );
		if(loadAppConfig(workingDir)) {
			startScan();
			Logger.writeToFile("Exiting application due to an error.");
		}
	}
	
	private boolean loadAppConfig(String workingDir) throws FileNotFoundException, IOException, InterruptedException {

		File appConfigFile = new File(workingDir + File.separator + "config.ini");
		boolean appConfigFound = false;
		
		while(!appConfigFound) {
			
			if(appConfigFile.exists()) {
				Logger.writeToFile("Loading app config file -" + appConfigFile.getAbsolutePath());

				if (appConfigFile.exists() && appConfigFile.isFile() ) {
					//this.appConfig.load(new FileReader(appConfigFile));
					this.appConfig = loadProperties(appConfigFile);
					
					encEmailPasswordInProperties(appConfigFile);
					
					return true;
				}
				
			}else {
				
				Logger.writeToFile("Missing app config file -" + appConfigFile.getAbsolutePath());
				Logger.writeToFile("Please open the link to configure - http://localhost:8090/config.jsp");
				Thread.sleep(2000);
			}
			
		}
		
		
		return false;
		
	}
	
	private void encEmailPasswordInProperties(File appConfigFile) throws IOException
    {
	
		String ps ="AASASKLSJDDJ34283DSJHSDNMSDnsdfsdfn23409w";
		
		if(this.appConfig.containsKey("password_encrypted") && this.appConfig.getProperty("password_encrypted").equals("true")) {
	        Logger.writeToFile("Email password already encrypted. " );
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
	        Logger.writeToFile("Email password encrypted. " );
			
		}
		
    }
	
	private void startScan() throws FileNotFoundException, IOException {
		File fScanDir = new File((String) this.appConfig.get("attachment_scan_dir"));
		String config_fromName = "";
		
		
		if(this.appConfig.containsKey("mail.smtp.fromName")) {
			 config_fromName = (String)this.appConfig.get("mail.smtp.fromName");
		}
		
		if(fScanDir.isDirectory() && fScanDir.exists()) {
			
			String archiveDir = fScanDir.getPath() +  File.separator  +"archive";
			File fArchiveDir = new File(archiveDir);
			fArchiveDir.mkdir();
		
		while(true) {
			Logger.writeToFile("Looking for attachments in - " + fScanDir.getAbsolutePath() );
			
			SMTPEmailer objSMTPEmailer = new SMTPEmailer(this.appConfig);
			
			for(File aFile:fScanDir.listFiles()) {
				if(aFile.getName().endsWith(".ini")) {
					Logger.writeToFile("Processing " + aFile.getName() + " ..............." );
					
					Properties emailIniFileProp = new Properties();
					//emailIniFileProp = loadProperties(aFile);
					emailIniFileProp = loadTallyINI(aFile);
					emailIniFileProp.put("from", config_fromName);
					
					if(objSMTPEmailer.sendemail(renameFilesIfRequired((Map)emailIniFileProp))) {
						Logger.writeToFile("Email sent." );

						Logger.writeToFile("Archiving file - " + aFile.getName() );
						File fArchive = new File(fArchiveDir.getPath() + File.separator +  aFile.getName()); 
						aFile.renameTo(fArchive);
						fArchive.delete();
						
						
					}else {
						Logger.writeToFile("Error in emailing. Will retry later." );

					}
				}
				
			}
			
			
			
			
			sleep();
		}
		
		
		}else {
			Logger.writeToFile("Invalid Scan directory - " + fScanDir.getPath() + " .Please check configuration");
		}
		
	}
	

private Map renameFilesIfRequired(Map<String, String> emailMap) {
	File fAttachment;	
	String fileName;
	Map<String, String> newEmailMap = new HashMap();
	
	newEmailMap = emailMap;
	
	for (String key : emailMap.keySet()) {
		if (key.startsWith("file")) {

			if(emailMap.get(key).indexOf(",") > 0) {
				fileName = emailMap.get(key).split(",")[0];
				String newFileName = emailMap.get(key).split(",")[1];
				fAttachment = new File(fileName);
				File newFile = new File(fAttachment.getParent() + File.separator +  newFileName );
				fAttachment.renameTo(newFile);
				newEmailMap.put(key, newFile.getAbsolutePath());
				
			}else {
				fileName = emailMap.get(key);
				newEmailMap.put(key, fileName);
			}
			
			

		}
	}
	return newEmailMap;
	
	
}
	
	
	private void sleep() {
		try {
			Logger.writeToFile("Sleeping now.");
			int poll=60000;
			
			if(this.appConfig.containsKey("poll")) {
				poll = Integer.parseInt((String) this.appConfig.get("poll")) * 1000;
			}
			
			Thread.sleep(poll);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
			Logger.writeToFile(e);
		}
		
	}
	
	
	
	private Properties loadProperties(File propFile) throws IOException {

	
		BufferedReader fr = new BufferedReader(new FileReader(propFile));
		String aLine="";
		
		Properties newProperties = new Properties();
		newProperties.load(fr);
		return newProperties;
		
		
	}

	
	private Properties loadTallyINI(File propFile) throws IOException {

		
		BufferedReader fr = new BufferedReader(new FileReader(propFile));
		String aLine="";
		

		Properties newProperties = new Properties();
		String lastkey ="";
		String lastKeyVal="";

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
				
				//FIX THE FILE NAME KEY
				if(key.startsWith("file")) {
					Double rndnumber = Math.random()*1000; 
					key = key +  rndnumber.toString();
				}
				

				newProperties.put(key, value);
				lastkey = key;
				lastKeyVal = value;
			
				
			}else {
				//this is a multiline text of the previous key
				lastKeyVal = lastKeyVal + System.lineSeparator() + aLine;
				newProperties.put(lastkey, lastKeyVal);
				
			}
		}
		
		fr.close();
		return newProperties;

	
	}
	
}
