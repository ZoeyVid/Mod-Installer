@echo off
C:
if exist %appdata%\.minecraft (
  cd %appdata%\.minecraft 
  curl -sL -o fabric.jar https://maven.fabricmc.net/net/fabricmc/fabric-installer/1.1.1/fabric-installer-1.1.1.jar
  if exist fabric.jar (
    java -jar fabric.jar client -mcversion 1.21.10 -loader 0.18.3
    del /S /Q fabric.jar
  )
)
