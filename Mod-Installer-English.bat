@echo off
setlocal
:start
endlocal
    where java >nul 2>nul
    if %errorlevel%==1 (
	CLS
	ECHO Java is not installed, please install Java!
	ECHO https://adoptopenjdk.net/?variant=openjdk16&jvmVariant=hotspot
	ECHO.
    ECHO 1. Update/Install Mod-Installer
    ECHO 2. Restart Installer
    ECHO 3. End Installer
	ECHO 4. Leave Feedback
    ECHO.

    CHOICE /C 1234 /M "Selection: "

    :: Note - list ERRORLEVELS in decreasing order
    IF ERRORLEVEL 4 GOTO fb
    IF ERRORLEVEL 3 GOTO end
    IF ERRORLEVEL 2 GOTO start
    IF ERRORLEVEL 1 GOTO update
)

if exist %userprofile%\AppData\Roaming\.minecraft (
endlocal
CLS
	ECHO.
	ECHO Client-Mods/Modpack Versions:
	ECHO.
	ECHO 1. 1.16.5
	ECHO.
	ECHO 2. Texture Packs
	ECHO.
	ECHO 3. Backups/Modprofile
	ECHO.
	ECHO 4. Open Minecraft-Launcher
	ECHO.
	ECHO Funktionen:
	ECHO.
	ECHO 5. Update/Install Mod-Installer 
    ECHO 6. Restart Installer
	ECHO 7. End Installer
	ECHO.
    CHOICE /C 1234567 /M "Selection: "

    :: Note - list ERRORLEVELS in decreasing order
    IF ERRORLEVEL 7 GOTO end
    IF ERRORLEVEL 6 GOTO start
    IF ERRORLEVEL 5 GOTO update
    IF ERRORLEVEL 4 GOTO mcl
    IF ERRORLEVEL 3 GOTO bp
	IF ERRORLEVEL 2 GOTO tp
    IF ERRORLEVEL 1 GOTO 1.16.5

:1.16.5
CLS
ECHO Client: FPS = Sodium, Shader = Optifine
ECHO Only = Only Grafikmods, Lite = few light Mods, Full = Minimap, Hwyla, usw.
ECHO Client = Playable on Vanila Servers, Modpack = Only playable in single Player and on a Server with the same Modpack.
ECHO.
ECHO Only Optifine/Modloader:
ECHO.
ECHO A. 1.16.5 Only Optifine		- https://optifine.net/home
ECHO B. 1.16.5 Only Fabric-Loader	- https://fabricmc.net/
ECHO C. 1.16.5 Only Forge-Loader	- https://files.minecraftforge.net/net/minecraftforge/forge/
ECHO.
ECHO Client-Modpacks:
ECHO.
ECHO D. 1.16.5 Client Only FPS
ECHO E. 1.16.5 Client Mods Lite FPS
ECHO F. 1.16.5 Client Mods Full FPS
ECHO.
ECHO G. 1.16.5 Client Only Shader
ECHO H. 1.16.5 Client Mods Lite Shader
ECHO I. 1.16.5 Client Mods Full Shader
ECHO.
ECHO Modpacks:
ECHO.
ECHO J. 1.16.5 Sanoj's Forge Modpack Lite 	 	- https://www.curseforge.com/minecraft/modpacks/sanojs-forge-loader-modpack/
ECHO K. 1.16.5 Sanoj's Forge Modpack Full 	 	- https://www.curseforge.com/minecraft/modpacks/sanojs-forge-loader-modpack/
ECHO.
ECHO L. 1.16.5 Sanoj's Fabric Modpack Lite 		- https://www.curseforge.com/minecraft/modpacks/sanojs-fabric-loader-modpack
ECHO M. 1.16.5 Sanoj's Fabric Modpack Full  	- https://www.curseforge.com/minecraft/modpacks/sanojs-fabric-loader-modpack
ECHO.
ECHO Server Modpacks:
ECHO.
ECHO N. 1.16.5 Forge Server Pack
ECHO O. 1.16.5 Fabric Server Pack
ECHO.
ECHO P. Restart Installer
ECHO Q. End Installer
ECHO.
ECHO Make sure you select the correct modloader in the Minecraft Launcher at the bottom left!
ECHO.

CHOICE /C abcdefghijklmnopq /M "RECOMMENDATION! SECURE MODS / CONFIGS IN ONE PROFILE! YOU WILL BE REMOVED! Selection: "
IF ERRORLEVEL 17 GOTO end
IF ERRORLEVEL 16 GOTO start
IF ERRORLEVEL 15 GOTO 1.16.5-fas
IF ERRORLEVEL 14 GOTO 1.16.5-fos
IF ERRORLEVEL 13 GOTO 1.16.5-sanoj's-fabric-modpack-full
IF ERRORLEVEL 12 GOTO 1.16.5-sanoj's-fabric-modpack-lite
IF ERRORLEVEL 11 GOTO 1.16.5-sanoj's-forge-modpack-full
IF ERRORLEVEL 10 GOTO 1.16.5-sanoj's-forge-modpack-lite
IF ERRORLEVEL 9 GOTO 1.16.5-Client-Mods-Full-Shader
IF ERRORLEVEL 8 GOTO 1.16.5-Client-Mods-Lite-Shader
IF ERRORLEVEL 7 GOTO 1.16.5-Client-Only-Shader
IF ERRORLEVEL 6 GOTO 1.16.5-Client-Mods-Full-FPS
IF ERRORLEVEL 5 GOTO 1.16.5-Client-Mods-Lite-FPS
IF ERRORLEVEL 4 GOTO 1.16.5-Client-Only-FPS
IF ERRORLEVEL 3 GOTO 1.16.5-forge
IF ERRORLEVEL 2 GOTO 1.16.5-fabric
IF ERRORLEVEL 1 GOTO 1.16.5-optifine

:tp
CLS
ECHO.
ECHO Texture Packs:
ECHO.
ECHO 1. Remove Punkin View - KÅrbis.zip
ECHO 2. Dark Mode - Make Minecraft Dark	- https://www.curseforge.com/minecraft/texture-packs/default-dark-mode
ECHO 3. Xray - mostly not welcome		- https://www.curseforge.com/minecraft/texture-packs/xray-ultimate-1-11-compatible
ECHO 4. Default Resourcepack - create your own Resourcepack
ECHO    Saved in Path of this Mod-Installer
ECHO.
ECHO 5. Restart Installer
ECHO 6. End Installer
ECHO.
CHOICE /C 123456 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 6 GOTO end
IF ERRORLEVEL 5 GOTO start
IF ERRORLEVEL 4 GOTO sr
IF ERRORLEVEL 3 GOTO x
IF ERRORLEVEL 2 GOTO dm
IF ERRORLEVEL 1 GOTO k


:1.16.5-optifine
echo Instalation starting...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods config
curl --output 1.16.5-optifine.jar --url https://download.san0j.de/mods/1.16.5-optifine.jar
echo In the next step, a window will open automatically, just click on "Install"!
Pause
java -jar 1.16.5-optifine.jar
del /S /Q 1.16.5-optifine.jar
echo Finished


ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16.5-fabric
echo Instalation starting...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods config
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.3/fabric-installer-0.7.3.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
echo Finished

ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16.5-forge
echo Instalation starting...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods config
curl --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.5-36.1.17/forge-1.16.5-36.1.17-installer.jar
echo Im nÑchsten Schritt îffnet sich automatisch ein Fenster klicke dort nur auf "OK"!
Pause
java -jar forge.jar
del /S /Q forge.jar
del /S /Q 1.16.5-forge.jar.log
echo Finished! 

ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start
	

:1.16.5-Client-Only-FPS
echo Instalation starting...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods config
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.3/fabric-installer-0.7.3.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16.5-Client-Only-FPS.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Finished!

ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16.5-Client-Mods-Lite-FPS
echo Instalation starting...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods config
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.3/fabric-installer-0.7.3.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16.5-Client-Mods-Lite-FPS.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Finished!

ECHO 1. Restart Installer
ECHO 2. End Installer
 CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16.5-Client-Mods-Full-FPS
echo Instalation starting...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods config
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.3/fabric-installer-0.7.3.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16.5-Client-Mods-Full-FPS.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Finished!

ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16.5-Client-Only-Shader
echo Instalation starting...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods config
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.3/fabric-installer-0.7.3.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16.5-Client-Only-Shader.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Finished!

ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16.5-Client-Mods-Lite-Shader
echo Instalation starting...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods config
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.3/fabric-installer-0.7.3.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16.5-Client-Mods-Lite-Shader.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Finished!

ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16.5-Client-Mods-Full-Shader
echo Instalation starting...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods config
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.3/fabric-installer-0.7.3.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16.5-Client-Mods-Full-Shader.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Finished!

ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16.5-sanoj's-forge-modpack-lite
echo Instalation starting...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods config
curl --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.5-36.1.17/forge-1.16.5-36.1.17-installer.jar
echo In the next step a window will open automatically, just click on "OK"!
Pause
java -jar forge.jar
del /S /Q forge.jar
del /S /Q 1.16.5-forge.jar.log
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16.5-Sanojs-Forge-Modpack-Lite.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Finished!

ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16.5-sanoj's-forge-modpack-full
echo Instalation starting...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods config
curl --output forge.jar --url https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.5-36.1.17/forge-1.16.5-36.1.17-installer.jar
echo In the next step a window will open automatically, just click on "OK"!
Pause
java -jar forge.jar
del /S /Q forge.jar
del /S /Q 1.16.5-forge.jar.log
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16.5-Sanojs-Forge-Modpack-Full.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Finished!

ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16.5-sanoj's-fabric-modpack-lite
echo Instalation starting...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods config
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.3/fabric-installer-0.7.3.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16.5-Sanojs-Fabric-Modpack-Lite.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Finished!

ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16.5-sanoj's-fabric-modpack-full
echo Instalation starting...
C:
cd %userprofile%\AppData\Roaming\.minecraft
tar cf Backup.tar mods config
curl --output fabric.jar --url https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.3/fabric-installer-0.7.3.jar
java -jar fabric.jar client -mcversion 1.16.5
del /S /Q fabric.jar
rmdir /S /Q mods
curl --output mods.zip --url https://download.san0j.de/mods/1.16.5-Sanojs-Fabric-Modpack-Full.zip
tar -xf mods.zip
del /S /Q mods.zip
echo Finished!

ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16.5-fos
echo Download startet...
start https://download.san0j.de/mods/1.16.5-Forge-Server-Pack.zip
ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:1.16.5-fas
echo Download startet...
start https://download.san0j.de/mods/1.16.5-Fabric-Server-Pack.zip
ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:k
echo Instalation starting...
C:
cd %userprofile%\AppData\Roaming\.minecraft\resourcepacks
curl --output KÅrbis.zip --url https://download.san0j.de/mods/KÅrbis.zip

ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:dm
echo Instalation starting...
C:
cd %userprofile%\AppData\Roaming\.minecraft\resourcepacks
curl --output Dark.zip --url https://download.san0j.de/mods/Dark-Mode.zip

ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:x
echo Instalation starting...
C:
cd %userprofile%\AppData\Roaming\.minecraft\resourcepacks
curl --output Xray.zip --url https://download.san0j.de/mods/Xray.zip

ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:sr
echo Instalation starting...
mkdir Selfedit
cd Selfedit
curl --output rp.zip --url https://download.san0j.de/mods/default-rp-for-selfedit.zip
tar -xf rp.zip
del /S /Q rp.zip

ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start

:mcl
echo Starting...
C:
cd %userprofile%\AppData\Roaming\.minecraft\
if exist steam (
	start steam://rungameid/13354743620561797120
) else (

if exist "C:\program files (x86)\Minecraft Launcher\MinecraftLauncher.exe" (
  start "" "C:\program files (x86)\Minecraft Launcher\MinecraftLauncher.exe" 
) else (
	CLS
	echo Minecraft Launcher cannot be found on the Usual Path!
	ECHO.
    ECHO 1. Update/Install Mod-Installer
    ECHO 2. Restart Installer
    ECHO 3. End Installer
	ECHO 4. Leave Feedback
    ECHO.

    CHOICE /C 1234 /M "Selection: "

    :: Note - list ERRORLEVELS in decreasing order
    IF ERRORLEVEL 4 GOTO fb
    IF ERRORLEVEL 3 GOTO end
    IF ERRORLEVEL 2 GOTO start
    IF ERRORLEVEL 1 GOTO update
)

)
EXIT /B

:bp
C:
cd "%userprofile%\AppData\Roaming\.minecraft\"
CLS
ECHO.
ECHO 1. Create Profile - Limit 9
ECHO 2. Load Profil - RECOMMENDATION! SECURE MODS / CONFIGS IN ONE PROFILE! YOU WILL BE REMOVED!
ECHO.
ECHO 3. Load Backup - is created automatically when downloading modpacks and loading profiles
ECHO.
ECHO 4. Restart Installer
ECHO 5. End Installer
ECHO.
ECHO Make sure you select the correct modloader in the Minecraft Launcher at the bottom left!
ECHO.
CHOICE /C 12345 /M "Selection: "
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
echo Finished!

ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start

:pu
tar cf Backup.tar mods config
rmdir /S /Q mods
rmdir /S /Q config
ECHO.
ECHO Which profile do you want to load?
ECHO.
CHOICE /C 123456789 /M "Selection: "
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
echo Finished!

ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start

:pc
ECHO.
ECHO Under which profile do you want to save the current mods and configs?
ECHO.
CHOICE /C 123456789 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 9 tar cf Profil-9.tar mods config
IF ERRORLEVEL 8 tar cf Profil-8.tar mods config
IF ERRORLEVEL 7 tar cf Profil-7.tar mods config
IF ERRORLEVEL 6 tar cf Profil-6.tar mods config
IF ERRORLEVEL 5 tar cf Profil-5.tar mods config
IF ERRORLEVEL 4 tar cf Profil-4.tar mods config
IF ERRORLEVEL 3 tar cf Profil-3.tar mods config
IF ERRORLEVEL 2 tar cf Profil-2.tar mods config
IF ERRORLEVEL 1 tar cf Profil-1.tar mods config
echo Finished!

ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:update
curl --output Mod-Installer.bat --url https://download.san0j.de/mods/Mod-Installer-English.bat
echo Finished!

ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


:end
EXIT /B

:fb
ECHO https://discord.san0j.de/
ECHO https://github.com/2020Sanoj/Mod-Installer/issues
ECHO Make sure you have selected the correct modloader in the Minecraft Launcher at the bottom left!
ECHO 1. Restart Installer
ECHO 2. End Installer
CHOICE /C 12 /M "Selection: "
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start


)   else (
    CLS
	
    echo .minecraft Folder not at the usual path or not available. 
	echo Execution of mod updates and installations not possible.
	ECHO.
    ECHO 1. Update/Install Mod-Installer
    ECHO 2. Restart Installer
    ECHO 3. End Installer
	ECHO 4. Leave Feedback
    ECHO.

    CHOICE /C 1234 /M "Selection: "

    :: Note - list ERRORLEVELS in decreasing order
    IF ERRORLEVEL 4 GOTO fb
    IF ERRORLEVEL 3 GOTO end
    IF ERRORLEVEL 2 GOTO start
    IF ERRORLEVEL 1 GOTO update
)