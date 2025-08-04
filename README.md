# 100% Bash Commands for Windows without WSL/Git Bash (Nushell Aliases for Bash)

[![Nushell](https://img.shields.io/badge/Nushell-0.106+-blue.svg)](https://nushell.sh)
[![Windows](https://img.shields.io/badge/Windows-11-blue.svg)](https://www.microsoft.com/windows)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**The Problem**

Windows doesn't have native Bash without WSL or Git Bash installation. When you try modern shells like Nushell, you lose familiar Bash commands and have to relearn everything.

**The Solution**

This configuration bridges that gap! Get 100% Bash command compatibility in Nushell on Windows - no WSL, no Git Bash, no relearning required.

Use all your favorite Bash commands (`ll`, `grep`, `ps`, `kill`, `git shortcuts`) exactly as you would in Linux/macOS, but with the power and speed of modern Nushell shell.

Based on the official [Nushell migration guide from Bash](https://www.nushell.sh/book/coming_from_bash.html), this config provides complete command equivalents and familiar workflows for Windows users.

## 📦 Installation

1. **Install Nushell** (if not already installed):
   ```powershell
   winget install nushell
   ```
   or
   ```powershell
   choco install nushell
   ```

2. **Open Nushell config**:
   ```bash
   $env.config.buffer_editor = "C:/Windows/System32/notepad.exe"
   config nu
   ```

3. **Copy content** from `config.nu` in this repository and paste it into the opened config file!

4. **Save and restart** Nushell

## 🌟 Features

### 📁 **File Operations**
- `ll`, `la`, `l`, `lh` - Enhanced directory listings
- `lt`, `ltr` - Time-sorted file listings  
- `lsd`, `lsf` - Directory/file-only listings
- `..`, `...`, `....` - Quick navigation shortcuts

### 🔍 **Text Processing**
- `grep`, `grepi` - Pattern searching with case options
- `head`, `tail` - File content preview
- `wc` - Word/line/character counting
- `uniq`, `sort` - Data manipulation
- `cut` - Field extraction

### ⚙️ **System Management**
- `ps`, `psg`, `psk` - Process management
- `free`, `uptime`, `whoami` - System information
- `top` - Process monitoring
- `kill-by-name`, `kill-by-port` - Process termination

### 🔧 **Git Workflow**
- `g`, `gs`, `ga`, `gc`, `gco` - Git shortcuts
- `gd`, `gl`, `gp`, `gpl` - Diff, log, push/pull
- `gb`, `gba`, `gr` - Branch and remote management

### 🗃️ **Archive Operations**
- `zip`, `unzip` - Archive handling with PowerShell integration
- Windows-native compression support

### 🏠 **Quick Navigation**
- `home`, `desktop`, `downloads`, `documents` - Common locations
- `root` - Drive root access

## 📦 Installation

1. **Install Nushell** (if not already installed):
   ```powershell
   winget install nushell
   ```

2. **Open Nushell config**:
   ```bash
   $env.config.buffer_editor = "C:/Windows/System32/notepad.exe"
   config nu
   ```

3. **Copy content** from `nushell/config.nu` in this repository and paste it into the opened config file

4. **Save and restart** Nushell

## 💡 Usage Examples

```bash
# File operations
ll                    # detailed file listing
la                    # all files including hidden
...                   # navigate up directories

# Text processing  
grep "error" log.txt  # search patterns
head 20               # first 20 lines
tail 10               # last 10 lines

# Git workflow
gs                    # git status
ga .                  # git add all
gcm "message"         # git commit with message

# System info
free                  # memory information
whoami                # current user
ps                    # list processes
```

## 📋 Available Commands

**File Operations:** `ll`, `la`, `l`, `lt`, `ltr`, `lsd`, `lsf`, `..`, `...`, `....`

**Git Shortcuts:** `g`, `gs`, `ga`, `gc`, `gcm`, `gco`, `gb`, `gd`, `gl`, `gp`, `gpl`

**System Commands:** `free`, `uptime`, `whoami`, `top`, `ps`, `psg`, `kill-by-name`

**Text Processing:** `grep`, `grepi`, `head`, `tail`, `wc`, `uniq`, `cut`

**Navigation:** `home`, `desktop`, `downloads`, `documents`, `root`

## 🔧 Requirements

- **Nushell** 0.106.1 or later
- **Windows** 11 (tested, may work on Windows 10)

## 📝 License

MIT License
