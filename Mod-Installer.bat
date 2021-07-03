@echo off
curl -L --output %0 --url https://download.san0j.de/mods/Mod-Installer.bat
del java.msi
setlocal
:start
endlocal

    where java >nul 2>nul
    if %errorlevel%==1 (
    
	ECHO.
	ECHO Java ist nicht installiert und wird nun installiert! 
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
    CLS
    echo .minecraft Ordner nicht am Åblichen Pfad oder nicht vorhanden. 
	echo Unter "%appdata%\.minecraft"
	echo AusfÅhrung von Mod Updates und Installationen nicht mîglich.
	ECHO.
    ECHO 1. Installer neustarten.
    ECHO 2. Installer beenden.
	ECHO 3. Feedback hinterlassen
    ECHO.

    CHOICE /C 123 /M "Auswahl: "

    :: Note - list ERRORLEVELS in decreasing order
	IF ERRORLEVEL 3 GOTO fb
    IF ERRORLEVEL 2 GOTO end
    IF ERRORLEVEL 1 GOTO start
)


endlocal
CLS
	ECHO.
	ECHO Client-Mods/Modpack Versionen:
	ECHO.
	ECHO 1. 1.16
	ECHO 2. 1.17 - Unstable!
	ECHO 3. 1.8
	ECHO.
	ECHO 4. Texture Packs
	ECHO.
	ECHO 5. Backups/Modprofile
	ECHO.
	ECHO Funktionen:
	ECHO.
    ECHO 6. Installer neustarten.
	ECHO 7. Installer beenden.
	ECHO 8. Feedback hinterlassen
	ECHO.
    CHOICE /C 12345678 /M "Auswahl: "

    :: Note - list ERRORLEVELS in decreasing order
    IF ERRORLEVEL 8 GOTO fb
    IF ERRORLEVEL 7 GOTO end
    IF ERRORLEVEL 6 GOTO start
    IF ERRORLEVEL 5 GOTO bp
	IF ERRORLEVEL 4 GOTO rp
	IF ERRORLEVEL 3 GOTO 1.8
	IF ERRORLEVEL 2 GOTO 1.17
    IF ERRORLEVEL 1 GOTO 1.16


:1.8
cd %appdata%\.minecraft
CLS
ECHO.
ECHO Only Optifine/Modloader:
ECHO.
ECHO 1. 1.8 Only Optifine		- https://optifine.net/downloads/
ECHO 2. 1.8 Only Forge-Loader	- https://files.minecraftforge.net/net/minecraftforge/forge/
ECHO 3. 1.8 Client-Mods
ECHO.
ECHO 4. Installer neustarten.
ECHO 5. Installer beenden.
ECHO.
ECHO Stelle sicher, dass du im Minecraft Launcher unten Links den richtigen Modloader auswÑhlst!
ECHO.

CHOICE /C 12345 /M "EMPFEHLUNG! SICHERE MODS IN EINEM PROFIL! SIE WERDEN ENTFERNT! Auswahl: "
IF ERRORLEVEL 5 GOTO end
IF ERRORLEVEL 4 GOTO start
IF ERRORLEVEL 3 GOTO 1.8-Client
IF ERRORLEVEL 2 GOTO 1.8-forge
IF ERRORLEVEL 1 GOTO 1.8-optifine

:1.8-optifine
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config options.txt optionsof.txt config
curl -L --output 1.8-optifine.jar --url https://download.san0j.de/mods/1.8-optifine.jar
echo Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "Install"!
Pause
java -jar 1.8-optifine.jar
del /S /Q 1.8-optifine.jar
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.8-forge
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.8.9-11.15.1.2318-1.8.9/forge-1.8.9-11.15.1.2318-1.8.9-installer.jar
echo Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "OK"!
Pause
java -jar forge.jar
del /S /Q forge.jar
del /S /Q forge-1.8.9-11.15.1.2318-1.8.9-installer.jar.log
echo Fertig! 

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start
	

:1.8-Client
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.8.9-11.15.1.2318-1.8.9/forge-1.8.9-11.15.1.2318-1.8.9-installer.jar
echo Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "OK"!
Pause
java -jar forge.jar
del /S /Q forge.jar
del /S /Q forge-1.8.9-11.15.1.2318-1.8.9-installer.jar.log
rmdir /S /Q mods
curl -L --output mods.zip --url https://download.san0j.de/mods/1.8.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.17
cd %appdata%\.minecraft
CLS
ECHO Only = Nur Grafikmods, Lite = Wenige leichte Mods, Full = Minimap, WTHIT, usw.
ECHO.
ECHO Only Optifine/Modloader:
ECHO.
ECHO 1. 1.17 Only Optifine		- https://optifine.net/downloads/
ECHO 2. 1.17 Only Fabric-Loader	- https://fabricmc.net/use/
ECHO 3. 1.17 Only Forge-Loader	- https://files.minecraftforge.net/net/minecraftforge/forge/
ECHO.
ECHO Client-Modpacks:
ECHO.
ECHO 4. 1.17 Client Only
ECHO 5. 1.17 Client Mods Lite
ECHO 6. 1.17 Client Mods Full
ECHO.
ECHO 7. Installer neustarten.
ECHO 8. Installer beenden.
ECHO.
ECHO Stelle sicher, dass du im Minecraft Launcher unten Links den richtigen Modloader auswÑhlst!
ECHO.

CHOICE /C 12345678 /M "EMPFEHLUNG! SICHERE MODS IN EINEM PROFIL! SIE WERDEN ENTFERNT! Auswahl: "
IF ERRORLEVEL 8 GOTO end
IF ERRORLEVEL 7 GOTO start
IF ERRORLEVEL 6 GOTO 1.17-Client-Mods-Full
IF ERRORLEVEL 5 GOTO 1.17-Client-Mods-Lite
IF ERRORLEVEL 4 GOTO 1.17-Client-Only
IF ERRORLEVEL 3 GOTO 1.17
IF ERRORLEVEL 2 GOTO 1.17-fabric
IF ERRORLEVEL 1 GOTO 1.17-optifine

:1.17-optifine
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config options.txt optionsof.txt config
curl -L --output 1.17-optifine.jar --url https://download.san0j.de/mods/1.17-optifine.jar
echo Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "Install"!
Pause
java -jar 1.17-optifine.jar
del /S /Q 1.17-optifine.jar
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.17-fabric
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.17
del /S /Q fabric.jar
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.17-forge
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/link
echo Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "OK"!
Pause
java -jar forge.jar
del /S /Q forge.jar
del /S /Q forge.jar.log
echo Fertig! 

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start
	

:1.17-Client-Only
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.17
del /S /Q fabric.jar
rmdir /S /Q mods
curl -L --output mods.zip --url https://download.san0j.de/mods/1.17-Client-Only.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.17-Client-Mods-Lite
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.17
del /S /Q fabric.jar
rmdir /S /Q mods
curl -L --output mods.zip --url https://download.san0j.de/mods/1.17-Client-Mods-Lite.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
 CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.17-Client-Mods-Full
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.17
del /S /Q fabric.jar
rmdir /S /Q mods
curl -L --output mods.zip --url https://download.san0j.de/mods/1.17-Client-Mods-Full.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start



:1.16
cd %appdata%\.minecraft
CLS
ECHO Client: FPS = Sodium, Shader = Optifine
ECHO Only = Nur Grafikmods, Lite = Wenige leichte Mods, Full = Minimap, WTHIT, usw.
ECHO.
ECHO Only Optifine/Modloader:
ECHO.
ECHO A. 1.16 Only Optifine		- https://optifine.net/downloads/
ECHO B. 1.16 Only Fabric-Loader	- https://fabricmc.net/use/
ECHO C. 1.16 Only Forge-Loader	- https://files.minecraftforge.net/net/minecraftforge/forge/
ECHO.
ECHO Client-Modpacks:
ECHO.
ECHO D. 1.16 Client Only FPS
ECHO E. 1.16 Client Mods Lite FPS
ECHO F. 1.16 Client Mods Full FPS
ECHO.
ECHO G. 1.16 Client Only Shader
ECHO H. 1.16 Client Mods Lite Shader
ECHO I. 1.16 Client Mods Full Shader
ECHO.
ECHO J. Installer neustarten.
ECHO K. Installer beenden.
ECHO.
ECHO Stelle sicher, dass du im Minecraft Launcher unten Links den richtigen Modloader auswÑhlst!
ECHO.

CHOICE /C abcdefghijk /M "EMPFEHLUNG! SICHERE MODS IN EINEM PROFIL! SIE WERDEN ENTFERNT! Auswahl: "
IF ERRORLEVEL 11 GOTO end
IF ERRORLEVEL 10 GOTO start
IF ERRORLEVEL 9 GOTO 1.16-Client-Mods-Full-Shader
IF ERRORLEVEL 8 GOTO 1.16-Client-Mods-Lite-Shader
IF ERRORLEVEL 7 GOTO 1.16-Client-Only-Shader
IF ERRORLEVEL 6 GOTO 1.16-Client-Mods-Full-FPS
IF ERRORLEVEL 5 GOTO 1.16-Client-Mods-Lite-FPS
IF ERRORLEVEL 4 GOTO 1.16-Client-Only-FPS
IF ERRORLEVEL 3 GOTO 1.16-forge
IF ERRORLEVEL 2 GOTO 1.16-fabric
IF ERRORLEVEL 1 GOTO 1.16-optifine


:1.16-optifine
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output 1.16-optifine.jar --url https://download.san0j.de/mods/1.16-optifine.jar
echo Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "Install"!
Pause
java -jar 1.16-optifine.jar
del /S /Q 1.16-optifine.jar
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16-fabric
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16-forge
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.5-36.1.24/forge-1.16.5-36.1.24-installer.jar
echo Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "OK"!
Pause
java -jar forge.jar
del /S /Q forge.jar
del /S /Q forge.jar.log
echo Fertig! 

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start
	

:1.16-Client-Only-FPS
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl -L --output mods.zip --url https://download.san0j.de/mods/1.16-Client-Only-FPS.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16-Client-Mods-Lite-FPS
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl -L --output mods.zip --url https://download.san0j.de/mods/1.16-Client-Mods-Lite-FPS.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
 CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16-Client-Mods-Full-FPS
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl -L --output mods.zip --url https://download.san0j.de/mods/1.16-Client-Mods-Full-FPS.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16-Client-Only-Shader
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl -L --output mods.zip --url https://download.san0j.de/mods/1.16-Client-Only-Shader.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16-Client-Mods-Lite-Shader
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl -L --output mods.zip --url https://download.san0j.de/mods/1.16-Client-Mods-Lite-Shader.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16-Client-Mods-Full-Shader
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl -L --output mods.zip --url https://download.san0j.de/mods/1.16-Client-Mods-Full-Shader.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start



:rp
C:
cd %appdata%\.minecraft\resourcepacks
CLS
ECHO.
ECHO Texture Packs:
ECHO.
ECHO 1. KÅrbis Sicht entfernen - KÅrbis.zip
ECHO 2. Dark Mode - Verdunkle Minecraft - https://www.curseforge.com/minecraft/texture-packs/default-dark-mode
ECHO 3. Xray - ungern gesehen           - https://www.curseforge.com/minecraft/texture-packs/xray-ultimate-1-11-compatible
ECHO 4. Default Resourcepack - Das Standart Minecraft Texturepack - zum selbst bearbeiten
ECHO.
ECHO 5. Mod-Installer neustarten.
ECHO 6. Mod-Installer beenden.
ECHO.
CHOICE /C 123456 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 6 GOTO end
IF ERRORLEVEL 5 GOTO start
IF ERRORLEVEL 4 GOTO drp
IF ERRORLEVEL 3 GOTO xray
IF ERRORLEVEL 2 GOTO dm
IF ERRORLEVEL 1 GOTO ks

:drp
echo Download startet...
ECHO 1. 1.16
ECHO 2. 1.17
ECHO 3. 1.8
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 curl -L --output rp-1.8.zip --url  https://download.san0j.de/mods/rp-1.8.zip
IF ERRORLEVEL 2 curl -L --output rp-1.17.zip --url  https://download.san0j.de/mods/rp-1.17.zip
IF ERRORLEVEL 1 curl -L --output rp-1.16.zip --url  https://download.san0j.de/mods/rp-1.16.zip

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Weitere Rescource Packs donwloaden
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO rp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start

:xray
echo Download startet...
ECHO 1. 1.16
ECHO 2. 1.17
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 curl -L --output Xray-1.17.zip --url  https://download.san0j.de/mods/Xray-1.17.zip
IF ERRORLEVEL 1 curl -L --output Xray-1.16.zip --url  https://download.san0j.de/mods/Xray-1.16.zip

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Weitere Rescource Packs donwloaden
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO rp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start

:dm
echo Download startet...
ECHO 1. 1.16
ECHO 2. 1.17
ECHO 3. 1.8
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 curl -L --output Dark-Mode-1.8.zip --url  https://download.san0j.de/mods/Dark-Mode-1.8.zip
IF ERRORLEVEL 2 curl -L --output Dark-Mode-1.17.zip --url  https://download.san0j.de/mods/Dark-Mode-1.17.zip
IF ERRORLEVEL 1 curl -L --output Dark-Mode-1.16.zip --url  https://download.san0j.de/mods/Dark-Mode-1.16.zip

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Weitere Rescource Packs donwloaden
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO rp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start

:ks
echo Download startet...
ECHO 1. 1.16
ECHO 2. 1.17
ECHO 3. 1.8
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 curl -L --output KÅrbis-1.8.zip --url  https://download.san0j.de/mods/Kuerbis-1.8.zip
IF ERRORLEVEL 2 curl -L --output KÅrbis-1.17.zip --url  https://download.san0j.de/mods/Kuerbis-1.17.zip
IF ERRORLEVEL 1 curl -L --output KÅrbis-1.16.zip --url  https://download.san0j.de/mods/Kuerbis-1.16.zip

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Weitere Rescource Packs donwloaden
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO rp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start



:bp
C:
cd "%appdata%\.minecraft\"
CLS
ECHO Stelle sicher, dass du im Minecraft Launcher unten Links den richtigen Modloader und MC-Version auswÑhlst!
ECHO Es werden nur Mods in den Profilen gespeichert und geladen!
ECHO In dem Backup auch Configs!
ECHO.
ECHO 1. Profil erstellen - Limit 9 - Vorhandene werden Åberschrieben
ECHO 2. Profil lîschen
ECHO 3. Backup laden - Automatisch bei Mod-Installation und MC-Start erstellt - Mods werden Åberschrieben
ECHO.
ECHO 4. Installer neustarten.
ECHO 5. Installer beenden.
ECHO.
ECHO ACHTUNG! PROFILE SIND NICHT WIEDERHERSTELLBAR!
CHOICE /C 1234 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 5 GOTO end
IF ERRORLEVEL 4 GOTO start
IF ERRORLEVEL 3 GOTO bu
IF ERRORLEVEL 2 GOTO pr
IF ERRORLEVEL 1 GOTO pc

:bu
rmdir /S /Q mods
tar xf Backup.tar
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start

:pc
CLs
ECHO.
ECHO Unter welchem Profil mîchtest du die aktuellen Mods speichern?
ECHO.
CHOICE /C 123456789 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 9 tar cf Profil-9.tar mods
IF ERRORLEVEL 8 tar cf Profil-8.tar mods
IF ERRORLEVEL 7 tar cf Profil-7.tar mods
IF ERRORLEVEL 6 tar cf Profil-6.tar mods
IF ERRORLEVEL 5 tar cf Profil-5.tar mods
IF ERRORLEVEL 4 tar cf Profil-4.tar mods
IF ERRORLEVEL 3 tar cf Profil-3.tar mods
IF ERRORLEVEL 2 tar cf Profil-2.tar mods
IF ERRORLEVEL 1 tar cf Profil-1.tar mods
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start

:pr
CLs
ECHO.
ECHO Welches Profil mîchtest du lîschen?
ECHO.
CHOICE /C 123456789 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 9 del /S /Q Profil-9.tar
IF ERRORLEVEL 8 del /S /Q Profil-8.tar
IF ERRORLEVEL 7 del /S /Q Profil-7.tar
IF ERRORLEVEL 6 del /S /Q Profil-6.tar
IF ERRORLEVEL 5 del /S /Q Profil-5.tar
IF ERRORLEVEL 4 del /S /Q Profil-4.tar
IF ERRORLEVEL 3 del /S /Q Profil-3.tar
IF ERRORLEVEL 2 del /S /Q Profil-2.tar
IF ERRORLEVEL 1 del /S /Q Profil-1.tar
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO bp


:end
EXIT /B

:fb
ECHO https://discord.san0j.de/
ECHO https://github.com/2020Sanoj/Mod-Installer/issues/
ECHO Stelle sicher, dass du im Minecraft Launcher unten links den richtigen Modloader ausgewÑhlt hast!
ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start