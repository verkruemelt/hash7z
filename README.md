SHA1-7Zip  
=========  
  
simple backup script  
inspired by git-scm  
  
creates and checks the sha1 hash of files (sha1sum) in a given source folder  
if any file has changed the entire folder will be compressed and backed up (7zip)  
  
  
7-Zip Command line version 9.20 by Igor Pavlov  
hashutils-1.2.4-redist by code.kliu.org  
  
  
Usage  
-----------  
change the parameters to your needs:  
* source="C:\Windows"	// root data directory  
* backup="backup"		// destination folder of backup; here relative  
* prefix=""				// prefix of the backup file name  
* suffix=""				// suffix of the backup file name  
* seconds=300			// time to wait before start over  
(no backslash at the end of source and backup path)  
  
start daemon.bat  
  
  
ToDo  
-----------  
* parameterisation of compression ratio for easier usage  
* delete old backups  
  
  
  
use at your own risk