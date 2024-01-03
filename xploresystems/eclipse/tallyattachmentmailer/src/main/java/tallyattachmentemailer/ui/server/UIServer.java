package tallyattachmentemailer.ui.server;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;

import org.apache.catalina.LifecycleException;
import org.apache.catalina.core.StandardContext;
import org.apache.catalina.startup.Tomcat;
 
public class UIServer {
 
	public UIServer(String application_dir) throws ServletException, LifecycleException, IOException {
        
        Tomcat tomcat = new Tomcat();

        //The port that we should run on can be set into an environment variable
        //Look for that variable and default to 8080 if it isn't there.
        String webPort ="8090";

        tomcat.setPort(Integer.valueOf(webPort));
        //tomcat.setSilent(true);

        
        String tmpdir = Files.createTempDirectory("tallyattachmentemailer_ui").toFile().getAbsolutePath();
        tomcat.setBaseDir(tmpdir);
        String webappDirLocation =application_dir + File.separator + "ui";
        StandardContext ctx = (StandardContext) tomcat.addWebapp("/", new File(webappDirLocation).getAbsolutePath());
        
        //System.out.println("configuring app with basedir: " + new File("./" + webappDirLocation).getAbsolutePath());

        // Declare an alternative location for your "WEB-INF/classes" dir
        // Servlet 3.0 annotation will work
       // File additionWebInfClasses = new File("target/classes");
       // WebResourceRoot resources = new StandardRoot(ctx);
        //resources.addPreResources(new DirResourceSet(resources, "/WEB-INF/classes",
        //        additionWebInfClasses.getAbsolutePath(), "/"));
       // ctx.setResources(resources);
        ServletContext context =   ctx.getServletContext();
        context.setAttribute("application_dir", application_dir);


        tomcat.start();
        tomcat.getServer().await();
	
	}
	
    public static void main(String[] args) throws LifecycleException, ServletException, IOException {
    	String workingDir="";

		if(args.length > 0) {
			workingDir = args[0];
		}else {
			workingDir = System.getProperty("user.dir");
		}
		
     	new UIServer(workingDir);
    }
}
