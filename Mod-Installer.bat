@echo off
curl --output %0 --url https://download.san0j.de/mods/Mod-Installer.bat
setlocal
:start
endlocal
    where java >nul 2>nul
    if %errorlevel%==1 (

	ECHO Java ist nicht installiert, der Mod-Installer wird nun gestoppt, 
	ECHO Bitte installiere Java 16 um diesen Mod-Installer nutzten zu kînnen! 
	ECHO https://adoptopenjdk.net/
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

if not exist "%userprofile%\AppData\Roaming\.minecraft" (
    CLS
    echo .minecraft Ordner nicht am Åblichen Pfad oder nicht vorhanden. 
	echo Unter "%userprofile%\AppData\Roaming\.minecraft"
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
	ECHO 2. 1.17
	ECHO.
	ECHO 3. Texture Packs
	ECHO.
	ECHO 4. Backups/Modprofile
	ECHO.
	ECHO Funktionen:
	ECHO.
    ECHO 5. Installer neustarten.
	ECHO 6. Installer beenden.
	ECHO 7. Feedback hinterlassen
	ECHO.
    CHOICE /C 1234567 /M "Auswahl: "

    :: Note - list ERRORLEVELS in decreasing order
    IF ERRORLEVEL 7 GOTO fb
    IF ERRORLEVEL 6 GOTO end
    IF ERRORLEVEL 5 GOTO start
    IF ERRORLEVEL 4 GOTO bp
	IF ERRORLEVEL 3 GOTO tp
	IF ERRORLEVEL 2 GOTO start
    IF ERRORLEVEL 1 GOTO 1.16

:1.17
cd %userprofile%\AppData\Roaming\.minecraft
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

CHOICE /C abcdefghijk /M "EMPFEHLUNG! SICHERE MODS IN EINEM PROFIL! SIE WERDEN ENTFERNT! Auswahl: "
IF ERRORLEVEL 8 GOTO end
IF ERRORLEVEL 7 GOTO start
IF ERRORLEVEL 6 GOTO 1.17-Client-Mods-Full
IF ERRORLEVEL 5 GOTO 1.17-Client-Mods-Lite
IF ERRORLEVEL 4 GOTO 1.17-Client-Only
IF ERRORLEVEL 3 GOTO 1.17-forge
IF ERRORLEVEL 2 GOTO 1.17-fabric
IF ERRORLEVEL 1 GOTO 1.17-optifine

:1.17-optifine
echo Instalation startet...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods
curl --output 1.17-optifine.jar --url https://download.san0j.de/mods/1.17-optifine.jar
echo Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "Install"!
Pause
java -jar 1.17-optifine.jar
del /S /Q 1.17-optifine.jar
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.17-fabric
echo Instalation startet...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.17
del /S /Q fabric.jar
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.17-forge
echo Instalation startet...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods
curl --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/link
echo Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "OK"!
Pause
java -jar forge.jar
del /S /Q forge.jar
del /S /Q forge.jar.log
echo Fertig! 

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start
	

:1.17-Client-Only
echo Instalation startet...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.17
del /S /Q fabric.jar
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.17-Client-Only.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.17-Client-Mods-Lite
echo Instalation startet...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.17
del /S /Q fabric.jar
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.17-Client-Mods-Lite.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
 CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.17-Client-Mods-Full
echo Instalation startet...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.17
del /S /Q fabric.jar
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.17-Client-Mods-Full.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start



:1.16
cd %userprofile%\AppData\Roaming\.minecraft
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
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods
curl --output 1.16-optifine.jar --url https://download.san0j.de/mods/1.16-optifine.jar
echo Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "Install"!
Pause
java -jar 1.16-optifine.jar
del /S /Q 1.16-optifine.jar
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16-fabric
echo Instalation startet...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16-forge
echo Instalation startet...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods
curl --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.5-36.1.24/forge-1.16.5-36.1.24-installer.jar
echo Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "OK"!
Pause
java -jar forge.jar
del /S /Q forge.jar
del /S /Q forge.jar.log
echo Fertig! 

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start
	

:1.16-Client-Only-FPS
echo Instalation startet...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16-Client-Only-FPS.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16-Client-Mods-Lite-FPS
echo Instalation startet...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16-Client-Mods-Lite-FPS.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
 CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16-Client-Mods-Full-FPS
echo Instalation startet...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16-Client-Mods-Full-FPS.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16-Client-Only-Shader
echo Instalation startet...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16-Client-Only-Shader.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16-Client-Mods-Lite-Shader
echo Instalation startet...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16-Client-Mods-Lite-Shader.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16-Client-Mods-Full-Shader
echo Instalation startet...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16-Client-Mods-Full-Shader.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start



:tp
cd %userprofile%\AppData\Roaming\.minecraft
CLS
ECHO.
ECHO Texture Packs:
ECHO.
ECHO 1. KÅrbis Sicht entfernen - KÅrbis.zip
ECHO 2. Dark Mode - Verdunkle Minecraft	- https://www.curseforge.com/minecraft/texture-packs/default-dark-mode
ECHO 3. Xray - ungern gesehen			- https://www.curseforge.com/minecraft/texture-packs/xray-ultimate-1-11-compatible
ECHO 4. Standart Resourcepack - erstelle dein eigenes Resourcepack
ECHO.
ECHO 5. Mod-Installer neustarten.
ECHO 6. Mod-Installer beenden.
ECHO.
CHOICE /C 123456 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 6 GOTO end
IF ERRORLEVEL 5 GOTO start
IF ERRORLEVEL 4 GOTO sr
IF ERRORLEVEL 3 GOTO x
IF ERRORLEVEL 2 GOTO dm
IF ERRORLEVEL 1 GOTO k

:k
echo Instalation startet...
C:
cd %userprofile%\AppData\Roaming\.minecraft\resourcepacks
curl --output KÅrbis.zip --url https://download.san0j.de/mods/KÅrbis.zip

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:dm
echo Instalation startet...
C:
cd %userprofile%\AppData\Roaming\.minecraft\resourcepacks
curl --output Dark.zip --url https://download.san0j.de/mods/Dark-Mode.zip

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:x
echo Instalation startet...
C:
cd %userprofile%\AppData\Roaming\.minecraft\resourcepacks
curl --output Xray.zip --url https://download.san0j.de/mods/Xray.zip

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:sr
echo Instalation startet...
mkdir Selfedit
cd Selfedit
curl --output rp.zip --url https://download.san0j.de/mods/default-rp-for-selfedit.zip
tar -xf rp.zip
del /S /Q rp.zip

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:bp
C:
cd "%userprofile%\AppData\Roaming\.minecraft\"
CLS
ECHO Stelle sicher, dass du im Minecraft Launcher unten Links den richtigen Modloader auswÑhlst!
ECHO.
ECHO 1. Profil erstellen - Limit 9
ECHO 2. Backup laden - wird Automatisch beim Herunterladen von Modpacks und dem laden von Profilen erstellt
ECHO.
ECHO 3. Installer neustarten.
ECHO 4. Installer beenden.
ECHO.
CHOICE /C 1234 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 4 GOTO end
IF ERRORLEVEL 3 GOTO start
IF ERRORLEVEL 2 GOTO bu
IF ERRORLEVEL 1 GOTO pc

:bu
rmdir /S /Q mods
tar xf Backup.tar
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
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
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
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