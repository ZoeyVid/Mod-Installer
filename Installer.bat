@echo off
curl -L --output %0 --url https://download.san0j.de/mods/Installer.bat
del /S /Q java.msi
:start
C:

    where java >nul 2>nul
    if %errorlevel%==1 (
    
	ECHO.
	ECHO Java ist nicht installiert und wird nun installiert! 
	ECHO Starten?
	Pause
	ECHO Bitte warten!
	ECHO Nach der beendigung der Java Instalation starte den Launcher einfach neu!
	curl -L --output java.msi --url https://corretto.aws/downloads/latest/amazon-corretto-16-x64-windows-jdk.msi
    start "" java.msi
	ECHO Fertig? Neustarten?
	Pause
	GOTO start
)

if not exist "%appdata%\.minecraft" (

    CLS
    echo .minecraft Ordner nicht am blichen Pfad oder nicht vorhanden. 
	echo Unter "%appdata%\.minecraft"
	echo Installer wird beendet...
	Pause
exit /B
)



if not exist "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" (

	CLS
	echo
	echo Minecraft Launcher konnte nicht am šblichen Pfad gefunden werden!
	echo Unter "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe"
	echo Benutzung des MC-Launcher nicht m”glich.
)



CLS
ECHO.
ECHO Willkommen beim Installer des Mod Installers!
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
cd "%appdata%\.minecraft"
curl -L --output Mod-Installer.bat --url https://download.san0j.de/mods/Mod-Installer.bat
curl -L --output MC-Launcher.bat --url https://download.san0j.de/mods/MC-Launcher.bat
curl -L --output Installer-Uninstaller.bat --url https://download.san0j.de/mods/Installer.bat
curl -L --output Donwload.ico --url https://download.san0j.de/mods/Download.ico
curl -L --output Installer.ico --url https://download.san0j.de/mods/Installer.ico

mkdir "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer"

CLS
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer\MC-Launcher.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo oLink.Arguments = "/C %appdata%\.minecraft\MC-Launcher.bat" >> %SCRIPT%
echo oLink.IconLocation = "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del /S /Q %SCRIPT%


set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer\Mod-Installer.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo oLink.Arguments = "/C %appdata%\.minecraft\Mod-Installer.bat" >> %SCRIPT%
echo oLink.IconLocation = "%appdata%\.minecraft\Donwload.ico" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del /S /Q %SCRIPT%


set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer\Installer-Uninstaller.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo oLink.Arguments = "/C %appdata%\.minecraft\Installer-Uninstaller.bat" >> %SCRIPT%
echo oLink.IconLocation = "%appdata%\.minecraft\Installer.ico" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del /S /Q %SCRIPT%

CLS
echo Scripte erfolgreich in "%appdata%\.minecraft" gespeichert!
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
echo oLink.Arguments = "/C %appdata%\.minecraft\MC-Launcher.bat" >> %SCRIPT%
echo oLink.IconLocation = "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del /S /Q %SCRIPT%


CLS
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\Mod-Installer.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo oLink.Arguments = "/C %appdata%\.minecraft\Mod-Installer.bat" >> %SCRIPT%
echo oLink.IconLocation = "%appdata%\.minecraft\Donwload.ico" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del /S /Q %SCRIPT%
del /S /Q %appdata%\.minecraft\Donwload.ico
del /S /Q %appdata%\.minecraft\Installer.ico
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
del /S /Q %appdata%\.minecraft\Donwload.ico
del /S /Q %appdata%\.minecraft\Installer.ico
del /S /Q %appdata%\.minecraft\MC-Launcher.bat
del /S /Q %appdata%\.minecraft\Mod-Installer.bat
del /S /Q %USERPROFILE%\Desktop\Mod-Installer.lnk
del /S /Q %USERPROFILE%\Desktop\MC-Launcher.lnk

rmdir /S /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer"

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
IF ERRORLEVEL 2 GOTO endr
IF ERRORLEVEL 1 GOTO rmpb


:rmpb
del /S /Q %appdata%\.minecraft\Profil-9.tar
del /S /Q %appdata%\.minecraft\Profil-8.tar
del /S /Q %appdata%\.minecraft\Profil-7.tar
del /S /Q %appdata%\.minecraft\Profil-6.tar
del /S /Q %appdata%\.minecraft\Profil-5.tar
del /S /Q %appdata%\.minecraft\Profil-4.tar
del /S /Q %appdata%\.minecraft\Profil-3.tar
del /S /Q %appdata%\.minecraft\Profil-2.tar
del /S /Q %appdata%\.minecraft\Profil-1.tar
del /S /Q %appdata%\.minecraft\Backup.tar
CLS
ECHO.
ECHO Fertig! Profile und Backups wurden gel”scht!
ECHO Ausversehen entfernt? https://github.com/2020Sanoj/Mod-Installer/releases/latest
ECHO.
Pause
GOTO endr

:endr
del /S /Q %appdata%\.minecraft\Installer-Uninstaller.bat
del /S /Q %0
GOTO end