@echo off
del "%userprofile%\AppData\Local\Temp\java.msi"
del "%userprofile%\AppData\Local\Temp\MC-Install.msi"
set /p steam=<%appdata%\.minecraft\steam.txt
CLS
:start
curl -L --output %0 --url https://download.san0j.de/mods/Mod-Installer.bat
endlocal
C:



    where java >nul 2>nul
    if %errorlevel%==1 (
    
	ECHO.
	ECHO Java ist nicht installiert und wird nun installiert! 
	ECHO Von https://lksr.de/corretto
	ECHO Starten?
	Pause
	ECHO Bitte warten!
	ECHO Nach der beendigung der Java Instalation starte den Mod-Installer einfach neu!
	C:
	cd "%userprofile%\AppData\Local\Temp"
	curl -L --output java.msi --url https://corretto.aws/downloads/latest/amazon-corretto-16-x64-windows-jdk.msi
    start "" java.msi
	ECHO Fertig? Neustarten?
	Pause
	GOTO start
)

if not exist "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" (
curl -L --output %0 --url https://download.san0j.de/mods/MC-Launcher.bat

	CLS
	echo Der Minecraft Launcher konnte nicht am öblichen Pfad gefunden werden!
	echo Unter "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe"
	echo Starten von Minecraft nicht mîglich
	echo Minecraft wird nun installiert.
	ECHO Bitte warten!
	ECHO Nach der beendigung der Instalation starte den Mod-Installer einfach neu!
	Pause
	C:
	cd "%userprofile%\AppData\Local\Temp"
	curl -L --output MC-Install.msi --url https://launcher.mojang.com/download/MinecraftInstaller.msi
    start "" MC-Install.msi
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
	echo ôffne den Minecraft Launcher und Probiere ob es dannach funktioniert!
	echo MC-Launcher wird beendet...
	Pause
EXIT /B
)


endlocal
CLS
	ECHO.
	ECHO Client-Mods/Modpack Versionen:
	ECHO.
	ECHO a) 1.17
	ECHO b) 1.16
	ECHO c) 1.8
	ECHO d) Profil Update
	ECHO e) Fabric-Loader	              - https://fabricmc.net/use/
	ECHO f) Iris + Sodium (1.16.5-1.17.1) - https://irisshaders.net/
	ECHO.
	ECHO g) Texture Packs
	ECHO.
	ECHO h) Backups/Modprofile
	ECHO.
	ECHO Funktionen:
	ECHO.
    ECHO i) Installer neustarten.
	ECHO j) Installer beenden.
	ECHO k) Feedback hinterlassen
	ECHO.
    CHOICE /C abcdefghijk /M "Auswahl: "

    :: Note - list ERRORLEVELS in decreasing order
    IF ERRORLEVEL 11 GOTO fb
    IF ERRORLEVEL 10 GOTO end
    IF ERRORLEVEL 9	GOTO start
    IF ERRORLEVEL 8 GOTO bp
	IF ERRORLEVEL 7 GOTO rp
	IF ERRORLEVEL 6 GOTO iris
	IF ERRORLEVEL 5 GOTO fabric
	IF ERRORLEVEL 4 GOTO update
	IF ERRORLEVEL 3 GOTO 1.8
	IF ERRORLEVEL 2 GOTO 1.16
    IF ERRORLEVEL 1 GOTO 1.17

:1.17
cd %appdata%\.minecraft
CLS
ECHO Only = Nur Grafikmods, Lite = Wenige leichte Mods, Full = Minimap, WTHIT, usw.
ECHO.
ECHO Only Optifine/Modloader:
ECHO.
ECHO 1. 1.17 Only Optifine		- https://optifine.net/downloads/
ECHO 2. 1.17 Only Forge-Loader	- https://files.minecraftforge.net/net/minecraftforge/forge/
ECHO.
ECHO Client-Modpacks (Fabric-Loader):
ECHO.
ECHO 3. 1.17 Client Only
ECHO 4. 1.17 Client Mods Lite
ECHO 5. 1.17 Client Mods Full
ECHO.
ECHO 6. Installer neustarten.
ECHO 7. Installer beenden.
ECHO.
ECHO Stelle sicher, dass du im Minecraft Launcher unten Links den richtigen Modloader auswÑhlst!
ECHO.

CHOICE /C 1234567 /M "EMPFEHLUNG! SICHERE MODS IN EINEM PROFIL! SIE WERDEN ENTFERNT! Auswahl: "
IF ERRORLEVEL 7 GOTO end
IF ERRORLEVEL 6 GOTO start
IF ERRORLEVEL 5 GOTO 1.17-Client-Mods-Full
IF ERRORLEVEL 4 GOTO 1.17-Client-Mods-Lite
IF ERRORLEVEL 3 GOTO 1.17-Client-Only
IF ERRORLEVEL 2 GOTO 1.17
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


:1.17-forge
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output forge.jar --url https://download.san0j.de/mods/1.17-forge.jar
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
java -jar fabric.jar client -mcversion 1.17.1
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
java -jar fabric.jar client -mcversion 1.17.1
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
java -jar fabric.jar client -mcversion 1.17.1
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
ECHO Only = Nur Grafikmods, Lite = Wenige leichte Mods, Full = Minimap, WTHIT, usw.
ECHO.
ECHO Only Optifine/Modloader:
ECHO.
ECHO 1. 1.16 Only Optifine		- https://optifine.net/downloads/
ECHO 2. 1.16 Only Forge-Loader	- https://files.minecraftforge.net/net/minecraftforge/forge/
ECHO.
ECHO Client-Modpacks (Fabric-Loader):
ECHO.
ECHO 3. 1.16 Client Only
ECHO 4. 1.16 Client Mods Lite
ECHO 5. 1.16 Client Mods Full
ECHO.
ECHO 6. Installer neustarten.
ECHO 7. Installer beenden.
ECHO.
ECHO Stelle sicher, dass du im Minecraft Launcher unten Links den richtigen Modloader auswÑhlst!
ECHO.

CHOICE /C 1234567 /M "EMPFEHLUNG! SICHERE MODS IN EINEM PROFIL! SIE WERDEN ENTFERNT! Auswahl: "
IF ERRORLEVEL 7 GOTO end
IF ERRORLEVEL 6 GOTO start
IF ERRORLEVEL 5 GOTO 1.16-Client-Mods-Full
IF ERRORLEVEL 4 GOTO 1.16-Client-Mods-Lite
IF ERRORLEVEL 3 GOTO 1.16-Client-Only
IF ERRORLEVEL 2 GOTO 1.16-forge
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


:1.16-forge
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output forge.jar --url https://download.san0j.de/mods/1.16-forge.jar
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
	

:1.16-Client-Only
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl -L --output mods.zip --url https://download.san0j.de/mods/1.16-Client-Only.zip
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


:1.16-Client-Mods-Lite
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl -L --output mods.zip --url https://download.san0j.de/mods/1.16-Client-Mods-Lite.zip
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


:1.16-Client-Mods-Full
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl -L --output mods.zip --url https://download.san0j.de/mods/1.16-Client-Mods-Full.zip
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



:1.8
cd %appdata%\.minecraft
CLS
ECHO.
ECHO Only Optifine/Modloader:
ECHO.
ECHO 1. 1.8 Only Optifine		- https://optifine.net/downloads/
ECHO 2. 1.8 Only Forge-Loader	- https://files.minecraftforge.net/net/minecraftforge/forge/
ECHO 3. 1.8 Client-Mods (Forge-Loader)
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
tar cf Backup.tar mods options.txt optionsof.txt config
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
curl -L --output forge.jar --url https://download.san0j.de/mods/1.8-forge.jar
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
curl -L --output forge.jar --url https://download.san0j.de/mods/1.8-forge.jar
echo Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "OK"!
Pause
java -jar forge.jar
del /S /Q forge.jar
del /S /Q forge.jar.log
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



:fabric
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar
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




:iris
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output iris.jar --url https://github.com/IrisShaders/Iris-Installer/releases/download/1.1.1/Iris-Installer-1.1.1.jar
java -jar iris.jar
del /S /Q iris.jar
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
ECHO 2. Dark Mode - Verdunkle Minecraft - https://lksr.de/darkrp
ECHO 3. Xray - ungern gesehen           - https://lksr.de/xray
ECHO 4. Default Resourcepack - Das Standart Minecraft Texturepack - zum selbst bearbeiten
ECHO 5. Textures der neuen Versionen fÅr die 1.8 - https://lksr.de/18new
ECHO 6. 1.8 PVP Pack (das von BastiGHG) - https://lksr.de/pvp
ECHO 7. Alles
ECHO.
ECHO 8. Mod-Installer neustarten.
ECHO 9. Mod-Installer beenden.
ECHO.
CHOICE /C 123456789 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 9 GOTO end
IF ERRORLEVEL 8 GOTO start
IF ERRORLEVEL 7 GOTO rpa
IF ERRORLEVEL 6 GOTO pvp
IF ERRORLEVEL 5 GOTO 1.8-new
IF ERRORLEVEL 4 GOTO drp
IF ERRORLEVEL 3 GOTO xray
IF ERRORLEVEL 2 GOTO dm
IF ERRORLEVEL 1 GOTO ks

:rpa
cd %appdata%\.minecraft
echo Download start...
curl -L --output Alles.zip --url  https://download.san0j.de/mods/Alles.zip
tar -xf Alles.zip
del /S /Q Alles.zip

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO rp
IF ERRORLEVEL 2 GOTO end

:pvp
echo Download start...
curl -L --output BastiGHG-PVP.zip --url  https://download.san0j.de/mods/BastiGHG-PVP.zip

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Weitere Rescource Packs donwloaden
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO rp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start

:1.8-new
curl -L --output 1.8-rp-with-newer-textures.zip --url  https://download.san0j.de/mods/1.8-rp-with-newer-textures.zip

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Weitere Rescource Packs donwloaden
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO rp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start

:drp
echo Download startet...
ECHO 1. 1.17
ECHO 2. 1.16
ECHO 3. 1.8
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 curl -L --output rp-1.8.zip --url  https://download.san0j.de/mods/rp-1.8.zip
IF ERRORLEVEL 2 curl -L --output rp-1.16.zip --url  https://download.san0j.de/mods/rp-1.17.zip
IF ERRORLEVEL 1 curl -L --output rp-1.17.zip --url  https://download.san0j.de/mods/rp-1.16.zip

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
ECHO 1. 1.17
ECHO 2. 1.16
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 curl -L --output Xray-1.16.zip --url  https://download.san0j.de/mods/Xray-1.17.zip
IF ERRORLEVEL 1 curl -L --output Xray-1.17.zip --url  https://download.san0j.de/mods/Xray-1.16.zip

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
ECHO 1. 1.17
ECHO 2. 1.16
ECHO 3. 1.8
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 curl -L --output Dark-Mode-1.8.zip --url  https://download.san0j.de/mods/Dark-Mode-1.8.zip
IF ERRORLEVEL 2 curl -L --output Dark-Mode-1.16.zip --url  https://download.san0j.de/mods/Dark-Mode-1.17.zip
IF ERRORLEVEL 1 curl -L --output Dark-Mode-1.17.zip --url  https://download.san0j.de/mods/Dark-Mode-1.16.zip

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
ECHO 1. 1.17
ECHO 2. 1.16
ECHO 3. 1.8
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 curl -L --output KÅrbis-1.8.zip --url  https://download.san0j.de/mods/Kuerbis-1.8.zip
IF ERRORLEVEL 2 curl -L --output KÅrbis-1.16.zip --url  https://download.san0j.de/mods/Kuerbis-1.17.zip
IF ERRORLEVEL 1 curl -L --output KÅrbis-1.17.zip --url  https://download.san0j.de/mods/Kuerbis-1.16.zip

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
ECHO 1. Profil erstellen - Limit 8 - Vorhandene werden Åberschrieben
ECHO 2. Profil laden
ECHO 3. Profil lîschen
ECHO 4. Backup laden - Automatisch bei Mod-Installation und MC-Start erstellt - Mods werden Åberschrieben
ECHO.
ECHO 5. Installer neustarten.
ECHO 6. Installer beenden.
ECHO.
ECHO ACHTUNG! PROFILE SIND NICHT WIEDERHERSTELLBAR!
CHOICE /C 123456 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 6 GOTO end
IF ERRORLEVEL 5 GOTO start
IF ERRORLEVEL 4 GOTO bl
IF ERRORLEVEL 3 GOTO pr
IF ERRORLEVEL 2 GOTO pl
IF ERRORLEVEL 1 GOTO pc

:bl
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

:pr
CLs
ECHO.
ECHO Welches Profil mîchtest du lîschen?
ECHO.
CHOICE /C 12345678 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
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

:pl
CLS
ECHO.
ECHO Welches Profil mîchtest du laden?
ECHO.
CHOICE /C 12345678 /M "Auswahl: "
IF ERRORLEVEL 8 tar xf Profil-8.tar
IF ERRORLEVEL 7 tar xf Profil-7.tar
IF ERRORLEVEL 6 tar xf Profil-6.tar
IF ERRORLEVEL 5 tar xf Profil-5.tar
IF ERRORLEVEL 4 tar xf Profil-4.tar
IF ERRORLEVEL 3 tar xf Profil-3.tar
IF ERRORLEVEL 2 tar xf Profil-2.tar
IF ERRORLEVEL 1 tar xf Profil-1.tar
ECHO Geladen!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
ECHO 4. Minecraft starten
CHOICE /C 1234 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 4 GOTO mcl
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start

:mcl
echo Starten...
C:
cd %appdata%\.minecraft\
if exist steam.txt (
  start "" "steam://rungameid/%steam%"
) else (
  start "" "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" 
)
EXIT /B

:pc
CLS
ECHO.
ECHO Was soll Im Profil gespeichert werden?
ECHO.
ECHO 1. Nur Mods
ECHO 2. Mods + Config
ECHO 3. Nur Configs
ECHO.
ECHO ACHTUNG! PROFILE SIND NICHT WIEDERHERSTELLBAR!
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO pcc
IF ERRORLEVEL 2 GOTO pcmc
IF ERRORLEVEL 1 GOTO pcm

:pcc
CLs
ECHO.
ECHO Unter welchem Profil mîchtest du die aktuellen Configs speichern?
ECHO.
CHOICE /C 12345678 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 8 tar cf Profil-8.tar config optionsof.txt options.txt
IF ERRORLEVEL 7 tar cf Profil-7.tar config optionsof.txt options.txt
IF ERRORLEVEL 6 tar cf Profil-6.tar config optionsof.txt options.txt
IF ERRORLEVEL 5 tar cf Profil-5.tar config optionsof.txt options.txt
IF ERRORLEVEL 4 tar cf Profil-4.tar config optionsof.txt options.txt
IF ERRORLEVEL 3 tar cf Profil-3.tar config optionsof.txt options.txt
IF ERRORLEVEL 2 tar cf Profil-2.tar config optionsof.txt options.txt
IF ERRORLEVEL 1 tar cf Profil-1.tar config optionsof.txt options.txt
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start

:pcmc
CLs
ECHO.
ECHO Unter welchem Profil mîchtest du die aktuellen Mods und Configs speichern?
ECHO.
CHOICE /C 12345678 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 8 tar cf Profil-8.tar mods config optionsof.txt options.txt
IF ERRORLEVEL 7 tar cf Profil-7.tar mods config optionsof.txt options.txt
IF ERRORLEVEL 6 tar cf Profil-6.tar mods config optionsof.txt options.txt
IF ERRORLEVEL 5 tar cf Profil-5.tar mods config optionsof.txt options.txt
IF ERRORLEVEL 4 tar cf Profil-4.tar mods config optionsof.txt options.txt
IF ERRORLEVEL 3 tar cf Profil-3.tar mods config optionsof.txt options.txt
IF ERRORLEVEL 2 tar cf Profil-2.tar mods config optionsof.txt options.txt
IF ERRORLEVEL 1 tar cf Profil-1.tar mods config optionsof.txt options.txt
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen/lîschen
CHOICE /C 123 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO bp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start

:pcm
CLs
ECHO.
ECHO Unter welchem Profil mîchtest du die aktuellen Mods speichern?
ECHO.
CHOICE /C 12345678 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
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



:update
CLS
ECHO.
ECHO Welches Profil mîchtest du aktualisieren?
ECHO.
CHOICE /C 12345678 /M "Auswahl: "
IF ERRORLEVEL 8 tar xf Profil-8.tar
IF ERRORLEVEL 7 tar xf Profil-7.tar
IF ERRORLEVEL 6 tar xf Profil-6.tar
IF ERRORLEVEL 5 tar xf Profil-5.tar
IF ERRORLEVEL 4 tar xf Profil-4.tar
IF ERRORLEVEL 3 tar xf Profil-3.tar
IF ERRORLEVEL 2 tar xf Profil-2.tar
IF ERRORLEVEL 1 tar xf Profil-1.tar

ECHO.
ECHO Mit welchem Modpack mîchtest du dieses Profil aktualisieren?
    ECHO.
    ECHO Client-Mods/Modpack Versionen:
	ECHO.
	ECHO 1. 1.17
	ECHO 2. 1.16
	ECHO 3. 1.8
	ECHO 4. Iris + Sodium (1.16.5-1.17.1)
CHOICE /C 1234 /M "Auswahl: "
IF ERRORLEVEL 4 GOTO iris
IF ERRORLEVEL 3 GOTO 1.8
IF ERRORLEVEL 2 GOTO 1.16
IF ERRORLEVEL 1 GOTO 1.17

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



:end
EXIT /B