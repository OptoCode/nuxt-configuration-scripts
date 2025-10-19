#!/bin/bash
# Nuxt DevTools Configuration Verification Script
# This script verifies that the LAUNCH_EDITOR is properly configured
# how to run: ./scripts/nuxt-dev-tools/verify-nuxt-devtools-config.sh

echo "========================================"
echo "Nuxt DevTools Configuration Verification"
echo "========================================"
echo

# Check if LAUNCH_EDITOR is set
if [[ -n "$LAUNCH_EDITOR" ]]; then
    echo "✓ LAUNCH_EDITOR is set to: $LAUNCH_EDITOR"
else
    echo "✗ LAUNCH_EDITOR is not set"
    echo "  Run the setup script first: ./scripts/setup-nuxt-devtools-editor.sh"
    exit 1
fi

# Check if the editor command is available
echo "Checking if $LAUNCH_EDITOR CLI is available..."
if command -v "$LAUNCH_EDITOR" &> /dev/null; then
    echo "✓ $LAUNCH_EDITOR CLI is available"
    
    # Try to get version
    version_output=$("$LAUNCH_EDITOR" --version 2>/dev/null)
    if [[ $? -eq 0 ]]; then
        echo "  Version: $version_output"
    else
        echo "  (version check failed, but command exists)"
    fi
else
    echo "✗ $LAUNCH_EDITOR command not found in PATH"
    echo "  Please ensure your editor is installed with CLI tools enabled"
    exit 1
fi

echo
echo "Checking Nuxt configuration..."

# Check if nuxt.config.ts exists and has the right configuration
if [[ -f "nuxt.config.ts" ]]; then
    echo "✓ nuxt.config.ts exists"
    
    # Check for devtools configuration
    if grep -q "devtools:" nuxt.config.ts; then
        echo "✓ DevTools configuration found"
        
        if grep -q "enabled: true" nuxt.config.ts; then
            echo "✓ DevTools is enabled"
        else
            echo "✗ DevTools is not enabled"
        fi
        
        if grep -q "vscode:" nuxt.config.ts; then
            echo "✓ VS Code integration configured"
        else
            echo "✗ VS Code integration not configured"
        fi
    else
        echo "✗ DevTools configuration not found"
    fi
    
    # Check for sourcemap configuration
    if grep -q "sourcemap:" nuxt.config.ts; then
        echo "✓ Sourcemap configuration found"
        
        if grep -q "server: true" nuxt.config.ts && grep -q "client: true" nuxt.config.ts; then
            echo "✓ Sourcemaps enabled for both client and server"
        else
            echo "✗ Sourcemaps not properly configured"
        fi
    else
        echo "✗ Sourcemap configuration not found"
    fi
else
    echo "✗ nuxt.config.ts not found"
    echo "  Make sure you're running this from the project root"
    exit 1
fi

echo
echo "========================================"
echo "Verification Complete!"
echo "========================================"
echo

# Check if dev server is running
if pgrep -f "nuxt dev" > /dev/null; then
    echo "✓ Nuxt dev server appears to be running"
    echo "  You can test the 'go to code' feature in Nuxt DevTools"
else
    echo "ℹ Nuxt dev server is not running"
    echo "  Start it with: npm run dev"
fi

echo
echo "To test the configuration:"
echo "1. Start your Nuxt dev server: npm run dev"
echo "2. Open your app in the browser"
echo "3. Open Nuxt DevTools (floating button)"
echo "4. Navigate to Components or Pages tab"
echo "5. Click the 'go to code' button next to any component/page"
echo "6. Verify that $LAUNCH_EDITOR opens with the correct file"
echo
