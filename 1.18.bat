@echo off
C:
if exist %appdata%\.minecraft (
cd %appdata%\.minecraft 
curl --ssl-no-revoke -sL -o fabric.jar https://zvcdn.de/fa
if exist fabric.jar (
java -jar fabric.jar client -mcversion 1.18.2 -loader 0.14.17
del /S /Q fabric.jar
)
)
