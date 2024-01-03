package licensing;

public class LicenseException extends Exception{

	public LicenseException(String expmsg) {
		// TODO Auto-generated constructor stub
		
		System.out.println("License error - " + expmsg);
		System.exit(0);
	}
	
}
