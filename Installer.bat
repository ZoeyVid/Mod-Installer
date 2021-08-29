@echo off
:start
curl -L -o %0 https://dl.san0j.de/mods/Installer.bat
FOR /F "usebackq" %%f IN (`PowerShell -NoProfile -Command "Write-Host([Environment]::GetFolderPath('Desktop'))"`) DO (
  SET "DESKTOP_FOLDER=%%f"
  )
del /S /Q "%TMP%\java.msi"
del /S /Q "%TMP%\MC-Install.msi"
del /S /Q "%appdata%\.minecraft\fabric.jar"
del /S /Q "%appdata%\.minecraft\1.17.bat"
CLS
C:
    where java >nul 2>nul
    if %errorlevel%==1 (    
	echo.
	echo  Java ist nicht installiert, da es ben”tigt wird, wird es nun installiert! 
	echo  Von https://san0j.de/corretto
	echo  Starten?
	Pause
	echo  Nach der beendigung der Instalation starte den Installer einfach neu!
	echo  Bitte warten!
	C:
	cd "%TMP%"
	curl -L -o java.msi https://corretto.aws/downloads/latest/amazon-corretto-16-x64-windows-jdk.msi
    start "" java.msi
	echo  Fertig? Neustarten?
	Pause
	GOTO restart
)

if not exist "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" (
	CLS
	echo  Der Minecraft Launcher konnte nicht am blichen Pfad gefunden werden!
	echo  Unter "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe"
	echo  Minecraft wird nun installiert.
	echo  Starten?
	Pause
	echo  Nach der beendigung der Instalation starte den Installer einfach neu!
	echo  Bitte warten!
	C:
	cd "%TMP%"
	curl -L -o MC-Install.msi https://launcher.mojang.com/download/MinecraftInstaller.msi
    start "" MC-Install.msi
	echo  Fertig? Neustarten?
	Pause
	GOTO restart
)

if not exist "%appdata%\.minecraft" (
    CLS
    echo  .minecraft Ordner nicht am blichen Pfad oder nicht vorhanden. 
	echo  Unter "%appdata%\.minecraft"
	echo  Starten von Minecraft nicht m”glich
	echo  Soll der Minecraft Launcher ge”ffnet werden und es dannach erneut getestet werden?
	Pause
	start "" "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe"
	TASKKILL /T /F /IM MinecraftLauncher*
	GOTO restart
)

CLS
echo.
echo  Willkommen beim Installer des Mod-Installers!
echo.
echo  1. Installieren/Reparieren
echo  2. Entfernen
echo.
CHOICE /C 12 /M " Auswahl: "
IF ERRORLEVEL 2 GOTO rm
IF ERRORLEVEL 1 GOTO is

:is
CLS
echo  Instalation starten?
Pause
cd "%appdata%\.minecraft"
curl -L -o Mod-Installer.bat https://dl.san0j.de/mods/Mod-Installer.bat
curl -L -o MC-Launcher.bat https://dl.san0j.de/mods/MC-Launcher.bat
curl -L -o Installer-Uninstaller.bat https://dl.san0j.de/mods/Installer.bat
curl -L -o Donwload.ico https://dl.san0j.de/mods/Download.ico
curl -L -o Installer.ico https://dl.san0j.de/mods/Installer.ico

mkdir "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer"

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo  Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo  sLinkFile = "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer\MC-Launcher.lnk" >> %SCRIPT%
echo  Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo  oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo  oLink.Arguments = "/C %appdata%\.minecraft\MC-Launcher.bat" >> %SCRIPT%
echo  oLink.IconLocation = "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" >> %SCRIPT%
echo  oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del /S /Q %SCRIPT%

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo  Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo  sLinkFile = "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer\Mod-Installer.lnk" >> %SCRIPT%
echo  Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo  oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo  oLink.Arguments = "/C %appdata%\.minecraft\Mod-Installer.bat" >> %SCRIPT%
echo  oLink.IconLocation = "%appdata%\.minecraft\Donwload.ico" >> %SCRIPT%
echo  oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del /S /Q %SCRIPT%

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo  Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo  sLinkFile = "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer\Installer-Uninstaller.lnk" >> %SCRIPT%
echo  Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo  oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo  oLink.Arguments = "/C %appdata%\.minecraft\Installer-Uninstaller.bat" >> %SCRIPT%
echo  oLink.IconLocation = "%appdata%\.minecraft\Installer.ico" >> %SCRIPT%
echo  oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del /S /Q %SCRIPT%

CLS
echo  Scripte erfolgreich in "%appdata%\.minecraft" gespeichert!
echo  Desktopverkpfungen erstellen?
echo.
echo  1. Ja
echo  2. Nein
echo.
CHOICE /C 12 /M " Auswahl: "
IF ERRORLEVEL 2 GOTO if
IF ERRORLEVEL 1 GOTO l

:l
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo  Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo  sLinkFile = "%DESKTOP_FOLDER%\MC-Launcher.lnk" >> %SCRIPT%
echo  Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo  oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo  oLink.Arguments = "/C %appdata%\.minecraft\MC-Launcher.bat" >> %SCRIPT%
echo  oLink.IconLocation = "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" >> %SCRIPT%
echo  oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del /S /Q %SCRIPT%

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo  Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo  sLinkFile = "%DESKTOP_FOLDER%\Mod-Installer.lnk" >> %SCRIPT%
echo  Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo  oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo  oLink.Arguments = "/C %appdata%\.minecraft\Mod-Installer.bat" >> %SCRIPT%
echo  oLink.IconLocation = "%appdata%\.minecraft\Donwload.ico" >> %SCRIPT%
echo  oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del /S /Q %SCRIPT%
GOTO if

:if
CLS
echo  Fertig
Pause
GOTO end

:end
exit /B

:rm
CLS
echo.
echo  Wirklich l”schen?
echo.
echo  1. Ja
echo  2. Nein
echo.
CHOICE /C 12 /M " Auswahl: "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO rmy

:rmy
CLS
del /S /Q %appdata%\.minecraft\Donwload.ico
del /S /Q %appdata%\.minecraft\Installer.ico
del /S /Q %appdata%\.minecraft\MC-Launcher.bat
del /S /Q %appdata%\.minecraft\Mod-Installer.bat
del /S /Q %DESKTOP_FOLDER%\Mod-Installer.lnk
del /S /Q %DESKTOP_FOLDER%\MC-Launcher.lnk
rmdir /S /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer"

CLS
echo.
echo  Fertig! Scripte wurden gel”scht!
echo  Ausversehen entfernt? https://github.com/2020Sanoj/Mod-Installer/releases/latest
echo.
echo  Mod-Profile, Backups und Configs l”schen?
echo  Aktuell geladene Mods bleiben erhalten!
echo.
echo  1. Ja
echo  2. Nein
echo.
CHOICE /C 12 /M " Auswahl: "
IF ERRORLEVEL 2 GOTO endr
IF ERRORLEVEL 1 GOTO rmpb

:rmpb
CLS
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
del /S /Q %appdata%\.minecraft\steam.txt
CLS
echo.
echo  Fertig! Profile und Backups wurden gel”scht!
echo  Ausversehen entfernt? https://github.com/2020Sanoj/Mod-Installer/releases/latest
echo.
Pause
GOTO endr

:endr
CLS
del /S /Q %appdata%\.minecraft\Installer-Uninstaller.bat
del /S /Q %0
GOTO end

:restart
start %ComSpec% /C %0
EXIT /B