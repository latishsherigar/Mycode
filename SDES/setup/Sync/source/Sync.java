/*
* Sync
* v 0.2 (2007-03-30)
* One-Way Directory Synchronization Tool
*
* Copyright 2007 Zach Scrivena
* Email: zachscrivena@gmail.com
* Webpage: http://zs.freeshell.org/
*
* Sync is a simple command-line utility that performs one-way
* directory synchronization.
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*/


import java.io.*;
import java.text.*;
import java.util.*;
import java.util.zip.*;


/**
* Sync
* Performs all the functions provided by the Sync utility.
*/

public class Sync
{
	/* Constants: */

	// program description
	private static final String PROG_TITLE = "Sync 0.2    Copyright 2007 Zach Scrivena    2007-03-30";

	// use a read/write buffer of 1 Mb
	private static final int BUFFER_SIZE = 1048576;


	/* Sync Parameters: */

	// options
	private static boolean noName = false;
	private static boolean noCrc = false;
	private static boolean noRecurse = false;
	private static long timeTolerance = 0;
	private static boolean simulateOnly = false;
	private static boolean ignoreWarnings = false;

	// file attributes used for matching
	private static boolean name = false;
	private static boolean size = false;
	private static boolean time = false;
	private static boolean crc  = false;

	// source & target
	private static String sourceName = null;
	private static String targetName = null;
	private static File source = null;
	private static File target = null;

	// synchronization mode (dir-dir, file-file, file-dir)
	private static String syncMode = null;

	// default choices
	private static char renameMatchedFileMode = '\0';
	private static char timeSyncMatchedFileMode = '\0';
	private static char deleteUnmatchedTargetFilesMode = '\0';
	private static char deleteUnmatchedTargetDirsMode = '\0';
	private static char overwriteExistingTargetFilesMode = '\0';

	// report statistics
	private static int reportNumWarnings = 0;
	private static int reportNumSourceDirsScanned = 0;
	private static int reportNumSourceFilesScanned = 0;
	private static int reportNumTargetFilesScanned = 0;
	private static int reportNumPerfectMatches = 0;
	private static int reportNumKeyMatches = 0;
	private static int reportNumKeyMatches_Synchronized = 0;
	private static int reportNumUnmatchedSourceFiles = 0;
	private static int reportNumUnmatchedSourceFiles_Copied = 0;
	private static int reportNumUnmatchedSourceDirs = 0;
	private static int reportNumUnmatchedSourceDirs_Created = 0;
	private static int reportNumUnmatchedTargetFiles = 0;
	private static int reportNumUnmatchedTargetFiles_Deleted = 0;
	private static int reportNumUnmatchedTargetDirs = 0;
	private static int reportNumUnmatchedTargetDirs_Deleted = 0;

	/* Sync Status: */
	private static boolean syncStarted = false;


	/**
	* printUsage()
	* Prints usage documentation.
	*/
	private static void printUsage()
	{
		/*   RULER
		     00000000011111111112222222222333333333344444444445555555555666666666677777777778
		     12345678901234567890123456789012345678901234567890123456789012345678901234567890 */
		p("\nSync performs one-way directory or file synchronization."+
		  "\n"+
		  "\nUSAGE:  java -jar Sync.jar   <switches>   [\"Source\"]   [\"Target\"]"+
		  "\n"+
		  "\nSync synchronizes [\"Target\"] to match [\"Source\"]. Only [\"Target\"] is modified."+
		  "\nThe synchronization mode depends on the [\"Source\"]-[\"Target\"] pair specified:"+
		  "\n"+
		  "\n * Directory-Directory: Sync will match the contents of the source and target"+
		  "\n                          directories recursively."+
		  "\n * File-File          : Sync will match the source and target files."+
		  "\n * File-Directory     : Sync will try to match the source file to a file in the"+
		  "\n                          target directory."+
		  "\n"+
		  "\n<Switches>:"+
		  "\n -m, --match:[n|s|t|c]   Use specified file attributes for matching source and"+
		  "\n                          target files. By default, --match:nsc is used."+
		  "\n                          File attributes:"+
		  "\n                            n   Name (see note 1)"+
		  "\n                            s   Size"+
		  "\n                            t   last-modified Time (see note 2)"+
		  "\n                            c   CRC-32 Checksum"+
		  "\n -t, --time:x            Use time-tolerance of x milliseconds (where x is a"+
		  "\n                          nonnegative integer) when matching files."+
		  "\n                          By default, --time:0 is used."+
		  "\n -c, --nocrc             Do not compute CRC-32 checksums (see note 3)"+
		  "\n     --rename:[y|n]      Always[y]/never[n] rename matched target files"+
		  "\n     --timesync:[y|n]      ... synchronize time of matched target files"+
		  "\n     --delfiles:[y|n]      ... delete unmatched target files"+
		  "\n     --deldirs:[y|n]       ... delete unmatched target directories"+
		  "\n     --overwrite:[y|n]     ... overwrite existing target files"+
		  "\n -f, --force             Equivalent to the combination: --rename:y --timesync:y"+
		  "\n                          --delfiles:y --deldirs:y --overwrite:y"+
		  "\n -r, --norecurse         Do not recurse into subdirectories"+
		  "\n -i, --ignorewarnings    Do not pause on warnings (see note 4)"+
		  "\n -s, --simulate          Simulate only, i.e. target is not modified"+
		  "\n"+
		  "\nNOTES:"+
		  "\n"+
		  "\n 1. File names are not used for matching in File-File synchronization."+
		  "\n 2. Sync uses millisecond-resolution time comparisons. This may be finer than"+
		  "\n     the resolution supported by some file systems. To avoid file mismatches"+
		  "\n     across different file systems, --time:1000 or more could be specified."+
		  "\n 3. If switch --nocrc is specified, then --match:nst is assumed instead"+
		  "\n     of --match:nsc."+
		  "\n 4. By default, Sync always pauses to warn the user when any file operation is"+
		  "\n     unsuccessful or when it thinks a file match is poor (e.g. files have"+
		  "\n     different checksums)."+
		  "\n"+
		  "\nEXAMPLES:"+
		  "\n"+
		  "\n 1. Synchronize target \"C:"+ File.separator +"BACKUP\" to look like source \"C:"+ File.separator +"MASTER\","+
		  "\n     matching files by (name,size,CRC):"+
		  "\n       java -jar Sync.jar \"C:"+ File.separator +"MASTER\" \"C:"+ File.separator +"BACKUP\""+
		  "\n 2. As in example 1, but never delete unmatched target files or directories:"+
		  "\n       java -jar Sync.jar --delfiles:n --deldirs:n \"C:"+ File.separator +"MASTER\" \"C:"+ File.separator +"BACKUP\""+
		  "\n 3. As in example 1, but match files by (name,size,time) with 2-second time"+
		  "\n     tolerance instead:"+
		  "\n       java -jar Sync.jar --match:nst --time:2000 \"C:"+ File.separator +"MASTER\" \"C:"+ File.separator +"BACKUP\""+
		  "\n 4. As in example 1, but always rename and synchronize time of matched target"+
		  "\n     files, delete unmatched target files and directories, and overwrite"+
		  "\n     existing target files:"+
		  "\n       java -jar Sync.jar --force \"C:"+ File.separator +"MASTER\" \"C:"+ File.separator +"BACKUP\""+
		  "\n");
	}


	/**
	* main()
	* Main entry point for program. Process command-line arguments.
	*/
	public static void main(final String args[]) throws Exception
	{
		p("\n" + PROG_TITLE);

		/* Extract Sync params from command-line arguments */
		processArguments(args);

		errorAssert(Sync.syncMode != null,
		            "(INTERNAL) Unable to determine synchronization mode.", 42);

		errorAssert(Sync.syncMode.equals("Dir-Dir") ||
		            Sync.syncMode.equals("File-File") ||
		            Sync.syncMode.equals("File-Dir"),
		            "(INTERNAL) Invalid synchronization mode " + Sync.syncMode + ".", 42);

		if (Sync.syncMode.equals("Dir-Dir"))
		{
			p("\n\nDIRECTORY-DIRECTORY SYNCHRONIZATION:"+
			  "\nSource directory : " + Sync.sourceName + File.separator +
			  "\nTarget directory : " + Sync.targetName + File.separator);
		}
		else if (Sync.syncMode.equals("File-File"))
		{
			p("\n\nFILE-FILE SYNCHRONIZATION:"+
			  "\nSource file : " + Sync.sourceName +
			  "\nTarget file : " + Sync.targetName);
		}
		else if (Sync.syncMode.equals("File-Dir"))
		{
			p("\n\nFILE-DIRECTORY SYNCHRONIZATION:"+
			  "\nSource file      : " + Sync.sourceName +
			  "\nTarget directory : " + Sync.targetName + File.separator);
		}

		p("\nMatching files by " + getKeyString());
		if (Sync.timeTolerance > 0) p(" with time tolerance of " + Sync.timeTolerance + " milliseconds");
		p("\n");

		/* Check validity of source and target */
		validateSourceTarget();

		/* Begin synchronization */
		Sync.syncStarted = true;

		if (Sync.syncMode.equals("Dir-Dir"))
		{
			p("\nSynchronizing contents of subdirectories...");
			// recursively synchronize subdirectories
			syncDirDir(Sync.source);
		}
		else if (Sync.syncMode.equals("File-File"))
		{
			syncFileFile();
		}
		else if (Sync.syncMode.equals("File-Dir"))
		{
			p("\nFinding matching file in target directory...");
			syncFileDir();
		}

		/* Print report statistics */
		printReportStatistics();

		/* Successful termination */
		p("\n\nSync is done!\n\n");
		System.exit(0);
	}


	private static void printReportStatistics()
	{
		if (Sync.syncMode.equals("Dir-Dir"))
		{
			p("\n\nSYNCHRONIZATION REPORT:"+
			  "\n  " + Sync.reportNumWarnings + " warnings encountered." +
			  "\n  Number of source subdirectories scanned   : " + Sync.reportNumSourceDirsScanned +
			  "\n  Number of source files scanned            : " + Sync.reportNumSourceFilesScanned +
			  "\n  Number of target files scanned            : " + Sync.reportNumTargetFilesScanned +
			  "\n  Number of 'perfect' file matches          : " + Sync.reportNumPerfectMatches +
			  "\n  Number of " + getKeyString() + "-only file matches : " + Sync.reportNumKeyMatches +
			  	" (" + Sync.reportNumKeyMatches_Synchronized + " synchronized)" +
			  "\n  Number of unmatched source directories    : " + Sync.reportNumUnmatchedSourceDirs +
			  	" (" + Sync.reportNumUnmatchedSourceDirs_Created + " created)" +
			  "\n  Number of unmatched source files          : " + Sync.reportNumUnmatchedSourceFiles +
			  	" (" + Sync.reportNumUnmatchedSourceFiles_Copied + " copied)" +
			  "\n  Number of unmatched target subdirectories : " + Sync.reportNumUnmatchedTargetDirs +
			  	" (" + Sync.reportNumUnmatchedTargetDirs_Deleted + " deleted)" +
			  "\n  Number of unmatched target files          : " + Sync.reportNumUnmatchedTargetFiles +
			  	" (" + Sync.reportNumUnmatchedTargetFiles_Deleted + " deleted)");
		}
		else if (Sync.syncMode.equals("File-File"))
		{
	 		if (Sync.reportNumWarnings > 0) p("\n" + Sync.reportNumWarnings + " warnings encountered.");
		}
		else if (Sync.syncMode.equals("File-Dir"))
		{
	 		if (Sync.reportNumWarnings > 0) p("\n" + Sync.reportNumWarnings + " warnings encountered.");
		}

	}


	private static void syncFileDir() throws Exception
	{
		/* Notes:
		   - We have established that
		     (1) the source file exists, and
		     (2) the target directory exists.

		   - Now, we need to scan the target directories for a match.
		*/

		final FileId sfid = new FileId(Sync.source);

		// get target directory contents
		final DirContents targetDirContents = getDirContents(Sync.target);

		if (targetDirContents == null)
		{
			warningAssert("Could not get contents of target directory " + Sync.targetName + File.separator + ";\nFile-Directory synchronization failed.");
			return;
		}

		// target files
		final ArrayList<FileId> targetFileIds = convertFilesToFileIds(targetDirContents.files);

		p(" " + targetFileIds.size() + " target files scanned.");

		boolean matchFound = false;

		if (!targetFileIds.isEmpty())
		{
			// compute match scores for each target file
			for (FileId tfid: targetFileIds)
			{
				tfid.computeMatchScore(sfid);
			}

			// sort by match scores (index 0 is best match)
			Collections.sort(targetFileIds);

			// print match results
			//for (int i = 0; i < targetFileIds.size(); i++) p("\nMatch["+i+"]: "+ targetFileIds.get(i).matchScoreString() + targetFileIds.get(i));

			final FileId tfid = targetFileIds.get(0); // the best match

			// check if the best match is unique
			if ((targetFileIds.size() > 1) &&
			    (tfid.isPerfectMatch() || tfid.isKeyMatch()))
			{
				warningAssert(tfid.compareTo(targetFileIds.get(1)) != 0,
					"Closest matching target file is nonunique;\nSync will pick a 'best' match arbitrarily.\nPlease use a stricter match key to avoid such ambiguity.");
			}

			if (tfid.isPerfectMatch())
			{
				/* Perfect match; nothing to do */

				matchFound = true;

				p("\nFound 'perfect' match for source file in target directory; nothing to do.");
			}
			else if (tfid.isKeyMatch())
			{
				/* prompt user if other file attributes should be synchronized */

				matchFound = true;

				boolean nameMatched = sfid.name.equals(tfid.name);
				final boolean sizeMatched = (sfid.size == tfid.size);
				boolean timeMatched = (sfid.time == tfid.time);
				final boolean crcMatched  = (sfid.crc  == tfid.crc);

				final StringBuffer sInfo = new StringBuffer();
				final StringBuffer tInfo = new StringBuffer();

				if (!nameMatched)
				{
					sInfo.append("\n    Name : \"" + sfid.name + "\"");
					tInfo.append("\n    Name : \"" + tfid.name + "\"");
				}

				if (!sizeMatched)
				{
					sInfo.append("\n    Size : " + sfid.size);
					tInfo.append("\n    Size : " + tfid.size);
				}

				if (!timeMatched)
				{
					sInfo.append("\n    Time : " + sfid.timeString());
					tInfo.append("\n    Time : " + tfid.timeString());
				}

				if (!crcMatched)
				{
					sInfo.append("\n    CRC  : " + sfid.crcString());
					tInfo.append("\n    CRC  : " + tfid.crcString());
				}

				p("\nSource & target files have the same " +
					getKeyString(nameMatched, sizeMatched, timeMatched, crcMatched) + " but"+
					"\n  [source] " + Sync.sourceName + sInfo +
					"\n  [target] " + tfid.file.getCanonicalPath() + tInfo);

				if (!sizeMatched)
				{
					warningAssert("Source & target files have different sizes;\nthis is probably a poor match.");
				}

				if (!crcMatched)
				{
					warningAssert("Source & target files have different CRCs;\nthis is probably a poor match.");
				}

				if (!nameMatched)
				{
					char choice = Sync.renameMatchedFileMode;

					switch (Sync.renameMatchedFileMode)
					{
						case '\0':
							p("\nRename target file to match source file? ");
							choice = choicePrompt("(Y)es/(N)o: ", "YN");
							break;

						case 'Y':
							p("\nRenaming target file to match source file.");
							break;

						case 'N':
							p("\nSkipping renaming of target file to match source file.");
							break;

						default:
							errorAssert("(INTERNAL) Unexpected value Sync.renameMatchedFileMode=" + Sync.renameMatchedFileMode + ".", 8);
							break;
					}

					boolean performRename = false;

					switch (choice)
					{
						case 'Y':
							performRename = true;
							break;

						case 'N':
							break;

						default:
							errorAssert("(INTERNAL) Unexpected value choice=" + choice + ".", 8);
							break;
					}

					if (performRename)
					{
						final File newf = new File(tfid.file.getParentFile().getCanonicalPath() + File.separator + sfid.name);

						if (newf.exists())
						{
							warningAssert("A target " + ((newf.isFile()) ? "file" : "subdirectory") +
										  " of the same name as the source file already exists;\ntarget file not renamed.");
						}
						else
						{
							nameMatched = renameFile(tfid.file, newf);
						}
					}
				}

				if (!timeMatched)
				{
					char choice = Sync.timeSyncMatchedFileMode;

					switch (Sync.timeSyncMatchedFileMode)
					{
						case '\0':
							p("\nSynchronize time of target file to match source file? ");
							choice = choicePrompt("(Y)es/(N)o: ", "YN");
							break;

						case 'Y':
							p("\nSynchronizing time of target file to match source file.");
							break;

						case 'N':
							p("\nSkipping synchronizing of time of target file to match source file.");
							break;

						default:
							errorAssert("(INTERNAL) Unexpected value Sync.timeSyncMatchedFileMode=" + Sync.timeSyncMatchedFileMode + ".", 8);
							break;
					}

					boolean performTimeSync = false;

					switch (choice)
					{
						case 'Y':
							performTimeSync = true;
							break;

						case 'N':
							break;

						default:
							errorAssert("(INTERNAL) Unexpected value choice=" + choice + ".", 8);
							break;
					}

					if (performTimeSync)
					{
						timeMatched = changeFileTime(tfid.file, sfid.time);
					}
				}
			}
		}

		if (!matchFound)
		{
			/* Match not found; copy source file to target directory */

			p("\nNo files in the target directory match with the source file.");

			final File tf = new File(Sync.targetName + File.separator + sfid.name);

			boolean performCopy = false;

			if (!tf.exists())
			{
				performCopy = true;
			}
			else if (tf.exists() && tf.isDirectory())
			{
				warningAssert("A target subdirectory of the same name as the source file already exists;\n" +
							  "unmatched source file not copied.");
			}
			else if (tf.exists() && tf.isFile())
			{
				// prompt if overwrite

				p("\nA target file of the same name as the source file already exists;");

				char choice = Sync.overwriteExistingTargetFilesMode;

				switch (Sync.overwriteExistingTargetFilesMode)
				{
					case '\0':
						p("\nOverwrite target file with source file? ");
						choice = choicePrompt("(Y)es/(N)o: ", "YN");
						break;

					case 'Y':
						p("\nOverwriting target file with source file.");
						break;

					case 'N':
						p("\nSkipping overwriting of target file with source file.");
						break;

					default:
						errorAssert("(INTERNAL) Unexpected value Sync.overwriteExistingTargetFilesMode=" + Sync.overwriteExistingTargetFilesMode + ".", 8);
						break;
				}

				switch (choice)
				{
					case 'Y':
						performCopy = true;
						break;

					case 'N':
						break;

					default:
						errorAssert("(INTERNAL) Unexpected value choice=" + choice + ".", 8);
						break;
				}
			}

			if (performCopy)
			{
				if (copyFile(Sync.source, tf))
				{
					p("\n1 file copied.");
				}
				else
				{
					p("\n0 files copied.");
				}
			}
		}
	}


	private static void syncFileFile() throws Exception
	{
	   	/* Notes:

	   	  - We have already established the following:
	   	    (1) the source file exists, and
	   	    (2) either:
	   	        (i)  the target is an existing file, or <-- we compare the target & source files
				(ii) the target does not exist.  <-- we create a new target file

		  - File names are ignored in File-File synchronization.
		*/

	   	/* Check if target file exists */

	   	if (Sync.target.exists() && Sync.target.isFile())
	   	{
			/* (i) Target is an existing file, so we compare the target and source files */

			final FileId sfid = new FileId(Sync.source);
			final FileId tfid = new FileId(Sync.target);

			// compute match score
			tfid.computeMatchScore(sfid);
			//p("\nMatch: "+ tfid.matchScoreString() + tfid); // print match result

			if (tfid.isPerfectMatch())
			{
				/* Perfect match; nothing to do */

				p("\nSource and target files match 'perfectly'; nothing to do.");
			}
			else if (tfid.isKeyMatch())
			{
				/* prompt user if other file attributes should be synchronized */

				final boolean sizeMatched = (sfid.size == tfid.size);
				boolean timeMatched = (sfid.time == tfid.time);
				final boolean crcMatched  = (sfid.crc  == tfid.crc);

				final StringBuffer sInfo = new StringBuffer();
				final StringBuffer tInfo = new StringBuffer();

				if (!sizeMatched)
				{
					sInfo.append("\n    Size : " + sfid.size);
					tInfo.append("\n    Size : " + tfid.size);
				}

				if (!timeMatched)
				{
					sInfo.append("\n    Time : " + sfid.timeString());
					tInfo.append("\n    Time : " + tfid.timeString());
				}

				if (!crcMatched)
				{
					sInfo.append("\n    CRC  : " + sfid.crcString());
					tInfo.append("\n    CRC  : " + tfid.crcString());
				}

				p("\nSource & target files have the same " +
					getKeyString(false, sizeMatched, timeMatched, crcMatched) + " but"+
					"\n  [source] " + Sync.sourceName + sInfo +
					"\n  [target] " + Sync.targetName + tInfo);

				if (!sizeMatched)
				{
					warningAssert("Source & target files have different sizes;\nthis is probably a poor match.");
				}

				if (!crcMatched)
				{
					warningAssert("Source & target files have different CRCs;\nthis is probably a poor match.");
				}

				if (!timeMatched)
				{
					char choice = Sync.timeSyncMatchedFileMode;

					switch (Sync.timeSyncMatchedFileMode)
					{
						case '\0':
							p("\nSynchronize time of target file to match source file? ");
							choice = choicePrompt("(Y)es/(N)o: ", "YN");
							break;

						case 'Y':
							p("\nSynchronizing time of target file to match source file.");
							break;

						case 'N':
							p("\nSkipping synchronizing of time of target file to match source file.");
							break;

						default:
							errorAssert("(INTERNAL) Unexpected value Sync.timeSyncMatchedFileMode=" + Sync.timeSyncMatchedFileMode + ".", 8);
							break;
					}

					boolean performTimeSync = false;

					switch (choice)
					{
						case 'Y':
							performTimeSync = true;
							break;

						case 'N':
							break;

						default:
							errorAssert("(INTERNAL) Unexpected value choice=" + choice + ".", 8);
							break;
					}

					if (performTimeSync)
					{
						timeMatched = changeFileTime(tfid.file, sfid.time);
					}
				}
			}
			else
			{
				/* Files do not match; prompt to overwrite target file with source file */

				p("\nSource and target files do not match.");

				char choice = Sync.overwriteExistingTargetFilesMode;

				switch (Sync.overwriteExistingTargetFilesMode)
				{
					case '\0':
						p("\nOverwrite target file with source file? ");
						choice = choicePrompt("(Y)es/(N)o: ", "YN");
						break;

					case 'Y':
						p("\nOverwriting target file with source file.");
						break;

					case 'N':
						p("\nSkipping overwriting of target file with source file.");
						break;

					default:
						errorAssert("(INTERNAL) Unexpected value Sync.overwriteExistingTargetFilesMode=" + Sync.overwriteExistingTargetFilesMode + ".", 8);
						break;
				}

				boolean performCopy = false;

				switch (choice)
				{
					case 'Y':
						performCopy = true;
						break;

					case 'N':
						break;

					default:
						errorAssert("(INTERNAL) Unexpected value choice=" + choice + ".", 8);
						break;
				}

				if (performCopy)
				{
					if (copyFile(Sync.source, Sync.target))
					{
						p("\n1 file copied.");
					}
					else
					{
						p("\n0 files copied.");
					}
				}
			}

	   	}
	   	else if (!Sync.target.exists())
	   	{
		 	/* (ii) Target does not exist, so we create a new target file */

		 	p("\nTarget file does not exist; copying source file to target file...");

			if (copyFile(Sync.source, Sync.target))
			{
				p("\n1 file copied.");
			}
			else
			{
				p("\n0 files copied.");
			}
		}
	   	else
	   	{
		 	errorAssert(false,
		 	            "(INTERNAL) Unexpected scenario encountered for file-file synchronization.",
		 	            8);
   		}
	}


	private static void syncDirDir(final File sourceDir) throws Exception
	{
		/* Check source directory */
		errorAssert(sourceDir.exists(),
		            "(INTERNAL) Input " + sourceDir + " to syncDirDir() does not exist.", 8);
		errorAssert(sourceDir.isDirectory(),
		            "(INTERNAL) Input " + sourceDir + " to syncDirDir() is not a directory.", 8);

		if (!sourceDir.canRead())
		{
			warningAssert("Source directory " + sourceDir + "  cannot be read; this subdirectory will be ignored.");
			return;
		}

		final String sourceDirName = trimTrailingSeparator(sourceDir.getCanonicalPath());
		final String subfolder = sourceDirName.substring(Sync.sourceName.length());

		p("\n\nSUBDIRECTORY : ." + subfolder + File.separator);

		final DirContents sourceDirContents = getDirContents(sourceDir);

		if (sourceDirContents == null)
		{
			warningAssert("Could not get contents of source directory " + sourceDir + File.separator + ";\nthis subdirectory will be ignored.");
			return;
		}

		Sync.reportNumSourceDirsScanned++;

		final ArrayList<FileId> sourceFileIds = convertFilesToFileIds(sourceDirContents.files);
		Sync.reportNumSourceFilesScanned += sourceFileIds.size();

		/* Check target directory */
		final String targetDirName = Sync.targetName + subfolder;
		final File targetDir = new File(targetDirName);
		DirContents targetDirContents = null;

		if (targetDir.exists())
		{
			if (targetDir.isDirectory())
			{
				targetDirContents = getDirContents(targetDir);
			}
			else
			{
				// the corresponding target is not a directory
				Sync.reportNumUnmatchedSourceDirs++;
				warningAssert("Target " + targetDir + " already exists but is not a directory (could it be a file?);\nthis subdirectory will be ignored.");
				return;
			}
		}
		else
		{
			Sync.reportNumUnmatchedSourceDirs++;

			if (Sync.simulateOnly)
			{
				targetDirContents = new DirContents();
				targetDirContents.files = new ArrayList<File>();
				targetDirContents.dirs = new ArrayList<File>();
			}
			else
			{
				createDir(targetDir);

				if (targetDir.exists() && targetDir.isDirectory())
				{
					Sync.reportNumUnmatchedSourceDirs_Created++;
					targetDirContents = getDirContents(targetDir);
				}
				else
				{
					warningAssert("Target directory " + targetDir + File.separator + " cannot be created;\nthis subdirectory will be ignored.");
					return;
				}
			}
		}

		if (targetDirContents == null)
		{
			warningAssert("Could not get contents of target directory " + targetDir + File.separator + ";\nthis subdirectory will be ignored.");
			return;
		}

		// unmatched target files (init to all target files)
		final ArrayList<FileId> unmatchedTargetFileIds = convertFilesToFileIds(targetDirContents.files);
		Sync.reportNumTargetFilesScanned += unmatchedTargetFileIds.size();

		// perfect matches, key matches, unmatched source files (init to empty)
		final ArrayList<SourceTargetFileIdPair> perfectMatchPairs = new ArrayList<SourceTargetFileIdPair>();
		final ArrayList<SourceTargetFileIdPair> keyMatchPairs = new ArrayList<SourceTargetFileIdPair>();
		final ArrayList<FileId> unmatchedSourceFileIds = new ArrayList<FileId>();

		// Generate <key,value> pair for each file in source Dir
		final TreeMap<FileKey,FileId> sourceFileKeyFileIdMap = new TreeMap<FileKey,FileId>();

		FileKey sfk = null;

		for (FileId sfid: sourceFileIds)
		{
			sfk = sfid.getFileKey();

			// check if sfk is unique in source directory
			if (sourceFileKeyFileIdMap.containsKey(sfk))
			{
				// key clash
				warningAssert("Key clash: The following source files have the same " + getKeyString() + ":" +
				              "\n [1] " + sourceDirName + File.separator + sourceFileKeyFileIdMap.get(sfk).name +
							  sourceFileKeyFileIdMap.get(sfk) +
				              "\n [2] " + sourceDirName + File.separator + sfid.name +
							  sfid +
							  "\nPlease use a stricter match key; this subdirectory will be ignored.");
				return;
			}
			else
			{
				sourceFileKeyFileIdMap.put(sfk, sfid);

				boolean matchFound = false;

				if (!unmatchedTargetFileIds.isEmpty())
				{
					// compute match scores for each remaining target unmatched file
					for (FileId tfid: unmatchedTargetFileIds)
					{
						tfid.computeMatchScore(sfid);
					}

					// sort by match scores (index 0 is best match)
					Collections.sort(unmatchedTargetFileIds);

					// print match results
					//for (int i = 0; i < unmatchedTargetFileIds.size(); i++) p("\nMatch["+i+"]: "+ unmatchedTargetFileIds.get(i).matchScoreString() + unmatchedTargetFileIds.get(i));

					final FileId tfid = unmatchedTargetFileIds.get(0); // the best match

					// check if the best match is unique
					if ((unmatchedTargetFileIds.size() > 1) &&
					    (tfid.isPerfectMatch() || tfid.isKeyMatch()))
					{
						warningAssert(tfid.compareTo(unmatchedTargetFileIds.get(1)) != 0,
							"Closest matching target file is nonunique;\nSync will pick a 'best' match arbitrarily.\nPlease use a stricter match key to avoid such ambiguity.");
					}

					if (tfid.isPerfectMatch())
					{
						perfectMatchPairs.add(new SourceTargetFileIdPair(sfid, tfid));
						unmatchedTargetFileIds.remove(tfid);
						matchFound = true;
					}
					else if (tfid.isKeyMatch())
					{
						keyMatchPairs.add(new SourceTargetFileIdPair(sfid, tfid));
						unmatchedTargetFileIds.remove(tfid);
						matchFound = true;
					}
				}

				if (!matchFound)
				{
					// match not found
					unmatchedSourceFileIds.add(sfid);
				}
			}
		}

		/* Delete unmatched target subdirectories */

		// Generate <name,dir> pair for all target subdirectories
		final TreeMap<String,File> unmatchedTargetDirs = new TreeMap<String,File>();

		for (File dir: targetDirContents.dirs)
		{
			unmatchedTargetDirs.put(dir.getName(), dir);
		}

		// remove target subdirectories that exist in the source directory
		for (File dir: sourceDirContents.dirs)
		{
			if (unmatchedTargetDirs.containsKey(dir.getName()))
			{
				unmatchedTargetDirs.remove(dir.getName());
			}
		}

		/* Process matched and unmatched files & directories */
		processUnmatchedTargetDirs(new ArrayList<File>(unmatchedTargetDirs.values()));
		processUnmatchedTargetFiles(unmatchedTargetFileIds);
		processPerfectMatchPairs(perfectMatchPairs);
		processKeyMatchPairs(keyMatchPairs);
		processUnmatchedSourceFiles(unmatchedSourceFileIds, targetDirName);

		/* Recurse into each source subdirectory */
		if (!Sync.noRecurse)
		{
			for (int i = 0; i < sourceDirContents.dirs.size(); i ++)
			{
				syncDirDir(sourceDirContents.dirs.get(i));
			}
		}

		/* Sync this directory time */
		changeDirTime(targetDir, sourceDir.lastModified());
	}


	/* Perfect matches are preserved */
	private static void processPerfectMatchPairs(final ArrayList<SourceTargetFileIdPair> mps)
	{
		if (mps.isEmpty())
		{
			//p("\n\n  No 'perfect' file matches.");
			return;
		}

		p("\n\n  " + mps.size() + " 'perfect' file matches:");

		// update report stats
		Sync.reportNumPerfectMatches += mps.size();

		for (int i = 0; i < mps.size(); i++)
		{
			//p("\n    P[" + (i + 1) + "]: " + mps.get(i).sourceFileId.name);
			p("\n    Preserved: " + mps.get(i).sourceFileId.name);
		}
	}


	/* Prompt user if target file attributes should be synchronized */
	private static void processKeyMatchPairs(final ArrayList<SourceTargetFileIdPair> mps) throws Exception
	{
		if (mps.isEmpty())
 		{
 			//p("\n\n  No " + keyString +"-only file matches.");
			return;
 		}

		char defaultRenameChoice = Sync.renameMatchedFileMode;
		char defaultTimeSyncChoice = Sync.timeSyncMatchedFileMode;

		p("\n\n  " + mps.size() + " " + getKeyString() + "-only file matches:");

		// update report stats
		Sync.reportNumKeyMatches += mps.size();

		FileId sfid = null;
		FileId tfid = null;

		for (int i = 0; i < mps.size(); i++)
		{
			//p("\n    K[" + (i + 1) + "]: " + mps.get(i).sourceFileId.name);

			sfid = mps.get(i).sourceFileId;
			tfid = mps.get(i).targetFileId;

			boolean nameMatched = sfid.name.equals(tfid.name);
			final boolean sizeMatched = (sfid.size == tfid.size);
			boolean timeMatched = (sfid.time == tfid.time);
			final boolean crcMatched  = (sfid.crc  == tfid.crc);

			final StringBuffer sInfo = new StringBuffer();
			final StringBuffer tInfo = new StringBuffer();

			if (!nameMatched)
			{
				sInfo.append("\n        Name : \"" + sfid.name + "\"");
				tInfo.append("\n        Name : \"" + tfid.name + "\"");
			}

			if (!sizeMatched)
			{
				sInfo.append("\n        Size : " + sfid.size);
				tInfo.append("\n        Size : " + tfid.size);
			}

			if (!timeMatched)
			{
				sInfo.append("\n        Time : " + sfid.timeString());
				tInfo.append("\n        Time : " + tfid.timeString());
			}

			if (!crcMatched)
			{
				sInfo.append("\n        CRC  : " + sfid.crcString());
				tInfo.append("\n        CRC  : " + tfid.crcString());
			}

			p("\n    Discrepancy: Source & target files have the same " +
              getKeyString(nameMatched, sizeMatched, timeMatched, crcMatched) + " but"+
			  "\n      [source] " + sfid.file.getCanonicalPath() + sInfo +
			  "\n      [target] " + tfid.file.getCanonicalPath() + tInfo);

			if (!sizeMatched)
			{
				warningAssert("Source & target files have different sizes;\nthis is probably a poor match.");
			}

			if (!crcMatched)
			{
				warningAssert("Source & target files have different CRCs;\nthis is probably a poor match.");
			}

			if (!nameMatched)
			{
				char choice = defaultRenameChoice;

				switch (defaultRenameChoice)
				{
					case '\0':
						p("\n      Rename target file to match source file? ");
						choice = choicePrompt("(Y)es/(N)o/(A)lways/Neve(R): ", "YNAR");
						break;

					case 'Y':
						p("\n      Renaming target file to match source file.");
						break;

					case 'N':
						p("\n      Skipping renaming of target file to match source file.");
						break;

					default:
						errorAssert("(INTERNAL) Unexpected value defaultRenameChoice=" + defaultRenameChoice + ".", 8);
						break;
				}

				boolean performRename = false;

				switch (choice)
				{
					case 'Y':
						performRename = true;
						break;

					case 'N':
						break;

					case 'A':
						performRename = true;
						defaultRenameChoice = 'Y';
						break;

					case 'R':
						defaultRenameChoice = 'N';
						break;

					default:
						errorAssert("(INTERNAL) Unexpected value choice=" + choice + ".", 8);
						break;
				}

				if (performRename)
				{
					final File newf = new File(tfid.file.getParentFile().getCanonicalPath() + File.separator + sfid.name);

					if (newf.exists())
					{
						warningAssert("A target " + ((newf.isFile()) ? "file" : "subdirectory") +
									  " of the same name as the source file already exists;\ntarget file not renamed.");
					}
					else
					{
						nameMatched = renameFile(tfid.file, newf);
					}
				}
			}

			if (!timeMatched)
			{
				char choice = defaultTimeSyncChoice;

				switch (defaultTimeSyncChoice)
				{
					case '\0':
						p("\n      Synchronize time of target file to match source file? ");
						choice = choicePrompt("(Y)es/(N)o/(A)lways/Neve(R): ", "YNAR");
						break;

					case 'Y':
						p("\n      Synchronizing time of target file to match source file.");
						break;

					case 'N':
						p("\n      Skipping synchronizing of time of target file to match source file.");
						break;

					default:
						errorAssert("(INTERNAL) Unexpected value defaultTimeSyncChoice=" + defaultTimeSyncChoice + ".", 8);
						break;
				}

				boolean performTimeSync = false;

				switch (choice)
				{
					case 'Y':
						performTimeSync = true;
						break;

					case 'N':
						break;

					case 'A':
						performTimeSync = true;
						defaultTimeSyncChoice = 'Y';
						break;

					case 'R':
						defaultTimeSyncChoice = 'N';
						break;

					default:
						errorAssert("(INTERNAL) Unexpected value choice=" + choice + ".", 8);
						break;
				}

				if (performTimeSync)
				{
					timeMatched = changeFileTime(tfid.file, sfid.time);
				}
			}

			// update report stats
			if (nameMatched && sizeMatched && timeMatched && crcMatched)
			{
				Sync.reportNumKeyMatches_Synchronized++;
			}
		}
	}


	/* Delete unmatched target files */
	private static void processUnmatchedTargetFiles(final ArrayList<FileId> fids)
	{
		if (fids.isEmpty())
		{
			//p("\n\n  No unmatched target files.");
			return;
		}

		char defaultChoice = Sync.deleteUnmatchedTargetFilesMode;

		p("\n\n  " + fids.size() + " unmatched target files to be deleted:");

		// update report stats
		Sync.reportNumUnmatchedTargetFiles += fids.size();

		for (int i = 0; i < fids.size(); i++)
		{
			//p("\n    UT[" + (i + 1) + "]: " + fids.get(i).name);

			char choice = defaultChoice;

			switch (defaultChoice)
			{
				case '\0':
					p("\n    Delete: " + fids.get(i).name + " ? ");
					choice = choicePrompt("(Y)es/(N)o/(A)lways/Neve(R): ", "YNAR");
					break;

				case 'Y':
					p("\n    Deleting: " + fids.get(i).name);
					break;

				case 'N':
					p("\n    Skipping: " + fids.get(i).name);
					break;

				default:
					errorAssert("(INTERNAL) Unexpected value defaultChoice=" + defaultChoice + ".", 8);
					break;
			}

			boolean performDelete = false;

			switch (choice)
			{
				case 'Y':
					performDelete = true;
					break;

				case 'N':
					break;

				case 'A':
					performDelete = true;
					defaultChoice = 'Y';
					break;

				case 'R':
					defaultChoice = 'N';
					break;

				default:
					errorAssert("(INTERNAL) Unexpected value choice=" + choice + ".", 8);
					break;
			}

			if (performDelete)
			{
				if (deleteFile(fids.get(i).file))
				{
					Sync.reportNumUnmatchedTargetFiles_Deleted++;
				}
			}
		}
	}

	/* Copy unmatched source files to target directory */
	private static void processUnmatchedSourceFiles(final ArrayList<FileId> fids, final String targetDirName)
	{
		if (fids.isEmpty())
		{
			//p("\n\n  No unmatched source files.");
			return;
		}

		char defaultChoice = Sync.overwriteExistingTargetFilesMode;

		p("\n\n  " + fids.size() + " unmatched source files to be copied:");

		// update report stats
		Sync.reportNumUnmatchedSourceFiles += fids.size();

		File sf = null;
		File tf = null;

		for (int i = 0; i < fids.size(); i++)
		{
			//p("\n    US[" + (i + 1) + "]: " + fids.get(i).name);
			p("\n    Copying: " + fids.get(i).name);

			sf = fids.get(i).file;
			tf = new File(targetDirName + File.separator + fids.get(i).name);

			boolean performCopy = false;

			if (!tf.exists())
			{
				performCopy = true;
			}
			else if (tf.exists() && tf.isDirectory())
			{
				warningAssert("A target subdirectory of the same name already exists;\nunmatched source file not copied.");
			}
			else if (tf.exists() && tf.isFile())
			{
				// prompt if overwrite

				p("\n      A target file of the same name already exists; ");

				char choice = defaultChoice;

				switch (defaultChoice)
				{
					case '\0':
						p("overwrite file? ");
						choice = choicePrompt("(Y)es/(N)o/(A)lways/Neve(R): ", "YNAR");
						break;

					case 'Y':
						p("overwriting file.");
						break;

					case 'N':
						p("skipping file.");
						break;

					default:
						errorAssert("(INTERNAL) Unexpected value defaultChoice=" + defaultChoice + ".", 8);
						break;
				}

				switch (choice)
				{
					case 'Y':
						performCopy = true;
						break;

					case 'N':
						break;

					case 'A':
						performCopy = true;
						defaultChoice = 'Y';
						break;

					case 'R':
						defaultChoice = 'N';
						break;

					default:
						errorAssert("(INTERNAL) Unexpected value choice=" + choice + ".", 8);
						break;
				}
			}

			if (performCopy)
			{
				if (copyFile(sf, tf))
				{
					Sync.reportNumUnmatchedSourceFiles_Copied++;
				}
			}
		}
	}


	/* Delete unmatched target dirs */
	private static void processUnmatchedTargetDirs(final ArrayList<File> dirs) throws Exception
	{
		if (dirs.isEmpty())
 		{
 			//p("\n\n  No unmatched target subdirectories.");
			return;
 		}

		char defaultChoice = Sync.deleteUnmatchedTargetDirsMode;

		p("\n\n  " + dirs.size() + " unmatched target subdirectories to be deleted:");

		// update report stats
		Sync.reportNumUnmatchedTargetDirs += dirs.size();

		for (int i = 0; i < dirs.size(); i++)
		{
			//p("\n    TUD[" + (i + 1) + "]: \t" + dirs.get(i).getName());

			char choice = defaultChoice;

			switch (defaultChoice)
			{
				case '\0':
					p("\n    Delete: " + dirs.get(i).getName() + File.separator + " and ALL its contents? ");
					choice = choicePrompt("(Y)es/(N)o/(A)lways/Neve(R): ", "YNAR");
					break;

				case 'Y':
					p("\n    Deleting: " + dirs.get(i).getName());
					break;

				case 'N':
					p("\n    Skipping: " + dirs.get(i).getName());
					break;

				default:
					errorAssert("(INTERNAL) Unexpected value defaultChoice=" + defaultChoice + ".", 8);
					break;
			}

			boolean performDelete = false;

			switch (choice)
			{
				case 'Y':
					performDelete = true;
					break;

				case 'N':
					break;

				case 'A':
					performDelete = true;
					defaultChoice = 'Y';
					break;

				case 'R':
					defaultChoice = 'N';
					break;

				default:
					errorAssert("(INTERNAL) Unexpected value choice=" + choice + ".", 8);
					break;
			}

			if (performDelete)
			{
				if (deleteDirTree(dirs.get(i)))
				{
					Sync.reportNumUnmatchedTargetDirs_Deleted++;
				}
			}
		}
	}


	private static ArrayList<FileId> convertFilesToFileIds(final ArrayList<File> files) throws Exception
	{
		final ArrayList<FileId> fids = new ArrayList<FileId>();

		for (File f: files)
		{
			fids.add(new FileId(f));
		}

		Collections.sort(fids);

		return fids;
	}


	private static DirContents getDirContents(final File dir) throws Exception
	{
		errorAssert(dir.exists(),
		            "(INTERNAL) Input " + dir + " to getDirContents() does not exist.",
					8);
		errorAssert(dir.isDirectory(),
		            "(INTERNAL) Input " + dir + " to getDirContents() is not a directory.",
					8);

		final DirContents dc = new DirContents();
		dc.files = new ArrayList<File>();
		dc.dirs = new ArrayList<File>();

		final File listFiles[] = dir.listFiles(); // files and directories

		if (listFiles == null)
		{
			return null;
		}

		for (int i = 0; i < listFiles.length; i ++)
		{
			if (listFiles[i].isFile())
			{
				dc.files.add(listFiles[i]);
			}
			else if (listFiles[i].isDirectory())
			{
				dc.dirs.add(listFiles[i]);
			}
			else
			{
				errorAssert("(INTERNAL) Directory content " + listFiles[i] + " is neither a file nor a directory.", 8);
			}
		}

		Collections.sort(dc.files);
		Collections.sort(dc.dirs);

		return dc;
	}


	private static void validateSourceTarget() throws Exception
	{
		if (Sync.syncMode.equals("Dir-Dir"))
		{
			/* Check if target and source are contained in each other  (exit code 1 for "bad source/target") */
			errorAssert(!Sync.sourceName.equals(Sync.targetName),
			            "The source and target directories cannot be the same.", 1);
			errorAssert(!(Sync.sourceName + File.separator).startsWith(Sync.targetName + File.separator),
						"The source directory cannot be contained within the target directory.", 1);
			errorAssert(!(Sync.targetName + File.separator).startsWith(Sync.sourceName + File.separator),
						"The target directory cannot be contained within the source directory.", 1);

			/* Check that if the target exists, it should be a directory and not a file */
			if (Sync.target.exists())
			{
				errorAssert(Sync.target.isDirectory(),
				            "The target already exists but is not a directory. Could it be a file?", 3);
			}
		}
		else if (Sync.syncMode.equals("File-File"))
		{
			errorAssert(!Sync.sourceName.equals(Sync.targetName),
			            "The source and target files cannot be the same.", 1);
		}
		else if (Sync.syncMode.equals("File-Dir"))
		{
			errorAssert(!trimTrailingSeparator(Sync.source.getParentFile().getCanonicalPath()).equals(Sync.targetName),
						"The source file cannot be contained in the target directory.", 1);
		}
	}


	private static void processArguments(final String[] args) throws Exception
	{
		String err = "";

		CheckArguments:
		do
		{
			/* runs one iteration */

			if (args.length == 0)
			{
				printUsage(); // print help
				System.exit(0);
				break CheckArguments;
			}
			else if (args.length < 2)
			{
				err = "Insufficient arguments.";
				break CheckArguments;
			}

			/* Initialize command-line arguments to default values */
			final String sourceArg = args[args.length - 2];
			final String targetArg = args[args.length - 1];

			/* Process source argument: */
			try
			{
				Sync.sourceName = (new File(sourceArg)).getCanonicalPath();
				Sync.source = new File(Sync.sourceName);
				Sync.sourceName = trimTrailingSeparator(Sync.sourceName);
			}
			catch (Exception e)
			{
				errorAssert("Source \"" + sourceArg + "\" is invalid.\n" + getExceptionMessage(e), 2);
			}

			// check that source exists
			errorAssert(Sync.source.exists(),
					    "The source " + Sync.sourceName + " does not exist.", 2);

			/* Process target argument: */
			try
			{
				Sync.targetName = (new File(targetArg)).getCanonicalPath();
				Sync.target = new File(Sync.targetName);
				Sync.targetName = trimTrailingSeparator(Sync.targetName);
			}
			catch (Exception e)
			{
				errorAssert("Target \"" + targetArg + "\" is invalid.\n" + getExceptionMessage(e), 3);
			}

			/* Decide on synchronization mode */
			if (Sync.source.isDirectory())
			{
				// source is a directory
				Sync.syncMode = "Dir-Dir";
			}
			else if (Sync.source.isFile())
			{
				// source is a file
				if (Sync.target.exists() && Sync.target.isDirectory())
				{
					Sync.syncMode = "File-Dir";
				}
				else
				{
					Sync.syncMode = "File-File";
					Sync.noName = true;
				}
			}

			/* Process switches: */
			for (int i = 0; i < args.length - 2; i ++)
			{
				final String sw = args[i].trim();
				//p("\nSwitch "+i+": <"+sw+">");

				if (sw.startsWith("--match:") ||
				    sw.startsWith("-m:"))
				{
					final String a = sw.substring(sw.indexOf(':') + 1);

					for (int j = 0; j < a.length(); j ++)
					{
						if (a.charAt(j) == 'n')
						{
							Sync.name = true;
						}
						else if (a.charAt(j) == 's')
						{
							Sync.size = true;
						}
						else if (a.charAt(j) == 't')
						{
							Sync.time = true;
						}
						else if (a.charAt(j) == 'c')
						{
							Sync.crc = true;
						}
						else
						{
							err = "Invalid --match parameter " + a.charAt(j) + " specified.";
							break CheckArguments;
						}
					}
				}
				else if (sw.startsWith("--time:") ||
				         sw.startsWith("-t:"))
				{
					final String a = sw.substring(sw.indexOf(':') + 1);

					if (a.length() > 0)
					{
						try
						{
							Sync.timeTolerance = Long.parseLong(a);
						}
						catch (Exception e)
						{
							Sync.timeTolerance = -1;
						}
					}

					if (Sync.timeTolerance < 0)
					{
						err = "Invalid --time parameter " + a + " specified.\nTime tolerance (in milliseconds) must be a nonnegative integer.";
						break CheckArguments;
					}
				}
				else if (sw.equals("--nocrc") ||
				         sw.equals("-c"))
				{
					Sync.noCrc = true;
				}
				else if (sw.startsWith("--rename:"))
				{
					final String a = sw.substring(sw.indexOf(':') + 1);

					if (a.equals("y"))
					{
						Sync.renameMatchedFileMode = 'Y';
					}
					else if (a.equals("n"))
					{
						Sync.renameMatchedFileMode = 'N';
					}
					else
					{
						err = "Invalid --rename parameter " + a + " specified.";
						break CheckArguments;
					}
				}
				else if (sw.startsWith("--timesync:"))
				{
					final String a = sw.substring(sw.indexOf(':') + 1);

					if (a.equals("y"))
					{
						Sync.timeSyncMatchedFileMode = 'Y';
					}
					else if (a.equals("n"))
					{
						Sync.timeSyncMatchedFileMode = 'N';
					}
					else
					{
						err = "Invalid --timesync parameter " + a + " specified.";
						break CheckArguments;
					}
				}
				else if (sw.startsWith("--delfiles:"))
				{
					final String a = sw.substring(sw.indexOf(':') + 1);

					if (a.equals("y"))
					{
						Sync.deleteUnmatchedTargetFilesMode = 'Y';
					}
					else if (a.equals("n"))
					{
						Sync.deleteUnmatchedTargetFilesMode = 'N';
					}
					else
					{
						err = "Invalid --delfiles parameter " + a + " specified.";
						break CheckArguments;
					}
				}
				else if (sw.startsWith("--deldirs:"))
				{
					final String a = sw.substring(sw.indexOf(':') + 1);

					if (a.equals("y"))
					{
						Sync.deleteUnmatchedTargetDirsMode = 'Y';
					}
					else if (a.equals("n"))
					{
						Sync.deleteUnmatchedTargetDirsMode = 'N';
					}
					else
					{
						err = "Invalid --deldirs parameter " + a + " specified.";
						break CheckArguments;
					}
				}
				else if (sw.startsWith("--overwrite:"))
				{
					final String a = sw.substring(sw.indexOf(':') + 1);

					if (a.equals("y"))
					{
						Sync.overwriteExistingTargetFilesMode = 'Y';
					}
					else if (a.equals("n"))
					{
						Sync.overwriteExistingTargetFilesMode = 'N';
					}
					else
					{
						err = "Invalid --overwrite parameter " + a + " specified.";
						break CheckArguments;
					}
				}
				else if (sw.equals("--force") ||
				         sw.equals("-f"))
				{
					Sync.renameMatchedFileMode = 'Y';
					Sync.timeSyncMatchedFileMode = 'Y';
					Sync.deleteUnmatchedTargetFilesMode = 'Y';
					Sync.deleteUnmatchedTargetDirsMode = 'Y';
					Sync.overwriteExistingTargetFilesMode = 'Y';
				}
				else if (sw.equals("--norecurse") ||
				         sw.equals("-r"))
				{
					Sync.noRecurse = true;
				}
				else if (sw.equals("--ignorewarnings") ||
				         sw.equals("-i"))
				{
					Sync.ignoreWarnings = true;
				}
				else if (sw.equals("--simulate") ||
				         sw.equals("-s"))
				{
					Sync.simulateOnly = true;
				}
				else
				{
					err = "Invalid switch " + sw + " specified.";
					break CheckArguments;
				}
			}

			if (!Sync.name && !Sync.size && !Sync.time && !Sync.crc)
			{
				// no match parameters specified; use default
				Sync.name = (Sync.noName) ? false : true;
				Sync.size = true;
				Sync.time = (Sync.noCrc) ? true  : false;
				Sync.crc  = (Sync.noCrc) ? false : true;
			}

			if (Sync.noCrc && Sync.crc)
			{
				err = "Switch --nocrc cannot be used when matching files by CRC.";
				break CheckArguments;
			}

			if (Sync.noName && Sync.name)
			{
				err = "Cannot match files by name when performing File-File synchronization.";
				break CheckArguments;
			}
		}
		while (false);

		/* Invalid command-line arguments encountered */
		if (err.length() > 0)
		{
			p("\nERROR: " + err);
			p("\nTo display help, run Sync without any command-line arguments.\n");
			System.exit(10); // bad command-line arguments
		}
	}


	private static boolean renameFile(final File oldf, final File newf)
	{
		if (Sync.simulateOnly) return false;

		if (!oldf.exists() || !oldf.isFile())
		{
			errorAssert("(INTERNAL) Input oldf=" + oldf + " to renameFile() is not a file.", 42);
			return false;
		}

		if (newf.exists())
		{
			errorAssert("(INTERNAL) Input newf=" + newf + " to renameFile() already exists.", 42);
			return false;
		}

		boolean success = false;

		try
		{
			success = oldf.renameTo(newf);
		}
		catch (Exception e)
		{
			warningAssert("Unable to rename file " + oldf + ".\n" + getExceptionMessage(e));
		}

		return success;
	}


	private static boolean changeFileTime(final File f, final long time)
	{
		if (Sync.simulateOnly) return false;

		if (!f.exists() || !f.isFile())
		{
			errorAssert("(INTERNAL) Input f=" + f + " to changeFileTime() is not a file.", 42);
			return false;
		}

		boolean success = false;
		String exceptionMessage = "";

		try
		{
			success = f.setLastModified(time);
		}
		catch (Exception e)
		{
			exceptionMessage = "\n" + getExceptionMessage(e);
		}

		if (!success)
		{
			warningAssert("Unable to change time of file " + f + "." + exceptionMessage);
		}

		return success;
	}


	private static boolean changeDirTime(final File d, final long time)
	{
		if (Sync.simulateOnly) return false;

		if (!d.exists() || !d.isDirectory())
		{
			errorAssert("(INTERNAL) Input d=" + d + " to changeDirTime() is not a directory.", 42);
			return false;
		}

		boolean success = false;
		String exceptionMessage = "";

		try
		{
			success = d.setLastModified(time);
		}
		catch (Exception e)
		{
			exceptionMessage = "\n" + getExceptionMessage(e);
		}

		if (!success)
		{
			warningAssert("Unable to change time of directory " + d + "." + exceptionMessage);
		}

		return success;
	}


	private static boolean createDir(final File d)
	{
		if (Sync.simulateOnly) return false;

		boolean success = false;

		try
		{
			success = d.mkdirs();
		}
		catch (Exception e)
		{
			warningAssert("Unable to create directory " + d + ".\n" + getExceptionMessage(e));
		}

		return success;
	}


	private static boolean deleteDirTree(final File dir) throws Exception
	{
		if (Sync.simulateOnly) return false;

		if (!dir.exists() || !dir.isDirectory())
		{
			errorAssert("(INTERNAL) Input " + dir + " to deleteDirTree() is not a directory.", 42);
			return false;
		}

		final DirContents dc = getDirContents(dir);

		// delete files
		for (File f: dc.files)
		{
			deleteFile(f);
		}

		// delete directories recursively
		for (File d: dc.dirs)
		{
			deleteDirTree(d);
		}

		// delete this directory itself
		final boolean success = deleteDir(dir);

		return success;
	}


	private static boolean deleteDir(final File d)
	{
		if (Sync.simulateOnly) return false;

		if (!d.exists() || !d.isDirectory())
		{
			errorAssert("(INTERNAL) Input " + d + " to deleteDir() is not a directory.", 42);
			return false;
		}

		boolean success = false;

		try
		{
			success = d.delete();
		}
		catch (Exception e)
		{
			warningAssert("Unable to delete directory " + d + ".\n" + getExceptionMessage(e));
		}

		return success;
	}


	private static boolean deleteFile(final File f)
	{
		if (Sync.simulateOnly) return false;

		if (!f.exists() || !f.isFile())
		{
			errorAssert("(INTERNAL) Input " + f + " to deleteFile() is not a file.", 42);
			return false;
		}

		boolean success = false;

		try
		{
			success = f.delete();
		}
		catch (Exception e)
		{
			warningAssert("Unable to delete file " + f + ".\n" + getExceptionMessage(e));
		}

		return success;
	}


	private static boolean copyFile(final File s, final File t)
	{
		if (Sync.simulateOnly) return false;

		final byte byteBuffer[] = new byte[BUFFER_SIZE];
		final File tParentDir = t.getParentFile();
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;

		try
		{
			bis = new BufferedInputStream(new FileInputStream(s));
		}
		catch (Exception e)
		{
			warningAssert("Unable to open source file " + s + " for reading; copy failed.\n" + getExceptionMessage(e));
			return false;
		}

		if (!tParentDir.exists())
		{
			// target subdirectory does not exist, so we create it
			createDir(tParentDir);
		}

		if ((!tParentDir.exists()) || (!tParentDir.isDirectory()))
		{
			warningAssert("Unable to create subdirectory " + tParentDir + " to contain target file; copy failed.");
			return false;
		}

		try
		{
			bos = new BufferedOutputStream(new FileOutputStream(t));
		}
		catch (Exception e)
		{
			warningAssert("Unable to open target file " + t + " for writing; copy failed.\n" + getExceptionMessage(e));
			return false;
		}

		int byteCount;

		try
		{
			while ((byteCount = bis.read(byteBuffer, 0, BUFFER_SIZE)) != -1)
			{
				bos.write(byteBuffer, 0, byteCount);
			}
		}
		catch (Exception e)
		{
			warningAssert("Unable to copy data from source file " + s + " to target file " + t + "; copy failed.\n" + getExceptionMessage(e));
			return false;
		}

		try
		{
			bis.close();
		}
		catch (Exception e)
		{
			warningAssert("Unable to close source file " + s + " after reading; copy may be unsuccessful.\n" + getExceptionMessage(e));
			return false;
		}

		try
		{
			bos.close();
		}
		catch (Exception e)
		{
			warningAssert("Unable to close target file " + t + " after writing; copy may be unsuccessful.\n" + getExceptionMessage(e));
			return false;
		}

		return changeFileTime(t, s.lastModified());
	}


	/**
	* computeFileCrc()
	* Computes the CRC32 checksum of a file.
	*
	* @params f  The file whose CRC32 is to be computed.
	* @returns The CRC32 checksum value.
	*/
	private static long computeFileCrc(final File f)
	{
		if (!f.isFile())
		{
			return 0;
		}

		try
		{
			final byte byteBuffer[] = new byte[BUFFER_SIZE];
			final CRC32 crc32 = new CRC32();
			final FileInputStream fis = new FileInputStream(f);
			int byteCount;

			while ((byteCount = fis.read(byteBuffer, 0, BUFFER_SIZE)) != -1)
			{
				crc32.update(byteBuffer, 0, byteCount);
			}

			fis.close();
			return crc32.getValue();
		}
		catch (Exception e)
		{
			warningAssert("Unable to compute CRC-32 checksum of " + f + ";\nassuming checksum = 0 instead.\n" + getExceptionMessage(e));
		}

		return 0; // reached only on exception
	}



	private static String trimTrailingSeparator(final String a_)
	{
		String a = a_;

		while (a.endsWith(File.separator))
		{
			a = a.substring(0, a.length() - 1);
		}

		return a;
	}


	private static char choicePrompt(final String prompt, final String options_)
	{
		if (Sync.simulateOnly) return 'N';

		// case-insensitive comparison
		final String options = options_.toUpperCase(Locale.US);

		try
		{
			final BufferedReader kb = new BufferedReader(new InputStreamReader(System.in));

			String choice = "";
			char c = '\0';

			while (true)
			{
				p(prompt);

				choice = kb.readLine().trim().toUpperCase();

				if (choice.length() != 1) continue;

				c = choice.charAt(0); // convert to char

				if (options.indexOf(c) >= 0) return c;
			}
		}
		catch (Exception e)
		{
			errorAssert("(FATAL) Cannot read from keyboard.\n" + getExceptionMessage(e), 42);
		}

		return '\0';
	}


	private static void pausePrompt(final String prompt)
	{
		if (Sync.simulateOnly) return;

		try
		{
			final BufferedReader kb = new BufferedReader(new InputStreamReader(System.in));

			p(prompt);

			kb.readLine().trim().toUpperCase();
		}
		catch (Exception e)
		{
			errorAssert("(FATAL) Cannot read from keyboard.\n" + getExceptionMessage(e), 42);
		}
	}


	/**
	* warningAssert()
	* Print a warning message and pause, if assertion of the condition fails.
	*
	* @params condition  Test condition.
	* @params toPrint    Warning message to be printed.
	*/
	private static void warningAssert(
	        final boolean condition,
	        final Object toPrint,
			final boolean noPause)
	{
		if (!condition)
		{
			Sync.reportNumWarnings++;

			p("\nWARNING: " + toPrint + "\n");

			if (Sync.simulateOnly) return;

			if (noPause) return;

			pausePrompt("Press ENTER to continue...");
		}
	}

	private static void warningAssert(final boolean condition, final Object toPrint)
	{
		warningAssert(condition, toPrint, Sync.ignoreWarnings);
	}

	private static void warningAssert(final Object toPrint)
	{
		warningAssert(false, toPrint, Sync.ignoreWarnings);
	}


	/**
	* errorAssert()
	* Print an error message and terminate program if assertion of the condition fails.
	*
	* @params condition  Test condition.
	* @params toPrint    Error message to be printed.
	* @params exitCode   Exit code to be returned to the operating system.
	*/
	private static void errorAssert(
	        final boolean condition,
	        final Object toPrint,
	        final int exitCode)
	{
		if (!condition)
		{
			p("\nERROR: " + toPrint);

			if (Sync.syncStarted)
			{
				printReportStatistics();
				p("\n\nSync was aborted because of an error.\n\n");
			}
			else
			{
				p("\nSync aborted.\n\n");
			}

			System.exit(exitCode);
		}
	}

	private static void errorAssert(final Object toPrint, final int exitCode)
	{
		errorAssert(false, toPrint, exitCode);
	}


	/* Custom exception message */
	private static String getExceptionMessage(final Exception e)
	{
		final StackTraceElement[] stackTrace = e.getStackTrace();
		final StringBuffer a = new StringBuffer();

		a.append("\nJAVA EXCEPTION INFORMATION (" + e.getClass() + "):" +
		         "\n\"" + e.getMessage() + "\"");

		for (int i = 0; i < stackTrace.length; i++)
		{
			a.append("\n  at " + stackTrace[i]);
		}

		a.append("\n");
		return a.toString();
	}


	/**
	* p()
	* General purpose method for printing to standard output.
	*
	* @params o The object to be printed.
	*/
	private static void p(final Object o)
	{
		System.out.print(o + "");
	}


	private static String getKeyString(
		final boolean n,
		final boolean s,
		final boolean t,
		final boolean c)
	{
		final String a = "("
			+ ((!Sync.noName && n) ? "name," : "")
			+ ((s) ? "size," : "")
			+ ((t) ? "time," : "")
			+ ((!Sync.noCrc && c) ? "CRC,"  : "");

		if (a.length() <= 1) return "()";

		return a.substring(0, a.length() - 1) + ")";
	}

	private static String getKeyString()
	{
		return getKeyString(Sync.name, Sync.size, Sync.time, Sync.crc);
	}


	/*
	 * INNER CLASSES:
	 */

	static class DirContents
	{
		public ArrayList<File> files = null;
		public ArrayList<File> dirs  = null;
	}


	static class FileKey implements Comparable<FileKey>
	{
		public String name = "";
		public long size = 0;
		public long time = 0;
		public long crc  = 0;


		FileKey(FileId fid)
		{
			this.name = (Sync.name) ? fid.name : "";
			this.size = (Sync.size) ? fid.size : 0;
			this.time = (Sync.time) ? fid.time : 0;
			this.crc  = (Sync.crc)  ? fid.crc  : 0;
		}


		public int compareTo(final FileKey o)
		{
			/* returns "this - o" */
			int i = 0;
			long l = 0;

			/* compare names */
			i = this.name.compareTo(o.name);
			if (i != 0) return i;

			/* compare sizes */
			l = this.size - o.size;
			if (l != 0) return (l < 0) ? -1 : 1;

			/* compare times */
			l = this.time - o.time;
			if (l != 0) return (l < 0) ? -1 : 1;

			/* compare crcs */
			l = this.crc - o.crc;
			if (l != 0) return (l < 0) ? -1 : 1;

			/* end-of-comparison */
			return 0;
		}
	}


	static class FileId implements Comparable<FileId>
	{
		public File file = null;
		public String name = "";
		public long size = 0;
		public long time = 0;
		public long crc  = 0;

		public long keyMatchScore = 0;
		public long nstcMatchScore = 0;
		public long timeDifference = 0;


		FileId(File f) throws Exception
		{
			this.file = f;
			this.name = (Sync.noName) ? "" : f.getName();
			this.size = f.length();
			this.time = f.lastModified();
			this.crc  = (Sync.noCrc) ? 0 : computeFileCrc(f);
		}


		public FileKey getFileKey()
		{
			return (new FileKey(this));
		}

		public String timeString()
		{
			return (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS", Locale.US)).format(new Date(this.time));
		}

		public String crcString()
		{
			return Long.toHexString(this.crc).toUpperCase();
		}

		public String toString()
		{
			return ((Sync.noName) ? "" : "\n      Name : \"" + this.name + "\"")
				+ "\n      Size : " + this.size + " bytes"
				+ "\n      Time : " + this.timeString()
				+ ((Sync.noCrc) ? "" : "\n      CRC  : " + this.crcString());
		}


		public void computeMatchScore(final FileId mfid)
		{
			this.keyMatchScore = 0;  // using only match-key attributes
			this.nstcMatchScore = 0; // using all file attributes: Name, Size, Time, CRC
			this.timeDifference = 0;

			if (!this.name.equals(mfid.name))
			{
				this.nstcMatchScore += 1;
				if (Sync.name) this.keyMatchScore += 1;
			}

			if (this.size != mfid.size)
			{
				this.nstcMatchScore += 1;
				if (Sync.size) this.keyMatchScore += 1;
			}

			this.timeDifference = Math.abs(this.time - mfid.time);

			if (this.timeDifference > Sync.timeTolerance)
			{
				this.nstcMatchScore += 1;
				if (Sync.time) this.keyMatchScore += 1;
			}

			if (this.crc != mfid.crc)
			{
				this.nstcMatchScore += 1;
				if (Sync.crc) this.keyMatchScore += 1;
			}
		}


		public boolean isKeyMatch()
		{
			return (this.keyMatchScore == 0);
		}


		public boolean isPerfectMatch()
		{
			return ((this.nstcMatchScore == 0) && (this.timeDifference == 0));
		}


		public String matchScoreString()
		{
			return "(" + this.keyMatchScore + "," + this.nstcMatchScore + "," + this.timeDifference + ")";
		}

		/* Comparison of match scores */
		public int compareTo(final FileId o)
		{
			long l = 0;

			/* compare "key" subscore */
			l = this.keyMatchScore - o.keyMatchScore;
			if (l != 0) return (l < 0) ? -1 : 1;

			/* compare "NSTC" subscore */
			l = this.nstcMatchScore - o.nstcMatchScore;
			if (l != 0) return (l < 0) ? -1 : 1;

			/* compare time difference */
			l = this.timeDifference - o.timeDifference;
			if (l != 0) return (l < 0) ? -1 : 1;

			/* end-of-comparison */
			return 0;
		}
	}


	static class SourceTargetFileIdPair
	{
		public FileId sourceFileId = null;
		public FileId targetFileId = null;

		SourceTargetFileIdPair(FileId sfid, FileId tfid)
		{
			this.sourceFileId = sfid;
			this.targetFileId = tfid;
		}
	}

}


/*
BUILD NOTES:

Compile:
javac -Xlint Sync.java

Package into JAR executable:
jar cvfm Sync.jar manifest.txt Sync*.class
*/
