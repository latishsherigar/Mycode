 *****************************************************************************
 *                            Release Notes for                              *
 *                                  Sync                                     *
 *                           v 0.2 (2007-03-30)                              *
 *                       Copyright 2007 Zach Scrivena                        *
 *                         <zachscrivena@gmail.com>                          *
 *****************************************************************************

Sync is a simple command-line utility for performing one-way directory or
file synchronization. It synchronizes the specified target to match the
specified source. Only the target is modified.


Main Features
-------------
 - FLEXIBLE FILE MATCHING: Match files by any combination of name, size,
   last-modified time, and CRC-32 checksum; by default, (name,size,CRC)
   is used.

 - FLEXIBLE FILE TIME COMPARISON: Specify a time allowance (in number of
   milliseconds) when matching files by their last-modified time.

 - SIMULATION MODE: Sync can be run to simulate file operations, so that
   the target directory is not modified.

 - UNATTENDED USAGE: With an appropriate choice of switches, Sync can be
   executed without user intervention.


System Requirements
-------------------
 A Java Runtime Environment (JRE 5.0+) is required. The latest version of the
 JRE can be downloaded from <http://java.sun.com/j2se>.


License
-------
 Sync is released with source code under the GNU General Public License
 (version 2). The license document can be found in license.txt.


Installation & Execution
------------------------
 The Sync utility is downloaded as a single Zip file with the following
 contents:

 Sync.jar              Sync executable JAR archive
 readme.txt            Release notes (this file)
 license.txt           License document (GNU GPL v2)
 source/Sync.java      Source file
 source/manifest.txt   Manifest file for packaging JAR archive
 unix/Sync             Unix/Linux script for executing Sync
 windows/Sync.bat      Windows batch file for executing Sync

 No installation is necessary — just unzip the downloaded file and you are
 ready to go. Assuming that the executable JAR archive Sync.jar is in
 the current directory, simply execute the following at the command-line:

   java -jar Sync.jar

 Several pages of documentation (usage syntax, notes, and examples) should
 fill the screen. The use of the Windows batch file (windows/Sync.bat)
 or the Unix/Linux script (unix/Sync) is recommended because it enables
 you to simply execute Sync instead of java -jar Sync.jar.
 Further instructions are given in the respective files.


Documentation: Usage Syntax, Notes, and Examples
------------------------------------------------
USAGE:  java -jar Sync.jar   <switches>   ["Source"]   ["Target"]

Sync synchronizes ["Target"] to match ["Source"]. Only ["Target"] is modified.
The synchronization mode depends on the ["Source"]-["Target"] pair specified:

 * Directory-Directory: Sync will match the contents of the source and target
                          directories recursively.
 * File-File          : Sync will match the source and target files.
 * File-Directory     : Sync will try to match the source file to a file in the
                          target directory.

<Switches>:
 -m, --match:[n|s|t|c]   Use specified file attributes for matching source and
                          target files. By default, --match:nsc is used.
                          File attributes:
                            n   Name (see note 1)
                            s   Size
                            t   last-modified Time (see note 2)
                            c   CRC-32 Checksum
 -t, --time:x            Use time-tolerance of x milliseconds (where x is a
                          nonnegative integer) when matching files.
                          By default, --time:0 is used.
 -c, --nocrc             Do not compute CRC-32 checksums (see note 3)
     --rename:[y|n]      Always[y]/never[n] rename matched target files
     --timesync:[y|n]      ... synchronize time of matched target files
     --delfiles:[y|n]      ... delete unmatched target files
     --deldirs:[y|n]       ... delete unmatched target directories
     --overwrite:[y|n]     ... overwrite existing target files
 -f, --force             Equivalent to the combination: --rename:y --timesync:y
                          --delfiles:y --deldirs:y --overwrite:y
 -r, --norecurse         Do not recurse into subdirectories
 -i, --ignorewarnings    Do not pause on warnings (see note 4)
 -s, --simulate          Simulate only, i.e. target is not modified

NOTES:

 1. File names are not used for matching in File-File synchronization.
 2. Sync uses millisecond-resolution time comparisons. This may be finer than
     the resolution supported by some file systems. To avoid file mismatches
     across different file systems, --time:1000 or more could be specified.
 3. If switch --nocrc is specified, then --match:nst is assumed instead
     of --match:nsc.
 4. By default, Sync always pauses to warn the user when any file operation is
     unsuccessful or when it thinks a file match is poor (e.g. files have
     different checksums).

EXAMPLES:

 1. Synchronize target "C:\BACKUP" to look like source "C:\MASTER",
     matching files by (name,size,CRC):
       java -jar Sync.jar "C:\MASTER" "C:\BACKUP"
 2. As in example 1, but never delete unmatched target files or directories:
       java -jar Sync.jar --delfiles:n --deldirs:n "C:\MASTER" "C:\BACKUP"
 3. As in example 1, but match files by (name,size,time) with 2-second time
     tolerance instead:
       java -jar Sync.jar --match:nst --time:2000 "C:\MASTER" "C:\BACKUP"
 4. As in example 1, but always rename and synchronize time of matched target
     files, delete unmatched target files and directories, and overwrite
     existing target files:
       java -jar Sync.jar --force "C:\MASTER" "C:\BACKUP"


Feedback?
---------
 Comments, suggestions, and bug reports are welcomed! Please send any feedback
 you have about Sync to <zachscrivena@gmail.com>.

 The latest version of Sync can be obtained from
 <http://zs.freeshell.org/sync.html>.
