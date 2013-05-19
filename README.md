SHA1-7Zip  
=========  
  
simple backup script, inspired by git-scm  
  
creates and checks the hashsum of files in a given source folder  
if any file has changed the entire folder will be compressed and backed up by 7zip  
  
License  
-------  
7-Zip Command line version 9.20 by Igor Pavlov  
* GNU LGPL + unRAR restrictions  
hashutils-1.2.4-redist by code.kliu.org  
* BSD(?)
the script itself
* GNU LGPL
  
  
Usage  
-----------  
change the parameters to your needs:  
* source="C:\Users"		// root data directory  
* backup="D:\backup"	// destination folder of backup
* prefix=""				// prefix of the backup file name  
* suffix=""				// suffix of the backup file name  
* seconds=3600			// time to wait before start over  
* compress=%fastest%	// compress ratio: fastest; fast; normal; maximum; ultra  
* alg=crc32				// hash algorithms: crc32; ed2k; md4; md5; sha1  
  
(no backslash at the end of source and backup path)  
  
start daemon.bat  
  
  
ToDo  
----  
* automaticly delete old backups  
  
  
use at your own risk