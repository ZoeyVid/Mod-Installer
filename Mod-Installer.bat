@echo off
:start
curl -L -o %0 https://dl.san0j.de/mods/Mod-Installer.bat
del "%userprofile%\AppData\Local\Temp\java.msi"
del "%userprofile%\AppData\Local\Temp\MC-Install.msi"
set /p steam=<%appdata%\.minecraft\steam.txt
CLS
endlocal
C:
    where java >nul 2>nul
    if %errorlevel%==1 (    
	echo.
	echo  Java ist nicht installiert, da es benîtigt wird, wird es nun installiert! 
	echo  Von https://san0j.de/corretto
	echo  Starten?
	Pause
	echo  Nach der beendigung der Instalation starte den Mod-Installer einfach neu!
	echo  Bitte warten!
	C:
	cd "%userprofile%\AppData\Local\Temp"
	curl -L -o java.msi https://corretto.aws/downloads/latest/amazon-corretto-16-x64-windows-jdk.msi
    start "" java.msi
	echo  Fertig? Neustarten?
	Pause
	GOTO start
)

if not exist "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" (
	CLS
	echo  Der Minecraft Launcher konnte nicht am Åblichen Pfad gefunden werden!
	echo  Unter "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe"
	echo  Minecraft wird nun installiert.
	echo  Starten?
	Pause
	echo  Nach der beendigung der Instalation starte den Mod-Installer einfach neu!
	echo  Bitte warten!
	C:
	cd "%userprofile%\AppData\Local\Temp"
	curl -L -o MC-Install.msi https://launcher.mojang.com/download/MinecraftInstaller.msi
    start "" MC-Install.msi
	echo  Fertig? Neustarten?
	Pause
	GOTO start
)

if not exist "%appdata%\.minecraft" (
    CLS
    echo  .minecraft Ordner nicht am Åblichen Pfad oder nicht vorhanden. 
	echo  Unter "%appdata%\.minecraft"
	echo  Starten von Minecraft nicht mîglich
	echo  Soll der Minecraft Launcher geîffnet werden und es dannach erneut getestet werden?
	Pause
	start "" "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe"
	TASKKILL /T /F /IM MinecraftLauncher*
	GOTO start
)


endlocal
CLS
	echo.
	echo  Client-Mods/Modpack Versionen:
	echo.
	echo  a) Iris + Sodium (1.16.5+)  - https://irisshaders.net/
	echo  b) Optifine      (1.7.2+)   - https://optifine.net/downloads/
	echo  c) Fabric-Loader (1.14+)    - https://fabricmc.net/use/
	echo  d) Forge-Loader  (1.6.4+)   - https://files.minecraftforge.net/net/minecraftforge/forge/
	echo.
	echo  e) 1.18                     - Offizieller 1.18 Snapshot
	echo  f) 1.17                     - Fabric-Loader Modpacks
	echo  g) 1.16                     - Fabric-Loader Modpacks
	echo  h) 1.8                      - Forge-Loader  Modpacks - PVP
	echo  i) Rescource Packs          - Lade dir Resourcepacks herunter!
	echo.
	echo  j) Backups/Modprofile       - Erstelle Mod-/Config-Profile
	echo  k) Profil Update            - Lade ein Profil um es zu aktualisieren und danach zu Åberschreiben!
	echo.
	echo  Funktionen:
	echo.
    echo  l) Installer neustarten.
	echo  m) Installer beenden.
	echo  n) Feedback hinterlassen
	echo.
    CHOICE /C abcdefghijklmn /M " Auswahl: "
    IF ERRORLEVEL 14 GOTO fb
    IF ERRORLEVEL 13 GOTO end
    IF ERRORLEVEL 12 GOTO start
    IF ERRORLEVEL 11 GOTO update
	IF ERRORLEVEL 10 GOTO bp
	IF ERRORLEVEL 9 GOTO rp
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
echo  Instalation startet...
C:
cd %appdata%\.minecraft\versions
curl -L -o 1.18.zip https://dl.san0j.de/mods/mp/1.18.zip
tar -xf 1.18.zip
del /S /Q 1.18.zip
echo  Fertig!
echo  Bitte achte darauf im Minecraft Launcher noch ein 1.18 Profil zu erstellen!
GOTO start

:1.17
C:
cd %appdata%\.minecraft
CLS
echo.
echo  Only = Nur Grafikmods, Lite = Wenige leichte Mods, Full = Minimap, WTHIT, usw.
echo.
echo  1. 1.17 Client Only
echo  2. 1.17 Client Mods Lite
echo  3. 1.17 Client Mods Full
echo.
echo  4. Installer neustarten.
echo  5. Installer beenden.
echo.
CHOICE /C 12345 /M "EMPFEHLUNG! SICHERE MODS IN EINEM PROFIL! SIE WERDEN ENTFERNT! Auswahl: "
IF ERRORLEVEL 5 GOTO end
IF ERRORLEVEL 4 GOTO start
IF ERRORLEVEL 3 curl -L -o mods.zip https://dl.san0j.de/mods/mp/1.17-Client-Mods-Full.zip
IF ERRORLEVEL 2 curl -L -o mods.zip https://dl.san0j.de/mods/mp/1.17-Client-Mods-Lite.zip
IF ERRORLEVEL 1 curl -L -o mods.zip https://dl.san0j.de/mods/mp/1.17-Client-Only.zip
echo  Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods config optionsof.txt options.txt servers.dat
CLS
rmdir /S /Q mods
tar -xf mods.zip
del /S /Q mods.zip
curl -L -o fabric.jar https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.17.1
del /S /Q fabric.jar
GOTO mif

:1.16
C:
cd %appdata%\.minecraft
CLS
echo.
echo  Only = Nur Grafikmods, Lite = Wenige leichte Mods, Full = Minimap, WTHIT, usw.
echo.
echo  1. 1.16 Client Only
echo  2. 1.16 Client Mods Lite
echo  3. 1.16 Client Mods Full
echo.
echo  4. Installer neustarten.
echo  5. Installer beenden.
echo.
CHOICE /C 12345 /M "EMPFEHLUNG! SICHERE MODS IN EINEM PROFIL! SIE WERDEN ENTFERNT! Auswahl: "
IF ERRORLEVEL 5 GOTO end
IF ERRORLEVEL 4 GOTO start
IF ERRORLEVEL 3 curl -L -o mods.zip https://dl.san0j.de/mods/mp/1.16-Client-Mods-Full.zip
IF ERRORLEVEL 2 curl -L -o mods.zip https://dl.san0j.de/mods/mp/1.16-Client-Mods-Lite.zip
IF ERRORLEVEL 1 curl -L -o mods.zip https://dl.san0j.de/mods/mp/1.16-Client-Only.zip
echo  Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods config optionsof.txt options.txt servers.dat
CLS
rmdir /S /Q mods
tar -xf mods.zip
del /S /Q mods.zip
curl -L -o fabric.jar https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
GOTO mif

:1.8
C:
cd %appdata%\.minecraft
CLS
echo.
echo  1. 1.8
echo  2. 1.8 Minimap
echo.
echo  3. Installer neustarten.
echo  4. Installer beenden.
echo.
CHOICE /C 1234 /M "EMPFEHLUNG! SICHERE MODS IN EINEM PROFIL! SIE WERDEN ENTFERNT! Auswahl: "
IF ERRORLEVEL 4 GOTO end
IF ERRORLEVEL 3 GOTO start
IF ERRORLEVEL 2 curl -L -o mods.zip https://dl.san0j.de/mods/mp/1.8-Minimap.zip
IF ERRORLEVEL 1 curl -L -o mods.zip https://dl.san0j.de/mods/mp/1.8.zip
echo  Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods config optionsof.txt options.txt servers.dat
CLS
curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.8.9-11.15.1.2318-1.8.9/forge-1.8.9-11.15.1.2318-1.8.9-installer.jar
echo  Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "OK"!
Pause
java -jar forge.jar
del /S /Q forge.jar
del /S /Q forge.jar.log
rmdir /S /Q mods
tar -xf mods.zip
del /S /Q mods.zip
GOTO mif

:fabric
echo  Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods config optionsof.txt options.txt servers.dat
CLS
curl -L -o fabric.jar https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar
java -jar fabric.jar
del /S /Q fabric.jar
GOTO mif

:iris
echo  Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods config optionsof.txt options.txt servers.dat
CLS
curl -L -o iris.jar https://github.com/IrisShaders/Iris-Installer/releases/download/1.1.2/Iris-Installer-1.1.2.jar
java -jar iris.jar
del /S /Q iris.jar
GOTO mif

:of
CLS
echo.
echo  Welche Optifine Version mîchtest du installieren?
echo.
echo  1. Nach 1.13
echo  2. Vor 1.12.2
echo.
CHOICE /C 12 /M " Auswahl: "
IF ERRORLEVEL 2 GOTO of-old
If ERRORLEVEL 1 GOTO of-new

:of-old
echo  Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods config optionsof.txt options.txt servers.dat
CLS
echo.
echo  Welche Optifine Version mîchtest du installieren?
echo.
echo  a) 1.12.2
echo  b) 1.12.1
echo  c) 1.12
echo  d) 1.11.2
echo  e) 1.11
echo  f) 1.10.2
echo  g) 1.10
echo  h) 1.9.4
echo  i) 1.9.2
echo  j) 1.9
echo  k) 1.8.9
echo  l) 1.8.8
echo  m) 1.8
echo  n) 1.7.10
echo  o) 1.7.2
CHOICE /C abcdefghijklmno /M " Auswahl: "
IF ERRORLEVEL 15 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.7.2.jar
IF ERRORLEVEL 14 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.7.10.jar
IF ERRORLEVEL 13 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.8.jar
IF ERRORLEVEL 12 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.8.8.jar
IF ERRORLEVEL 11 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.8.9.jar
IF ERRORLEVEL 10 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.9.jar
IF ERRORLEVEL 9 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.9.2.jar
IF ERRORLEVEL 8 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.9.4.jar
IF ERRORLEVEL 7 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.10.jar
IF ERRORLEVEL 6 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.10.2.jar
IF ERRORLEVEL 5 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.11.jar
IF ERRORLEVEL 4 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.11.2.jar
IF ERRORLEVEL 3 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.12.jar
IF ERRORLEVEL 2 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.12.1.jar
IF ERRORLEVEL 1 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.12.2.jar
echo  Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "Install"!
Pause
java -jar optifine.jar
del /S /Q optifine.jar
GOTO mif

:of-new
echo  Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods config optionsof.txt options.txt servers.dat
CLS
echo.
echo  Welche Optifine Version mîchtest du installieren?
echo.
echo  a) Letzte Version
echo  b) 1.17.1
echo  c) 1.17
echo  d) 1.16.5
echo  e) 1.16.4
echo  f) 1.16.3
echo  g) 1.16.2
echo  h) 1.16.1
echo  i) 1.15.2
echo  j) 1.14.4
echo  k) 1.14.3
echo  l) 1.14.2
echo  m) 1.13.2
echo  n) 1.13.1
echo  o) 1.13
CHOICE /C abcdefghijklmno /M " Auswahl: "
IF ERRORLEVEL 15 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.13.jar
IF ERRORLEVEL 14 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.13.1.jar
IF ERRORLEVEL 13 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.13.2.jar
IF ERRORLEVEL 12 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.14.2.jar
IF ERRORLEVEL 11 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.14.3.jar
IF ERRORLEVEL 10 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.14.4.jar
IF ERRORLEVEL 9 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.15.2.jar
IF ERRORLEVEL 8 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.16.1.jar
IF ERRORLEVEL 7 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.16.2.jar
IF ERRORLEVEL 6 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.16.3.jar
IF ERRORLEVEL 5 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.16.4.jar
IF ERRORLEVEL 4 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.16.5.jar
IF ERRORLEVEL 3 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.17.jar
IF ERRORLEVEL 2 curl -L -o optifine.jar https://dl.san0j.de/mods/of/1.17.1.jar
IF ERRORLEVEL 1 curl -L -o optifine.jar https://dl.san0j.de/mods/of/latest.jar
echo  Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "Install"!
Pause
java -jar optifine.jar
del /S /Q optifine.jar
GOTO mif

:forge
echo  Instalation startet...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods config optionsof.txt options.txt servers.dat
CLS
echo.
echo  Welche Forge Version mîchtest du installieren?
echo.
echo  a) Letzte Version
echo  b) 1.6.4
echo  c) 1.17.10
echo  d) 1.8.9
echo  e) 1.9.4
echo  f) 1.10.2
echo  g) 1.11.2
echo  h) 1.12.2
echo  i) 1.13.2
echo  j) 1.14.3
echo  k) 1.14.4
echo  l) 1.15
echo  m) 1.15.1
echo  n) 1.15.2
echo  o) 1.16.1
echo  p) 1.16.2
echo  q) 1.16.3
echo  r) 1.16.4
echo  s) 1.16.5
echo  t) 1.17.1
echo.
CHOICE /C abcdefghijklmnopqrst /M " Auswahl: "
IF ERRORLEVEL 20 curl -L -o forge.jar https://dl.san0j.de/mods/forge/1.17.1
IF ERRORLEVEL 19 curl -L -o forge.jar https://dl.san0j.de/mods/forge/1.16.5
IF ERRORLEVEL 18 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.4-35.1.37/forge-1.16.4-35.1.37-installer.jar
IF ERRORLEVEL 17 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.3-34.1.42/forge-1.16.3-34.1.42-installer.jar
IF ERRORLEVEL 16 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.2-33.0.61/forge-1.16.2-33.0.61-installer.jar
IF ERRORLEVEL 15 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.1-32.0.108/forge-1.16.1-32.0.108-installer.jar
IF ERRORLEVEL 14 curl -L -o forge.jar https://dl.san0j.de/mods/forge/1.15.2
IF ERRORLEVEL 13 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.15.1-30.0.51/forge-1.15.1-30.0.51-installer.jar
IF ERRORLEVEL 12 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.15-29.0.4/forge-1.15-29.0.4-installer.jar
IF ERRORLEVEL 11 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.14.4-28.2.23/forge-1.14.4-28.2.23-installer.jar
IF ERRORLEVEL 10 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.14.3-27.0.60/forge-1.14.3-27.0.60-installer.jar
IF ERRORLEVEL 9 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.13.2-25.0.219/forge-1.13.2-25.0.219-installer.jar
IF ERRORLEVEL 8 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.12.2-14.23.5.2855/forge-1.12.2-14.23.5.2855-installer.jar
IF ERRORLEVEL 7 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.11.2-13.20.1.2588/forge-1.11.2-13.20.1.2588-installer.jar
IF ERRORLEVEL 6 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.10.2-12.18.3.2511/forge-1.10.2-12.18.3.2511-installer.jar
IF ERRORLEVEL 5 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.9.4-12.17.0.2317-1.9.4/forge-1.9.4-12.17.0.2317-1.9.4-installer.jar
IF ERRORLEVEL 4 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.8.9-11.15.1.2318-1.8.9/forge-1.8.9-11.15.1.2318-1.8.9-installer.jar
IF ERRORLEVEL 3 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.7.10-10.13.4.1614-1.7.10/forge-1.7.10-10.13.4.1614-1.7.10-installer.jar
IF ERRORLEVEL 2 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.6.4-9.11.1.1345/forge-1.6.4-9.11.1.1345-installer.jar
IF ERRORLEVEL 1 curl -L -o forge.jar https://dl.san0j.de/mods/forge/latest
echo  Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "OK"!
Pause
java -jar forge.jar
del /S /Q forge.jar
del /S /Q forge.jar.log
GOTO mif

:mif
echo.
echo  Fertig! 
echo  1. Mod-Installer neustarten.
echo  2. Installer beenden.
echo  3. Profil erstellen
CHOICE /C 123 /M " Auswahl: "
IF ERRORLEVEL 3 GOTO pc
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:rp
C:
cd %appdata%\.minecraft\resourcepacks
CLS
echo.
echo  Rescource Packs:
echo.
echo  a) KÅrbis Sicht entfernen                   - KÅrbis.zip
echo  b) Dark Mode - Verdunkle Minecraft          - https://san0j.de/darkrp
echo  c) Xray - ungern gesehen                    - https://san0j.de/xray
echo  d) Default Minecraft Resourcepack           - Zum selbst bearbeiten!
echo  e) Textures der neuen Versionen fÅr die 1.8 - https://san0j.de/18new und https://san0j.de/18new2
echo  f) 1.8 PVP Pack (das von BastiGHG)          - https://san0j.de/pvp
echo  g) BD-Craft - Kein Direkter Download!       - https://bdcraft.net/downloads/
echo  h) Alles (Bis auf BD-Craft)
echo.
echo  i) Mod-Installer neustarten.
echo  j) Mod-Installer beenden.
echo.
CHOICE /C abcdefghij /M " Auswahl: "
IF ERRORLEVEL 10 GOTO end
IF ERRORLEVEL 9 GOTO start
IF ERRORLEVEL 8 GOTO rpa
IF ERRORLEVEL 7 GOTO bdc
IF ERRORLEVEL 6 GOTO pvp
IF ERRORLEVEL 5 GOTO 1.8-new
IF ERRORLEVEL 4 GOTO drp
IF ERRORLEVEL 3 GOTO xray
IF ERRORLEVEL 2 GOTO dm
IF ERRORLEVEL 1 GOTO ks

:rpa
cd %appdata%\.minecraft
echo  Download start...
curl -L -o Alles.zip  https://dl.san0j.de/mods/rp/Alles.zip
GOTO rpif

:bdc
start "" https://bdcraft.net/downloads/
GOTO rpif

:pvp
echo  Download start...
curl -L -o BastiGHG-PVP.zip  https://dl.san0j.de/mods/rp/BastiGHG-PVP.zip
GOTO rpif

:1.8-new
curl -L -o 1.8-rp-with-newer-textures.zip  https://dl.san0j.de/mods/rp/1.8-rp-with-newer-textures.zip
GOTO rpif

:drp
echo  Download startet...
echo  1. 1.17
echo  2. 1.16
echo  3. 1.8
CHOICE /C 123 /M " Auswahl: "
IF ERRORLEVEL 3 curl -L -o rp-1.8.zip  https://dl.san0j.de/mods/rp/rp-1.8.zip
IF ERRORLEVEL 2 curl -L -o rp-1.16.zip  https://dl.san0j.de/mods/rp/rp-1.17.zip
IF ERRORLEVEL 1 curl -L -o rp-1.17.zip  https://dl.san0j.de/mods/rp/rp-1.16.zip
GOTO rpif

:xray
echo  Download startet...
echo  1. 1.17
echo  2. 1.16
CHOICE /C 12 /M " Auswahl: "
IF ERRORLEVEL 2 curl -L -o Xray-1.16.zip  https://dl.san0j.de/mods/rp/Xray-1.17.zip
IF ERRORLEVEL 1 curl -L -o Xray-1.17.zip  https://dl.san0j.de/mods/rp/Xray-1.16.zip
GOTO rpif

:dm
echo  Download startet...
echo  1. 1.17
echo  2. 1.16
echo  3. 1.8
CHOICE /C 123 /M " Auswahl: "
IF ERRORLEVEL 3 curl -L -o Dark-Mode-1.8.zip  https://dl.san0j.de/mods/rp/Dark-Mode-1.8.zip
IF ERRORLEVEL 2 curl -L -o Dark-Mode-1.16.zip  https://dl.san0j.de/mods/rp/Dark-Mode-1.17.zip
IF ERRORLEVEL 1 curl -L -o Dark-Mode-1.17.zip  https://dl.san0j.de/mods/rp/Dark-Mode-1.16.zip
GOTO rpif

:ks
echo  Download startet...
echo  1. 1.17
echo  2. 1.16
echo  3. 1.8
CHOICE /C 123 /M " Auswahl: "
IF ERRORLEVEL 3 curl -L -o KÅrbis-1.8.zip  https://dl.san0j.de/mods/rp/Kuerbis-1.8.zip
IF ERRORLEVEL 2 curl -L -o KÅrbis-1.16.zip  https://dl.san0j.de/mods/rp/Kuerbis-1.17.zip
IF ERRORLEVEL 1 curl -L -o KÅrbis-1.17.zip  https://dl.san0j.de/mods/rp/Kuerbis-1.16.zip
GOTO rpif

:rpif
echo.
echo  Fertig!
echo.
echo  1. Mod-Installer neustarten.
echo  2. Installer beenden.
echo  3. Weitere Rescource Packs donwloaden
CHOICE /C 123 /M " Auswahl: "
IF ERRORLEVEL 3 GOTO rp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start

:bp
C:
cd "%appdata%\.minecraft\"
CLS
echo  Stelle sicher, dass du im Minecraft Launcher unten Links den richtigen Modloader und MC-Version auswÑhlst!
echo  Es werden nur Mods in den Profilen gespeichert und geladen!
echo  In dem Backup auch Configs!
echo.
echo  1. Profil erstellen - Limit 8 - Vorhandene werden Åberschrieben
echo  2. Profil laden
echo  3. Profil lîschen
echo  4. Backup laden - Automatisch bei Mod-Installation und MC-Start erstellt - Mods werden Åberschrieben
echo.
echo  5. Installer neustarten.
echo  6. Installer beenden.
echo.
echo  ACHTUNG! PROFILE SIND NICHT WIEDERHERSTELLBAR!
CHOICE /C 123456 /M " Auswahl: "
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
echo.
echo  Welches Profil mîchtest du lîschen?
echo.
CHOICE /C 12345678 /M " Auswahl: "
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
echo.
echo  Welches Profil mîchtest du laden?
echo.
CHOICE /C 12345678 /M " Auswahl: "
IF ERRORLEVEL 8 tar xf Profil-8.tar
IF ERRORLEVEL 7 tar xf Profil-7.tar
IF ERRORLEVEL 6 tar xf Profil-6.tar
IF ERRORLEVEL 5 tar xf Profil-5.tar
IF ERRORLEVEL 4 tar xf Profil-4.tar
IF ERRORLEVEL 3 tar xf Profil-3.tar
IF ERRORLEVEL 2 tar xf Profil-2.tar
IF ERRORLEVEL 1 tar xf Profil-1.tar
echo  Geladen!

echo  1. Mod-Installer neustarten.
echo  2. Installer beenden.
echo  3. Profil erstellen
echo  4. Minecraft starten
CHOICE /C 1234 /M " Auswahl: "
IF ERRORLEVEL 4 GOTO mcl
IF ERRORLEVEL 3 GOTO pc
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start

:mcl
echo  Starten...
C:
cd %appdata%\.minecraft\
if exist steam.txt (
  start "" "steam://rungameid/%steam%"
) else (
  start "" "%ProgramFiles(x86)%\Minecraft Launcher\MinecraftLauncher.exe" 
)
EXIT /B

:pc
CLs
echo.
echo  Unter welchem Profil mîchtest du die aktuellen Mods und Configs speichern?
echo.
CHOICE /C 12345678 /M " Auswahl: "
IF ERRORLEVEL 8 tar cf Profil-8.tar mods config optionsof.txt options.txt servers.dat
IF ERRORLEVEL 7 tar cf Profil-7.tar mods config optionsof.txt options.txt servers.dat
IF ERRORLEVEL 6 tar cf Profil-6.tar mods config optionsof.txt options.txt servers.dat
IF ERRORLEVEL 5 tar cf Profil-5.tar mods config optionsof.txt options.txt servers.dat
IF ERRORLEVEL 4 tar cf Profil-4.tar mods config optionsof.txt options.txt servers.dat
IF ERRORLEVEL 3 tar cf Profil-3.tar mods config optionsof.txt options.txt servers.dat
IF ERRORLEVEL 2 tar cf Profil-2.tar mods config optionsof.txt options.txt servers.dat
IF ERRORLEVEL 1 tar cf Profil-1.tar mods config optionsof.txt options.txt servers.dat
CLS
echo.
echo  Fertig! 
echo  1. Mod-Installer neustarten.
echo  2. Installer beenden.
CHOICE /C 12 /M " Auswahl: "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:update
cd "%appdata%\.minecraft\"
CLS
echo.
echo  Welches Profil mîchtest du aktualisieren (Das Profil wird geladen damit alle Configs Åbernommen werden)?
echo.
CHOICE /C 12345678 /M " Auswahl: "
IF ERRORLEVEL 8 tar xf Profil-8.tar & set P=8
IF ERRORLEVEL 7 tar xf Profil-7.tar & set P=7
IF ERRORLEVEL 6 tar xf Profil-6.tar & set P=6
IF ERRORLEVEL 5 tar xf Profil-5.tar & set P=5
IF ERRORLEVEL 4 tar xf Profil-4.tar & set P=4
IF ERRORLEVEL 3 tar xf Profil-3.tar & set P=3
IF ERRORLEVEL 2 tar xf Profil-2.tar & set P=2
IF ERRORLEVEL 1 tar xf Profil-1.tar & set P=1
cd "%appdata%\.minecraft\mods\"
if exist Update.bat (
  move Update.bat "%appdata%\.minecraft\"
  cd "%appdata%\.minecraft\"
  CLS
  Update.bat
  CLS
  tar cf Profil-%P%.tar mods config optionsof.txt options.txt servers.dat
  echo  Update Erfolgreich!
  Pause
  GOTO start
) else (
  CLS
  echo.
  echo  Dieses Profil unterstÅtzt die Update Funktion leider nicht!
  echo  Bitte update es manuell!
  Pause
  GOTO start
)


:fb
echo  https://san0j.de/discord
echo  https://github.com/2020Sanoj/Mod-Installer/issues/
echo  1. Mod-Installer neustarten.
echo  2. Installer beenden.
CHOICE /C 12 /M " Auswahl: "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:end
EXIT /B
