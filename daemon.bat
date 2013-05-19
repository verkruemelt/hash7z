@ECHO OFF
SET source="C:\Users"
SET backup="D:\backup\profiles"
SET prefix=""
SET suffix=""
SET seconds=300
SET "fastest=-mx1 -md=64k -mfb=32 -ms=8m"
SET "fast=-mx3 -md=1m -mfb=32 -ms=128m"
SET "normal=-mx5 -md=16m -mfb=32 -ms=2g"
SET "maximum=-mx7 -md=32m -mfb=64 -ms=4g"
SET "ultra=-mx9 -md=64m -mfb=64 -ms=4g"
REM %fastest% %fast% %normal% %maximum% %ultra%
SET compress=%fastest%
REM crc32 ed2k md4 md5 sha1
SET alg=crc32
SET index=hash\index.%alg%
SET check=hash\check.%alg%
IF %processor_architecture% == x86 (SET hash=bin\%alg%sum.exe)
IF %processor_architecture% == AMD64 (SET hash=bin\%alg%sum64.exe)
TITLE hash7z - %source% ^> %backup%
:loop
CLS
IF NOT EXIST %index% (
	ECHO create index..
	%hash% -r %source%\* > %index%
	)
CLS
ECHO check index..
%hash% -r %source%\* > %check%
CLS
FOR /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
SET datetime=%ldt:~0,4%-%ldt:~4,2%-%ldt:~6,2%_%ldt:~8,2%%ldt:~10,2%%ldt:~12,2%
ECHO last check @ %datetime%
FC %index% %check% > NUL
IF %errorlevel% EQU 0 (
	DEL %check%
	) ELSE (
	MOVE %check% %index% > NUL
	bin\7za.exe a -t7z -m0=LZMA -mmt=on %compress% -sccUTF-8 -w%backup% %backup%\%prefix%%datetime%%suffix%.7z %source%
	ECHO backup created @ %datetime%
	)
timeout /T %seconds% > NUL
GOTO loop
