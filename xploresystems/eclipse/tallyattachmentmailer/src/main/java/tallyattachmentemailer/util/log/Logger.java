package tallyattachmentemailer.util.log;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

public final class Logger {

	static BufferedWriter bfw;
	static String logFilePath;
	static boolean firstRun = false;
	
	public static void init(String logFileDir,boolean rotatingLog) throws IOException {

		new File(logFileDir).mkdir();	
		logFilePath = logFileDir + File.separator + "app.log";
		if(new File(logFilePath).exists()) {
			new File(logFilePath).renameTo(new File(logFilePath + "_" + new Date()));
		}
		bfw = new BufferedWriter(new FileWriter(logFilePath));
		//writeaLine(new Date().toString());
		firstRun = true;
		
		if(rotatingLog) {
			setRotatingLogTimer();
		}
		

	}

	private static void setRotatingLogTimer() {
		Timer timer = new Timer();
		timer.schedule(new TimerTask() {
			
			@Override
			public void run() {
				if(!firstRun) {
					try {

						new File(logFilePath).renameTo(new File(logFilePath + "_" + new Date()));
						bfw = new BufferedWriter(new FileWriter(logFilePath));
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

				}
				firstRun = false;
			}
		}, 0, 86400000); //1 day

	}
	
	public static void writeToFile(String s) {

		try {
			writeaLine(s);
			bfw.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private static void writeaLine(String aLine) {
		try {
			//bfw.newLine();
			bfw.write(new Date().toString() +   aLine);
			bfw.newLine();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	public static void writeToFile(Exception em) {
		try {
			bfw.newLine();
			writeaLine("----------------------------------------------------------");
			writeaLine(em.getMessage());

			for (StackTraceElement st : em.getStackTrace()) {
				writeaLine(st.toString());
			}
			
			writeaLine("----------------------------------------------------------");
			bfw.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	protected void finalize() throws IOException {
		bfw.flush();
		bfw.close();
	}
}
