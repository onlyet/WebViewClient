@echo off
setlocal

rem The format of %TIME% is HH:MM:SS,CS for example 23:59:59,99
set STARTTIME=%TIME%

rem here begins the command you want to measure

REM 生成文件-用来显示打包时间
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
echo currentTime: "%fullstamp%"
rem echo %fullstamp% > ..\FileToInstall\PackTime.txt


REM 创建打包目录Release
SET releaseFolder=..\Release
IF NOT EXIST %releaseFolder% (
		MD %releaseFolder%
)

FOR /F "delims=" %%A IN ('git show --pretty^=format:"%%ci %%cr" ..\..\..\') DO (
    SET TEMPVAR=%%A
    GOTO :Print 
)

:Print
ECHO %TEMPVAR%

FOR /F "tokens=1-2 delims= " %%1 IN ("%TEMPVAR%") DO SET VER=%%1%%2
rem ECHO %VER%
SET VER=%VER:-=%
rem ECHO %VER%
SET VER=%VER::=%
rem ECHO %VER%
SET VER=%VER:~2%
ECHO %VER%

"makensis.exe" -DVER=%VER% "WebViewClient.nsi"

rem here ends the command you want to measure

set ENDTIME=%TIME%

rem output as time
echo STARTTIME: %STARTTIME%
echo ENDTIME: %ENDTIME%

rem convert STARTTIME and ENDTIME to centiseconds
set /A STARTTIME=(1%STARTTIME:~0,2%-100)*360000 + (1%STARTTIME:~3,2%-100)*6000 + (1%STARTTIME:~6,2%-100)*100 + (1%STARTTIME:~9,2%-100)
set /A ENDTIME=(1%ENDTIME:~0,2%-100)*360000 + (1%ENDTIME:~3,2%-100)*6000 + (1%ENDTIME:~6,2%-100)*100 + (1%ENDTIME:~9,2%-100)

rem calculating the duratyion is easy
set /A DURATION=%ENDTIME%-%STARTTIME%

rem we might have measured the time inbetween days
if %ENDTIME% LSS %STARTTIME% set set /A DURATION=%STARTTIME%-%ENDTIME%

rem now break the centiseconds down to hors, minutes, seconds and the remaining centiseconds
set /A DURATIONH=%DURATION% / 360000
set /A DURATIONM=(%DURATION% - %DURATIONH%*360000) / 6000
set /A DURATIONS=(%DURATION% - %DURATIONH%*360000 - %DURATIONM%*6000) / 100
set /A DURATIONHS=(%DURATION% - %DURATIONH%*360000 - %DURATIONM%*6000 - %DURATIONS%*100)

rem some formatting
if %DURATIONH% LSS 10 set DURATIONH=0%DURATIONH%
if %DURATIONM% LSS 10 set DURATIONM=0%DURATIONM%
if %DURATIONS% LSS 10 set DURATIONS=0%DURATIONS%
if %DURATIONHS% LSS 10 set DURATIONHS=0%DURATIONHS%

rem outputing
echo 打包耗时: %DURATIONH%:%DURATIONM%:%DURATIONS%,%DURATIONHS%
echo ----------------------------------------------------------------------------------------

endlocal
pause