package tallyattachmentemailer.email;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import java.io.File;
import java.util.Map;
import java.util.Properties;

public class SMTPEmailer {

	Session session = null;

	public SMTPEmailer(Properties propConfig) {
		final String username = propConfig.getProperty("mail.smtp.username");
		final String password = propConfig.getProperty("mail.smtp.password");

		Properties prop = new Properties();
		prop.put("mail.smtp.host", propConfig.getProperty("mail.smtp.host"));
		prop.put("mail.smtp.port", propConfig.getProperty("mail.smtp.port"));
		prop.put("mail.smtp.auth", propConfig.getProperty("mail.smtp.auth"));
		prop.put("mail.smtp.starttls.enable", propConfig.getProperty("mail.smtp.starttls.enable")); // TLS

		this.session = Session.getInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

	}

	public boolean sendemail(Map<String, String> emailMap) {
		boolean email_sent = false;
		try {

			Message message = new MimeMessage(this.session);
			// message.setFrom(new InternetAddress(emailMap.get("from")));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailMap.get("to")));
			message.setRecipients(Message.RecipientType.CC, InternetAddress.parse(emailMap.get("cc")));
			message.setSubject(emailMap.get("subject"));
			// message.setText(emailMap.get("body"));

			// Create the message part
			BodyPart messageBodyPart = new MimeBodyPart();

			// Now set the actual message
			messageBodyPart.setText(emailMap.get("body"));

			// Create a multipar message
			Multipart multipart = new MimeMultipart();

			// Set text message part
			multipart.addBodyPart(messageBodyPart);

			// Part two is attachment

			for (String key : emailMap.keySet()) {
				if (key.startsWith("file")) {

					File fAttachment = new File(emailMap.get(key));
					
					if(fAttachment.exists() && fAttachment.isFile()) {
						messageBodyPart = new MimeBodyPart();
						String filename = fAttachment.getName() ;
						DataSource source = new FileDataSource(fAttachment.getPath());
						messageBodyPart.setDataHandler(new DataHandler(source));
						messageBodyPart.setFileName(filename);
						multipart.addBodyPart(messageBodyPart);
					}else {
						System.out.println("Error in attaching file - " + fAttachment.getPath() + " ........... Skipping this file");
					}
					

				}
			}

			// Send the complete message parts
			message.setContent(multipart);

			Transport.send(message);

			email_sent = true;

		} catch (MessagingException e) {
			e.printStackTrace();
			email_sent = false;
		}
		return email_sent;
	}

}