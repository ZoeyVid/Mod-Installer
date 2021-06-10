@echo off
setlocal
:start
endlocal
    where java >nul 2>nul
    if %errorlevel%==1 (

	ECHO Java ist nicht installiert, der Mod-Installer wird nun gestoppt, 
	ECHO bitte installiere Java um diesen Mod-Installer nutzten zu kînnen! 
	ECHO https://adoptopenjdk.net/
	ECHO.
    ECHO 1. Update/Install Mod-Installer - Empfohlen
    ECHO 2. Update/Install Dev-Mod-Installer - evt. Fehlerhaft
    ECHO 3. Installer neustarten.
    ECHO 4. Installer beenden.
	ECHO 5. Feedback hinterlassen
    ECHO.

    CHOICE /C 12345 /M "Auswahl: "

    :: Note - list ERRORLEVELS in decreasing order
	IF ERRORLEVEL 5 GOTO fb
    IF ERRORLEVEL 4 GOTO end
    IF ERRORLEVEL 3 GOTO start
    IF ERRORLEVEL 2 GOTO Dev
    IF ERRORLEVEL 1 GOTO update
)

if exist %userprofile%\AppData\Roaming\.minecraft (
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
	ECHO 5. Minecraft-Launcher starten
	ECHO.
	ECHO Funktionen:
	ECHO.
	ECHO 6. Update/Install Mod-Installer - Empfohlen
	ECHO 7. Update/Install Dev-Mod-Installer - evt. Fehlerhaft
    ECHO 8. Installer neustarten.
	ECHO 9. Installer beenden.
	ECHO 10. Feedback hinterlassen
	ECHO.
    CHOICE /C 123456789 /M "Auswahl: "

    :: Note - list ERRORLEVELS in decreasing order
    IF ERRORLEVEL 10 GOTO fb
    IF ERRORLEVEL 9 GOTO end
    IF ERRORLEVEL 8 GOTO start
    IF ERRORLEVEL 7 GOTO Dev
    IF ERRORLEVEL 6 GOTO update
    IF ERRORLEVEL 5 GOTO mcl
    IF ERRORLEVEL 4 GOTO bp
	IF ERRORLEVEL 3 GOTO tp
	IF ERRORLEVEL 2 GOTO 1.17
    IF ERRORLEVEL 1 GOTO 1.16

:1.17
CLS
ECHO Client: FPS = Sodium, Shader = Optifine
ECHO Only = Nur Grafikmods, Lite = Wenige leichte Mods, Full = Minimap, Hwyla, usw.
ECHO Client = Auf Vanila Servern spielbar, Modpack = Nur auf Servern mit dem selben installierten Modpack spielbar und im Singleplayer.
ECHO.
ECHO Only Optifine/Modloader:
ECHO.
ECHO 1. 1.17 Only Optifine		- https://optifine.net/downloads/
ECHO 2. 1.17 Only Fabric-Loader	- https://fabricmc.net/use/
ECHO 3. 1.17 Only Forge-Loader	- https://files.minecraftforge.net/net/minecraftforge/forge/
ECHO.
ECHO 4. Installer neustarten.
ECHO 5. Installer beenden.
ECHO.
ECHO Stelle sicher, dass du im Minecraft Launcher unten Links den richtigen Modloader auswÑhlst!
ECHO.

CHOICE /C 12345 /M "EMPFEHLUNG! SICHERE MODS/CONFIGS IN EINEM PROFIL! SIE WERDEN ENTFERNT! Auswahl: "
IF ERRORLEVEL 5 GOTO end
IF ERRORLEVEL 4 GOTO start
IF ERRORLEVEL 3 GOTO start
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
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.3/fabric-installer-0.7.3.jar
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


:1.16
CLS
ECHO Client: FPS = Sodium, Shader = Optifine
ECHO Only = Nur Grafikmods, Lite = Wenige leichte Mods, Full = Minimap, Hwyla, usw.
ECHO Client = Auf Vanila Servern spielbar, Modpack = Nur auf Servern mit dem selben installierten Modpack spielbar und im Singleplayer.
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
ECHO Modpacks:
ECHO.
ECHO J. 1.16 Sanoj's Forge Modpack Lite 	 	- https://www.curseforge.com/minecraft/modpacks/sanojs-forge-loader-modpack/
ECHO K. 1.16 Sanoj's Forge Modpack Full 	 	- https://www.curseforge.com/minecraft/modpacks/sanojs-forge-loader-modpack/
ECHO.
ECHO L. 1.16 Sanoj's Fabric Modpack Lite 		- https://www.curseforge.com/minecraft/modpacks/sanojs-fabric-loader-modpack
ECHO M. 1.16 Sanoj's Fabric Modpack Full  		- https://www.curseforge.com/minecraft/modpacks/sanojs-fabric-loader-modpack
ECHO.
ECHO Server Modpacks:
ECHO.
ECHO N. 1.16 Forge Server Pack
ECHO O. 1.16 Fabric Server Pack
ECHO.
ECHO P. Installer neustarten.
ECHO Q. Installer beenden.
ECHO.
ECHO Stelle sicher, dass du im Minecraft Launcher unten Links den richtigen Modloader auswÑhlst!
ECHO.

CHOICE /C abcdefghijklmnopq /M "EMPFEHLUNG! SICHERE MODS/CONFIGS IN EINEM PROFIL! SIE WERDEN ENTFERNT! Auswahl: "
IF ERRORLEVEL 17 GOTO end
IF ERRORLEVEL 16 GOTO start
IF ERRORLEVEL 15 GOTO 1.16-fas
IF ERRORLEVEL 14 GOTO 1.16-fos
IF ERRORLEVEL 13 GOTO 1.16-sanoj's-fabric-modpack-full
IF ERRORLEVEL 12 GOTO 1.16-sanoj's-fabric-modpack-lite
IF ERRORLEVEL 11 GOTO 1.16-sanoj's-forge-modpack-full
IF ERRORLEVEL 10 GOTO 1.16-sanoj's-forge-modpack-lite
IF ERRORLEVEL 9 GOTO 1.16-Client-Mods-Full-Shader
IF ERRORLEVEL 8 GOTO 1.16-Client-Mods-Lite-Shader
IF ERRORLEVEL 7 GOTO 1.16-Client-Only-Shader
IF ERRORLEVEL 6 GOTO 1.16-Client-Mods-Full-FPS
IF ERRORLEVEL 5 GOTO 1.16-Client-Mods-Lite-FPS
IF ERRORLEVEL 4 GOTO 1.16-Client-Only-FPS
IF ERRORLEVEL 3 GOTO 1.16-forge
IF ERRORLEVEL 2 GOTO 1.16-fabric
IF ERRORLEVEL 1 GOTO 1.16-optifine

:tp
CLS
ECHO.
ECHO Texture Packs:
ECHO.
ECHO 1. KÅrbis Sicht entfernen - KÅrbis.zip
ECHO 2. Dark Mode - Verdunkle Minecraft	- https://www.curseforge.com/minecraft/texture-packs/default-dark-mode
ECHO 3. Xray - ungern gesehen			- https://www.curseforge.com/minecraft/texture-packs/xray-ultimate-1-11-compatible
ECHO 4. Standart Resourcepack - erstelle dein eigenes Resourcepack
ECHO    Gespeichert im Pfad des Installers - Umbennenung des Ordners Empfohlen
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
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.3/fabric-installer-0.7.3.jar
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
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.3/fabric-installer-0.7.3.jar
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
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.3/fabric-installer-0.7.3.jar
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
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.3/fabric-installer-0.7.3.jar
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
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.3/fabric-installer-0.7.3.jar
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
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.3/fabric-installer-0.7.3.jar
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
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.3/fabric-installer-0.7.3.jar
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


:1.16-sanoj's-forge-modpack-lite
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
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16-Sanojs-Forge-Modpack-Lite.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16-sanoj's-forge-modpack-full
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
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16-Sanojs-Forge-Modpack-Full.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16-sanoj's-fabric-modpack-lite
echo Instalation startet...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.3/fabric-installer-0.7.3.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16-Sanojs-Fabric-Modpack-Lite.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16-sanoj's-fabric-modpack-full
echo Instalation startet...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.3/fabric-installer-0.7.3.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16-Sanojs-Fabric-Modpack-Full.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16-fos
echo Download startet...
start https://download.san0j.de/mods/1.16-Forge-Server-Pack.zip
ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16-fas
echo Download startet...
start https://download.san0j.de/mods/1.16-Fabric-Server-Pack.zip
ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


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

:mcl
echo Starten...
C:
cd %userprofile%\AppData\Roaming\.minecraft\
if exist steam (
	start steam://rungameid/13354743620561797120
) else (

if exist "C:\program files (x86)\Minecraft Launcher\MinecraftLauncher.exe" (
  start "" "C:\program files (x86)\Minecraft Launcher\MinecraftLauncher.exe" 
) else (
	CLS
	echo Minecraft Launcher konnte nicht am öblichen Pfad gefunden werden!
	ECHO.
    ECHO 1. Update/Install Mod-Installer - Empfohlen
    ECHO 2. Update/Install Dev-Mod-Installer - evt. Fehlerhaft
    ECHO 3. Installer neustarten.
    ECHO 4. Installer beenden.
	ECHO 5. Feedback hinterlassen
    ECHO.

    CHOICE /C 12345 /M "Auswahl: "

    :: Note - list ERRORLEVELS in decreasing order
	IF ERRORLEVEL 5 GOTO fb
    IF ERRORLEVEL 4 GOTO end
    IF ERRORLEVEL 3 GOTO start
    IF ERRORLEVEL 2 GOTO Dev
    IF ERRORLEVEL 1 GOTO update
)

)
EXIT /B

:bp
C:
cd "%userprofile%\AppData\Roaming\.minecraft\"
CLS
ECHO Stelle sicher, dass du im Minecraft Launcher unten Links den richtigen Modloader auswÑhlst!
ECHO.
ECHO 1. Profil erstellen - Limit 9
ECHO 2. Profil laden - EMPFEHLUNG! SICHERE MODS/CONFIGS IN EINEM PROFIL! SIE WERDEN ENTFERNT!
ECHO.
ECHO 3. Backup laden - wird Automatisch beim Herunterladen von Modpacks und dem laden von Profilen erstellt
ECHO.
ECHO 4. Installer neustarten.
ECHO 5. Installer beenden.
ECHO.
CHOICE /C 12345 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 5 GOTO end
IF ERRORLEVEL 4 GOTO start
IF ERRORLEVEL 3 GOTO bu
IF ERRORLEVEL 2 GOTO pu
IF ERRORLEVEL 1 GOTO pc

:bu
rmdir /S /Q mods
rmdir /S /Q config
tar xf Backup.tar
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start

:pu
tar cf Backup.tar mods
rmdir /S /Q mods
rmdir /S /Q config
ECHO.
ECHO Welches Profil mîchtest du laden?
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
ECHO Unter welchem Profil mîchtest du die aktuellen Mods und Configs speichern?
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
IF ERRORLEVEL 1 GOTO start


:update
curl --output Mod-Installer.bat --url https://download.san0j.de/mods/Mod-Installer.bat
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:Dev
curl --output Mod-Installer-Dev.bat --url https://download.san0j.de/mods/Mod-Installer-Dev.bat
echo Fertig!

ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:end
EXIT /B

:fb
ECHO https://discord.san0j.de/
ECHO https://github.com/2020Sanoj/Mod-Installer/issues
ECHO Stelle sicher, dass du im Minecraft Launcher unten links den richtigen Modloader ausgewÑhlt hast!
ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


)   else (
    CLS
	
    echo .minecraft Ordner nicht am Åblichen Pfad oder nicht vorhanden. 
	echo AusfÅhrung von Mod Updates und Installationen nicht mîglich.
	ECHO.
    ECHO 1. Update/Install Mod-Installer - Empfohlen
    ECHO 2. Update/Install Dev-Mod-Installer - evt. Fehlerhaft
    ECHO 3. Installer neustarten.
    ECHO 4. Installer beenden.
	ECHO 5. Feedback hinterlassen
    ECHO.

    CHOICE /C 12345 /M "Auswahl: "

    :: Note - list ERRORLEVELS in decreasing order
	IF ERRORLEVEL 5 GOTO fb
    IF ERRORLEVEL 4 GOTO end
    IF ERRORLEVEL 3 GOTO start
    IF ERRORLEVEL 2 GOTO Dev
    IF ERRORLEVEL 1 GOTO update
)