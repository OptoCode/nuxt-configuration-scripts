# Nuxt DevTools Editor Configuration Script for PowerShell
# This script sets up the LAUNCH_EDITOR environment variable for Nuxt DevTools
# how to run: .\scripts\nuxt-dev-tools\setup-nuxt-devtools-editor.ps1

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Nuxt DevTools Editor Configuration" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Available editors:" -ForegroundColor Yellow
Write-Host "1. Cursor" -ForegroundColor White
Write-Host "2. Visual Studio Code" -ForegroundColor White
Write-Host "3. Windsurf" -ForegroundColor White
Write-Host ""

$choice = Read-Host "Select your editor (1-3)"

switch ($choice) {
    "1" {
        $editor_name = "Cursor"
        $editor_command = "cursor"
    }
    "2" {
        $editor_name = "Visual Studio Code"
        $editor_command = "code"
    }
    "3" {
        $editor_name = "Windsurf"
        $editor_command = "windsurf"
    }
    default {
        Write-Host "Invalid choice. Exiting..." -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "Configuring for $editor_name..." -ForegroundColor Green
Write-Host ""

# Check if the editor CLI is available
Write-Host "Checking if $editor_command CLI is available..." -ForegroundColor Yellow
try {
    $version = & $editor_command --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ $editor_command CLI is available" -ForegroundColor Green
    } else {
        throw "Command failed"
    }
} catch {
    Write-Host "WARNING: $editor_command command not found in PATH" -ForegroundColor Red
    Write-Host "Please ensure $editor_name is installed with CLI tools enabled" -ForegroundColor Yellow
    Write-Host ""
    $continue = Read-Host "Continue anyway? (y/n)"
    if ($continue -notmatch "^[Yy]$") {
        Write-Host "Configuration cancelled." -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "Setting LAUNCH_EDITOR environment variable..." -ForegroundColor Yellow

# Set for current session
$env:LAUNCH_EDITOR = $editor_command
Write-Host "✓ Set LAUNCH_EDITOR=$editor_command for current session" -ForegroundColor Green

# Add to user environment variables (persistent)
try {
    [Environment]::SetEnvironmentVariable("LAUNCH_EDITOR", $editor_command, "User")
    Write-Host "✓ Added LAUNCH_EDITOR=$editor_command to user environment variables" -ForegroundColor Green
} catch {
    Write-Host "WARNING: Could not set persistent environment variable" -ForegroundColor Red
    Write-Host "You may need to set it manually in System Properties" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Configuration Complete!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Restart your terminal/PowerShell session" -ForegroundColor White
Write-Host "2. Restart your Nuxt dev server: npm run dev" -ForegroundColor White
Write-Host "3. Test the 'go to code' feature in Nuxt DevTools" -ForegroundColor White
Write-Host ""
Write-Host "Current LAUNCH_EDITOR: $env:LAUNCH_EDITOR" -ForegroundColor Cyan
Write-Host ""

Read-Host "Press Enter to continue"
