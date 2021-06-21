@echo off
curl --output %0 --url https://download.san0j.de/mods/Installer.bat

echo Instalation starten?
Pause
cd %userprofile%\AppData\Roaming\.minecraft
curl --output Mod-Installer.bat --url https://download.san0j.de/mods/Mod-Installer.bat
curl --output MC-Launcher.bat --url https://download.san0j.de/mods/MC-Launcher.bat
CLS
echo Scripte erfolgreich in "%userprofile%\AppData\Roaming\.minecraft" gespeichert!
echo Desktopverkpfungen erstellen?
echo.
ECHO 1. Ja
ECHO 2. Nein
ECHO.
CHOICE /C 12 /M "Auswahl: "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO sc
	
:sc
GOTO l

:l
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\MC-Launcher.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo oLink.Arguments = "/C %userprofile%\AppData\Roaming\.minecraft\MC-Launcher.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%
GOTO i

:i
CLS
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\Mod-Installer.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo oLink.Arguments = "/C %userprofile%\AppData\Roaming\.minecraft\Mod-Installer.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%
CLS
echo Fertig
Pause
GOTO end

:end
exit /B