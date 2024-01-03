package ftphttpbridge;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import ftphttpbridge.vo.FtpRequest;

@RestController
@RequestMapping("/ftphttpbridge")
public class FtpController {
	
	@PostMapping(value = "/upload", consumes = {MediaType.APPLICATION_JSON_VALUE})
	    public ResponseEntity<String> uploadFile(@RequestBody FtpRequest ftpRequest) {
	    boolean successFlag = false;
	    FtpConnection ftpConnection = null;
		try {
			ftpConnection = new FtpConnection(ftpRequest);
			successFlag= ftpConnection.uploadFile(ftpRequest.getLocalFilePath(), ftpRequest.getRemoteFileName(), ftpRequest.getRemoteDirectoryPath());
			 
			
		}catch(Exception e) {
			successFlag= false;
			 e.printStackTrace();
		}finally {
			
			if(ftpConnection!=null) {
				ftpConnection.disconnect();
			}
			
		}
		
		if(successFlag) {
			return new ResponseEntity<String>( HttpStatus.OK);
		}else {
			return new ResponseEntity<String>( HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
	       
	    }   
}
