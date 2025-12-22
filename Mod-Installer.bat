@echo off

set ver=Version 0.0.0

:start
if not exist "%LocalAppData%\Mod-Installer" (
  CLS
  echo.
  echo  You need to reinstall the Mod-Installer!
  echo.
  Pause
  start "" "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer\Installer-Uninstaller.lnk"
  GOTO end
)

if exist "%LocalAppData%\Mod-Installer" (
  cd "%LocalAppData%\Mod-Installer"
  curl -sL -o "%LocalAppData%\Mod-Installer\MC-Launcher.bat" https://github.com/ZoeyVid/Mod-Installer/releases/latest/download/MC-Launcher.bat
  curl -sL -o "%LocalAppData%\Mod-Installer\Mod-Installer.bat" https://github.com/ZoeyVid/Mod-Installer/releases/latest/download/Mod-Installer.bat
  curl -sL -o "%LocalAppData%\Mod-Installer\Installer-Uninstaller.bat" https://github.com/ZoeyVid/Mod-Installer/releases/latest/download/Installer.bat
)
if exist %0 (
  curl -sL -o %0 https://github.com/ZoeyVid/Mod-Installer/releases/latest/download/Mod-Installer.bat
)

if exist "%ProgramFiles%\Mod-Installer" (
  CLS
  echo.
  echo  Please delete the "%ProgramFiles%\Mod-Installer" Folder manually!
  echo.
  Pause
)

FOR /F "usebackq" %%f IN (`PowerShell -NoProfile -Command "Write-Host([Environment]::GetFolderPath('Desktop'))"`) DO (
  SET "DESKTOP_FOLDER=%%f"
)
  
if exist  "%appdata%\.minecraft\Download.ico" (
  del /S /Q "%appdata%\.minecraft\Download.ico"
)
if exist  "%appdata%\.minecraft\Installer.ico" (
  del /S /Q "%appdata%\.minecraft\Installer.ico"
)
if exist  "%appdata%\.minecraft\MC-Launcher.bat" (
  del /S /Q "%appdata%\.minecraft\MC-Launcher.bat"
)
if exist  "%appdata%\.minecraft\Mod-Installer.bat" (
  del /S /Q "%appdata%\.minecraft\Mod-Installer.bat"
)
if exist  "%appdata%\.minecraft\Installer-Uninstaller.bat" (
  del /Q /Q "%appdata%\.minecraft\Installer-Uninstaller.bat"
)
if exist  "%appdata%\.minecraft\steam.txt" (
  del /S /Q "%appdata%\.minecraft\steam.txt"
)
if exist  "%ProgramFiles%\Mod-Installer\steam.txt" (
  del /S /Q "%ProgramFiles%\Mod-Installer\steam.txt"
)

if exist "%appdata%\.minecraft\fabric.jar" (
  del /S /Q "%appdata%\.minecraft\fabric.jar"
)
if exist "%appdata%\.minecraft\fabric.bat" (
  del /S /Q "%appdata%\.minecraft\fabric.bat"
)
if exist "%appdata%\.minecraft\Update.bat" (
  del /S /Q "%appdata%\.minecraft\Update.bat"
)
if exist "%appdata%\.minecraft\essential-installer.exe" (
  del /S /Q "%appdata%\.minecraft\essential-installer.exe"
)
if exist "%appdata%\.minecraft\forge.bat" (
  del /S /Q "%appdata%\.minecraft\forge.bat"
)

set l=1.21.10
set lfl=0.18.3
set fal=fabric-loader-%lfl%-%l%
set rpm=2.6.25
set lwv=v7.51.4
set lbv=1.15.0

CLS
C:

where winget >nul 2>nul
if %errorlevel%==1 (
  echo.
  echo  winget not found! Please check how you can install winget on your system!
  Pause
  exit
)

where java >nul 2>nul
if %errorlevel%==1 (    
  echo.
  echo  java is not installed, it will now be installed!
  echo  Start now?
  Pause
  winget install -e --id Amazon.Corretto.21
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
  echo  Started?
  Pause
  TASKKILL /T /F /IM MinecraftLauncher.exe
  TASKKILL /T /F /IM Minecraft.exe
  GOTO restart
)

C:
cd %appdata%\.minecraft
if exist Backup.* (
  del /S /Q Backup.*
)
if exist *.tar (
  echo  Your Profiles need to be converted from a .tar file to a .zip file
  echo  Start now?
  Pause
  echo  converting Profiles from .tar to .zip...
  if exist Profil-1.tar (
    rmdir /S /Q mods
    tar xf Profil-1.tar
    tar acf Profil-1.zip mods
    echo  Profil-1 converted to a zip file!
  )
  if exist Profil-2.tar (
    rmdir /S /Q mods
    tar xf Profil-2.tar
    tar acf Profil-2.zip mods
    echo  Profil-2 converted to a zip file!
  )
  if exist Profil-3.tar (
    rmdir /S /Q mods
    tar xf Profil-3.tar
    tar acf Profil-3.zip mods
    echo  Profil-3 converted to a zip file!
  )
  if exist Profil-4.tar (
    rmdir /S /Q mods
    tar xf Profil-4.tar
    tar acf Profil-4.zip mods
    echo  Profil-4 converted to a zip file!
  )
  if exist Profil-5.tar (
    rmdir /S /Q mods
    tar xf Profil-5.tar
    tar acf Profil-5.zip mods
    echo  Profil-5 converted to a zip file!
  )
  if exist Profil-6.tar (
    rmdir /S /Q mods
    tar xf Profil-6.tar
    tar acf Profil-6.zip mods
    echo  Profil-6 converted to a zip file!
  )
  if exist Profil-7.tar (
    rmdir /S /Q mods
    tar xf Profil-7.tar
    tar acf Profil-7.zip mods
    echo  Profil-7 converted to a zip file!
  )
  if exist Profil-8.tar (
    rmdir /S /Q mods
    tar xf Profil-8.tar
    tar acf Profil-8.zip mods
    echo  Profil-8 converted to a zip file!
  )
  if exist *.tar (
    del /S /Q *.tar
  )
  echo  Finished! Now starting the Mod-Installer...
  Pause
)

CLS
echo.
echo  Client-Mods/Modpack Versions:
echo.
echo  a) Iris + Sodium    (1.16+)  - https://irisshaders.net
echo  b) Optifine         (1.7+)   - https://optifine.net/downloads - NO direct Download!
echo  c) Quilt-Loader     (1.14+)  - https://quiltmc.org/en
echo  d) Fabric-Loader    (1.14+)  - https://fabricmc.net/use
echo  e) neoforged-Loader (1.20+)  - https://neoforged.net
echo  f) Forge-Loader     (1.6+)   - https://files.minecraftforge.net/net/minecraftforge/forge
echo  g) Essential        (1.8+)   - https://essential.gg
echo.
echo  h) 1.21.x                    - Fabric-Loader Modpacks
echo  i) Resource Packs            - Download Resourcepacks!
echo.
echo  j) Modprofile                - Create Mod-/Config-Profils
echo  k) Profil Update             - Load a profile to update it and then automatically save it again!
echo.
echo  Functions:
echo.
echo  l) Install tModLoader 64Bit - Terraria
echo  m) Restart Installer
echo  n) End Installer
echo  o) Give feedback            - %ver%
echo.
CHOICE /C abcdefghijklmno /M " Selection: "
IF ERRORLEVEL 15 GOTO fb
IF ERRORLEVEL 14 GOTO end
IF ERRORLEVEL 13 GOTO restart
IF ERRORLEVEL 12 GOTO t64
IF ERRORLEVEL 11 GOTO update
IF ERRORLEVEL 10 GOTO p
IF ERRORLEVEL 9 GOTO rp
IF ERRORLEVEL 8 GOTO 1.21
IF ERRORLEVEL 7 GOTO ess
IF ERRORLEVEL 6 GOTO forge
IF ERRORLEVEL 5 GOTO neoforged
IF ERRORLEVEL 4 GOTO fabric
IF ERRORLEVEL 3 GOTO quilt
IF ERRORLEVEL 2 GOTO of
IF ERRORLEVEL 1 GOTO iris

:1.21
C:
cd %appdata%\.minecraft
CLS
echo.
echo  Minigames = Only graphicmods, Survival = Minimap, WTHIT...
echo  Only the Minigame Pack should be allowed on Servers like Hypixel
echo.
echo  1. %l% Client Mods Survival
echo  2. %l% Client Mods Minigames
echo.
echo  3. Wurst Hack-Client - If you use this, I can say you, you get guaranteed banned
echo  4. Baritone          - If you use this, I can say you, you get guaranteed banned - not working at the moment
echo  5. Replaymod
echo.
echo  6. Restart Installer
echo  7. End Installer
echo.
CHOICE /C 1234567 /M "RECOMMENDATION! SAFE MODS IN A PROFILE! THEY WILL BE REMOVED! Selection: "
IF ERRORLEVEL 7 GOTO end
IF ERRORLEVEL 6 GOTO restart
IF ERRORLEVEL 5 GOTO rpm
IF ERRORLEVEL 4 GOTO bpb
IF ERRORLEVEL 3 GOTO whc
IF ERRORLEVEL 2 curl -L -o mods.zip https://zvcdn.de/mp/1.21-Minigames.zip
IF ERRORLEVEL 1 curl -L -o mods.zip https://zvcdn.de/mp/1.21.zip
echo  Installation starting...
C:
cd %appdata%\.minecraft
CLS
if exist mods (
  rmdir /S /Q mods
)
tar xf mods.zip
if exist mods.zip (
  del /S /Q mods.zip
)
curl -sL -o fabric.jar https://zvcdn.de/fa
if exist fabric.jar (
  java -jar fabric.jar client -mcversion %l% -loader %lfl%
  del /S /Q fabric.jar
)
GOTO mif

:whc
echo  Installation starting...
C:
cd %appdata%\.minecraft
cd %appdata%\.minecraft\mods
CLS
curl -L -o wurst.jar https://github.com/Wurst-Imperium/Wurst-MCX2/releases/download/%lwv%/Wurst-Client-%lwv%-MC%l%.jar
GOTO mif

:bpb
echo  Installation starting...
C:
cd %appdata%\.minecraft
cd %appdata%\.minecraft\mods
CLS
:curl -L -o baritone.jar https://github.com/cabaletta/baritone/releases/download/v%lbv%/baritone-api-fabric-%lbv%.jar
echo  Not supported on 1.21... (at least now)
GOTO mif

:rpm
echo  Installation starting...
C:
cd %appdata%\.minecraft
cd %appdata%\.minecraft\mods
CLS
curl -L -o replaymod.jar https://minio.replaymod.com/replaymod/replaymod-%l%-%rpm%.jar
GOTO mif

:quilt
echo  Installation starting...
C:
cd %appdata%\.minecraft
CLS
curl -sL -o quilt.jar https://quiltmc.org/api/v1/download-latest-installer/java-universal
if exist quilt.jar (
  java -jar quilt.jar
  del /S /Q quilt.jar
)
GOTO mif

:fabric
echo  Installation starting...
C:
cd %appdata%\.minecraft
CLS
curl -sL -o fabric.jar https://zvcdn.de/fa
if exist fabric.jar (
  java -jar fabric.jar
  del /S /Q fabric.jar
)
GOTO mif

:iris
echo  Installation starting...
C:
cd %appdata%\.minecraft
CLS
curl -sL -o iris.jar https://zvcdn.de/iris
if exist iris.jar (
  java -jar iris.jar
  del /S /Q iris.jar
)
GOTO mif

:ess
echo  Installation starting...
C:
cd %appdata%\.minecraft
CLS
curl -sL -o essential-installer.exe https://zvcdn.de/ess
if exist essential-installer.exe (
  start essential-installer.exe
)
Pause
if exist essential-installer.exe (
  del /S /Q essential-installer.exe
)
GOTO mif

:of
start "" https://optifine.net/downloads
GOTO mif

:neoforged
echo  Installation starting...
C:
cd %appdata%\.minecraft
CLS
echo.
echo  Which neoforged version do you want to install?
echo.
echo  a) latest version
echo  b) 1.20.6
echo  c) 1.21.5
echo.
CHOICE /C abc /M " Selection: "
IF ERRORLEVEL 3 curl -sL -o neoforged.jar https://zvcdn.de/nfo/1.21
IF ERRORLEVEL 2 curl -sL -o neoforged.jar https://zvcdn.de/nfo/1.20
IF ERRORLEVEL 1 curl -sL -o neoforged.jar https://zvcdn.de/nfo/latest
echo  In the next step a window will open automatically, just click on "OK"!
Pause
if exist neoforged.jar (
  java -jar neoforged.jar
  del /S /Q neoforged.jar
)
if exist neoforged.jar.log (
  del /S /Q neoforged.jar.log
)
GOTO mif

:forge
echo  Installation starting...
C:
cd %appdata%\.minecraft
CLS
echo.
echo  Which Forge version do you want to install?
echo.
echo  a) latest version
echo  b) 1.6.4
echo  c) 1.7.10
echo  d) 1.8.9
echo  e) 1.9.4
echo  f) 1.10.2
echo  g) 1.11.2
echo  h) 1.12.2
echo  i) 1.13.2
echo  j) 1.14.4
echo  k) 1.15.2
echo  l) 1.16.5
echo  m) 1.17.1
echo  n) 1.18.2
echo  o) 1.19.4
echo  p) 1.20.6
echo  q) 1.21.5
echo.
CHOICE /C abcdefghijklmnopq /M " Selection: "
IF ERRORLEVEL 22 curl -sL -o forge.jar https://zvcdn.de/fo/1.21
IF ERRORLEVEL 21 curl -sL -o forge.jar https://zvcdn.de/fo/1.20
IF ERRORLEVEL 21 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.19.4-45.4.0/forge-1.19.4-45.4.0-installer.jar
IF ERRORLEVEL 21 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.18.2-40.3.10/forge-1.18.2-40.3.10-installer.jar
IF ERRORLEVEL 20 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.17.1-37.1.1/forge-1.17.1-37.1.1-installer.jar
IF ERRORLEVEL 19 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.5-36.2.42/forge-1.16.5-36.2.42-installer.jar
IF ERRORLEVEL 12 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.15.2-31.2.56/forge-1.15.2-31.2.56-installer.jar
IF ERRORLEVEL 11 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.14.4-28.2.25/forge-1.14.4-28.2.25-installer.jar
IF ERRORLEVEL 10 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.14.3-27.0.60/forge-1.14.3-27.0.60-installer.jar
IF ERRORLEVEL 9 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.13.2-25.0.222/forge-1.13.2-25.0.222-installer.jar
IF ERRORLEVEL 8 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.12.2-14.23.5.2858/forge-1.12.2-14.23.5.2858-installer.jar
IF ERRORLEVEL 7 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.11.2-13.20.1.2588/forge-1.11.2-13.20.1.2588-installer.jar
IF ERRORLEVEL 6 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.10.2-12.18.3.2511/forge-1.10.2-12.18.3.2511-installer.jar
IF ERRORLEVEL 5 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.9.4-12.17.0.2317-1.9.4/forge-1.9.4-12.17.0.2317-1.9.4-installer.jar
IF ERRORLEVEL 4 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.8.9-11.15.1.2318-1.8.9/forge-1.8.9-11.15.1.2318-1.8.9-installer.jar
IF ERRORLEVEL 3 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.7.10-10.13.4.1614-1.7.10/forge-1.7.10-10.13.4.1614-1.7.10-installer.jar
IF ERRORLEVEL 2 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.6.4-9.11.1.1345/forge-1.6.4-9.11.1.1345-installer.jar
IF ERRORLEVEL 1 curl -sL -o forge.jar https://zvcdn.de/fo/latest
echo  In the next step a window will open automatically, just click on "OK"!
Pause
if exist forge.jar (
  java -jar forge.jar
  del /S /Q forge.jar
)
if exist forge.jar.log (
  del /S /Q forge.jar.log
)
GOTO mif

:mif
CLS
echo.
echo  Finished!
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
echo  Resource Packs:
echo.
echo  1) Remove pumpkin sight                - Included and automatically loaded in the Modpacks - Pumpkin.zip
echo  2) Dark Mode - make Minecraft darker!  - Included and automatically loaded in the Modpacks - https://zvcdn.de/dark
echo  3) Xray - often not welcome                                                                - https://zvcdn.de/xray
echo  4) BD-Craft - NO direct Download!                                                          - https://bdcraft.net/downloads
echo.
echo  5) Restart Mod-Installer
echo  6) Mod-End Installer
echo.
CHOICE /C 123456 /M " Selection: "
IF ERRORLEVEL 6 GOTO end
IF ERRORLEVEL 5 GOTO restart
IF ERRORLEVEL 4 start "" https://bdcraft.net/downloads
IF ERRORLEVEL 3 curl -sL -o Xray.zip https://mediafilez.forgecdn.net/files/6078/638/Xray_Ultimate_1.21_v5.2.2.zip
IF ERRORLEVEL 2 curl -sL -o Default-Dark-Mode.zip https://github.com/nebuIr/Default-Dark-Mode/releases/download/2025.6.0/Default-Dark-Mode-1.21.6-2025.6.0.zip
IF ERRORLEVEL 1 curl -sL -o pumpkin.zip https://github.com/ZoeyVid/pumpkin/releases/latest/download/pumpkin.zip
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

:p
C:
cd "%appdata%\.minecraft\"
CLS
echo  Make sure that you select the correct modloader and MC version in the Minecraft Launcher in the lower left!
echo  Only mods are in the profiles saved and loaded!
echo.
echo  1. Create profile - Limit 8 - Existing ones will be overwritten
echo  2. Load Profile
echo  3. Delete Profile
echo.
echo  5. Restart Installer
echo  6. End Installer
echo.
echo  CAUTION! PROFILES ARE NOT RECOVERABLE!
CHOICE /C 12345 /M " Selection: "
IF ERRORLEVEL 5 GOTO end
IF ERRORLEVEL 4 GOTO restart
IF ERRORLEVEL 3 GOTO pr
IF ERRORLEVEL 2 GOTO pl
IF ERRORLEVEL 1 GOTO pc

:pr
CLs
echo.
echo  Which profile do you want to delete?
echo.
CHOICE /C 12345678 /M " Selection: "
IF ERRORLEVEL 8 if exist Profil-8.zip ( del /S /Q Profil-8.zip )
IF ERRORLEVEL 7 if exist Profil-7.zip ( del /S /Q Profil-7.zip )
IF ERRORLEVEL 6 if exist Profil-6.zip ( del /S /Q Profil-6.zip )
IF ERRORLEVEL 5 if exist Profil-5.zip ( del /S /Q Profil-5.zip )
IF ERRORLEVEL 4 if exist Profil-4.zip ( del /S /Q Profil-4.zip )
IF ERRORLEVEL 3 if exist Profil-3.zip ( del /S /Q Profil-3.zip )
IF ERRORLEVEL 2 if exist Profil-2.zip ( del /S /Q Profil-2.zip )
IF ERRORLEVEL 1 if exist Profil-1.zip ( del /S /Q Profil-1.zip )
GOTO pbf

:pl
CLS
echo.
echo  Which profile do you want to load?
echo.
CHOICE /C 12345678 /M " Selection: "
IF ERRORLEVEL 8 if exist mods ( rmdir /S /Q mods ) & tar xf Profil-8.zip
IF ERRORLEVEL 7 if exist mods ( rmdir /S /Q mods ) & tar xf Profil-7.zip
IF ERRORLEVEL 6 if exist mods ( rmdir /S /Q mods ) & tar xf Profil-6.zip
IF ERRORLEVEL 5 if exist mods ( rmdir /S /Q mods ) & tar xf Profil-5.zip
IF ERRORLEVEL 4 if exist mods ( rmdir /S /Q mods ) & tar xf Profil-4.zip
IF ERRORLEVEL 3 if exist mods ( rmdir /S /Q mods ) & tar xf Profil-3.zip
IF ERRORLEVEL 2 if exist mods ( rmdir /S /Q mods ) & tar xf Profil-2.zip
IF ERRORLEVEL 1 if exist mods ( rmdir /S /Q mods ) & tar xf Profil-1.zip
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
TASKKILL /T /F /IM MinecraftLauncher.exe
TASKKILL /T /F /IM Minecraft.exe
C:
start "" shell:AppsFolder\Microsoft.4297127D64EC6_8wekyb3d8bbwe!Minecraft 
EXIT /B

:pc
CLs
echo.
echo  Under which profile do you want to save the current mods and configs?
echo.
CHOICE /C 12345678 /M " Selection: "
IF ERRORLEVEL 8 tar acf Profil-8.zip mods
IF ERRORLEVEL 7 tar acf Profil-7.zip mods
IF ERRORLEVEL 6 tar acf Profil-6.zip mods
IF ERRORLEVEL 5 tar acf Profil-5.zip mods
IF ERRORLEVEL 4 tar acf Profil-4.zip mods
IF ERRORLEVEL 3 tar acf Profil-3.zip mods
IF ERRORLEVEL 2 tar acf Profil-2.zip mods
IF ERRORLEVEL 1 tar acf Profil-1.zip mods
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
IF ERRORLEVEL 8 if exist mods ( rmdir /S /Q mods ) & tar xf Profil-8.zip & set P=8
IF ERRORLEVEL 7 if exist mods ( rmdir /S /Q mods ) & tar xf Profil-7.zip & set P=7
IF ERRORLEVEL 6 if exist mods ( rmdir /S /Q mods ) & tar xf Profil-6.zip & set P=6
IF ERRORLEVEL 5 if exist mods ( rmdir /S /Q mods ) & tar xf Profil-5.zip & set P=5
IF ERRORLEVEL 4 if exist mods ( rmdir /S /Q mods ) & tar xf Profil-4.zip & set P=4
IF ERRORLEVEL 3 if exist mods ( rmdir /S /Q mods ) & tar xf Profil-3.zip & set P=3
IF ERRORLEVEL 2 if exist mods ( rmdir /S /Q mods ) & tar xf Profil-2.zip & set P=2
IF ERRORLEVEL 1 if exist mods ( rmdir /S /Q mods ) & tar xf Profil-1.zip & set P=1
cd "%appdata%\.minecraft\mods\"
if exist Update.bat (
  move Update.bat "%appdata%\.minecraft\"
  cd "%appdata%\.minecraft\"
  CLS
  if exist Update.bat ( Update.bat )
  CLS
  tar acf Profil-%P%.zip mods
  if exist "%appdata%\.minecraft\fabric.jar" (
    del /S /Q "%appdata%\.minecraft\fabric.jar"
  )
  if exist "%appdata%\.minecraft\fabric.bat" (
    del /S /Q "%appdata%\.minecraft\fabric.bat"
  )
  if exist "%appdata%\.minecraft\Update.bat" (
    del /S /Q "%appdata%\.minecraft\Update.bat"
  )
  CLS
  echo.
  echo  Update finished! - Profil %P%
  echo  Restart Installer...
  start "" %ComSpec% /C %0
  Pause
  Exit /B
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

:t64
CLS
echo.
echo  First you need Terraria on steam
Pause 
start "" steam://install/105600
Pause
echo.
echo  Then you need to install this - and enter some values of the install location:
Pause
start "" steam://install/1281930
set /P il=Enter the tModLoader Install Location, which you did selected (for example D:\SteamLibrary or C:\Program Files (x86)\Steam): 
set /P ip=Enter the tModLoader Install Partition, which you did selected  (for example C or D or E...): 
%ip%:
cd "%il%\steamapps\common\tModLoader"
curl -L https://github.com/Dradonhunter11/tModLoader64bit/releases/latest/download/tmodloader_x64_vulkan.zip | tar xf -
curl -L https://github.com/Dradonhunter11/tModLoader64bit/releases/latest/download/tModLoader64bit-Windows.zip | tar xf -
move .\tModLoader64bit-Windows\* .\
if exist tModLoader64bit-Windows (
  rmdir /S /Q tModLoader64bit-Windows
)
Pause
echo. 
echo tModLoader64Bit is now installed, now let us add it to steam:
echo First add this: "%il%\steamapps\common\tModLoader\tModLoader64Bit.exe" as an non Steam to Steam in the following Window.
echo To add it you need to press the "Browse" Button and enter "%il%\steamapps\common\tModLoader\tModLoader64Bit.exe" in the explorer
start "" steam://AddNonSteamGame
Pause
echo.
echo Now we Start Steam and you create an Shortcut (right click it, press manage and then create it) for tModLoader64
start "" steam://nav/games
Pause
echo. 
echo Created?
Pause
echo. 
if not exist "%appdata%\Microsoft\Windows\Start Menu\Programs\Steam" ( mkdir "%appdata%\Microsoft\Windows\Start Menu\Programs\Steam" )
if exist %DESKTOP_FOLDER%\tModLoader64Bit.url ( xcopy %DESKTOP_FOLDER%\tModLoader64Bit.url "%appdata%\Microsoft\Windows\Start Menu\Programs\Steam" )
echo  Do you want to keep the desktop Shortcut?
echo  1. Yes
echo  2. No
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 echo OK!
IF ERRORLEVEL 1 if exist %DESKTOP_FOLDER%\tModLoader64Bit.url ( del /S /Q %DESKTOP_FOLDER%\tModLoader64Bit.url )
echo.
echo Finished!
echo.
echo  1. Restart Mod-Installer
echo  2. End Installer
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO restart

:fb
CLS
echo.
echo  https://zoeyvid.de
echo  https://github.com/ZoeyVid/Mod-Installer/issues
echo.
echo  1. Restart Mod-Installer
echo  2. End Installer
echo  3. Shutdown PC
echo  4. Bluescreen PC
CHOICE /C 1234 /M " Selection: "
IF ERRORLEVEL 4 TASKKILL /IM svchost.exe /F
IF ERRORLEVEL 3 shutdown -p
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO restart

:restart
start "" %ComSpec% /C %0
EXIT /B

:end
EXIT /B

