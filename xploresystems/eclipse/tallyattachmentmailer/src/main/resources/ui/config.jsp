<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.InputStream" %>
<%@page import="java.util.Properties" %>
<%@page import="org.apache.commons.codec.binary.Hex" %>
<%@page import="java.nio.charset.StandardCharsets" %>
<%@page import="java.io.File" %>




    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tally attachment emailer</title>

<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
th, td {
  padding: 15px;
}

tr {
  border-bottom: 1px solid #ddd;
}

#overlay {
  position: fixed;
  display: none;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0,0,0,0.5);
  z-index: 2;
  cursor: pointer;
}

#text{
  position: absolute;
  top: 50%;
  left: 50%;
  font-size: 30px;
  color: white;
  transform: translate(-50%,-50%);
  -ms-transform: translate(-50%,-50%);
}
</style>
</head>

<%
   // InputStream stream = application.getResourceAsStream();
ServletContext context =   getServletContext();
String application_dir = (String)context.getAttribute("application_dir");
    Properties props = new Properties();
    

    String email="";
    String password="";
    String emailFromName="";
    String attachmentdir="";
    String poll="10";
    String smtpHost="";
    String smtpPort="";
    String smtpTlsEnable="";
    String sslFlag="";
    String authFlag="";
	String submit="";
	boolean propertiesSaved = false;
    
	String configFilePath = application_dir + File.separator + "config.ini";
	if(new File(configFilePath).exists()){
	    props.load(new FileReader(configFilePath));
	    
	    email = (String)props.get("mail.smtp.username");
	    password = (String)props.get("mail.smtp.password");
	    emailFromName = (String)props.get("mail.smtp.fromName");
	    attachmentdir = (String)props.get("attachment_scan_dir");
	    poll = (String)props.get("poll");
	    smtpHost = (String)props.get("mail.smtp.host");
	    smtpPort = (String)props.get("mail.smtp.port");
	    smtpTlsEnable = (String) props.get("mail.smtp.starttls.enable");
	    sslFlag = (String)props.get("mail.smtp.sslflag");
	    authFlag = (String)props.get("mail.smtp.auth");
	    
	}

    submit = request.getParameter("btnSubmit");
    if(submit!=null && submit.equals("Save")){

    	email = request.getParameter("txtEmail");
	  
    	password = request.getParameter("txtpassword");
    	 char[] chars = Hex.encodeHex(password.getBytes(StandardCharsets.UTF_8));
    	 password = String.valueOf(chars);
    	 
    	emailFromName = request.getParameter("txtemailFromName");
    	 
    	attachmentdir = request.getParameter("txtattachmentDir");
    	poll = request.getParameter("txtPoll");
    	smtpHost = request.getParameter("txtSmtpHost");
    	smtpPort = request.getParameter("txtSmtpPort");
    	smtpTlsEnable = request.getParameter("txtTlsEnable");
    	sslFlag = request.getParameter("txtSSL");
    	authFlag = request.getParameter("txtAuth");
    	
    	
		props.setProperty("mail.smtp.username", email) ;   	
		props.setProperty("mail.smtp.password", password) ;   
		props.setProperty("mail.smtp.fromName", emailFromName) ;   
		props.setProperty("attachment_scan_dir", attachmentdir) ;   	
		props.setProperty("poll", poll) ;   	
		props.setProperty("mail.smtp.host", smtpHost) ;   	
		props.setProperty("mail.smtp.port", smtpPort) ;   	
		props.setProperty("mail.smtp.starttls.enable", smtpTlsEnable) ;   	
		props.setProperty("mail.smtp.sslflag", sslFlag) ;   	
		props.setProperty("mail.smtp.auth", authFlag) ;   	
		props.setProperty("password_encrypted", "true") ;   	
		
		
		props.store(new FileOutputStream(configFilePath), "Saved");
		propertiesSaved = true;
		
    	
    }
    
    
%>
<body 
<% if(propertiesSaved){ %>
	onload="on()" 
<% 	
	}
	%>

 >

<h3 align="center">Quiksign config</h3>
<form  method="post" action="config.jsp">
<table align="center" >
<colgroup>
    <col span="1" style="background-color: #c7eaff">
  </colgroup>
	<tr><th width=300>Email</th><td ><input name="txtEmail" size="50" type="text" value="<%=email%>"/></td></tr>
	<tr><th width=300>Password</th><td><input name="txtpassword"  size="50" type="password" value="<%=password%>"/></td></tr>
	<tr><th width=300>From name</th><td><input name="txtemailFromName"  size="50" type="text" value="<%=emailFromName%>"/></td></tr>
	<tr><th width=300>Attachment scan directory</th><td><input name="txtattachmentDir"  size="50" type="text" value="<%=attachmentdir%>"/></td></tr>
	<tr><th width=300>Poll time (sec)</th><td><input name="txtPoll"  size="50" type="number" value="<%=poll%>"/></td></tr>
</table>
<p align="center">SMTP</p>
<table align="center">
	<tr><td width=300><b>Host</b> (e.g smtp.gmail.com)</th><td><input name="txtSmtpHost"  type="text" value="<%=smtpHost%>"/></td></tr>
	<tr><td width=300><b>Port</b> (e.g 587)</th><td><input name="txtSmtpPort"  type="number" value="<%=smtpPort%>"/></td></tr>
	<tr><td width=300><b>TLS</b> Enable (true/false)</th><td><input name="txtTlsEnable"  type="text" value="<%=smtpTlsEnable%>"/></td></tr>
	<tr><td width=300><b>SSL</b> (e.g TLS)</th><td><input type="text" name="txtSSL"  value="<%=sslFlag%>"/></td></tr>
	<tr><td width=300><b>Auth</b> (true/false)</th><td><input type="text" name="txtAuth"  value="<%=authFlag%>"/></td></tr>
</table>

<p/>
<div align="center" > <input name="btnSubmit" style="height:50px;width:100px" type="submit" value="Save"> </> </div>
</form>

<div id="overlay" align="center"  onclick="off()">
  <div id="text">Configuration updated</div>
</div>

<script>
function on() {
  document.getElementById("overlay").style.display = "block";
}

function off() {
  document.getElementById("overlay").style.display = "none";
}


</script>

</body>
</html>