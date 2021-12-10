@echo off
C:
cd %appdata%\.minecraft
curl -sL -o fabric.jar https://dl.sancraft.dev/fa
java -jar fabric.jar client -mcversion 1.18.1 -launcher microsoft_store -loader 0.12.11
del /S /Q fabric.jar
