package ftphttpbridge.vo;

public class FtpRequest {
private String server;
private String username;
private String password;
private int port;
private String remoteFileName;
private String remoteDirectoryPath;
private String localFilePath;



public String getServer() {
	return server;
}
public void setServer(String server) {
	this.server = server;
}
public String getUsername() {
	return username;
}
public void setUsername(String username) {
	this.username = username;
}
public String getPassword() {
	return password;
}
public void setPassword(String password) {
	this.password = password;
}
public int getPort() {
	return port;
}
public void setPort(int port) {
	this.port = port;
}
public String getRemoteFileName() {
	return remoteFileName;
}
public void setRemoteFileName(String remoteFileName) {
	this.remoteFileName = remoteFileName;
}
public String getRemoteDirectoryPath() {
	return remoteDirectoryPath;
}
public void setRemoteDirectoryPath(String remoteDirectoryPath) {
	this.remoteDirectoryPath = remoteDirectoryPath;
}
public String getLocalFilePath() {
	return localFilePath;
}
public void setLocalFileName(String localFilePath) {
	this.localFilePath = localFilePath;
}
	
}
