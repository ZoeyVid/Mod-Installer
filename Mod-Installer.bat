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
	ECHO Java ist nicht installiert, da es benîtigt wird, wird es nun installiert! 
	ECHO Von https://lksr.de/corretto
	echo Starten?
	Pause
	ECHO Nach der beendigung der Instalation starte den Mod-Installer einfach neu!
	ECHO Bitte warten!
	C:
	cd "%userprofile%\AppData\Local\Temp"
	curl -L --output java.msi --url https://corretto.aws/downloads/latest/amazon-corretto-16-x64-windows-jdk.msi
    start "" java.msi
	ECHO Fertig? Neustarten?
	Pause
	GOTO start
)

if not exist "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" (
	CLS
	echo Der Minecraft Launcher konnte nicht am öblichen Pfad gefunden werden!
	echo Unter "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe"
	echo Minecraft wird nun installiert.
	echo Starten?
	Pause
	ECHO Nach der beendigung der Instalation starte den Mod-Installer einfach neu!
	ECHO Bitte warten!
	C:
	cd "%userprofile%\AppData\Local\Temp"
	curl -L --output MC-Install.msi --url https://launcher.mojang.com/download/MinecraftInstaller.msi
    start "" MC-Install.msi
	ECHO Fertig? Neustarten?
	Pause
	GOTO start
)

if not exist "%appdata%\.minecraft" (
    CLS
    echo .minecraft Ordner nicht am Åblichen Pfad oder nicht vorhanden. 
	echo Unter "%appdata%\.minecraft"
	echo Starten von Minecraft nicht mîglich
	echo Soll der Minecraft Launcher geîffnet werden und es dannach erneut getestet werden?
	Pause
	start "" "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe"
	TASKKILL /T /F /IM MinecraftLauncher*
	GOTO start
)


endlocal
CLS
	ECHO.
	ECHO Client-Mods/Modpack Versionen:
	ECHO.
	ECHO a) Iris + Sodium (1.16.5+)  - https://irisshaders.net/
	ECHO b) Optifine      (1.7.2+)   - https://optifine.net/downloads/
	ECHO c) Fabric-Loader (1.14+)    - https://fabricmc.net/use/
	ECHO d) Forge-Loader  (1.6.4+)   - https://files.minecraftforge.net/net/minecraftforge/forge/
	ECHO.
	ECHO e) 1.18                     - Offiziell Snapshot
	ECHO f) 1.17.1                   - Fabric-Loader Modpacks
	ECHO g) 1.16.5                   - Fabric-Loader Modpacks
	ECHO h) 1.8.9                    - Forge-Loader  Modpack
	ECHO i) Profil Update            - Lade ein Profil um es zu aktualisieren und danach zu Åberschreiben!
	ECHO.
	ECHO j) Rescource Packs          - Lade dir Resourcepacks herunter!
	ECHO.
	ECHO k) Backups/Modprofile       - Erstelle Mod-/Config-Profile
	ECHO.
	ECHO Funktionen:
	ECHO.
    ECHO l) Installer neustarten.
	ECHO m) Installer beenden.
	ECHO n) Feedback hinterlassen
	ECHO.
    CHOICE /C abcdefghijklmn /M "Auswahl: "
    IF ERRORLEVEL 14 GOTO fb
    IF ERRORLEVEL 13 GOTO end
    IF ERRORLEVEL 12 GOTO start
    IF ERRORLEVEL 11 GOTO bp
	IF ERRORLEVEL 10 GOTO rp
	IF ERRORLEVEL 9 GOTO update
	IF ERRORLEVEL 8 GOTO 1.8
	IF ERRORLEVEL 7 GOTO 1.16
    IF ERRORLEVEL 6 GOTO 1.17
	IF ERRORLEVEL 5 GOTO 1.18
	IF ERRORLEVEL 4 GOTO forge
	IF ERRORLEVEL 3 GOTO fabric
	IF ERRORLEVEL 2 GOTO of
	IF ERRORLEVEL 1 GOTO iris


:1.18
CLS
echo Instalation startet...
C:
cd %appdata%\.minecraft\versions
curl -L --output 1.18.zip --url https://download.san0j.de/mods/mp/1.18.zip
tar -xf 1.18.zip
del /S /Q 1.18.zip
echo Fertig!
echo Bitte achte darauf im Minecraft Launcher noch ein 1.18 Profil zu erstellen!
GOTO mif

:1.17
C:
cd %appdata%\.minecraft
CLS
ECHO Only = Nur Grafikmods, Lite = Wenige leichte Mods, Full = Minimap, WTHIT, usw.
ECHO.
ECHO 1. 1.17 Client Only
ECHO 2. 1.17 Client Mods Lite
ECHO 3. 1.17 Client Mods Full
ECHO.
ECHO 4. Installer neustarten.
ECHO 5. Installer beenden.
ECHO.
CHOICE /C 12345 /M "EMPFEHLUNG! SICHERE MODS IN EINEM PROFIL! SIE WERDEN ENTFERNT! Auswahl: "
IF ERRORLEVEL 5 GOTO end
IF ERRORLEVEL 4 GOTO start
IF ERRORLEVEL 3 curl -L --output mods.zip --url https://download.san0j.de/mods/mp/1.17-Client-Mods-Full.zip
IF ERRORLEVEL 2 curl -L --output mods.zip --url https://download.san0j.de/mods/mp/1.17-Client-Mods-Lite.zip
IF ERRORLEVEL 1 curl -L --output mods.zip --url https://download.san0j.de/mods/mp/1.17-Client-Only.zip
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
rmdir /S /Q mods
tar -xf mods.zip
del /S /Q mods.zip
curl -L --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.17.1
del /S /Q fabric.jar
GOTO mif

:1.16
C:
cd %appdata%\.minecraft
CLS
ECHO Only = Nur Grafikmods, Lite = Wenige leichte Mods, Full = Minimap, WTHIT, usw.
ECHO.
ECHO 1. 1.16 Client Only
ECHO 2. 1.16 Client Mods Lite
ECHO 3. 1.16 Client Mods Full
ECHO.
ECHO 4. Installer neustarten.
ECHO 5. Installer beenden.
ECHO.
CHOICE /C 12345 /M "EMPFEHLUNG! SICHERE MODS IN EINEM PROFIL! SIE WERDEN ENTFERNT! Auswahl: "
IF ERRORLEVEL 5 GOTO end
IF ERRORLEVEL 4 GOTO start
IF ERRORLEVEL 3 curl -L --output mods.zip --url https://download.san0j.de/mods/mp/1.16-Client-Mods-Full.zip
IF ERRORLEVEL 2 curl -L --output mods.zip --url https://download.san0j.de/mods/mp/1.16-Client-Mods-Lite.zip
IF ERRORLEVEL 1 curl -L --output mods.zip --url https://download.san0j.de/mods/mp/1.16-Client-Only.zip
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
rmdir /S /Q mods
tar -xf mods.zip
del /S /Q mods.zip
curl -L --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
GOTO mif

:1.8
CLS
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.8.9-11.15.1.2318-1.8.9/forge-1.8.9-11.15.1.2318-1.8.9-installer.jar
echo Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "OK"!
Pause
java -jar forge.jar
del /S /Q forge.jar
del /S /Q forge.jar.log
rmdir /S /Q mods
curl -L --output mods.zip --url https://download.san0j.de/mods/mp/1.8.zip
tar -xf mods.zip
del /S /Q mods.zip
GOTO mif

:fabric
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar
del /S /Q fabric.jar
GOTO mif

:iris
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
curl -L --output iris.jar --url https://github.com/IrisShaders/Iris-Installer/releases/download/1.1.1/Iris-Installer-1.1.1.jar
java -jar iris.jar
del /S /Q iris.jar
GOTO mif

:of
CLS
ECHO.
ECHO Welche Optifine Version mîchtest du installieren?
ECHO.
ECHO 1. Nach 1.13
ECHO 2. Vor 1.12.2
ECHO.
CHOICE /C 12 /M "Auswahl: "
IF ERRORLEVEL 2 GOTO of-old
If ERRORLEVEL 1 GOTO of-new

:of-old
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config options.txt optionsof.txt config
CLS
ECHO.
ECHO Welche Optifine Version mîchtest du installieren?
ECHO.
ECHO a) 1.12.2
ECHO b) 1.12.1
ECHO c) 1.12
ECHO d) 1.11.2
ECHO e) 1.11
ECHO f) 1.10.2
ECHO g) 1.10
ECHO h) 1.9.4
ECHO i) 1.9.2
ECHO j) 1.9
ECHO k) 1.8.9
ECHO l) 1.8.8
ECHO m) 1.8
ECHO n) 1.7.10
ECHO o) 1.7.2
CHOICE /C abcdefghijklmno /M "Auswahl: "
IF ERRORLEVEL 15 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.7.2.jar
IF ERRORLEVEL 14 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.7.10.jar
IF ERRORLEVEL 13 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.8.jar
IF ERRORLEVEL 12 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.8.8.jar
IF ERRORLEVEL 11 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.8.9.jar
IF ERRORLEVEL 10 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.9.jar
IF ERRORLEVEL 9 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.9.2.jar
IF ERRORLEVEL 8 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.9.4.jar
IF ERRORLEVEL 7 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.10.jar
IF ERRORLEVEL 6 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.10.2.jar
IF ERRORLEVEL 5 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.11.jar
IF ERRORLEVEL 4 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.11.2.jar
IF ERRORLEVEL 3 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.12.jar
IF ERRORLEVEL 2 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.12.1.jar
IF ERRORLEVEL 1 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.12.2.jar
echo Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "Install"!
Pause
java -jar optifine.jar
del /S /Q optifine.jar
GOTO mif

:of-new
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config options.txt optionsof.txt config
CLS
ECHO.
ECHO Welche Optifine Version mîchtest du installieren?
ECHO.
ECHO a) Letzte Version
ECHO b) 1.17.1
ECHO c) 1.17
ECHO d) 1.16.5
ECHO e) 1.16.4
ECHO f) 1.16.3
ECHO g) 1.16.2
ECHO h) 1.16.1
ECHO i) 1.15.2
ECHO j) 1.14.4
ECHO k) 1.14.3
ECHO l) 1.14.2
ECHO m) 1.13.2
ECHO n) 1.13.1
ECHO o) 1.13
CHOICE /C abcdefghijklmno /M "Auswahl: "
IF ERRORLEVEL 15 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.13.jar
IF ERRORLEVEL 14 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.13.1.jar
IF ERRORLEVEL 13 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.13.2.jar
IF ERRORLEVEL 12 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.14.2.jar
IF ERRORLEVEL 11 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.14.3.jar
IF ERRORLEVEL 10 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.14.4.jar
IF ERRORLEVEL 9 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.15.2.jar
IF ERRORLEVEL 8 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.16.1.jar
IF ERRORLEVEL 7 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.16.2.jar
IF ERRORLEVEL 6 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.16.3.jar
IF ERRORLEVEL 5 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.16.4.jar
IF ERRORLEVEL 4 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.16.5.jar
IF ERRORLEVEL 3 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.17.jar
IF ERRORLEVEL 2 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/1.17.1.jar
IF ERRORLEVEL 1 curl -L --output optifine.jar --url https://download.san0j.de/mods/of/latest.jar
echo Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "Install"!
Pause
java -jar optifine.jar
del /S /Q optifine.jar
GOTO mif

:forge
echo Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods options.txt optionsof.txt config
CLS
ECHO.
ECHO Welche Forge Version mîchtest du installieren?
ECHO.
ECHO a) Letzte Version
ECHO b) 1.6.4
ECHO c) 1.17.10
ECHO d) 1.8.9
ECHO e) 1.9.4
ECHO f) 1.10.2
ECHO g) 1.11.2
ECHO h) 1.12.2
ECHO i) 1.13.2
ECHO j) 1.14.3
ECHO k) 1.14.4
ECHO l) 1.15
ECHO m) 1.15.1
ECHO n) 1.15.2
ECHO o) 1.16.1
ECHO p) 1.16.2
ECHO q) 1.16.3
ECHO r) 1.16.4
ECHO s) 1.16.5
ECHO.
CHOICE /C abcdefghijklmnopqrs /M "Auswahl: "
IF ERRORLEVEL 19 curl -L --output forge.jar --url https://download.san0j.de/mods/forge/1.16.5
IF ERRORLEVEL 18 curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.4-35.1.37/forge-1.16.4-35.1.37-installer.jar
IF ERRORLEVEL 17 curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.3-34.1.42/forge-1.16.3-34.1.42-installer.jar
IF ERRORLEVEL 16 curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.2-33.0.61/forge-1.16.2-33.0.61-installer.jar
IF ERRORLEVEL 15 curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.1-32.0.108/forge-1.16.1-32.0.108-installer.jar
IF ERRORLEVEL 14 curl -L --output forge.jar --url https://download.san0j.de/mods/forge/1.15.2
IF ERRORLEVEL 13 curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.15.1-30.0.51/forge-1.15.1-30.0.51-installer.jar
IF ERRORLEVEL 12 curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.15-29.0.4/forge-1.15-29.0.4-installer.jar
IF ERRORLEVEL 11 curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.14.4-28.2.23/forge-1.14.4-28.2.23-installer.jar
IF ERRORLEVEL 10 curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.14.3-27.0.60/forge-1.14.3-27.0.60-installer.jar
IF ERRORLEVEL 9 curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.13.2-25.0.219/forge-1.13.2-25.0.219-installer.jar
IF ERRORLEVEL 8 curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.12.2-14.23.5.2855/forge-1.12.2-14.23.5.2855-installer.jar
IF ERRORLEVEL 7 curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.11.2-13.20.1.2588/forge-1.11.2-13.20.1.2588-installer.jar
IF ERRORLEVEL 6 curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.10.2-12.18.3.2511/forge-1.10.2-12.18.3.2511-installer.jar
IF ERRORLEVEL 5 curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.9.4-12.17.0.2317-1.9.4/forge-1.9.4-12.17.0.2317-1.9.4-installer.jar
IF ERRORLEVEL 4 curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.8.9-11.15.1.2318-1.8.9/forge-1.8.9-11.15.1.2318-1.8.9-installer.jar
IF ERRORLEVEL 3 curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.7.10-10.13.4.1614-1.7.10/forge-1.7.10-10.13.4.1614-1.7.10-installer.jar
IF ERRORLEVEL 2 curl -L --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.6.4-9.11.1.1345/forge-1.6.4-9.11.1.1345-installer.jar
IF ERRORLEVEL 1 curl -L --output forge.jar --url https://download.san0j.de/mods/forge/latest
echo Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "OK"!
Pause
java -jar forge.jar
del /S /Q forge.jar
del /S /Q forge.jar.log
GOTO mif

:mif
echo.
echo Fertig! 
ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Profil erstellen
CHOICE /C 123 /M "Auswahl: "
IF ERRORLEVEL 3 GOTO pc
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:rp
C:
cd %appdata%\.minecraft\resourcepacks
CLS
ECHO.
ECHO Texture Packs:
ECHO.
ECHO 1. KÅrbis Sicht entfernen                   - KÅrbis.zip
ECHO 2. Dark Mode - Verdunkle Minecraft          - https://lksr.de/darkrp
ECHO 3. Xray - ungern gesehen                    - https://lksr.de/xray
ECHO 4. Default Minecraft Resourcepack           - Zum selbst bearbeiten!
ECHO 5. Textures der neuen Versionen fÅr die 1.8 - https://lksr.de/18new
ECHO 6. 1.8 PVP Pack (das von BastiGHG)          - https://lksr.de/pvp
ECHO 7. Alles
ECHO.
ECHO 8. Mod-Installer neustarten.
ECHO 9. Mod-Installer beenden.
ECHO.
CHOICE /C 123456789 /M "Auswahl: "
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
curl -L --output Alles.zip --url  https://download.san0j.de/mods/rp/Alles.zip
GOTO rpif

:pvp
echo Download start...
curl -L --output BastiGHG-PVP.zip --url  https://download.san0j.de/mods/rp/BastiGHG-PVP.zip
GOTO rpif

:1.8-new
curl -L --output 1.8-rp-with-newer-textures.zip --url  https://download.san0j.de/mods/rp/1.8-rp-with-newer-textures.zip
GOTO rpif

:drp
echo Download startet...
ECHO 1. 1.17
ECHO 2. 1.16
ECHO 3. 1.8
CHOICE /C 123 /M "Auswahl: "
IF ERRORLEVEL 3 curl -L --output rp-1.8.zip --url  https://download.san0j.de/mods/rp/rp-1.8.zip
IF ERRORLEVEL 2 curl -L --output rp-1.16.zip --url  https://download.san0j.de/mods/rp/rp-1.17.zip
IF ERRORLEVEL 1 curl -L --output rp-1.17.zip --url  https://download.san0j.de/mods/rp/rp-1.16.zip
GOTO rpif

:xray
echo Download startet...
ECHO 1. 1.17
ECHO 2. 1.16
CHOICE /C 12 /M "Auswahl: "
IF ERRORLEVEL 2 curl -L --output Xray-1.16.zip --url  https://download.san0j.de/mods/rp/Xray-1.17.zip
IF ERRORLEVEL 1 curl -L --output Xray-1.17.zip --url  https://download.san0j.de/mods/rp/Xray-1.16.zip
GOTO rpif

:dm
echo Download startet...
ECHO 1. 1.17
ECHO 2. 1.16
ECHO 3. 1.8
CHOICE /C 123 /M "Auswahl: "
IF ERRORLEVEL 3 curl -L --output Dark-Mode-1.8.zip --url  https://download.san0j.de/mods/rp/Dark-Mode-1.8.zip
IF ERRORLEVEL 2 curl -L --output Dark-Mode-1.16.zip --url  https://download.san0j.de/mods/rp/Dark-Mode-1.17.zip
IF ERRORLEVEL 1 curl -L --output Dark-Mode-1.17.zip --url  https://download.san0j.de/mods/rp/Dark-Mode-1.16.zip
GOTO rpif

:ks
echo Download startet...
ECHO 1. 1.17
ECHO 2. 1.16
ECHO 3. 1.8
CHOICE /C 123 /M "Auswahl: "
IF ERRORLEVEL 3 curl -L --output KÅrbis-1.8.zip --url  https://download.san0j.de/mods/rp/Kuerbis-1.8.zip
IF ERRORLEVEL 2 curl -L --output KÅrbis-1.16.zip --url  https://download.san0j.de/mods/rp/Kuerbis-1.17.zip
IF ERRORLEVEL 1 curl -L --output KÅrbis-1.17.zip --url  https://download.san0j.de/mods/rp/Kuerbis-1.16.zip
GOTO rpif

:rpif
echo.
echo Fertig!
echo.
ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
ECHO 3. Weitere Rescource Packs donwloaden
CHOICE /C 123 /M "Auswahl: "
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
IF ERRORLEVEL 6 GOTO end
IF ERRORLEVEL 5 GOTO start
IF ERRORLEVEL 4 GOTO bl
IF ERRORLEVEL 3 GOTO pr
IF ERRORLEVEL 2 GOTO pl
IF ERRORLEVEL 1 GOTO pc

:bl
rmdir /S /Q mods
tar xf Backup.tar
GOTO pbf

:pr
CLs
ECHO.
ECHO Welches Profil mîchtest du lîschen?
ECHO.
CHOICE /C 12345678 /M "Auswahl: "
IF ERRORLEVEL 8 del /S /Q Profil-8.tar
IF ERRORLEVEL 7 del /S /Q Profil-7.tar
IF ERRORLEVEL 6 del /S /Q Profil-6.tar
IF ERRORLEVEL 5 del /S /Q Profil-5.tar
IF ERRORLEVEL 4 del /S /Q Profil-4.tar
IF ERRORLEVEL 3 del /S /Q Profil-3.tar
IF ERRORLEVEL 2 del /S /Q Profil-2.tar
IF ERRORLEVEL 1 del /S /Q Profil-1.tar
GOTO pbf

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
ECHO 3. Profil erstellen
ECHO 4. Minecraft starten
CHOICE /C 1234 /M "Auswahl: "
IF ERRORLEVEL 4 GOTO mcl
IF ERRORLEVEL 3 GOTO pc
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
IF ERRORLEVEL 3 GOTO pcc
IF ERRORLEVEL 2 GOTO pcmc
IF ERRORLEVEL 1 GOTO pcm

:pcc
CLs
ECHO.
ECHO Unter welchem Profil mîchtest du die aktuellen Configs speichern?
ECHO.
CHOICE /C 12345678 /M "Auswahl: "
IF ERRORLEVEL 8 tar cf Profil-8.tar config optionsof.txt options.txt
IF ERRORLEVEL 7 tar cf Profil-7.tar config optionsof.txt options.txt
IF ERRORLEVEL 6 tar cf Profil-6.tar config optionsof.txt options.txt
IF ERRORLEVEL 5 tar cf Profil-5.tar config optionsof.txt options.txt
IF ERRORLEVEL 4 tar cf Profil-4.tar config optionsof.txt options.txt
IF ERRORLEVEL 3 tar cf Profil-3.tar config optionsof.txt options.txt
IF ERRORLEVEL 2 tar cf Profil-2.tar config optionsof.txt options.txt
IF ERRORLEVEL 1 tar cf Profil-1.tar config optionsof.txt options.txt
GOTO pbf

:pcmc
CLs
ECHO.
ECHO Unter welchem Profil mîchtest du die aktuellen Mods und Configs speichern?
ECHO.
CHOICE /C 12345678 /M "Auswahl: "
IF ERRORLEVEL 8 tar cf Profil-8.tar mods config optionsof.txt options.txt
IF ERRORLEVEL 7 tar cf Profil-7.tar mods config optionsof.txt options.txt
IF ERRORLEVEL 6 tar cf Profil-6.tar mods config optionsof.txt options.txt
IF ERRORLEVEL 5 tar cf Profil-5.tar mods config optionsof.txt options.txt
IF ERRORLEVEL 4 tar cf Profil-4.tar mods config optionsof.txt options.txt
IF ERRORLEVEL 3 tar cf Profil-3.tar mods config optionsof.txt options.txt
IF ERRORLEVEL 2 tar cf Profil-2.tar mods config optionsof.txt options.txt
IF ERRORLEVEL 1 tar cf Profil-1.tar mods config optionsof.txt options.txt
GOTO pbf

:pcm
CLs
ECHO.
ECHO Unter welchem Profil mîchtest du die aktuellen Mods speichern?
ECHO.
CHOICE /C 12345678 /M "Auswahl: "
IF ERRORLEVEL 8 tar cf Profil-8.tar mods
IF ERRORLEVEL 7 tar cf Profil-7.tar mods
IF ERRORLEVEL 6 tar cf Profil-6.tar mods
IF ERRORLEVEL 5 tar cf Profil-5.tar mods
IF ERRORLEVEL 4 tar cf Profil-4.tar mods
IF ERRORLEVEL 3 tar cf Profil-3.tar mods
IF ERRORLEVEL 2 tar cf Profil-2.tar mods
IF ERRORLEVEL 1 tar cf Profil-1.tar mods
GOTO pbf

:pbf
echo.
echo Fertig! 
ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:update
CLS
ECHO.
ECHO Welches Profil mîchtest du aktualisieren (Das Profil wird geladen damit alle Config Åbernommen werden)?
ECHO Nach der Auswahl musst du das Modpack herunterladen und erneut in einem Profil abspeichern!
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
GOTO start


:fb
ECHO https://san0j.de/discord
ECHO https://github.com/2020Sanoj/Mod-Installer/issues/
ECHO 1. Mod-Installer neustarten.
ECHO 2. Installer beenden.
CHOICE /C 12 /M "Auswahl: "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:end
EXIT /B