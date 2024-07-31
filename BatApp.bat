@echo off

setlocal enabledelayedexpansion

:: Main logic
if "%~1" == "" (
    echo Unknown command, Type -h to see the available commands
    goto :eof
)

if "%1" == "-v" (
    echo Bat App version 1.1
) else if "%1" == "-h" (
    echo Available commands:
    echo -h: Shows the available commands
    echo -u: Check for Updates
    echo -v: Shows the current version of the app
) else if "%1" == "-u" (
    call :check_updates
) else (
    echo Unknown command, Type -h to see the available commands
)

goto :eof

:: Function to get the latest version from GitHub
:check_updates
    set "repo_url=https://api.github.com/repos/juliankh6142/BatApp/releases/latest"
    echo Checking for Updates...
    :: Fetch the latest version tag from GitHub
    for /f "tokens=*" %%i in (
        'curl -s -H "Accept: application/vnd.github.v3+json" !repo_url! ^| findstr /i "\"tag_name\""'
    ) do (
        set "latest_version=%%i"
    )
    :: Extract the version number by trimming unwanted characters
    for /f "tokens=2 delims=:," %%i in ("!latest_version!") do (
        set "latest_version=%%i"
    )
    set "latest_version=!latest_version:~2,-1!"

    :: Compare with the current version
    set "current_version=1.1"
    if "!latest_version!" neq "!current_version!" (
        echo A new version is available: !latest_version!
        echo Downloading the latest version...
        call :self_update
    ) else (
        echo You are using the latest version: !latest_version!
    )
    exit /b

:: Function to update the script
:self_update
    set "script_url=https://raw.githubusercontent.com/juliankh6142/BatApp/main/BatApp.bat"
    echo Downloading new version of the script...
    curl -s -L -o "%~f0" "!script_url!"
    echo Update complete. Restarting...
    start "" "%~f0" -h
    exit /b

endlocal
