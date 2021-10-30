/*
Author: Latish Sherigar
email : latishsherigar@yahoo.co.in
Desc: Report Engine -- a webservice which takes the report 
      source file and outputs a pdf to the browser.
*/
import java.io.IOException;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Properties;
import java.util.Enumeration;
 
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;

//import net.sf.jasperreports.engine.JasperCompileManager;
//import net.sf.jasperreports.engine.JasperReport;
 
 /**
  * The <code>ReportEngine</code> class serves html and pdf reports using
  * Jasper reports.
  * 
  * @author Latish Sherigar
  */
 public class ReportEngine extends HttpServlet {
     /**
      * Called by the server to allow a servlet to handle a GET request.
      * 
      * @param request
      *            the request the client has made of the servlet
      * @param response
      *            the response the servlet sends to the client
      * @throws ServletException
      * @throws IOException
      */


     public void doGet(HttpServletRequest request, HttpServletResponse response)
             throws ServletException, IOException {
 
         // Pass this request off to the handleSubmit method. It's an accepted
         // best pracice to handle GET and POST submissions the same way unless
         // there's a good reason not to do so.
         this.handleSubmit(request, response);
 
     }
 
     /**
      * Called by the server to allow a servlet to handle a POST request.
      * 
      * @param request
      *            the request the client has made of the servlet
      * @param response
      *            the response the servlet sends to the client
      * @throws ServletException
      * @throws IOException
      */
     public void doPost(HttpServletRequest request, HttpServletResponse response)
             throws ServletException, IOException {
         // Pass this request off to the handleSubmit method. It's an accepted
         // best pracice to handle GET and POST submissions the same way unless
         // there's a good reason not to do so.
         this.handleSubmit(request, response);
     }
 
     /**
      * Handles form submissions for <code>#doGet</code> and
      * <code>#doPost</code>.
      * 
      * @param request
      *            The <code>HttpServletRequest</code> wrapping the HTTP
      *            request that triggered this method.
      * @param response
      *            The <code>HttpServletResponse</code> that gives this method
      *            access to the HTTP response the servlet container will send
      *            back to the user agent.
      * @throws IOException
      *             when an error occurs while trying to access the output stream
      *             to notify the user of an error.
      */
     protected void handleSubmit(HttpServletRequest request,
             HttpServletResponse response) throws IOException {
         // Declare the printwriter (which we'll use if an error occurs), but
         // don't instantiate it yet because instantiating it will prevent us
         // from streaming the PDF back to the client if everything else works.
         //PrintWriter out = null;
 
         Connection conn = null;
         
    
         try {
              Properties props = new Properties();

              FileInputStream fis = 
              new FileInputStream(getServletContext().getRealPath("/") +
                                 "report_app/" +
                                 request.getParameter("rep_app_name") +
                                 "/db.properties");

              props.load(fis);
              String dbdriver = props.getProperty("driver");
              String dburl = props.getProperty("url");
              String dbuser = props.getProperty("dbuser");
              String dbpass = props.getProperty("dbpass");
        
             Class.forName(dbdriver);
              conn = DriverManager.getConnection(dburl, dbuser, dbpass);

              String report_dir = getServletContext().getRealPath("/") +
                   "report_app/" +
                   request.getParameter("rep_app_name") +
                   "/reports/"; 

             // Get report file name from params
             String rptfilename = report_dir +  request.getParameter("rep_src") + ".jasper";

             // Add filter value to a hashtable of report parameters
	      HashMap<String, String> params = new HashMap<String, String>();

             //SUBREPORT_DIR
             params.put("SUBREPORT_DIR", report_dir);

             //REPORT_DIR
             params.put("REPORT_DIR", report_dir);
             
             // Find out the names of all the parameters.
             Enumeration req_params = request.getParameterNames();
               
             while (req_params.hasMoreElements())
                {
                // Get the next parameter name.
                 String req_paramName = (String) req_params.nextElement();
                 params.put(req_paramName, request.getParameter(req_paramName));
                } 
                
                

             // fill the report
             JasperPrint jasperprint = JasperFillManager.fillReport(
                     rptfilename, params,conn);

 
             // export report to pdf and stream back to browser
             byte[] pdfasbytes = JasperExportManager
                     .exportReportToPdf(jasperprint);
 
             ServletOutputStream outstream = response.getOutputStream();

             response.setContentType("application/pdf");
             response.setContentLength(pdfasbytes.length);
 
             response.setHeader("Content-disposition","inline; filename=Report.pdf");
             outstream.write(pdfasbytes);
         } 
          catch (Exception e) {
	      e.printStackTrace();
         }
	  finally{
              try{
                   conn.close();  
             }catch(SQLException sqle){

              } 
          } 
     }//handleSubmit ends 
 }//class ReportEngine ends
