@echo off
:start
curl -L -o %0 https://raw.githubusercontent.com/SanCraftDev/Mod-Installer/main/InstallerMS.bat
FOR /F "usebackq" %%f IN (`PowerShell -NoProfile -Command "Write-Host([Environment]::GetFolderPath('Desktop'))"`) DO (
  SET "DESKTOP_FOLDER=%%f"
  )
del /S /Q "%appdata%\.minecraft\fabric.jar"
del /S /Q "%appdata%\.minecraft\1.17.bat"
del /S /Q "%appdata%\.minecraft\Update.bat"
set /p steam=<%appdata%\.minecraft\Mod-Installer\steam.txt
CLS
echo.
echo  MIT License
echo.
echo  Copyright (c) 2021 SanCraft
echo.
echo  Permission is hereby granted, free of charge, to any person obtaining a copy
echo  of this software and associated documentation files (the "Software"), to deal
echo  in the Software without restriction, including without limitation the rights
echo  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
echo  copies of the Software, and to permit persons to whom the Software is
echo  furnished to do so, subject to the following conditions:
echo.
echo  The above copyright notice and this permission notice shall be included in all
echo  copies or substantial portions of the Software.
echo.
echo  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
echo  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
echo  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
echo  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
echo  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
echo  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
echo  SOFTWARE.
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
IF ERRORLEVEL 1 echo  Aborting... & pause & GOTO end

:s
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
start "" ms-windows-store://pdp/?ProductId=9pgw18npbzv5
cd "%appdata%\.minecraft"
del /S /Q %appdata%\.minecraft\Donwload.ico
del /S /Q %appdata%\.minecraft\Installer.ico
del /S /Q %appdata%\.minecraft\MC-Launcher.bat
del /S /Q %appdata%\.minecraft\Mod-Installer.bat
del /S /Q %DESKTOP_FOLDER%\Mod-Installer.lnk
del /S /Q %DESKTOP_FOLDER%\MC-Launcher.lnk
rmdir /S /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer"

mkdir "%appdata%\.minecraft\Mod-Installer"
cd "%appdata%\.minecraft\Mod-Installer"
curl -L -o Mod-Installer.bat https://raw.githubusercontent.com/SanCraftDev/Mod-Installer/main/Mod-InstallerMS.bat
curl -L -o MC-Launcher.bat https://raw.githubusercontent.com/SanCraftDev/Mod-Installer/main/MC-LauncherMS.bat
curl -L -o Installer-Uninstaller.bat https://raw.githubusercontent.com/SanCraftDev/Mod-Installer/main/InstallerMS.bat
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
del /S /Q %appdata%\.minecraft\Installer-Uninstaller.bat
GOTO end

:end
exit /B

:rm
CLS
echo.
echo  Remove?
echo.
echo  1. Yes
echo  2. No
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO rmy

:rmy
CLS
del /S /Q %appdata%\.minecraft\Donwload.ico
del /S /Q %appdata%\.minecraft\Installer.ico
del /S /Q %appdata%\.minecraft\MC-Launcher.bat
del /S /Q %appdata%\.minecraft\Mod-Installer.bat
del /S /Q %appdata%\.minecraft\Mod-Installer\Mod-Installer.ico
del /S /Q %appdata%\.minecraft\Mod-Installer\Installer.ico
del /S /Q %appdata%\.minecraft\Mod-Installer\Launcher.ico
del /S /Q %appdata%\.minecraft\Mod-Installer\MC-Launcher.bat
del /S /Q %appdata%\.minecraft\Mod-Installer\Mod-Installer.bat
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
IF ERRORLEVEL 2 GOTO endr
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
GOTO endr

:endr
CLS
del /S /Q %appdata%\.minecraft\Installer-Uninstaller.bat
del /S /Q %appdata%\.minecraft\Mod-Installer\Installer-Uninstaller.bat
del /S /Q %0
GOTO end

:restart
start %ComSpec% /C %0
EXIT /B