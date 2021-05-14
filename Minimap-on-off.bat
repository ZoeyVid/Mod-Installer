@echo off
curl --output Mod-Installer.bat --url https://download.san0j.de/mods/Minimap-on-off.bat
C:
cd "%userprofile%\AppData\Roaming\.minecraft\mods\"
if exist Xaero* (
  echo On. Disable?
  Pause
  move Xaero* "%userprofile%\AppData\Roaming\.minecraft\"
  Exit
)

C:
cd "%userprofile%\AppData\Roaming\.minecraft\"
if exist Xaero* (
  echo Off. Enable?
  Pause
  move Xaero* "%userprofile%\AppData\Roaming\.minecraft\mods\"
  Exit
)