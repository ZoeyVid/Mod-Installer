@echo off
:start
curl -L -o %0 https://raw.githubusercontent.com/SanCraftDev/Mod-Installer/main/I.bat
FOR /F "usebackq" %%f IN (`PowerShell -NoProfile -Command "Write-Host([Environment]::GetFolderPath('Desktop'))"`) DO (
  SET "DESKTOP_FOLDER=%%f"
  )
del /S /Q "%appdata%\.minecraft\fabric.jar"
del /S /Q "%appdata%\.minecraft\1.17.bat"
del /S /Q "%appdata%\.minecraft\Update.bat"
set /p steam=<%appdata%\.minecraft\Mod-Installer\steam.txt

CLS
C:
    where java >nul 2>nul
    if %errorlevel%==1 (    
	echo.
	echo  java is not installed, it will now be installed!
	echo  Start now?
	Pause
	winget install -e --id Amazon.Corretto.17
	GOTO restart
)

if not exist "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" (
	CLS
	echo  The Minecraft Launcher could not be found on the usual path!
	echo  Under "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe"
	echo  Minecraft will now be installed.
	echo  Start now?
	Pause
	winget install -e --id Mojang.MinecraftLauncher
	GOTO restart
)

if not exist "%appdata%\.minecraft" (
    CLS
    echo  .minecraft folder not at the usual path or not available.
	echo  Under "%appdata%\.minecraft"
	echo  Unable to start Minecraft!
	echo  Do you want to open the Minecraft Launcher and test it again afterwards?
	Pause
	start "" "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe"
	TASKKILL /T /F /IM MinecraftLauncher.exe
    TASKKILL /T /F /IM Minecraft.exe
	GOTO restart
)

CLS
echo.
echo  Welcome to the Mod-Installer Installer!
echo.
echo  1. Install/Repair
echo  2. Remove
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO rm
IF ERRORLEVEL 1 GOTO is

:is
CLS
echo  Start Installation?
Pause
cd "%appdata%\.minecraft"
del /S /Q %appdata%\.minecraft\Donwload.ico
del /S /Q %appdata%\.minecraft\Installer.ico
del /S /Q %appdata%\.minecraft\MC-Launcher.bat
del /S /Q %appdata%\.minecraft\Mod-Installer.bat
del /Q /Q %appdata%\.minecraft\Installer-Uninstaller.bat
del /S /Q %DESKTOP_FOLDER%\Mod-Installer.lnk
del /S /Q %DESKTOP_FOLDER%\MC-Launcher.lnk
rmdir /S /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer"

mkdir "%appdata%\.minecraft\Mod-Installer"
cd "%appdata%\.minecraft\Mod-Installer"
curl -L -o Mod-Installer.bat https://raw.githubusercontent.com/SanCraftDev/Mod-Installer/main/Mod-Installer.bat
curl -L -o MC-Launcher.bat https://raw.githubusercontent.com/SanCraftDev/Mod-Installer/main/MC-Launcher.bat
curl -L -o Installer-Uninstaller.bat https://raw.githubusercontent.com/SanCraftDev/Mod-Installer/main/Installer.bat
curl -L -o Mod-Installer.ico https://raw.githubusercontent.com/SanCraftDev/Mod-Installer/main/Mod-Installer.ico
curl -L -o Installer.ico https://raw.githubusercontent.com/SanCraftDev/Mod-Installer/main/Installer.ico
curl -L -o Launcher.ico https://raw.githubusercontent.com/SanCraftDev/Mod-Installer/main/Launcher.ico
move %appdata%\.minecraft\steam.txt %appdata%\.minecraft\Mod-Installer\steam.txt

mkdir "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer"

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo  Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo  sLinkFile = "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer\MC-Launcher.lnk" >> %SCRIPT%
echo  Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo  oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo  oLink.Arguments = "/C %appdata%\.minecraft\Mod-Installer\MC-Launcher.bat" >> %SCRIPT%
echo  oLink.IconLocation = "%appdata%\.minecraft\Mod-Installer\Launcher.ico" >> %SCRIPT%
echo  oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del /S /Q %SCRIPT%

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo  Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo  sLinkFile = "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer\Mod-Installer.lnk" >> %SCRIPT%
echo  Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo  oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo  oLink.Arguments = "/C %appdata%\.minecraft\Mod-Installer\Mod-Installer.bat" >> %SCRIPT%
echo  oLink.IconLocation = "%appdata%\.minecraft\Mod-Installer\Mod-Installer.ico" >> %SCRIPT%
echo  oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del /S /Q %SCRIPT%

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo  Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo  sLinkFile = "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer\Installer-Uninstaller.lnk" >> %SCRIPT%
echo  Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo  oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo  oLink.Arguments = "/C %appdata%\.minecraft\Mod-Installer\Installer-Uninstaller.bat" >> %SCRIPT%
echo  oLink.IconLocation = "%appdata%\.minecraft\Mod-Installer\Installer.ico" >> %SCRIPT%
echo  oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del /S /Q %SCRIPT%

CLS
echo  Scripts were saved in "%appdata%\.minecraft\Mod-Installer"!
echo  Create desktop shortcuts?
echo.
echo  1. Yes
echo  2. No
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO if
IF ERRORLEVEL 1 GOTO l

:l
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo  Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo  sLinkFile = "%DESKTOP_FOLDER%\MC-Launcher.lnk" >> %SCRIPT%
echo  Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo  oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo  oLink.Arguments = "/C %appdata%\.minecraft\Mod-Installer\MC-Launcher.bat" >> %SCRIPT%
echo  oLink.IconLocation = "%appdata%\.minecraft\Mod-Installer\Launcher.ico" >> %SCRIPT%
echo  oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del /S /Q %SCRIPT%

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo  Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo  sLinkFile = "%DESKTOP_FOLDER%\Mod-Installer.lnk" >> %SCRIPT%
echo  Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo  oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo  oLink.Arguments = "/C %appdata%\.minecraft\Mod-Installer\Mod-Installer.bat" >> %SCRIPT%
echo  oLink.IconLocation = "%appdata%\.minecraft\Mod-Installer\Mod-Installer.ico" >> %SCRIPT%
echo  oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del /S /Q %SCRIPT%
GOTO if

:if
CLS
echo  Finished!
Pause
del /S /Q %0 & exit /B

:rm
CLS
echo.
echo  Remove?
echo.
echo  1. Yes
echo  2. No
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 del /S /Q %0 & exit /B
IF ERRORLEVEL 1 GOTO rmy

:rmy
CLS
del /S /Q %appdata%\.minecraft\Donwload.ico
del /S /Q %appdata%\.minecraft\Installer.ico
del /S /Q %appdata%\.minecraft\MC-Launcher.bat
del /S /Q %appdata%\.minecraft\Mod-Installer.bat
del /S /Q %appdata%\.minecraft\Installer-Uninstaller.bat
rmdir /S /Q %appdata%\.minecraft\Mod-Installer
del /S /Q %DESKTOP_FOLDER%\Mod-Installer.lnk
del /S /Q %DESKTOP_FOLDER%\MC-Launcher.lnk
rmdir /S /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer"

CLS
echo.
echo  Finished! Scripts were deleted!
echo  Accidentally removed? https://github.com/SanCraftDev/Mod-Installer/releases/latest
echo.
echo  Remove Mod-Profils and the Backup?
echo  Current loaded Mods are keept!
echo.
echo  1. Yes
echo  2. No
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 del /S /Q %0 & exit /B
IF ERRORLEVEL 1 GOTO rmpb

:rmpb
CLS
del /S /Q %appdata%\.minecraft\Profil-*
del /S /Q %appdata%\.minecraft\Backup.tar
del /S /Q %appdata%\.minecraft\steam.txt
del /S /Q %appdata%\.minecraft\Mod-Installer\steam.txt
CLS
echo.
echo  Finished! Profils and Backups had been deleted!
echo  Accidentally removed? https://github.com/SanCraftDev/Mod-Installer/releases/latest
echo.
Pause
del /S /Q %0 & exit /B

:restart
start %ComSpec% /C %0
EXIT /B