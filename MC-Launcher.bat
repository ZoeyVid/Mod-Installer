@echo off

set ver=Version 5.1.2.2

:start
FOR /F "usebackq" %%f IN (`PowerShell -NoProfile -Command "Write-Host([Environment]::GetFolderPath('Desktop'))"`) DO (
  SET "DESKTOP_FOLDER=%%f"
  )
if exist "%appdata%\.minecraft\fabric.jar" (
del /S /Q "%appdata%\.minecraft\fabric.jar"
)
if exist "%appdata%\.minecraft\1.17.bat" (
del /S /Q "%appdata%\.minecraft\1.17.bat"
)
if exist "%appdata%\.minecraft\Update.bat" (
del /S /Q "%appdata%\.minecraft\Update.bat"
)
if exist "%appdata%\.minecraft\essential-installer.exe" (
del /S /Q "%appdata%\.minecraft\essential-installer.exe"
)
CLS
C:
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
move servers.dat_tmp servers.dat
C:
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
IF ERRORLEVEL 8 tar acf Backup.zip mods options.txt & rmdir /S /Q mods & tar xf Profil-8.zip
IF ERRORLEVEL 7 tar acf Backup.zip mods options.txt & rmdir /S /Q mods & tar xf Profil-7.zip
IF ERRORLEVEL 6 tar acf Backup.zip mods options.txt & rmdir /S /Q mods & tar xf Profil-6.zip
IF ERRORLEVEL 5 tar acf Backup.zip mods options.txt & rmdir /S /Q mods & tar xf Profil-5.zip
IF ERRORLEVEL 4 tar acf Backup.zip mods options.txt & rmdir /S /Q mods & tar xf Profil-4.zip
IF ERRORLEVEL 3 tar acf Backup.zip mods options.txt & rmdir /S /Q mods & tar xf Profil-3.zip
IF ERRORLEVEL 2 tar acf Backup.zip mods options.txt & rmdir /S /Q mods & tar xf Profil-2.zip
IF ERRORLEVEL 1 tar acf Backup.zip mods options.txt & rmdir /S /Q mods & tar xf Profil-1.zip
:mcl
TASKKILL /T /F /IM MinecraftLauncher.exe
TASKKILL /T /F /IM Minecraft.exe
start "" shell:AppsFolder\Microsoft.4297127D64EC6_8wekyb3d8bbwe!Minecraft 
EXIT /B
