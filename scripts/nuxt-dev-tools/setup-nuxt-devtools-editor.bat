@echo off
REM Nuxt DevTools Editor Configuration Script for Windows
REM This script sets up the LAUNCH_EDITOR environment variable for Nuxt DevTools
# how to run: scripts\nuxt-dev-tools\setup-nuxt-devtools-editor.bat

echo ========================================
echo Nuxt DevTools Editor Configuration
echo ========================================
echo.

echo Available editors:
echo 1. Cursor
echo 2. Visual Studio Code
echo 3. Windsurf
echo.

set /p choice="Select your editor (1-3): "

if "%choice%"=="1" (
    set editor_name=Cursor
    set editor_command=cursor
) else if "%choice%"=="2" (
    set editor_name=Visual Studio Code
    set editor_command=code
) else if "%choice%"=="3" (
    set editor_name=Windsurf
    set editor_command=windsurf
) else (
    echo Invalid choice. Exiting...
    pause
    exit /b 1
)

echo.
echo Configuring for %editor_name%...
echo.

REM Check if the editor CLI is available
echo Checking if %editor_command% CLI is available...
%editor_command% --version >nul 2>&1
if %errorlevel% neq 0 (
    echo WARNING: %editor_command% command not found in PATH
    echo Please ensure %editor_name% is installed with CLI tools enabled
    echo.
    set /p continue="Continue anyway? (y/n): "
    if /i not "%continue%"=="y" (
        echo Configuration cancelled.
        pause
        exit /b 1
    )
) else (
    echo ✓ %editor_command% CLI is available
)

echo.
echo Setting LAUNCH_EDITOR environment variable...

REM Set for current session
set LAUNCH_EDITOR=%editor_command%
echo ✓ Set LAUNCH_EDITOR=%editor_command% for current session

REM Add to user environment variables (persistent)
setx LAUNCH_EDITOR "%editor_command%" >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ Added LAUNCH_EDITOR=%editor_command% to user environment variables
) else (
    echo WARNING: Could not set persistent environment variable
    echo You may need to set it manually in System Properties
)

echo.
echo ========================================
echo Configuration Complete!
echo ========================================
echo.
echo Next steps:
echo 1. Restart your terminal/command prompt
echo 2. Restart your Nuxt dev server: npm run dev
echo 3. Test the "go to code" feature in Nuxt DevTools
echo.
echo Current LAUNCH_EDITOR: %LAUNCH_EDITOR%
echo.

pause
