@echo off
C:
if exist %appdata%\.minecraft (
cd %appdata%\.minecraft 
curl --ssl-no-revoke -sL -o fabric.jar https://dl.scdmx.de/fa
if exist fabric.jar (
java -jar fabric.jar client -mcversion 1.18.2 -loader 0.14.9
del /S /Q fabric.jar
)
)
