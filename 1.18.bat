@echo off
C:
cd %appdata%\.minecraft
curl -sL -o fabric.jar https://dl.sancraft.dev/fa
java -jar fabric.jar client -mcversion 1.18.2 -loader 0.13.3
del /S /Q fabric.jar
