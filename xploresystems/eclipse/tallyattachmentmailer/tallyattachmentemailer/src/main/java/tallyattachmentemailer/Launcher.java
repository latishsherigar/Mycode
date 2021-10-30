package tallyattachmentemailer;

import tallyattachmentemailer.licensing.AppLicense;

public class Launcher {

	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		String workingDir="";

		if(args.length > 0) {
			workingDir = args[0];
		}else {
			workingDir = System.getProperty("user.dir");
		}
		
		new AppLicense(workingDir);
		
		
		new FileScanner(workingDir);
		
		
	}

}
