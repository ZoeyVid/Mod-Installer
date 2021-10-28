@echo off
:start
curl -L -o %0 https://raw.githubusercontent.com/SanCraft-io/Mod-Installer/main/Mod-Installer.bat
FOR /F "usebackq" %%f IN (`PowerShell -NoProfile -Command "Write-Host([Environment]::GetFolderPath('Desktop'))"`) DO (
  SET "DESKTOP_FOLDER=%%f"
  )
del /S /Q "%appdata%\.minecraft\fabric.jar"
del /S /Q "%appdata%\.minecraft\1.17.bat"
del /S /Q "%appdata%\.minecraft\Update.bat"
set /p steam=<%appdata%\.minecraft\steam.txt
CLS
C:
    where java >nul 2>nul
    if %errorlevel%==1 (    
	echo.
	echo  Java is not installed, it will be installed now!
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
	TASKKILL /T /F /IM MinecraftLauncher*
	GOTO restart
)


endlocal
CLS
	echo.
	echo  Client-Mods/Modpack Versions:
	echo.
	echo  a) Iris + Sodium (1.16.5+)  - https://irisshaders.net/
	echo  b) Optifine      (1.7.2+)   - https://optifine.net/downloads/
	echo  c) Fabric-Loader (1.14+)    - https://fabricmc.net/use/
	echo  d) Forge-Loader  (1.6.4+)   - https://files.minecraftforge.net/net/minecraftforge/forge/
	echo.
	echo  e) 1.17                     - Fabric-Loader Modpacks
	echo  f) 1.8                      - Forge-Loader  Modpacks - PVP
	echo  g) Rescource Packs          - Download Resourcepacks!
	echo.
	echo  h) Backups/Modprofile       - Create Mod-/Config-Profils
	echo  i) Profil Update            - Load a profile to update it and then automatically save it again!
	echo.
	echo  Funktions:
	echo.
    echo  j) Restart Installer
	echo  k) End Installer
	echo  l) Give feedback
	echo.
    CHOICE /C abcdefghijklm /M " Selection: "
    IF ERRORLEVEL 12 GOTO fb
    IF ERRORLEVEL 11 GOTO end
    IF ERRORLEVEL 10 GOTO restart
    IF ERRORLEVEL 9 GOTO update
	IF ERRORLEVEL 8 GOTO bp
	IF ERRORLEVEL 7 GOTO rp
	IF ERRORLEVEL 6 GOTO 1.8
    IF ERRORLEVEL 5 GOTO 1.17
	IF ERRORLEVEL 4 GOTO forge
	IF ERRORLEVEL 3 GOTO fabric
	IF ERRORLEVEL 2 GOTO of
	IF ERRORLEVEL 1 GOTO iris

:1.17
C:
cd %appdata%\.minecraft
CLS
echo.
echo  Minigames = Only Grafikmods, Lite = light Mods, Full = Minimap, WTHIT...
echo  Only the Minigame Pack should be allowed on Servers like Hypixel
echo.
echo  1. 1.17 Client Mods Minigames
echo  2. 1.17 Client Mods Survival Lite
echo  3. 1.17 Client Mods Survival Full
echo.
echo  4. Restart Installer
echo  5. End Installer
echo.
CHOICE /C 12345 /M "RECOMMENDATION! SAFE MODS IN A PROFILE! THEY WILL BE REMOVED! Selection: "
IF ERRORLEVEL 5 GOTO end
IF ERRORLEVEL 4 GOTO restart
IF ERRORLEVEL 3 curl -L -o mods.zip https://dl.san0j.de/mp/1.17-Full.zip
IF ERRORLEVEL 2 curl -L -o mods.zip https://dl.san0j.de/mp/1.17-Lite.zip
IF ERRORLEVEL 1 curl -L -o mods.zip https://dl.san0j.de/mp/1.17-Only.zip
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods config optionsof.txt options.txt servers.dat .iasx .iasp .iasms_v2
CLS
rmdir /S /Q mods
tar -xf mods.zip
del /S /Q mods.zip
curl -L -o fabric.jar https://dl.san0j.de/fa
java -jar fabric.jar client -mcversion 1.17.1
del /S /Q fabric.jar
GOTO mif

:1.8
C:
cd %appdata%\.minecraft
CLS
echo.
echo  Only = Nur Grafikmods, Full = Minimap
echo  Both should be allowed on Servers like Hypixel
echo.
echo  1. 1.8 Only
echo  2. 1.8 Full
echo.
echo  3. Restart Installer
echo  4. End Installer
echo.
CHOICE /C 1234 /M "RECOMMENDATION! SAFE MODS IN A PROFILE! THEY WILL BE REMOVED! Selection: "
IF ERRORLEVEL 4 GOTO end
IF ERRORLEVEL 3 GOTO restart
IF ERRORLEVEL 2 curl -L -o mods.zip https://dl.san0j.de/mp/1.8-Full.zip
IF ERRORLEVEL 1 curl -L -o mods.zip https://dl.san0j.de/mp/1.8-Only.zip
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods config optionsof.txt options.txt servers.dat .iasx .iasp .iasms_v2
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
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods config optionsof.txt options.txt servers.dat .iasx .iasp .iasms_v2
CLS
curl -L -o fabric.jar https://dl.san0j.de/fa
java -jar fabric.jar
del /S /Q fabric.jar
GOTO mif

:iris
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods config optionsof.txt options.txt servers.dat .iasx .iasp .iasms_v2
CLS
curl -L -o iris.jar https://github.com/IrisShaders/Iris-Installer/releases/download/2.0.0/Iris-Installer-2.0.0.jar
java -jar iris.jar
del /S /Q iris.jar
GOTO mif

:of
CLS
echo.
echo  Which Optifine version do you want to install?
echo.
echo  1. Afte 1.13
echo  2. Bevor 1.12.2
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO of-old
If ERRORLEVEL 1 GOTO of-new

:of-old
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods config optionsof.txt options.txt servers.dat .iasx .iasp .iasms_v2
CLS
echo.
echo  Which Optifine version do you want to install?
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
CHOICE /C abcdefghijklmno /M " Selection: "
IF ERRORLEVEL 15 curl -L -o optifine.jar https://dl.san0j.de/of/1.7.2.jar
IF ERRORLEVEL 14 curl -L -o optifine.jar https://dl.san0j.de/of/1.7.10.jar
IF ERRORLEVEL 13 curl -L -o optifine.jar https://dl.san0j.de/of/1.8.jar
IF ERRORLEVEL 12 curl -L -o optifine.jar https://dl.san0j.de/of/1.8.8.jar
IF ERRORLEVEL 11 curl -L -o optifine.jar https://dl.san0j.de/of/1.8.9.jar
IF ERRORLEVEL 10 curl -L -o optifine.jar https://dl.san0j.de/of/1.9.jar
IF ERRORLEVEL 9 curl -L -o optifine.jar https://dl.san0j.de/of/1.9.2.jar
IF ERRORLEVEL 8 curl -L -o optifine.jar https://dl.san0j.de/of/1.9.4.jar
IF ERRORLEVEL 7 curl -L -o optifine.jar https://dl.san0j.de/of/1.10.jar
IF ERRORLEVEL 6 curl -L -o optifine.jar https://dl.san0j.de/of/1.10.2.jar
IF ERRORLEVEL 5 curl -L -o optifine.jar https://dl.san0j.de/of/1.11.jar
IF ERRORLEVEL 4 curl -L -o optifine.jar https://dl.san0j.de/of/1.11.2.jar
IF ERRORLEVEL 3 curl -L -o optifine.jar https://dl.san0j.de/of/1.12.jar
IF ERRORLEVEL 2 curl -L -o optifine.jar https://dl.san0j.de/of/1.12.1.jar
IF ERRORLEVEL 1 curl -L -o optifine.jar https://dl.san0j.de/of/1.12.2.jar
echo  In the next step, a window will open automatically, just click on "Install"!
Pause
java -jar optifine.jar
del /S /Q optifine.jar
GOTO mif

:of-new
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods config optionsof.txt options.txt servers.dat .iasx .iasp .iasms_v2
CLS
echo.
echo  Which Optifine version do you want to install?
echo.
echo  a) latest version
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
CHOICE /C abcdefghijklmno /M " Selection: "
IF ERRORLEVEL 15 curl -L -o optifine.jar https://dl.san0j.de/of/1.13.jar
IF ERRORLEVEL 14 curl -L -o optifine.jar https://dl.san0j.de/of/1.13.1.jar
IF ERRORLEVEL 13 curl -L -o optifine.jar https://dl.san0j.de/of/1.13.2.jar
IF ERRORLEVEL 12 curl -L -o optifine.jar https://dl.san0j.de/of/1.14.2.jar
IF ERRORLEVEL 11 curl -L -o optifine.jar https://dl.san0j.de/of/1.14.3.jar
IF ERRORLEVEL 10 curl -L -o optifine.jar https://dl.san0j.de/of/1.14.4.jar
IF ERRORLEVEL 9 curl -L -o optifine.jar https://dl.san0j.de/of/1.15.2.jar
IF ERRORLEVEL 8 curl -L -o optifine.jar https://dl.san0j.de/of/1.16.1.jar
IF ERRORLEVEL 7 curl -L -o optifine.jar https://dl.san0j.de/of/1.16.2.jar
IF ERRORLEVEL 6 curl -L -o optifine.jar https://dl.san0j.de/of/1.16.3.jar
IF ERRORLEVEL 5 curl -L -o optifine.jar https://dl.san0j.de/of/1.16.4.jar
IF ERRORLEVEL 4 curl -L -o optifine.jar https://dl.san0j.de/of/1.16.5.jar
IF ERRORLEVEL 3 curl -L -o optifine.jar https://dl.san0j.de/of/1.17.jar
IF ERRORLEVEL 2 curl -L -o optifine.jar https://dl.san0j.de/of/1.17.1.jar
IF ERRORLEVEL 1 curl -L -o optifine.jar https://dl.san0j.de/of/latest.jar
echo  In the next step, a window will open automatically, just click on "Install"!
Pause
java -jar optifine.jar
del /S /Q optifine.jar
GOTO mif

:forge
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods config optionsof.txt options.txt servers.dat .iasx .iasp .iasms_v2
CLS
echo.
echo  Which Forge version do you want to install?
echo.
echo  a) latest version
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
CHOICE /C abcdefghijklmnopqrst /M " Selection: "
IF ERRORLEVEL 20 curl -L -o forge.jar https://dl.san0j.de/fo/1.17.1
IF ERRORLEVEL 19 curl -L -o forge.jar https://dl.san0j.de/fo/1.16.5
IF ERRORLEVEL 18 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.4-35.1.37/forge-1.16.4-35.1.37-installer.jar
IF ERRORLEVEL 17 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.3-34.1.42/forge-1.16.3-34.1.42-installer.jar
IF ERRORLEVEL 16 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.2-33.0.61/forge-1.16.2-33.0.61-installer.jar
IF ERRORLEVEL 15 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.1-32.0.108/forge-1.16.1-32.0.108-installer.jar
IF ERRORLEVEL 14 curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.15.2-31.2.55/forge-1.15.2-31.2.55-installer.jar
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
IF ERRORLEVEL 1 curl -L -o forge.jar https://dl.san0j.de/fo/latest
echo  In the next step a window will open automatically, just click on "OK"!
Pause
java -jar forge.jar
del /S /Q forge.jar
del /S /Q forge.jar.log
GOTO mif

:mif
CLS
echo.
echo  Finisched!
echo  1. Restart Mod-Installer
echo  2. End Installer
echo  3. Create Profile
echo  4. Start Minecraft
CHOICE /C 1234 /M " Selection: "
IF ERRORLEVEL 4 GOTO mcl
IF ERRORLEVEL 3 GOTO pc
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO restart


:rp
C:
cd %appdata%\.minecraft\resourcepacks
CLS
echo.
echo  Rescource Packs:
echo.
echo  a) Remove pumpkin sight                     - KÅrbis.zip
echo  b) Dark Mode - make Minecraft darker!       - https://san0j.de/dark
echo  c) Xray - not welcome                       - https://san0j.de/xray
echo  d) Default Minecraft Resourcepack           - Zum selbst bearbeiten!
echo  e) Textures of the newer Versionen for 1.8  - https://san0j.de/18new und https://san0j.de/18new2
echo  f) 1.8 PVP Pack (from BastiGHG)             - https://san0j.de/pvp
echo  g) BD-Craft - NO direkt Download!           - https://bdcraft.net/downloads/
echo  h) All (Without BD-Craft)
echo.
echo  i) Restart Mod-Installer
echo  j) Mod-End Installer
echo.
CHOICE /C abcdefghij /M " Selection: "
IF ERRORLEVEL 10 GOTO end
IF ERRORLEVEL 9 GOTO restart
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
echo  Download starting...
curl -L -o Alles.zip https://dl.san0j.de/rp/Alles.zip
GOTO rpif

:bdc
start "" https://bdcraft.net/downloads/
GOTO rpif

:pvp
echo  Download starting...
curl -L -o BastiGHG-PVP.zip  https://dl.san0j.de/rp/BastiGHG-PVP.zip
GOTO rpif

:1.8-new
curl -L -o 1.8-rp-with-newer-textures.zip  https://dl.san0j.de/rp/1.8-rp-with-newer-textures.zip
GOTO rpif

:drp
echo  Download starting...
echo  1. 1.17
echo  2. 1.16
echo  3. 1.8
CHOICE /C 123 /M " Selection: "
IF ERRORLEVEL 3 curl -L -o rp-1.8.zip  https://dl.san0j.de/rp/rp-1.8.zip
IF ERRORLEVEL 2 curl -L -o rp-1.16.zip  https://dl.san0j.de/rp/rp-1.17.zip
IF ERRORLEVEL 1 curl -L -o rp-1.17.zip  https://dl.san0j.de/rp/rp-1.16.zip
GOTO rpif

:xray
echo  Download starting...
echo  1. 1.17
echo  2. 1.16
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 curl -L -o Xray-1.16.zip  https://media.forgecdn.net/files/3359/914/Xray_Ultimate_1.17_v4.1.2.zip
IF ERRORLEVEL 1 curl -L -o Xray-1.17.zip  https://media.forgecdn.net/files/3226/914/Xray_Ultimate_1.16_v4.1.0.zip
GOTO rpif

:dm
echo  Download starting...
echo  1. 1.17
echo  2. 1.16
echo  3. 1.8
CHOICE /C 123 /M " Selection: "
IF ERRORLEVEL 3 curl -L -o Dark-Mode-1.8.zip  https://github.com/xnebulr/Minecraft-Default-Dark-Mode/releases/download/v1.3.0/Default-Dark-Mode-1.8-v1.3.0.zip
IF ERRORLEVEL 2 curl -L -o Dark-Mode-1.16.zip  https://github.com/xnebulr/Minecraft-Default-Dark-Mode/releases/download/v1.3.0/Default-Dark-Mode-1.17-v1.3.0.zip
IF ERRORLEVEL 1 curl -L -o Dark-Mode-1.17.zip  https://github.com/xnebulr/Minecraft-Default-Dark-Mode/releases/download/v1.3.0/Default-Dark-Mode-1.16.2+-v1.3.0.zip
GOTO rpif

:ks
echo  Download starting...
echo  1. 1.17
echo  2. 1.16
echo  3. 1.8
CHOICE /C 123 /M " Selection: "
IF ERRORLEVEL 3 curl -L -o KÅrbis-1.8.zip  https://dl.san0j.de/rp/Kuerbis-1.8.zip
IF ERRORLEVEL 2 curl -L -o KÅrbis-1.16.zip  https://dl.san0j.de/rp/Kuerbis-1.17.zip
IF ERRORLEVEL 1 curl -L -o KÅrbis-1.17.zip  https://dl.san0j.de/rp/Kuerbis-1.16.zip
GOTO rpif

:rpif
echo.
echo  Finished!
echo.
echo  1. Restart Mod-Installer
echo  2. End Installer
echo  3. Download more Resourcepacks
CHOICE /C 123 /M " Selection: "
IF ERRORLEVEL 3 GOTO rp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO restart

:bp
C:
cd "%appdata%\.minecraft\"
CLS
echo  Make sure that you select the correct modloader and MC version in the Minecraft Launcher in the lower left!
echo  Only mods in the profiles are saved and loaded!
echo  In the backup also configs!
echo.
echo  1. Create profile - Limit 8 - Existing ones will be overwritten
echo  2. Load Profile
echo  3. Delete Profile
echo  4. Load backup - Automatically created during mod installation and MC start - Mods will be overwritten
echo.
echo  5. Restart Installer
echo  6. End Installer
echo.
echo  CAUTION! PROFILES ARE NOT RECOVERABLE!
CHOICE /C 123456 /M " Selection: "
IF ERRORLEVEL 6 GOTO end
IF ERRORLEVEL 5 GOTO restart
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
echo  Which profile do you want to delete?
echo.
CHOICE /C 12345678 /M " Selection: "
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
echo  Which profile do you want to load?
echo.
CHOICE /C 12345678 /M " Selection: "
IF ERRORLEVEL 8 tar xf Profil-8.tar
IF ERRORLEVEL 7 tar xf Profil-7.tar
IF ERRORLEVEL 6 tar xf Profil-6.tar
IF ERRORLEVEL 5 tar xf Profil-5.tar
IF ERRORLEVEL 4 tar xf Profil-4.tar
IF ERRORLEVEL 3 tar xf Profil-3.tar
IF ERRORLEVEL 2 tar xf Profil-2.tar
IF ERRORLEVEL 1 tar xf Profil-1.tar
echo  Loaded!

echo  1. Restart Mod-Installer
echo  2. End Installer
echo  3. Create Profile
echo  4. Start Minecraft
CHOICE /C 1234 /M " Selection: "
IF ERRORLEVEL 4 GOTO mcl
IF ERRORLEVEL 3 GOTO pc
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO restart

:mcl
echo  Starting...
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
echo  Under which profile do you want to save the current mods and configs?
echo.
CHOICE /C 12345678 /M " Selection: "
IF ERRORLEVEL 8 tar cf Profil-8.tar mods config optionsof.txt options.txt .iasx .iasp .iasms_v2
IF ERRORLEVEL 7 tar cf Profil-7.tar mods config optionsof.txt options.txt .iasx .iasp .iasms_v2
IF ERRORLEVEL 6 tar cf Profil-6.tar mods config optionsof.txt options.txt .iasx .iasp .iasms_v2
IF ERRORLEVEL 5 tar cf Profil-5.tar mods config optionsof.txt options.txt .iasx .iasp .iasms_v2
IF ERRORLEVEL 4 tar cf Profil-4.tar mods config optionsof.txt options.txt .iasx .iasp .iasms_v2
IF ERRORLEVEL 3 tar cf Profil-3.tar mods config optionsof.txt options.txt .iasx .iasp .iasms_v2
IF ERRORLEVEL 2 tar cf Profil-2.tar mods config optionsof.txt options.txt .iasx .iasp .iasms_v2
IF ERRORLEVEL 1 tar cf Profil-1.tar mods config optionsof.txt options.txt .iasx .iasp .iasms_v2
CLS
echo.
echo  Finished! 
echo  1. Restart Mod-Installer
echo  2. End Installer
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO restart


:update
cd "%appdata%\.minecraft\"
CLS
echo.
echo  Which profile do you want to update (the profile is loaded so that all configs are adopted)?
echo.
CHOICE /C 12345678 /M " Selection: "
IF ERRORLEVEL 8 tar cf Backup.tar mods config optionsof.txt options.txt servers.dat .iasx .iasp .iasms_v2 & rmdir /S /Q mods & tar xf Profil-8.tar & set P=8
IF ERRORLEVEL 7 tar cf Backup.tar mods config optionsof.txt options.txt servers.dat .iasx .iasp .iasms_v2 & rmdir /S /Q mods & tar xf Profil-7.tar & set P=7
IF ERRORLEVEL 6 tar cf Backup.tar mods config optionsof.txt options.txt servers.dat .iasx .iasp .iasms_v2 & rmdir /S /Q mods & tar xf Profil-6.tar & set P=6
IF ERRORLEVEL 5 tar cf Backup.tar mods config optionsof.txt options.txt servers.dat .iasx .iasp .iasms_v2 & rmdir /S /Q mods & tar xf Profil-5.tar & set P=5
IF ERRORLEVEL 4 tar cf Backup.tar mods config optionsof.txt options.txt servers.dat .iasx .iasp .iasms_v2 & rmdir /S /Q mods & tar xf Profil-4.tar & set P=4
IF ERRORLEVEL 3 tar cf Backup.tar mods config optionsof.txt options.txt servers.dat .iasx .iasp .iasms_v2 & rmdir /S /Q mods & tar xf Profil-3.tar & set P=3
IF ERRORLEVEL 2 tar cf Backup.tar mods config optionsof.txt options.txt servers.dat .iasx .iasp .iasms_v2 & rmdir /S /Q mods & tar xf Profil-2.tar & set P=2
IF ERRORLEVEL 1 tar cf Backup.tar mods config optionsof.txt options.txt servers.dat .iasx .iasp .iasms_v2 & rmdir /S /Q mods & tar xf Profil-1.tar & set P=1
cd "%appdata%\.minecraft\mods\"
if exist Update.bat (
  move Update.bat "%appdata%\.minecraft\"
  cd "%appdata%\.minecraft\"
  CLS
  Update.bat
  CLS
  tar cf Profil-%P%.tar mods config optionsof.txt options.txt .iasx .iasp .iasms_v2
  del /S /Q "%appdata%\.minecraft\fabric.jar"
  del /S /Q "%appdata%\.minecraft\1.17.bat"
  del /S /Q "%appdata%\.minecraft\Fabric-Install.bat"
  del /S /Q "%appdata%\.minecraft\Update.bat"
  CLS
  echo.
  echo  Update finished!
  echo  End Installer..
  Pause
GOTO end
) else (
  CLS
  echo.
  echo  Unfortunately, this profile does not support the update function!
  echo  Please update it manually!
echo.
echo  1. Restart Mod-Installer
echo  2. End Installer
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO restart
)

:fb
echo  https://sancraft.de/discord
echo  https://github.com/SanCraftDev/Mod-Installer/issues/
echo  1. Restart Mod-Installer
echo  2. End Installer
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO restart

:restart
start %ComSpec% /C %0
EXIT /B

:end
EXIT /B
