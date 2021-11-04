@echo off
:start
curl -L -o %0 https://raw.githubusercontent.com/SanCraftDev/Mod-Installer/main/Mod-InstallerMS.bat

if not exist "%appdata%\.minecraft\Mod-Installer" (
CLS
echo.
echo You need to reinstall the Mod-Installer!
echo.
Pause
start "" "%appdata%\.minecraft\Installer-Uninstaller.bat"
GOTO end
)

FOR /F "usebackq" %%f IN (`PowerShell -NoProfile -Command "Write-Host([Environment]::GetFolderPath('Desktop'))"`) DO (
  SET "DESKTOP_FOLDER=%%f"
  )
del /S /Q "%appdata%\.minecraft\fabric.jar"
del /S /Q "%appdata%\.minecraft\1.17.bat"
del /S /Q "%appdata%\.minecraft\Update.bat"
set /p steam=<%appdata%\.minecraft\Mod-Installer\steam.txt
set l=1.17.1
set vl=1.17.1
set fal=fabric-loader-0.11.7-1.17.1
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
    TASKKILL /T /F /IM MinecraftLauncher.exe
    TASKKILL /T /F /IM Minecraft.exe
	GOTO restart
)

CLS
	echo.
	echo  Client-Mods/Modpack Versions:
	echo.
	echo  a) Iris + Sodium (1.16.5+)  - https://irisshaders.net/
	echo  b) Optifine      (1.7.2+)   - https://optifine.net/downloads/ - NO direct Download!
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
	echo  j) .minecraft Cleaner       - Clear your .minecraft folder up!
	echo  k) Migrate Launcher         - Migrate to the OLD MC Launcher
    echo  l) Restart Installer
	echo  m) End Installer
	echo  n) Give feedback
	echo.
    CHOICE /C abcdefghijklmn /M " Selection: "
    IF ERRORLEVEL 14 GOTO fb
    IF ERRORLEVEL 13 GOTO end
    IF ERRORLEVEL 12 GOTO restart
	IF ERRORLEVEL 11 GOTO mi
	IF ERRORLEVEL 10 GOTO c
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
IF ERRORLEVEL 3 curl -L -o mods.zip https://dl.sancraft.dev/mp/1.17-Full.zip
IF ERRORLEVEL 2 curl -L -o mods.zip https://dl.sancraft.dev/mp/1.17-Lite.zip
IF ERRORLEVEL 1 curl -L -o mods.zip https://dl.sancraft.dev/mp/1.17-Only.zip
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat
CLS
rmdir /S /Q mods
tar -xf mods.zip
del /S /Q mods.zip
curl -L -o fabric.jar https://dl.sancraft.dev/fa
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
IF ERRORLEVEL 2 curl -L -o mods.zip https://dl.sancraft.dev/mp/1.8-Full.zip
IF ERRORLEVEL 1 curl -L -o mods.zip https://dl.sancraft.dev/mp/1.8-Only.zip
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat
CLS
curl -L -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.8.9-11.15.1.2318-1.8.9/forge-1.8.9-11.15.1.2318-1.8.9-installer.jar
echo  In the next step a window will open automatically, just click on "OK"!
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
tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat
CLS
curl -L -o fabric.jar https://dl.sancraft.dev/fa
java -jar fabric.jar
del /S /Q fabric.jar
GOTO mif

:iris
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat
CLS
curl -L -o iris.jar https://github.com/IrisShaders/Iris-Installer/releases/download/2.0.0/Iris-Installer-2.0.0.jar
java -jar iris.jar
del /S /Q iris.jar
GOTO mif

:of
start "" https://optifine.net/downloads
GOTO mif

:forge
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat
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
IF ERRORLEVEL 20 curl -L -o forge.jar https://dl.sancraft.dev/fo/1.17.1
IF ERRORLEVEL 19 curl -L -o forge.jar https://dl.sancraft.dev/fo/1.16.5
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
IF ERRORLEVEL 1 curl -L -o forge.jar https://dl.sancraft.dev/fo/latest
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
echo  a) Remove pumpkin sight                               - Pumpkin.zip
echo  b) Dark Mode - make Minecraft darker!                 - https://sancraft.dev/dark
echo  c) Xray - often not welcome                           - https://sancraft.dev/xray
echo  d) Textures of the newer Versions for 1.8             - https://sancraft.dev/18new and https://sancraft.dev/18new2 - combined
echo  e) 1.8 PVP Pack (from BastiGHG) - NO direct Download! - https://resourcepacks24.de/resourcepack/53862
echo  f) BD-Craft - NO direct Download!                     - https://bdcraft.net/downloads/
echo.
echo  g) Restart Mod-Installer
echo  h) Mod-End Installer
echo.
CHOICE /C abcdefgh /M " Selection: "
IF ERRORLEVEL 8 GOTO end
IF ERRORLEVEL 7 GOTO restart
IF ERRORLEVEL 6 GOTO bdc
IF ERRORLEVEL 5 GOTO pvp
IF ERRORLEVEL 4 GOTO 1.8-new
IF ERRORLEVEL 3 GOTO xray
IF ERRORLEVEL 2 GOTO dm
IF ERRORLEVEL 1 GOTO ps

:ps
echo  Download starting...
echo  1. 1.17
echo  2. 1.16
echo  3. 1.8
CHOICE /C 123 /M " Selection: "
IF ERRORLEVEL 3 curl -L -o pumpkin-1.8.zip  https://dl.sancraft.dev/mp/pumpkin-1.8.zip
IF ERRORLEVEL 2 curl -L -o pumpkin-1.16.zip  https://dl.sancraft.dev/mp/pumpkin-1.17.zip
IF ERRORLEVEL 1 curl -L -o pumpkin-1.17.zip  https://dl.sancraft.dev/mp/pumpkin-1.16.zip
GOTO rpif

:dm
echo  Download starting...
echo  1. 1.17
echo  2. 1.16
echo  3. 1.8
CHOICE /C 123 /M " Selection: "
IF ERRORLEVEL 3 curl -L -o Dark-Mode-1.8.zip  https://github.com/xnebulr/Minecraft-Default-Dark-Mode/releases/latest/download/Default-Dark-Mode-1.8-v1.3.0.zip
IF ERRORLEVEL 2 curl -L -o Dark-Mode-1.16.zip  https://github.com/xnebulr/Minecraft-Default-Dark-Mode/releases/latest/download/Default-Dark-Mode-1.17-v1.3.0.zip
IF ERRORLEVEL 1 curl -L -o Dark-Mode-1.17.zip  https://github.com/xnebulr/Minecraft-Default-Dark-Mode/releases/latest/download/Default-Dark-Mode-1.16.2+-v1.3.0.zip
GOTO rpif

:xray
echo  Download starting...
echo  1. 1.17
echo  2. 1.16
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 curl -L -o Xray-1.16.zip  https://media.forgecdn.net/files/3359/914/Xray_Ultimate_1.17_v4.1.2.zip
IF ERRORLEVEL 1 curl -L -o Xray-1.17.zip  https://media.forgecdn.net/files/3226/914/Xray_Ultimate_1.16_v4.1.0.zip
GOTO rpif

:1.8-new
curl -L -o 1.8-rp.zip  https://dl.sancraft.dev/mp/1.8-rp.zip
GOTO rpif

:pvp
start "" https://resourcepacks24.de/download/53862
echo  Download starting...
GOTO rpif

:bdc
start "" https://bdcraft.net/downloads/
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
cd %appdata%\.minecraft\Mod-Installer\
if exist steam.txt (
  start "" "steam://rungameid/%steam%"
) else (
  start "" shell:AppsFolder\Microsoft.4297127D64EC6_8wekyb3d8bbwe!Minecraft 
)
EXIT /B

:pc
CLs
echo.
echo  Under which profile do you want to save the current mods and configs?
echo.
CHOICE /C 12345678 /M " Selection: "
IF ERRORLEVEL 8 tar cf Profil-8.tar mods config optionsof.txt options.txt options.amecsapi.txt
IF ERRORLEVEL 7 tar cf Profil-7.tar mods config optionsof.txt options.txt options.amecsapi.txt
IF ERRORLEVEL 6 tar cf Profil-6.tar mods config optionsof.txt options.txt options.amecsapi.txt
IF ERRORLEVEL 5 tar cf Profil-5.tar mods config optionsof.txt options.txt options.amecsapi.txt
IF ERRORLEVEL 4 tar cf Profil-4.tar mods config optionsof.txt options.txt options.amecsapi.txt
IF ERRORLEVEL 3 tar cf Profil-3.tar mods config optionsof.txt options.txt options.amecsapi.txt
IF ERRORLEVEL 2 tar cf Profil-2.tar mods config optionsof.txt options.txt options.amecsapi.txt
IF ERRORLEVEL 1 tar cf Profil-1.tar mods config optionsof.txt options.txt options.amecsapi.txt
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
IF ERRORLEVEL 8 tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & tar xf Profil-8.tar & set P=8
IF ERRORLEVEL 7 tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & tar xf Profil-7.tar & set P=7
IF ERRORLEVEL 6 tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & tar xf Profil-6.tar & set P=6
IF ERRORLEVEL 5 tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & tar xf Profil-5.tar & set P=5
IF ERRORLEVEL 4 tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & tar xf Profil-4.tar & set P=4
IF ERRORLEVEL 3 tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & tar xf Profil-3.tar & set P=3
IF ERRORLEVEL 2 tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & tar xf Profil-2.tar & set P=2
IF ERRORLEVEL 1 tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat & rmdir /S /Q mods & tar xf Profil-1.tar & set P=1
cd "%appdata%\.minecraft\mods\"
if exist Update.bat (
  move Update.bat "%appdata%\.minecraft\"
  cd "%appdata%\.minecraft\"
  CLS
  Update.bat
  CLS
  tar cf Profil-%P%.tar mods config optionsof.txt options.txt options.amecsapi.txt
  del /S /Q "%appdata%\.minecraft\fabric.jar"
  del /S /Q "%appdata%\.minecraft\1.17.bat"
  del /S /Q "%appdata%\.minecraft\Fabric-Install.bat"
  del /S /Q "%appdata%\.minecraft\Update.bat"
  CLS
  echo.
  echo  Update finished! - Profil %P%
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

:c
CLS
echo.
echo  Do you really want to remove not needed Files and Folders of your .minecraft Folder?
echo  Your Minecraft Launcher will be closed!
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO cy
IF ERRORLEVEL 1 GOTO end

:cy
cd "%appdata%\.minecraft"
tar cf Backup.tar mods config optionsof.txt options.txt options.amecsapi.txt servers.dat
TASKKILL /T /F /IM MinecraftLauncher.exe
TASKKILL /T /F /IM Minecraft.exe
rmdir /S /Q "%appdata%\.iris-installer"
rmdir /S /Q .icons
rmdir /S /Q .mixin.out
rmdir /S /Q .replay_cache
rmdir /S /Q ViaForge
:rmdir /S /Q assets
rmdir /S /Q bettergamemenu
rmdir /S /Q craftpresence
rmdir /S /Q crash-reports
rmdir /S /Q defaultconfigs
rmdir /S /Q logs
rmdir /S /Q ModTranslations
rmdir /S /Q not-enough-crashes
rmdir /S /Q server-resource-packs
rmdir /S /Q bin
rmdir /S /Q cachedImages
:rmdir /S /Q libraries
rmdir /S /Q webcache2
rmdir /S /Q debug
rmdir /S /Q libraries 
rmdir /S /Q stats
rmdir /S /Q texturepacks-mp-cache
rmdir /S /Q webcache
del /S /Q versions\version_manifest_v2*
del /S /Q versions\cache.dat
del /S /Q betterfps.txt
del /S /Q clientId.txt
del /S /Q deaths.dat
del /S /Q servers.dat_old
del /S /Q textures_*.png
del /S /Q updateLog.txt
del /S /Q usercache*
del /S /Q usernamecache*
del /S /Q launcher_log.txt
del /S /Q level.dat
del /S /Q realms_persistence*
del /S /Q launcher_cef_log.txt
del /S /Q output-server.log
del /S /Q output-client.log
del /S /Q debug.stitched_items.png
del /S /Q debug.stitched_terrain.png
del /S /Q hotbar.nbt
del /S /Q lastlogin
del /S /Q resourcepacks*
del /S /Q treatment_tags*
del /S /Q hs_err_pid*
del /S /Q options.amecsapi.txt
del /S /Q launcher_ui_state*
del /S /Q launcher_settings*
del /S /Q launcher_gamer_pics*
del /S /Q launcher_entitlements*
del /S /Q .iasx
del /S /Q .iasp
del /S /Q .iasms_v2
del /S /Q launcher_accounts.*
del /S /Q launcher_msa_credentials.*
del /S /Q launcher_profiles.*
del /S /Q launcher_ui_state.*

if exist "%appdata%\.minecraft\wurst" (
echo.
echo Hello Hacker/Cheater do you want to delete your Wurst Configs?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\wurst"
IF ERRORLEVEL 1 echo OK, Happy Hacking/Cheating!
)
if exist "%appdata%\.minecraft\XaeroWaypoints" (
echo.
echo  Do you want to delete your Xaero Waypoints?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\XaeroWaypoints"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\bettercommandblock_script" (
echo.
echo  Do you want to delete your bettercommandblock scripts?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\bettercommandblock_script"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\replay_recordings" (
echo.
echo  Do you want to delete your replay recordings?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\replay_recordings"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\backups" (
echo.
echo  Do you want to delete your world backups?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\backups"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\saves" (
echo.
echo  Do you want to delete ALL your worlds?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\saves"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\shaderpacks" (
echo.
echo  Do you want to delete ALL your shaderpacks?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\shaderpacks"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\resourcepacks" (
echo.
echo  Do you want to delete ALL your resourcepacks?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\resourcepacks"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\config" (
echo.
echo  Do you want to delete ALL your current loaded mod configs?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\config"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\mods" (
echo.
echo  Do you want to delete ALL your current loaded mods?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\mods"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\servers.dat" (
echo.
echo  Do you want to delete your server list?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 del /S /Q "%appdata%\.minecraft\servers.*"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\options.txt" (
echo.
echo  Do you want to delete ALL your current loaded OPTIONS?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 del /S /Q "%appdata%\.minecraft\options*"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\screenshots" (
echo.
echo  Do you want to delete ALL your minecraft screenshots?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\screenshots"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\hotbar.nbt" (
echo.
echo  Do you want to delete your saved hotbars?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 del /S /Q "%appdata%\.minecraft\hotbar.nbt"
IF ERRORLEVEL 1 echo OK!
)

echo.
echo  Do you want to delete your launcher settings?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 del /S /Q "%appdata%\.minecraft\launcher_settings*"
IF ERRORLEVEL 1 echo OK!

echo.
echo  Do you want to delete your skins?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 del /S /Q "%appdata%\.minecraft\launcher_skins*"
IF ERRORLEVEL 1 echo OK!

echo.
echo  Do you want to LOGOUT from EVERY account in your minecraft launcher?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 del /S /Q "%appdata%\.minecraft\launcher_accounts*" & del /S /Q "%appdata%\.minecraft\launcher_msa_credentials*"
IF ERRORLEVEL 1 echo OK!

echo.
echo  Do you want to delete all your launcher profiles, only vanila %vl% will be kept?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 del /S /Q "%appdata%\.minecraft\launcher_profiles*"
IF ERRORLEVEL 1 echo OK!

echo.
echo  Do you want to delete old Minecraft Versions and Snapshots? - only 1.8.9-vanila/forge and latest %l%-vanila/fabric will be kept
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO c1
IF ERRORLEVEL 1 GOTO c2

:c1
mkdir tmp
move versions\1.8.9 tmp
move versions\1.8.9-forge1.8.9-11.15.1.2318-1.8.9 tmp
move versions\%l% tmp
move versions\%fal% tmp
rmdir /S /Q versions
mkdir versions
move tmp\1.8.9 versions
move tmp\1.8.9-forge1.8.9-11.15.1.2318-1.8.9 versions
move tmp\%l% versions
move tmp\%fal% versions
rmdir /S /Q tmp

:c2
if exist .fabric (
echo.
echo  Do you want to delete old Fabric Versions and Snapshots? - only latest %fal% will be kept?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO c3
IF ERRORLEVEL 1 GOTO c4
)

:c3
if exist .fabric (
mkdir tmp
move .fabric\remappedJars\minecraft-%l%\intermediary-%fal%.jar tmp
rmdir /S /Q .fabric
mkdir .fabric
mkdir .fabric\remappedJars\
mkdir .fabric\remappedJars\minecraft-%l%
move tmp\intermediary-%fal%.jar .fabric\remappedJars\minecraft-%l%\
rmdir /S /Q tmp
)

:c4
CLS
echo.
echo  Cleaned
echo.
echo  1. Restart Mod-Installer
echo  2. End Installer
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO restart

:mi
CLS
echo.
echo  Do you really want to migrate to the OLD Minecraft Launcher?
echo  Your Minecraft Launcher will be closed!
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO miy
IF ERRORLEVEL 1 GOTO end

:miy
cd "%appdata%\.minecraft"
TASKKILL /T /F /IM MinecraftLauncher.exe
TASKKILL /T /F /IM Minecraft.exe
del /S /Q launcher_profiles.json
move launcher_profiles_microsoft_store.json launcher_profiles.json
curl -L -o Installer-Uninstaller.bat https://raw.githubusercontent.com/SanCraftDev/Mod-Installer/main/Installer.bat & start "" "%appdata%\.minecraft\Installer-Uninstaller.bat"
EXIT /B

:fb
CLS
echo.
echo  https://sancraft.dev/discord
echo  https://github.com/SanCraftDev/Mod-Installer/issues/
echo  1. Restart Mod-Installer
echo.
echo  2. End Installer
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO restart

:restart
start %ComSpec% /C %0
EXIT /B

:end
EXIT /B
