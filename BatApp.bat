@echo off

if "%1" == "-v" (
    echo Bat App version 1.0
) else if "%1" == "-h" (
    echo Available commands:
    echo -h: Shows the available commands
    echo -u: Check for Updates
    echo -v: Shows the current version of the app
) else if "%1" == "-u" (
    echo Checking for Updates...
    
) else (
    echo Unknown command, Type -h or to see the available commands
)
