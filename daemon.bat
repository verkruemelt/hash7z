@ECHO OFF

SET source="C:\Windows"
SET backup="backup"
SET prefix=""
SET suffix=""
SET seconds=300
SET fastest=-mx1 -md=64k -mfb=32 -ms=8m
SET fast=-mx3 -md=1m -mfb=32 -ms=128m
SET normal=-mx5 -md=16m -mfb=32 -ms=2g
SET maximum=-mx7 -md=32m -mfb=64 -ms=4g
SET ultra=-mx9 -md=64m -mfb=64 -ms=4g
IF %processor_architecture% == x86 (SET sha1=sha1sum.exe)
IF %processor_architecture% == AMD64 (SET sha1=sha1sum64.exe)

:loop
IF NOT EXIST HASH (%sha1% -r %source%\* > HASH)
%sha1% -r %source%\* > CHECK
FC HASH CHECK
IF %errorlevel% == 1 (
	MOVE CHECK HASH
	7za.exe a -t7z -m0=LZMA -mmt=on %fastest% -sccUTF-8 -w%backup% %backup%\%prefix%%date:~6,4%-%date:~3,2%-%date:~0,2%" "%time:~0,2%-%time:~3,2%-%time:~6,2%%suffix%.7z %source%
	echo backup created @ %date:~6,4%-%date:~3,2%-%date:~0,2% %time:~0,2%-%time:~3,2%-%time:~6,2%
	
	)
timeout /T %seconds% > NUL
CLS
GOTO loop