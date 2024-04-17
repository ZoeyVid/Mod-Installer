@echo off

set ver=Version 0.0.0

:start
if exist %0 ( curl --ssl-no-revoke -sL -o %0 https://github.com/ZoeyVid/Mod-Installer/releases/latest/download/Installer.bat )
FOR /F "usebackq" %%f IN (`PowerShell -NoProfile -Command "Write-Host([Environment]::GetFolderPath('Desktop'))"`) DO (
  SET "DESKTOP_FOLDER=%%f"
  )
if exist "%appdata%\.minecraft\fabric.jar" (
del /S /Q "%appdata%\.minecraft\fabric.jar"
)
if exist "%appdata%\.minecraft\fabric.bat" (
del /S /Q "%appdata%\.minecraft\fabric.bat"
)
if exist "%appdata%\.minecraft\Update.bat" (
del /S /Q "%appdata%\.minecraft\Update.bat"
)
if exist "%appdata%\.minecraft\essential-installer.exe" (
del /S /Q "%appdata%\.minecraft\essential-installer.exe"
)
if exist "%appdata%\.minecraft\forge.bat" (
del /S /Q "%appdata%\.minecraft\forge.bat"
)

CLS
echo.
echo  GNU General Public License v3.0
echo.
echo  Copyright (c) 2024 ZoeyVid
echo.
echo  You can find the License here: https://github.com/ZoeyVid/Mod-Installer/blob/main/COPYING
echo.
echo  NOT AN OFFICIAL MINECRAFT PRODUCT. NOT APPROVED BY OR ASSOCIATED WITH MOJANG.
echo.
echo  Do you accept this?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO s
IF ERRORLEVEL 1 echo  Aborting... & pause & EXIT /B

:s
CLS

    where winget >nul 2>nul
    if %errorlevel%==1 (
        echo.
        echo  winget not found! Please check how you can install winget on your system!
        Pause
        exit
)

echo  Please install now the Minecraft-Launcher:
Pause
start "" ms-windows-store://pdp/?ProductId=9pgw18npbzv5
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

if not exist "%appdata%\.minecraft" (
    CLS
    echo  .minecraft folder not at the usual path or not available.
	echo  Under "%appdata%\.minecraft"
	echo  Unable to start Minecraft!
	echo  Do you want to open the Minecraft Launcher and test it again afterwards?
	Pause
	start "" shell:AppsFolder\Microsoft.4297127D64EC6_8wekyb3d8bbwe!Minecraft 
	echo  Started?
	Pause
    TASKKILL /T /F /IM MinecraftLauncher.exe
    TASKKILL /T /F /IM Minecraft.exe
	GOTO restart
)

cd "%appdata%\.minecraft"
CLS
echo.
echo  Welcome to the Mod-Installer Installer %ver%!
echo.
echo  1. Install/Repair
echo  2. Remove
echo  3. Cancel
echo.
CHOICE /C 123 /M " Selection: "
IF ERRORLEVEL 3 exit /B
IF ERRORLEVEL 2 GOTO rm
IF ERRORLEVEL 1 GOTO is

:is
CLS
echo  Start Installation? The Minecraft Launcher will be closed!
Pause

cd "%appdata%\.minecraft"
TASKKILL /T /F /IM MinecraftLauncher.exe
TASKKILL /T /F /IM Minecraft.exe
if exist "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" (
winget uninstall Mojang.MinecraftLauncher
)

if exist %appdata%\.minecraft\Donwload.ico ( del /S /Q %appdata%\.minecraft\Donwload.ico )
if exist %appdata%\.minecraft\Installer.ico ( del /S /Q %appdata%\.minecraft\Installer.ico )
if exist %appdata%\.minecraft\MC-Launcher.bat ( del /S /Q %appdata%\.minecraft\MC-Launcher.bat )
if exist %appdata%\.minecraft\Mod-Installer.bat ( del /S /Q %appdata%\.minecraft\Mod-Installer.bat )
if exist %appdata%\.minecraft\Installer-Uninstaller.bat ( del /Q /Q %appdata%\.minecraft\Installer-Uninstaller.bat )
if exist %DESKTOP_FOLDER%\Mod-Installer.lnk ( del /S /Q %DESKTOP_FOLDER%\Mod-Installer.lnk )
if exist %DESKTOP_FOLDER%\MC-Launcher.lnk ( del /S /Q %DESKTOP_FOLDER%\MC-Launcher.lnk )
if exist %appdata%\.minecraft\steam.txt ( del /S /Q %appdata%\.minecraft\steam.txt )
if exist %ProgramFiles%\Mod-Installer\steam.txt ( del /S /Q %ProgramFiles%\Mod-Installer\steam.txt )
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer" ( rmdir /S /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer" )
if exist %appdata%\.minecraft\Mod-Installer ( rmdir /S /Q %appdata%\.minecraft\Mod-Installer )

if not exist "%LocalAppData%\Mod-Installer" (
mkdir "%LocalAppData%\Mod-Installer"
)
if exist "%LocalAppData%\Mod-Installer" (
cd "%LocalAppData%\Mod-Installer"
curl --ssl-no-revoke -L -o Mod-Installer.bat https://github.com/ZoeyVid/Mod-Installer/releases/latest/download/Mod-Installer.bat
curl --ssl-no-revoke -L -o MC-Launcher.bat https://github.com/ZoeyVid/Mod-Installer/releases/latest/download/MC-Launcher.bat
curl --ssl-no-revoke -L -o Installer-Uninstaller.bat https://github.com/ZoeyVid/Mod-Installer/releases/latest/download/Installer.bat
curl --ssl-no-revoke -L -o Mod-Installer.ico https://github.com/ZoeyVid/Mod-Installer/releases/latest/download/Mod-Installer.ico
curl --ssl-no-revoke -L -o Installer.ico https://github.com/ZoeyVid/Mod-Installer/releases/latest/download/Installer.ico
curl --ssl-no-revoke -L -o Launcher.ico https://github.com/ZoeyVid/Mod-Installer/releases/latest/download/Launcher.ico
)

if not exist mkdir "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer" (
mkdir "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer"
)
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo  Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo  sLinkFile = "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer\MC-Launcher.lnk" >> %SCRIPT%
echo  Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo  oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo  oLink.Arguments = "/C %LocalAppData%\Mod-Installer\MC-Launcher.bat" >> %SCRIPT%
echo  oLink.IconLocation = "%LocalAppData%\Mod-Installer\Launcher.ico" >> %SCRIPT%
echo  oLink.Save >> %SCRIPT%
if exist %SCRIPT% ( cscript /nologo %SCRIPT% )
if exist %SCRIPT% ( del /S /Q %SCRIPT% )

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo  Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo  sLinkFile = "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer\Mod-Installer.lnk" >> %SCRIPT%
echo  Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo  oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo  oLink.Arguments = "/C %LocalAppData%\Mod-Installer\Mod-Installer.bat" >> %SCRIPT%
echo  oLink.IconLocation = "%LocalAppData%\Mod-Installer\Mod-Installer.ico" >> %SCRIPT%
echo  oLink.Save >> %SCRIPT%
if exist %SCRIPT% ( cscript /nologo %SCRIPT% )
if exist %SCRIPT% ( del /S /Q %SCRIPT% )

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo  Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo  sLinkFile = "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer\Installer-Uninstaller.lnk" >> %SCRIPT%
echo  Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo  oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo  oLink.Arguments = "/C %LocalAppData%\Mod-Installer\Installer-Uninstaller.bat" >> %SCRIPT%
echo  oLink.IconLocation = "%LocalAppData%\Mod-Installer\Installer.ico" >> %SCRIPT%
echo  oLink.Save >> %SCRIPT%
if exist %SCRIPT% ( cscript /nologo %SCRIPT% )
if exist %SCRIPT% ( del /S /Q %SCRIPT% )

CLS
echo  Scripts were saved in "%LocalAppData%\Mod-Installer"!
echo  Create desktop shortcuts?
echo.
echo  1. Yes
echo  2. No
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO if
IF ERRORLEVEL 1 if exist "%DESKTOP_FOLDER%" ( GOTO l ) else ( GOTO if )

:l
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo  Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo  sLinkFile = "%DESKTOP_FOLDER%\MC-Launcher.lnk" >> %SCRIPT%
echo  Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo  oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo  oLink.Arguments = "/C %LocalAppData%\Mod-Installer\MC-Launcher.bat" >> %SCRIPT%
echo  oLink.IconLocation = "%LocalAppData%\Mod-Installer\Launcher.ico" >> %SCRIPT%
echo  oLink.Save >> %SCRIPT%
if exist %SCRIPT% ( cscript /nologo %SCRIPT% )
if exist %SCRIPT% ( del /S /Q %SCRIPT% )

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo  Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo  sLinkFile = "%DESKTOP_FOLDER%\Mod-Installer.lnk" >> %SCRIPT%
echo  Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo  oLink.TargetPath = "%windir%\system32\cmd.exe" >> %SCRIPT%
echo  oLink.Arguments = "/C %LocalAppData%\Mod-Installer\Mod-Installer.bat" >> %SCRIPT%
echo  oLink.IconLocation = "%LocalAppData%\Mod-Installer\Mod-Installer.ico" >> %SCRIPT%
echo  oLink.Save >> %SCRIPT%
if exist %SCRIPT% ( cscript /nologo %SCRIPT% )
if exist %SCRIPT% ( del /S /Q %SCRIPT% )
GOTO if

:if
PAUSE
CLS

if exist "%ProgramFiles%\Mod-Installer" (
CLS
echo.
echo  Please delete the "%ProgramFiles%\Mod-Installer" Folder manualy!
echo.
Pause
)

echo  Finished! & Pause & exit /B

:rm
CLS
echo.
echo  Remove?
echo.
echo  1. Yes
echo  2. No
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 exit /B
IF ERRORLEVEL 1 GOTO rmy

:rmy
CLS

if exist "%ProgramFiles%\Mod-Installer" (
CLS
echo.
echo  Please delete the "%ProgramFiles%\Mod-Installer" Folder manualy!
echo.
Pause
)

if exist %appdata%\.minecraft\Donwload.ico ( del /S /Q %appdata%\.minecraft\Donwload.ico )
if exist %appdata%\.minecraft\Installer.ico ( del /S /Q %appdata%\.minecraft\Installer.ico )
if exist %appdata%\.minecraft\MC-Launcher.bat ( del /S /Q %appdata%\.minecraft\MC-Launcher.bat )
if exist %appdata%\.minecraft\Mod-Installer.bat ( del /S /Q %appdata%\.minecraft\Mod-Installer.bat )
if exist %appdata%\.minecraft\Installer-Uninstaller.bat ( del /Q /Q %appdata%\.minecraft\Installer-Uninstaller.bat )
if exist %DESKTOP_FOLDER%\Mod-Installer.lnk ( del /S /Q %DESKTOP_FOLDER%\Mod-Installer.lnk )
if exist %DESKTOP_FOLDER%\MC-Launcher.lnk ( del /S /Q %DESKTOP_FOLDER%\MC-Launcher.lnk )
if exist %appdata%\.minecraft\steam.txt ( del /S /Q %appdata%\.minecraft\steam.txt )
if exist %ProgramFiles%\Mod-Installer\steam.txt ( del /S /Q %ProgramFiles%\Mod-Installer\steam.txt )
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer" ( rmdir /S /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer" )
if exist %appdata%\.minecraft\Mod-Installer ( rmdir /S /Q %appdata%\.minecraft\Mod-Installer )

CLS
echo.
echo  Finished! Scripts were deleted!
echo  Accidentally removed? https://github.com/ZoeyVid/Mod-Installer/releases/latest/download/Installer.bat 
echo.
echo  Remove Mod-Profils and the Backup?
echo  Current loaded Mods are keept!
echo.
echo  1. Yes
echo  2. No
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 if exist "%LocalAppData%\Mod-Installer" ( rmdir /S /Q "%LocalAppData%\Mod-Installer" & exit /B ) & exit /B
IF ERRORLEVEL 1 GOTO rmpb
exit /B

:rmpb
CLS
if exist %appdata%\.minecraft\Profil-* ( del /S /Q %appdata%\.minecraft\Profil-* )
if exist %appdata%\.minecraft\Backup.* ( del /S /Q %appdata%\.minecraft\Backup.* )
CLS
echo.
echo  Finished! Profils and Backups had been removed!
echo  Accidentally removed? https://github.com/ZoeyVid/Mod-Installer/releases/latest/download/Installer.bat 
echo. 
Pause & if exist "%LocalAppData%\Mod-Installer" ( rmdir /S /Q "%LocalAppData%\Mod-Installer" & exit /B ) & exit /B
exit /B

:restart
start %ComSpec% /C %0
EXIT /B
