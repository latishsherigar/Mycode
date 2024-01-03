package ftphttpbridge;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import org.apache.commons.net.PrintCommandListener;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;

import ftphttpbridge.vo.FtpRequest;

public class FtpConnection {
	FTPClient ftpClient= null;
	
	
	FtpConnection(FtpRequest ftpRequest) throws Exception{
		 ftpClient  = new FTPClient();
		ftpClient.addProtocolCommandListener(new PrintCommandListener(new PrintWriter(System.out)));
		int reply;
		ftpClient.connect(ftpRequest.getServer(),ftpRequest.getPort());
		reply = ftpClient.getReplyCode();
		if (!FTPReply.isPositiveCompletion(reply)) {
			ftpClient.disconnect();
			throw new Exception("Exception in connecting to FTP Server");
		}
		ftpClient.login(ftpRequest.getUsername(), ftpRequest.getPassword());
		ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
		ftpClient.enterLocalPassiveMode();
	}
	
	public boolean uploadFile(String localFileFullName, String fileName, String hostDir)
			throws Exception {
		try(InputStream input = new FileInputStream(new File(localFileFullName))){
		boolean resFlag = this.ftpClient.storeFile(hostDir + fileName, input);
		return resFlag;
	}
	}

	public void disconnect(){
		if (this.ftpClient.isConnected()) {
			try {
				this.ftpClient.logout();
				this.ftpClient.disconnect();
			} catch (IOException f) {
				// do nothing as file is already saved to server
			}
		}
	}
	
	
}

