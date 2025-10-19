#!/bin/bash
# Nuxt DevTools Editor Configuration Script for Unix/Linux/Git Bash
# This script sets up the LAUNCH_EDITOR environment variable for Nuxt DevTools
# how to run: ./scripts/nuxt-dev-tools/setup-nuxt-devtools-editor.sh
#
# Shell Configuration File Detection Logic:
# This script intelligently detects which shell configuration file to use:
#
# 1. Zsh users: Uses ~/.zshrc
# 2. Bash users: Checks for existing config files in this order:
#    - ~/.bashrc (preferred - most common on Linux)
#    - ~/.bash_profile (fallback - common on macOS and some Linux setups)
#    - Defaults to ~/.bashrc if neither exists
#
# Why check .bash_profile?
# - macOS: Often uses .bash_profile instead of .bashrc for login shells
# - Different shell types: .bashrc for interactive non-login, .bash_profile for login shells
# - System variations: Some Linux distributions use .bash_profile as primary config
# - Robustness: Ensures script works across different Unix-like environments

echo "========================================"
echo "Nuxt DevTools Editor Configuration"
echo "========================================"
echo

echo "Available editors:"
echo "1. Cursor"
echo "2. Visual Studio Code"
echo "3. Windsurf"
echo

read -p "Select your editor (1-3): " choice

case $choice in
    1)
        editor_name="Cursor"
        editor_command="cursor"
        ;;
    2)
        editor_name="Visual Studio Code"
        editor_command="code"
        ;;
    3)
        editor_name="Windsurf"
        editor_command="windsurf"
        ;;
    *)
        echo "Invalid choice. Exiting..."
        exit 1
        ;;
esac

echo
echo "Configuring for $editor_name..."
echo

# Check if the editor CLI is available
echo "Checking if $editor_command CLI is available..."
if command -v "$editor_command" &> /dev/null; then
    echo "✓ $editor_command CLI is available"
    "$editor_command" --version 2>/dev/null || echo "  (version check failed, but command exists)"
else
    echo "WARNING: $editor_command command not found in PATH"
    echo "Please ensure $editor_name is installed with CLI tools enabled"
    echo
    read -p "Continue anyway? (y/n): " continue
    if [[ ! "$continue" =~ ^[Yy]$ ]]; then
        echo "Configuration cancelled."
        exit 1
    fi
fi

echo
echo "Setting LAUNCH_EDITOR environment variable..."

# Determine the appropriate shell config file
if [[ "$SHELL" == *"zsh"* ]]; then
    config_file="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then
    if [[ -f "$HOME/.bashrc" ]]; then
        config_file="$HOME/.bashrc"
    elif [[ -f "$HOME/.bash_profile" ]]; then
        config_file="$HOME/.bash_profile"
    else
        config_file="$HOME/.bashrc"
    fi
else
    config_file="$HOME/.bashrc"
fi

# Set for current session
export LAUNCH_EDITOR="$editor_command"
echo "✓ Set LAUNCH_EDITOR=$editor_command for current session"

# Add to shell config file
if [[ -f "$config_file" ]]; then
    # Check if LAUNCH_EDITOR is already set
    if grep -q "LAUNCH_EDITOR" "$config_file"; then
        echo "Updating existing LAUNCH_EDITOR setting in $config_file..."
        # Remove existing LAUNCH_EDITOR lines
        sed -i.bak '/LAUNCH_EDITOR/d' "$config_file"
    else
        echo "Adding LAUNCH_EDITOR setting to $config_file..."
    fi
    
    # Add new setting
    echo "" >> "$config_file"
    echo "# Nuxt DevTools Editor Configuration" >> "$config_file"
    echo "export LAUNCH_EDITOR=\"$editor_command\"" >> "$config_file"
    echo "✓ Added LAUNCH_EDITOR=$editor_command to $config_file"
else
    echo "Creating $config_file..."
    echo "# Nuxt DevTools Editor Configuration" > "$config_file"
    echo "export LAUNCH_EDITOR=\"$editor_command\"" >> "$config_file"
    echo "✓ Created $config_file with LAUNCH_EDITOR=$editor_command"
fi

echo
echo "========================================"
echo "Configuration Complete!"
echo "========================================"
echo
echo "Next steps:"
echo "1. Restart your terminal or run: source $config_file"
echo "2. Restart your Nuxt dev server: npm run dev"
echo "3. Test the 'go to code' feature in Nuxt DevTools"
echo
echo "Current LAUNCH_EDITOR: $LAUNCH_EDITOR"
echo "Config file: $config_file"
echo

# Offer to source the config file now
read -p "Source the config file now? (y/n): " source_now
if [[ "$source_now" =~ ^[Yy]$ ]]; then
    source "$config_file"
    echo "✓ Config file sourced. LAUNCH_EDITOR is now active."
fi
