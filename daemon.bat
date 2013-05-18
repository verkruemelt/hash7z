@ECHO OFF
TITLE SHA seventeen Zip
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
SET compress=%fastest%
IF %processor_architecture% == x86 (SET sha1=sha1sum.exe)
IF %processor_architecture% == AMD64 (SET sha1=sha1sum64.exe)
:loop
CLS
IF NOT EXIST INDEX (
	ECHO create index..
	%sha1% -r %source%\* > INDEX
	)
CLS
ECHO check index..
%sha1% -r %source%\* > CHECK
CLS
FOR /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
SET datetime=%ldt:~0,4%-%ldt:~4,2%-%ldt:~6,2%_%ldt:~8,2%%ldt:~10,2%%ldt:~12,2%
ECHO Last check @ %datetime%
FC INDEX CHECK > NUL
IF %errorlevel% NEQ 0 (
	MOVE CHECK INDEX > NUL
	7za.exe a -t7z -m0=LZMA -mmt=on %compress% -sccUTF-8 -w%backup% %backup%\%prefix%%datetime%%suffix%.7z %source%
	ECHO backup created @ %datetime%
	)
timeout /T %seconds% > NUL
GOTO loop
