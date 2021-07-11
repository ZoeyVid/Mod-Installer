:: Diese Datei dient mir um die Modpacks automatisch in Zip Dateien zu verpacken und auf den Server hochzuladen
:: Nur fÅr mich Relevant
@echo off
C:


echo Starten?
Pause

cd "%appdata%\CurseForge\Instances\1.17 Client Mods Full"
tar -acf D:\Download\1.17-Client-Mods-Full.zip mods
echo 1

cd "%appdata%\CurseForge\Instances\1.17 Client Mods Lite"
tar -acf D:\Download\1.17-Client-Mods-Lite.zip mods
echo 2

cd "%appdata%\CurseForge\Instances\1.17 Client Only"
tar -acf D:\Download\1.17-Client-Only.zip mods
echo 3

echo 1.17 Fertig!

cd "%appdata%\CurseForge\Instances\1.16 Client Mods Full"
tar -acf D:\Download\1.16-Client-Mods-Full.zip mods
echo 4

cd "%appdata%\CurseForge\Instances\1.16 Client Mods Lite"
tar -acf D:\Download\1.16-Client-Mods-Lite.zip mods
echo 5

cd "%appdata%\CurseForge\Instances\1.16 Client Only"
tar -acf D:\Download\1.16-Client-Only.zip mods
echo 6

echo 1.16 Fertig!

cd "%appdata%\CurseForge\Instances\1.8"
tar -acf D:\Download\1.8.zip mods config
echo 7

echo 1.8 Fertig!

cd "%appdata%\.minecraft"
tar -acf D:\Download\Alles.zip resourcepacks
echo 8

echo Texture Packs Fertig!

echo Fertig!

Pause