package tallyattachmentemailer.config;

import javax.swing.JOptionPane;

public class Config {

	Config(){
		String data = JOptionPane.showInputDialog("Email password");
		
	}
	
	public static void main(String[] args) {
		new Config();
	}
}
