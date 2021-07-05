@echo off
del java.msi
:start
C:

    where java >nul 2>nul
    if %errorlevel%==1 (
    
	ECHO.
	ECHO Java ist nicht installiert und wird nun installiert! 
	ECHO Von https://lksr.de/corretto
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
curl -L --output %0 --url https://download.san0j.de/mods/MC-Launcher.bat

    CLS
    echo .minecraft Ordner nicht am Åblichen Pfad oder nicht vorhanden. 
	echo Unter "%appdata%\.minecraft"
	echo Starten von Minecraft nicht mîglich
	echo MC-Launcher wird beendet...
	Pause
EXIT /B
)


if not exist "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" (
curl -L --output %0 --url https://download.san0j.de/mods/MC-Launcher.bat

	CLS
	echo Minecraft Launcher konnte nicht am öblichen Pfad gefunden werden!
	echo Unter "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe"
	echo Starten von Minecraft nicht mîglich
	echo MC-Launcher wird beendet...
	Pause
EXIT /B	
)

C:
cd "%appdata%\.minecraft\"
tar cf Backup.tar mods config
rmdir /S /Q mods
CLS
ECHO.
ECHO Mit welchem Mod-Profil Minecraft starten?
ECHO Achte darauf im MC-Launcher den richtigen Mod-Loader zuwÑhlen!
ECHO.
CHOICE /C 123456789 /M "Auswahl: "
IF ERRORLEVEL 9 tar xf Profil-9.tar
IF ERRORLEVEL 8 tar xf Profil-8.tar
IF ERRORLEVEL 7 tar xf Profil-7.tar
IF ERRORLEVEL 6 tar xf Profil-6.tar
IF ERRORLEVEL 5 tar xf Profil-5.tar
IF ERRORLEVEL 4 tar xf Profil-4.tar
IF ERRORLEVEL 3 tar xf Profil-3.tar
IF ERRORLEVEL 2 tar xf Profil-2.tar
IF ERRORLEVEL 1 tar xf Profil-1.tar

echo Mods geladen! Starten...
C:
cd %appdata%\.minecraft\
if exist steam (

	start steam://rungameid/13354743620561797120
curl -L --output %0 --url https://download.san0j.de/mods/MC-Launcher.bat
	
) else (

  start "" "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" 
curl -L --output %0 --url https://download.san0j.de/mods/MC-Launcher.bat
  
)
EXIT /B