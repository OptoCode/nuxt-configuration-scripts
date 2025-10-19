@echo off
REM Nuxt DevTools Configuration Verification Script for Windows
REM This script verifies that the LAUNCH_EDITOR is properly configured
# how to run: scripts\nuxt-dev-tools\verify-nuxt-devtools-config.bat

echo ========================================
echo Nuxt DevTools Configuration Verification
echo ========================================
echo.

REM Check if LAUNCH_EDITOR is set
if defined LAUNCH_EDITOR (
    echo ✓ LAUNCH_EDITOR is set to: %LAUNCH_EDITOR%
) else (
    echo ✗ LAUNCH_EDITOR is not set
    echo   Run the setup script first: scripts\setup-nuxt-devtools-editor.bat
    pause
    exit /b 1
)

REM Check if the editor command is available
echo Checking if %LAUNCH_EDITOR% CLI is available...
%LAUNCH_EDITOR% --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ %LAUNCH_EDITOR% CLI is available
    for /f "tokens=*" %%i in ('%LAUNCH_EDITOR% --version 2^>nul') do (
        echo   Version: %%i
    )
) else (
    echo ✗ %LAUNCH_EDITOR% command not found in PATH
    echo   Please ensure your editor is installed with CLI tools enabled
    pause
    exit /b 1
)

echo.
echo Checking Nuxt configuration...

REM Check if nuxt.config.ts exists
if exist "nuxt.config.ts" (
    echo ✓ nuxt.config.ts exists
    
    REM Check for devtools configuration
    findstr /C:"devtools:" nuxt.config.ts >nul 2>&1
    if %errorlevel% equ 0 (
        echo ✓ DevTools configuration found
        
        findstr /C:"enabled: true" nuxt.config.ts >nul 2>&1
        if %errorlevel% equ 0 (
            echo ✓ DevTools is enabled
        ) else (
            echo ✗ DevTools is not enabled
        )
        
        findstr /C:"vscode:" nuxt.config.ts >nul 2>&1
        if %errorlevel% equ 0 (
            echo ✓ VS Code integration configured
        ) else (
            echo ✗ VS Code integration not configured
        )
    ) else (
        echo ✗ DevTools configuration not found
    )
    
    REM Check for sourcemap configuration
    findstr /C:"sourcemap:" nuxt.config.ts >nul 2>&1
    if %errorlevel% equ 0 (
        echo ✓ Sourcemap configuration found
        
        findstr /C:"server: true" nuxt.config.ts >nul 2>&1
        if %errorlevel% equ 0 (
            findstr /C:"client: true" nuxt.config.ts >nul 2>&1
            if %errorlevel% equ 0 (
                echo ✓ Sourcemaps enabled for both client and server
            ) else (
                echo ✗ Sourcemaps not properly configured
            )
        ) else (
            echo ✗ Sourcemaps not properly configured
        )
    ) else (
        echo ✗ Sourcemap configuration not found
    )
) else (
    echo ✗ nuxt.config.ts not found
    echo   Make sure you're running this from the project root
    pause
    exit /b 1
)

echo.
echo ========================================
echo Verification Complete!
echo ========================================
echo.

REM Check if dev server is running (basic check)
tasklist /FI "IMAGENAME eq node.exe" 2>NUL | find /I /N "node.exe" >NUL
if %errorlevel% equ 0 (
    echo ✓ Node.js processes are running
    echo   You can test the 'go to code' feature in Nuxt DevTools
) else (
    echo ℹ No Node.js processes detected
    echo   Start your dev server with: npm run dev
)

echo.
echo To test the configuration:
echo 1. Start your Nuxt dev server: npm run dev
echo 2. Open your app in the browser
echo 3. Open Nuxt DevTools (floating button)
echo 4. Navigate to Components or Pages tab
echo 5. Click the 'go to code' button next to any component/page
echo 6. Verify that %LAUNCH_EDITOR% opens with the correct file
echo.

pause
