# Nuxt DevTools Editor Configuration Scripts

This directory contains automated scripts to configure Nuxt DevTools to work seamlessly with your preferred code editor. These scripts ensure that the "Toggle Component Inspector" feature in Nuxt DevTools opens files directly in your editor.

## 🚀 Quick Start

### Windows Users

**Option 1: Batch File (Command Prompt)**

```cmd
scripts\nuxt-dev-tools\setup-nuxt-devtools-editor.bat
```

**Option 2: PowerShell**

```powershell
.\scripts\nuxt-dev-tools\setup-nuxt-devtools-editor.ps1
```

### Unix/Linux/Git Bash Users

```bash
./scripts/nuxt-dev-tools/setup-nuxt-devtools-editor.sh
```

## ✨ What These Scripts Do

1. **🎯 Interactive Editor Selection**: Choose from Cursor, VS Code, or Windsurf
2. **🔍 CLI Verification**: Check if your editor's command-line tools are installed
3. **⚙️ Environment Variable Setup**: Configure `LAUNCH_EDITOR` for your chosen editor
4. **💾 Persistent Configuration**: Save settings to your shell profile (Unix) or user environment variables (Windows)
5. **✅ Verification**: Confirm everything is working correctly

## 🛠️ Supported Editors

| Editor       | Command    | Description                         | CLI Setup Required |
| ------------ | ---------- | ----------------------------------- | ------------------ |
| **Cursor**   | `cursor`   | AI-powered code editor              | Usually automatic  |
| **VS Code**  | `code`     | Microsoft's popular editor          | Manual setup       |
| **Windsurf** | `windsurf` | AI-enhanced development environment | Check docs         |

## 🔍 Verification Scripts

After running the setup script, verify your configuration:

### Windows

```cmd
scripts\nuxt-dev-tools\verify-nuxt-devtools-config.bat
```

### Unix/Linux/Git Bash

```bash
./scripts/nuxt-dev-tools/verify-nuxt-devtools-config.sh
```

## ⚙️ Manual Configuration (Alternative)

If you prefer to configure manually:

### Windows (Command Prompt)

```cmd
setx LAUNCH_EDITOR "cursor"
```

### Windows (PowerShell)

```powershell
[Environment]::SetEnvironmentVariable("LAUNCH_EDITOR", "cursor", "User")
```

### Unix/Linux/Git Bash

```bash
echo 'export LAUNCH_EDITOR="cursor"' >> ~/.bashrc
source ~/.bashrc
```

## 📋 Prerequisites

Before running the setup scripts, ensure:

- **Nuxt DevTools is enabled** in your `nuxt.config.ts`:

  ```typescript
  export default defineNuxtConfig({
    devtools: { enabled: true },
  });
  ```

- **Sourcemaps are completely optional** and not required for the "Toggle Component Inspector" feature to work. However, enabling sourcemaps can improve your overall debugging experience:

  ```typescript
  export default defineNuxtConfig({
    sourcemap: {
      server: true,
      client: true,
    },
  });
  ```

- **Development server is running**: `npm run dev`

## 🐛 Troubleshooting

### Editor CLI Not Found

**Cursor:**

- Usually installed automatically
- Check Cursor settings for CLI tools
- Verify installation: `cursor --version`

**VS Code:**

- Install via Command Palette: `Ctrl+Shift+P` → "Shell Command: Install 'code' command in PATH"
- Verify installation: `code --version`

**Windsurf:**

- Check Windsurf documentation for CLI setup
- Verify installation: `windsurf --version`

### Environment Variable Not Working

1. **Restart your terminal** after running the setup script
2. **Verify the variable**:
   - Windows: `echo %LAUNCH_EDITOR%`
   - Unix: `echo $LAUNCH_EDITOR`
3. **Check persistence**: Close and reopen your terminal
4. **Test manually**: Try `cursor .` or `code .` in your project directory

### DevTools "Toggle Component Inspector" Not Working

1. **Verify configuration**: Run the verification script
2. **Check sourcemaps**: Ensure they're enabled in `nuxt.config.ts`
3. **Restart dev server**: `npm run dev`
4. **Test in browser**: Open Nuxt DevTools and try the "Toggle Component Inspector" feature
5. **Check browser console**: Look for any error messages
6. **Verify file paths**: Ensure the file exists and is accessible

### Common Issues

**Issue**: "Command not found" errors

- **Solution**: Ensure your editor's CLI tools are properly installed and in your PATH

**Issue**: Environment variable not persisting

- **Solution**: Check your shell configuration file (`.bashrc`, `.zshrc`, etc.) and ensure it's being sourced

**Issue**: DevTools opens wrong file or doesn't open anything

- **Solution**: Verify sourcemaps are enabled and restart the development server

## 📁 File Structure

```
scripts/nuxt-dev-tools/
├── README.md                           # This documentation
├── setup-nuxt-devtools-editor.bat      # Windows batch setup
├── setup-nuxt-devtools-editor.ps1      # PowerShell setup
├── setup-nuxt-devtools-editor.sh       # Unix/Linux/Git Bash setup
├── verify-nuxt-devtools-config.bat     # Windows verification
└── verify-nuxt-devtools-config.sh      # Unix/Linux/Git Bash verification
```

## 🎯 Next Steps

After running the setup script:

1. **Restart your terminal**
2. **Start your Nuxt dev server**: `npm run dev`
3. **Open your app in the browser**
4. **Open Nuxt DevTools** (floating button in bottom-right)
5. **Navigate to Components or Pages tab**
6. **Click "Toggle Component Inspector"** next to any component/page
7. **Verify your editor opens** with the correct file

## 🔄 Switching Editors

To switch to a different editor, simply run the setup script again and select a different option. The script will update your configuration automatically.

## 📚 Additional Resources

- **Nuxt DevTools Documentation**: [Official Nuxt DevTools Guide](https://devtools.nuxt.com/)
- **Project Documentation**: See `docs/nuxt-dev-tools.md` for additional troubleshooting information
- **Nuxt 4 Template**: This project uses Nuxt 4.1.3 with Vuetify 3 and Firebase integration

## ✅ Compatibility

- **Nuxt Version**: 4.1.3+
- **DevTools**: Latest version (included with Nuxt 4)
- **Editors**: Cursor, VS Code, Windsurf
- **Platforms**: Windows, macOS, Linux
- **Shells**: Command Prompt, PowerShell, Git Bash, Zsh, Bash

## 📝 Important Notes

- The `nuxt.config.ts` configuration works for all editors
- Only the `LAUNCH_EDITOR` environment variable needs to change when switching editors
- Sourcemaps are essential for the "Toggle Component Inspector" feature to work properly
- This configuration works with Nuxt 4.1.3 and the latest DevTools
- Make sure your development server is running before testing the "Toggle Component Inspector" feature
