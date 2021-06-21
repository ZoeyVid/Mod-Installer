@echo off
curl --output %0 --url https://download.san0j.de/mods/Installer.bat
C:
if exist %userprofile%\AppData\Roaming\.minecraft (
if exist "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" (


echo Instalation starten?
Pause
cd %userprofile%\AppData\Roaming\.minecraft
curl --output Mod-Installer.bat --url https://download.san0j.de/mods/Mod-Installer.bat
curl --output MC-Launcher.bat --url https://download.san0j.de/mods/MC-Launcher.bat
CLS
echo Scripte erfolgreich in "%userprofile%\AppData\Roaming\.minecraft" gespeichert!
echo DesktopverkÅpfungen erstellen?
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
echo oLink.IconLocation = "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" >> %SCRIPT%
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
echo oLink.IconLocation = "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%
CLS
echo Fertig
Pause
GOTO end

:end
CLS
echo.
ECHO Installer Lîschen?
ECHO 1. Ja
ECHO 2. Nein
ECHO.
CHOICE /C 12 /M "Auswahl: "
IF ERRORLEVEL 2 GOTO exit
IF ERRORLEVEL 1 GOTO del

:del
del /S /Q %0
exit /B

:exit
exit /B

) else (
curl --output %0 --url https://download.san0j.de/mods/MC-Launcher.bat

	CLS
	echo Minecraft Launcher konnte nicht am öblichen Pfad gefunden werden!
	echo Unter "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe"
	echo Installer wird beendet...
	Pause
	
)

)   else (
curl --output %0 --url https://download.san0j.de/mods/MC-Launcher.bat

    CLS
    echo .minecraft Ordner nicht am Åblichen Pfad oder nicht vorhanden. 
	echo Unter "%userprofile%\AppData\Roaming\.minecraft"
	echo Starten von Minecraft nicht mîglich
	echo Installer wird beendet...
	Pause
)