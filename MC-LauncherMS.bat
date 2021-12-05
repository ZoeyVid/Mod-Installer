@echo off
:start
FOR /F "usebackq" %%f IN (`PowerShell -NoProfile -Command "Write-Host([Environment]::GetFolderPath('Desktop'))"`) DO (
  SET "DESKTOP_FOLDER=%%f"
  )
del /S /Q "%appdata%\.minecraft\fabric.jar"
del /S /Q "%appdata%\.minecraft\1.17.bat"
del /S /Q "%appdata%\.minecraft\Update.bat"
del /S /Q "%appdata%\.minecraft\I.bat"
del /S /Q "%appdata%\.minecraft\IMS.bat"
set /p steam=<%ProgramFiles%\Mod-Installer\steam.txt
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
IF ERRORLEVEL 8 tar cf Backup.tar mods config the5zigmod cosmetics essential optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & rmdir /S /Q config & tar xf Profil-8.tar
IF ERRORLEVEL 7 tar cf Backup.tar mods config the5zigmod cosmetics essential optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & rmdir /S /Q config & tar xf Profil-7.tar
IF ERRORLEVEL 6 tar cf Backup.tar mods config the5zigmod cosmetics essential optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & rmdir /S /Q config & tar xf Profil-6.tar
IF ERRORLEVEL 5 tar cf Backup.tar mods config the5zigmod cosmetics essential optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & rmdir /S /Q config & tar xf Profil-5.tar
IF ERRORLEVEL 4 tar cf Backup.tar mods config the5zigmod cosmetics essential optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & rmdir /S /Q config & tar xf Profil-4.tar
IF ERRORLEVEL 3 tar cf Backup.tar mods config the5zigmod cosmetics essential optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & rmdir /S /Q config & tar xf Profil-3.tar
IF ERRORLEVEL 2 tar cf Backup.tar mods config the5zigmod cosmetics essential optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & rmdir /S /Q config & tar xf Profil-2.tar
IF ERRORLEVEL 1 tar cf Backup.tar mods config the5zigmod cosmetics essential optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & rmdir /S /Q config & tar xf Profil-1.tar
:mcl
TASKKILL /T /F /IM MinecraftLauncher.exe
TASKKILL /T /F /IM Minecraft.exe
C:
cd %ProgramFiles%\Mod-Installer\
if exist steam.txt (
  start "" "steam://rungameid/%steam%"
) else (
  start "" shell:AppsFolder\Microsoft.4297127D64EC6_8wekyb3d8bbwe!Minecraft 
)
EXIT /B

:restart
start %ComSpec% /C %0
EXIT /B
