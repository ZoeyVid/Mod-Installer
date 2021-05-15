@echo off

C:
cd "%userprofile%\AppData\Roaming\.minecraft\"
tar cf Backup.tar mods config
rmdir /S /Q mods
rmdir /S /Q config
ECHO.
ECHO Which profile do you want to load?
ECHO.
CHOICE /C 123456789 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 9 tar xf Profil-9.tar
IF ERRORLEVEL 8 tar xf Profil-8.tar
IF ERRORLEVEL 7 tar xf Profil-7.tar
IF ERRORLEVEL 6 tar xf Profil-6.tar
IF ERRORLEVEL 5 tar xf Profil-5.tar
IF ERRORLEVEL 4 tar xf Profil-4.tar
IF ERRORLEVEL 3 tar xf Profil-3.tar
IF ERRORLEVEL 2 tar xf Profil-2.tar
IF ERRORLEVEL 1 tar xf Profil-1.tar

C:
cd %userprofile%\AppData\Roaming\.minecraft\
if exist steam (
	start steam://rungameid/13354743620561797120
) else (

if exist "C:\program files (x86)\Minecraft Launcher\MinecraftLauncher.exe" (
  start "" "C:\program files (x86)\Minecraft Launcher\MinecraftLauncher.exe" 
))

curl --output MC-Launcher.bat --url https://download.san0j.de/mods/MC-Launcher.bat