@echo off
:start
curl -L -o %0 https://raw.githubusercontent.com/SanCraftDev/Mod-Installer/main/MC-Launcher.bat

if not exist "%appdata%\.minecraft\Mod-Installer" (
CLS
echo.
echo You need to reinstall the Mod-Installer!
echo.
Pause
start "" "%appdata%\.minecraft\Installer-Uninstaller.bat"
GOTO end
)

FOR /F "usebackq" %%f IN (`PowerShell -NoProfile -Command "Write-Host([Environment]::GetFolderPath('Desktop'))"`) DO (
  SET "DESKTOP_FOLDER=%%f"
  )
del /S /Q "%appdata%\.minecraft\fabric.jar"
del /S /Q "%appdata%\.minecraft\1.17.bat"
del /S /Q "%appdata%\.minecraft\Update.bat"
del /S /Q "%appdata%\.minecraft\I.bat"
del /S /Q "%appdata%\.minecraft\IMS.bat"
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
move servers.dat_tmp servers.dat
C:
cd "%appdata%\.minecraft\"
CLS
echo.
echo  With which mod profile do you want to start Minecraft?
echo  Choose between profile 1-8 and 9 if nothing should be loaded!
echo  Make sure you choose the right mod loader in the MC launcher!
echo.
CHOICE /C 123456789 /M " Auswahl: "
IF ERRORLEVEL 9 GOTO mcl
IF ERRORLEVEL 8 tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & rmdir /S /Q config & tar xf Profil-8.tar
IF ERRORLEVEL 7 tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & rmdir /S /Q config & tar xf Profil-7.tar
IF ERRORLEVEL 6 tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & rmdir /S /Q config & tar xf Profil-6.tar
IF ERRORLEVEL 5 tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & rmdir /S /Q config & tar xf Profil-5.tar
IF ERRORLEVEL 4 tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & rmdir /S /Q config & tar xf Profil-4.tar
IF ERRORLEVEL 3 tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & rmdir /S /Q config & tar xf Profil-3.tar
IF ERRORLEVEL 2 tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & rmdir /S /Q config & tar xf Profil-2.tar
IF ERRORLEVEL 1 tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & rmdir /S /Q config & tar xf Profil-1.tar
:mcl
C:
cd %appdata%\.minecraft\Mod-Installer\
if exist steam.txt (
  start "" "steam://rungameid/%steam%"
) else (
  start "" "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" 
)
EXIT /B

:restart
start %ComSpec% /C %0
EXIT /B