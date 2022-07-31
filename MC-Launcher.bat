@echo off

set ver=Version 0.0.0

:start
if not exist "%LocalAppData%\Mod-Installer" (
CLS
echo.
echo  You need to reinstall the Mod-Installer!
echo.
Pause
start "" "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer\Installer-Uninstaller.lnk"
GOTO end
)

if exist "%LocalAppData%\Mod-Installer" (
cd "%LocalAppData%\Mod-Installer"
curl --ssl-no-revoke -sL -o "%LocalAppData%\Mod-Installer\MC-Launcher.bat" https://github.com/SanCraftDev/Mod-Installer/releases/latest/download/MC-Launcher.bat
curl --ssl-no-revoke -sL -o "%LocalAppData%\Mod-Installer\Mod-Installer.bat" https://github.com/SanCraftDev/Mod-Installer/releases/latest/download/Mod-Installer.bat
curl --ssl-no-revoke -sL -o "%LocalAppData%\Mod-Installer\Installer-Uninstaller.bat" https://github.com/SanCraftDev/Mod-Installer/releases/latest/download/Installer.bat
)
if exist %0 ( curl --ssl-no-revoke -sL -o %0 https://github.com/SanCraftDev/Mod-Installer/releases/latest/download/MC-Launcher.bat )

FOR /F "usebackq" %%f IN (`PowerShell -NoProfile -Command "Write-Host([Environment]::GetFolderPath('Desktop'))"`) DO (
  SET "DESKTOP_FOLDER=%%f"
  )

if exist "%ProgramFiles%\Mod-Installer" (
CLS
echo.
echo  Please delete the "%ProgramFiles%\Mod-Installer" Folder manualy!
echo.
Pause
)
  
if exist  "%appdata%\.minecraft\Donwload.ico" (
del /S /Q "%appdata%\.minecraft\Donwload.ico"
)
if exist  "%appdata%\.minecraft\Installer.ico" (
del /S /Q "%appdata%\.minecraft\Installer.ico"
)
if exist  "%appdata%\.minecraft\MC-Launcher.bat" (
del /S /Q "%appdata%\.minecraft\MC-Launcher.bat"
)
if exist  "%appdata%\.minecraft\Mod-Installer.bat" (
del /S /Q "%appdata%\.minecraft\Mod-Installer.bat"
)
if exist  "%appdata%\.minecraft\Installer-Uninstaller.bat" (
del /Q /Q "%appdata%\.minecraft\Installer-Uninstaller.bat"
)
if exist  "%appdata%\.minecraft\steam.txt" (
del /S /Q "%appdata%\.minecraft\steam.txt"
)
if exist  "%ProgramFiles%\Mod-Installer\steam.txt" (
del /S /Q "%ProgramFiles%\Mod-Installer\steam.txt"
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
C:

    where winget >nul 2>nul
    if %errorlevel%==1 (
        echo.
        echo  winget not found! Please check how you can install winget on your system!
        Pause
        exit
)

    where java >nul 2>nul
    if %errorlevel%==1 (    
	echo.
	echo  java is not installed, it will now be installed!
	echo  Start now?
	Pause
	winget install -e --id Amazon.Corretto.17
start %ComSpec% /C %0
EXIT /B
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
start %ComSpec% /C %0
EXIT /B
)

C:
cd %appdata%\.minecraft
if exist Backup.* (
del /S /Q Backup.*
)
if exist *.tar (
echo  Your Profiles need to be converted from a .tar file to a .zip file
echo  Start now?
Pause
echo  converting Profiles from .tar to .zip...
if exist Profil-1.tar (
rmdir /S /Q mods
tar xf Profil-1.tar
tar acf Profil-1.zip mods config\openloader
echo  Profil-1 converted to a zip file!
)
if exist Profil-2.tar (
rmdir /S /Q mods
tar xf Profil-2.tar
tar acf Profil-2.zip mods config\openloader
echo  Profil-2 converted to a zip file!
)
if exist Profil-3.tar (
rmdir /S /Q mods
tar xf Profil-3.tar
tar acf Profil-3.zip mods config\openloader
echo  Profil-3 converted to a zip file!
)
if exist Profil-4.tar (
rmdir /S /Q mods
tar xf Profil-4.tar
tar acf Profil-4.zip mods config\openloader
echo  Profil-4 converted to a zip file!
)
if exist Profil-5.tar (
rmdir /S /Q mods
tar xf Profil-5.tar
tar acf Profil-5.zip mods config\openloader
echo  Profil-5 converted to a zip file!
)
if exist Profil-6.tar (
rmdir /S /Q mods
tar xf Profil-6.tar
tar acf Profil-6.zip mods config\openloader
echo  Profil-6 converted to a zip file!
)
if exist Profil-7.tar (
rmdir /S /Q mods
tar xf Profil-7.tar
tar acf Profil-7.zip mods config\openloader
echo  Profil-7 converted to a zip file!
)
if exist Profil-8.tar (
rmdir /S /Q mods
tar xf Profil-8.tar
tar acf Profil-8.zip mods config\openloader
echo  Profil-8 converted to a zip file!
)
del /S /Q *.tar
echo  Finished! Now starting the Mod-Installer...
Pause
)

TASKKILL /T /F /IM MinecraftLauncher.exe
TASKKILL /T /F /IM Minecraft.exe

C:
if exist "%appdata%\.minecraft\" (
cd "%appdata%\.minecraft\"
CLS
echo.
echo  With which mod profile do you want to start Minecraft?
echo  Choose between profile 1-8 and 9 if nothing should be loaded!
echo  Make sure you choose the right mod loader in the MC launcher!
echo  MC-Launcher %ver%
echo.
CHOICE /C 123456789 /M " Auswahl: "
IF ERRORLEVEL 9 GOTO mcl
IF ERRORLEVEL 8 if exist mods ( rmdir /S /Q mods ) & if exist config\openloader ( rmdir /S /Q config\openloader ) & tar xf Profil-8.zip
IF ERRORLEVEL 7 if exist mods ( rmdir /S /Q mods ) & if exist config\openloader ( rmdir /S /Q config\openloader ) & tar xf Profil-7.zip
IF ERRORLEVEL 6 if exist mods ( rmdir /S /Q mods ) & if exist config\openloader ( rmdir /S /Q config\openloader ) & tar xf Profil-6.zip
IF ERRORLEVEL 5 if exist mods ( rmdir /S /Q mods ) & if exist config\openloader ( rmdir /S /Q config\openloader ) & tar xf Profil-5.zip
IF ERRORLEVEL 4 if exist mods ( rmdir /S /Q mods ) & if exist config\openloader ( rmdir /S /Q config\openloader ) & tar xf Profil-4.zip
IF ERRORLEVEL 3 if exist mods ( rmdir /S /Q mods ) & if exist config\openloader ( rmdir /S /Q config\openloader ) & tar xf Profil-3.zip
IF ERRORLEVEL 2 if exist mods ( rmdir /S /Q mods ) & if exist config\openloader ( rmdir /S /Q config\openloader ) & tar xf Profil-2.zip
IF ERRORLEVEL 1 if exist mods ( rmdir /S /Q mods ) & if exist config\openloader ( rmdir /S /Q config\openloader ) & tar xf Profil-1.zip
)
:mcl
start "" shell:AppsFolder\Microsoft.4297127D64EC6_8wekyb3d8bbwe!Minecraft 
EXIT /B
