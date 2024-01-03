package licensing;

import java.awt.*;
import java.awt.Graphics2D;
import java.awt.SplashScreen;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;
import java.util.jar.JarInputStream;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JWindow;
import javax.swing.SwingConstants;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.Options;
import org.apache.commons.io.IOUtils;

//import tallyattachmentemailer.ui.server.UIServer;

public class Launcher {

	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		String workingDir = "";
		String appFile = "";
		boolean exitApp = false;

		Options options = new Options();
		options.addOption("w", "workingDir", true, "Working directory");
		options.addOption("f", "appFile", true, "App to be launched");

		CommandLineParser parser = new DefaultParser();
		CommandLine cmd = parser.parse(options, args);

		if (cmd.hasOption("appFile")) {
			appFile = cmd.getOptionValue("appFile");
			
		}else {
			System.out.println("Missing argument - appFile");
			exitApp = true;
		}

		if (cmd.hasOption("workingDir")) {
			workingDir = cmd.getOptionValue("workingDir");
		} else {
			workingDir = System.getProperty("user.dir");
		}

		if(!exitApp) {
			AppLicense objAppLicense = new AppLicense(workingDir, appFile);
			Launcher objLauncher = new Launcher();

			objLauncher.showSplashScreen();

			// (new Launcher()).loadapp(appFile,workingDir,objAppLicense.getAppByteData());
			objLauncher.executeApp(workingDir, objAppLicense.getAppByteData());
		}
		

	}
	
	private void showSplashScreen1() throws MalformedURLException {
		JWindow window = new JWindow();
		
        window.getContentPane().add(
                new JLabel("", new ImageIcon("splash-startup.gif"), SwingConstants.CENTER)).setBackground(new Color(0, 0, 0, 0));

        //Set the window's bounds, centering the window
        int width = 305;
        int height = 200;
        Dimension screen = Toolkit.getDefaultToolkit().getScreenSize();
        int x = (screen.width - width) / 2;
        int y = (screen.height - height) / 2;
        window.setBounds(x, y, width, height);

        window.setVisible(true);
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }finally {
        	 window.setVisible(false);
        }
	}

	private void showSplashScreen() {

		try {
			SplashScreen splash = SplashScreen.getSplashScreen();
			if (splash != null) {
				// Thread.sleep(3000);

				Graphics2D g = splash.createGraphics();
				if (g == null) {
					System.out.println("g is null");
					return;
				}
				for (int i = 0; i < 100; i++) {
					// renderSplashFrame(g, i);
					// splash.update();
					try {
						Thread.sleep(30);
					} catch (InterruptedException e) {
					}
				}

				splash.close();

			}
		} catch (Exception e) {

		}
	}

	private void executeApp(String workingDir, byte[] byteData)
			throws IOException, IllegalBlockSizeException, BadPaddingException, InterruptedException {
		File fOp = File.createTempFile(Math.random() * 100 + "", ".a");
		writeToFile(fOp, byteData);

		Process ps = Runtime.getRuntime()
				.exec(new String[] { "java", "-DworkingDir=" + workingDir, "-jar", fOp.getAbsolutePath() });
		ps.waitFor();
		java.io.InputStream is = ps.getInputStream();
		byte b[] = new byte[is.available()];
		is.read(b, 0, b.length);
		System.out.println(new String(b));
		fOp.delete();

	}

	public void loadapp(String appFile, String workingDir, byte[] byteData)
			throws IOException, ClassNotFoundException, InstantiationException, IllegalAccessException,
			IllegalArgumentException, InvocationTargetException, NoSuchMethodException, SecurityException,
			IllegalBlockSizeException, BadPaddingException, InterruptedException {
		File fOp = File.createTempFile(Math.random() * 100 + "", ".a");
		writeToFile(fOp, byteData);
		JarFile jarFile = new JarFile(fOp.getAbsolutePath());
		ByteClassLoader byteClassLoader = new ByteClassLoader(this.getClass().getClassLoader());
		String mainClassName = "";

		try (JarInputStream is = new JarInputStream(new ByteArrayInputStream(byteData))) {

			mainClassName = (String) is.getManifest().getMainAttributes().getValue("Main-Class");

			for (;;) {
				JarEntry nextEntry = is.getNextJarEntry();
				if (nextEntry == null)
					break;

				// System.out.println(nextEntry + " --- " + nextEntry.getName());

				byte[] bytes = IOUtils.toByteArray(jarFile.getInputStream(nextEntry));
				byteClassLoader.loadDataInBytes(bytes, nextEntry.getName());
				// System.out.println(nextEntry.getName());

			}

			fOp.delete();
		}

		// Class<?> helloWorldClass =
		// byteClassLoader.loadClass("tallyattachmentemailer.FileScanner");
		Class<?> helloWorldClass = byteClassLoader.loadClass(mainClassName);
		helloWorldClass.getConstructors()[0].newInstance(workingDir);

	}

	private String getMainClassFromManifest(InputStream is) throws IOException {

		System.out.println(is.readAllBytes().toString());

		return null;

	}

	private void writeToFile(File output, byte[] toWrite)
			throws IllegalBlockSizeException, BadPaddingException, IOException {
		FileOutputStream fos = new FileOutputStream(output);
		fos.write(toWrite);
		fos.flush();
		fos.close();
	}

	// Define Custom ClassLoader
	public class ByteClassLoader extends ClassLoader {
		private HashMap<String, byte[]> byteDataMap = new HashMap<String, byte[]>();

		public ByteClassLoader(ClassLoader parent) {
			super(parent);
		}

		public void loadDataInBytes(byte[] byteData, String resourcesName) {
			byteDataMap.put(resourcesName, byteData);
		}

		@Override
		protected Class<?> findClass(String className) throws ClassNotFoundException {

			// System.out.println("findClass - " + className);
			if (byteDataMap.isEmpty())
				throw new ClassNotFoundException("byte data is empty");

			String filePath = className.replaceAll("\\.", "/").concat(".class");
			byte[] extractedBytes = byteDataMap.get(filePath);
			if (extractedBytes == null)
				throw new ClassNotFoundException("Cannot find " + filePath + " in bytes");

			return defineClass(className, extractedBytes, 0, extractedBytes.length);
		}

		public InputStream getResourceAsStream(String name) {
//			if(!byteDataMap.containsKey(name) && name.contains("META-INF/javamail.") && !name.contains("META-INF/javamail.default") ) {
//				name=name.replace("META-INF/javamail.","META-INF/javamail.default.");
//			}

			// System.out.println("load resource - " + name);
			byte[] buffer = byteDataMap.get(name);
			if (buffer != null) {
				return new ByteArrayInputStream(buffer);
			} else {
				// System.out.println("Missing entry -" + name);
				return null;
			}
		}
	}
}
