@echo off
curl --output %0 --url https://download.san0j.de/mods/Installer.bat
C:


if not exist "%userprofile%\AppData\Roaming\.minecraft" (

    CLS
    echo .minecraft Ordner nicht am blichen Pfad oder nicht vorhanden. 
	echo Unter "%userprofile%\AppData\Roaming\.minecraft"
	echo Installer wird beendet...
	Pause
)

if not exist "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" (

	CLS
	echo Minecraft Launcher konnte nicht am šblichen Pfad gefunden werden!
	echo Unter "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe"
	echo Installer wird beendet...
	Pause
	
)


CLS
ECHO.
ECHO 1. Installieren/Reparieren
ECHO 2. Entfernen
ECHO.
CHOICE /C 12 /M "Auswahl: "
IF ERRORLEVEL 2 GOTO rm
IF ERRORLEVEL 1 GOTO is


:is
echo Instalation starten?
Pause
cd "%userprofile%\AppData\Roaming\.minecraft"
curl --output Mod-Installer.bat --url https://download.san0j.de/mods/Mod-Installer.bat
curl --output MC-Launcher.bat --url https://download.san0j.de/mods/MC-Launcher.bat
curl --output Installer-Uninstaller.bat --url https://download.san0j.de/mods/Installer.bat
curl --output Donwload.ico --url https://download.san0j.de/mods/Download.ico
curl --output Installer.ico --url https://download.san0j.de/mods/Installer.ico

mkdir "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Mod-Installer"

CLS
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Mod-Installer\MC-Launcher.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo oLink.Arguments = "/C %userprofile%\AppData\Roaming\.minecraft\MC-Launcher.bat" >> %SCRIPT%
echo oLink.IconLocation = "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%


set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Mod-Installer\Mod-Installer.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo oLink.Arguments = "/C %userprofile%\AppData\Roaming\.minecraft\Mod-Installer.bat" >> %SCRIPT%
echo oLink.IconLocation = "%userprofile%\AppData\Roaming\.minecraft\Donwload.ico" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%


set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Mod-Installer\Installer-Uninstaller.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo oLink.Arguments = "/C %userprofile%\AppData\Roaming\.minecraft\Installer-Uninstaller.bat" >> %SCRIPT%
echo oLink.IconLocation = "%userprofile%\AppData\Roaming\.minecraft\Installer.ico" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%

CLS
echo Scripte erfolgreich in "%userprofile%\AppData\Roaming\.minecraft" gespeichert!
echo Desktopverkpfungen erstellen?
echo.
ECHO 1. Ja
ECHO 2. Nein
ECHO.
CHOICE /C 12 /M "Auswahl: "
IF ERRORLEVEL 2 GOTO if
IF ERRORLEVEL 1 GOTO l

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


CLS
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\Mod-Installer.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo oLink.Arguments = "/C %userprofile%\AppData\Roaming\.minecraft\Mod-Installer.bat" >> %SCRIPT%
echo oLink.IconLocation = "%userprofile%\AppData\Roaming\.minecraft\Donwload.ico" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%
GOTO if

:if
CLS
echo Fertig
Pause
GOTO end

:end
exit /B


:rm
CLS
ECHO.
ECHO Wirklich entfernen?
ECHO.
ECHO 1. Ja
ECHO 2. Nein
ECHO.
CHOICE /C 12 /M "Auswahl: "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO rmy

:rmy
del /S /Q %userprofile%\AppData\Roaming\.minecraft\Donwload.ico
del /S /Q %userprofile%\AppData\Roaming\.minecraft\Installer.ico
del /S /Q %userprofile%\AppData\Roaming\.minecraft\Installer-Uninstaller.bat
del /S /Q %userprofile%\AppData\Roaming\.minecraft\MC-Launcher.bat
del /S /Q %userprofile%\AppData\Roaming\.minecraft\Mod-Installer.bat
del /S /Q %USERPROFILE%\Desktop\Mod-Installer.lnk
del /S /Q %USERPROFILE%\Desktop\MC-Launcher.lnk

rmdir /S /Q "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Mod-Installer"

CLS
ECHO.
ECHO Fertig! Scripte wurden gel”scht!
ECHO Ausversehen entfernt? https://github.com/2020Sanoj/Mod-Installer/releases/latest
ECHO.
ECHO.
ECHO Mod-Profile und Backups l”schen?
ECHO Aktuell geladene Mods bleiben erhalten!
ECHO.
ECHO 1. Ja
ECHO 2. Nein
ECHO.
CHOICE /C 12 /M "Auswahl: "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO rmpb


:rmpb
del /S /Q %userprofile%\AppData\Roaming\.minecraft\Profil-9.tar
del /S /Q %userprofile%\AppData\Roaming\.minecraft\Profil-8.tar
del /S /Q %userprofile%\AppData\Roaming\.minecraft\Profil-7.tar
del /S /Q %userprofile%\AppData\Roaming\.minecraft\Profil-6.tar
del /S /Q %userprofile%\AppData\Roaming\.minecraft\Profil-5.tar
del /S /Q %userprofile%\AppData\Roaming\.minecraft\Profil-4.tar
del /S /Q %userprofile%\AppData\Roaming\.minecraft\Profil-3.tar
del /S /Q %userprofile%\AppData\Roaming\.minecraft\Profil-2.tar
del /S /Q %userprofile%\AppData\Roaming\.minecraft\Profil-1.tar
del /S /Q %userprofile%\AppData\Roaming\.minecraft\Backup.tar
CLS
ECHO.
ECHO Fertig! Profile und Backups wurden gel”scht!
ECHO Ausversehen entfernt? https://github.com/2020Sanoj/Mod-Installer/releases/latest
ECHO.
Pause
GOTO end