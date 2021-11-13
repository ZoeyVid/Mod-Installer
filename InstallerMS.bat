@echo off
:start
curl -L -o %0 https://raw.githubusercontent.com/SanCraftDev/Mod-Installer/main/InstallerMS.bat
FOR /F "usebackq" %%f IN (`PowerShell -NoProfile -Command "Write-Host([Environment]::GetFolderPath('Desktop'))"`) DO (
  SET "DESKTOP_FOLDER=%%f"
  )
del /S /Q "%appdata%\.minecraft\fabric.jar"
del /S /Q "%appdata%\.minecraft\1.17.bat"
del /S /Q "%appdata%\.minecraft\Update.bat"
del /S /Q "%appdata%\.minecraft\I.bat"
del /S /Q "%appdata%\.minecraft\IMS.bat"
set /p steam=<%appdata%\.minecraft\Mod-Installer\steam.txt
CLS
echo.
echo  MIT License
echo.
echo  Copyright (c) 2021 SanCraft
echo.
echo  Permission is hereby granted, free of charge, to any person obtaining a copy
echo  of this software and associated documentation files (the "Software"), to deal
echo  in the Software without restriction, including without limitation the rights
echo  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
echo  copies of the Software, and to permit persons to whom the Software is
echo  furnished to do so, subject to the following conditions:
echo.
echo  The above copyright notice and this permission notice shall be included in all
echo  copies or substantial portions of the Software.
echo.
echo  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
echo  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
echo  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
echo  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
echo  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
echo  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
echo  SOFTWARE.
echo.
echo  NOT AN OFFICIAL MINECRAFT PRODUCT. NOT APPROVED BY OR ASSOCIATED WITH MOJANG.
echo.
echo  Do you accept this?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO s
IF ERRORLEVEL 1 echo  Aborting... & pause & EXIT /B

:s
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
	echo  Started?
	Pause
    TASKKILL /T /F /IM MinecraftLauncher.exe
    TASKKILL /T /F /IM Minecraft.exe
	GOTO restart
)
move servers.dat_tmp servers.dat
cd "%appdata%\.minecraft"
curl -L -o IMS.bat https://raw.githubusercontent.com/SanCraftDev/Mod-Installer/main/IMS.bat
start "" IMS.bat
EXIT /B
