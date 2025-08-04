# Nushell Configuration with Bash Compatibility Aliases for Windows 11
# Based on official Nushell documentation: https://www.nushell.sh/book/

# Basic configuration
$env.config = {
    show_banner: false
}

# ============================================================================
# FILE AND DIRECTORY OPERATIONS
# ============================================================================

# Common ls aliases
alias ll = ls -l
alias la = ls -la
alias l = ls -la
alias lh = ls -la
def lt [] { ls -l | sort-by modified }
def ltr [] { ls -l | sort-by modified | reverse }
def lsd [] { ls | where type == dir }
def lsf [] { ls | where type == file }

# Directory navigation shortcuts
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..
alias ..... = cd ../../../..

# Directory operations
alias md = mkdir
alias rd = rmdir

# File operations
alias cp = cp
alias mv = mv
alias rm = rm
alias ln = ln

# ============================================================================
# TEXT PROCESSING COMMANDS
# ============================================================================

# Grep equivalents
def grep [pattern: string, ...files: string] {
    if ($files | is-empty) {
        $in | lines | where ($it | str contains $pattern)
    } else {
        $files | each { |file|
            open $file | lines | where ($it | str contains $pattern) | each { |line| $"($file):($line)" }
        } | flatten
    }
}

def grepi [pattern: string, ...files: string] {
    if ($files | is-empty) {
        $in | lines | where ($it | str downcase | str contains ($pattern | str downcase))
    } else {
        $files | each { |file|
            open $file | lines | where ($it | str downcase | str contains ($pattern | str downcase)) | each { |line| $"($file):($line)" }
        } | flatten
    }
}

# Head and tail equivalents
def head [n: int = 10] { $in | first $n }
def tail [n: int = 10] { $in | last $n }

# Wc equivalent
def wc [] {
    let content = $in
    let lines = ($content | lines | length)
    let words = ($content | str replace -a '\n' ' ' | split words | length)
    let chars = ($content | str length)
    {lines: $lines, words: $words, chars: $chars}
}

# Sort equivalents
# Built-in sort command available
def sort-reverse [] { $in | sort | reverse }
def sort-numeric [] { $in | sort-by {|x| $x | into int} }

# Uniq equivalent
def uniq [] { $in | uniq }

# Cut equivalent
def cut [delimiter: string, field: int] {
    $in | lines | each { |line| $line | split row $delimiter | get ($field - 1) }
}

# ============================================================================
# SYSTEM MONITORING AND PROCESS MANAGEMENT
# ============================================================================

# Process management
alias ps = ps
def psg [pattern: string] { ps | where name =~ $pattern }
def psk [pattern: string] { ps | where name =~ $pattern | each { |proc| kill $proc.pid } }

# System information (Windows compatible)
def free [] { sys mem }
def uptime [] { sys | get uptime }
def whoami [] { $env.USERNAME }

# Process monitoring (Windows compatible)
# Use Task Manager: taskmgr
# Use PowerShell: Get-Process
def top [] { ps | sort-by cpu | reverse }

# ============================================================================
# NETWORK UTILITIES
# ============================================================================

# Network commands (Windows compatible)
alias ping = ^ping
# Note: wget, curl available via winget or chocolatey
# alias curl = ^curl
# SSH available in Windows 10/11
# alias ssh = ^ssh

# ============================================================================
# ARCHIVE AND COMPRESSION
# ============================================================================

# Archive operations (Windows compatible)
# Use built-in Compress-Archive / Expand-Archive
def zip [source: string, dest: string] { ^powershell -Command $"Compress-Archive '($source)' '($dest)'" }
def unzip [source: string, dest?: string] {
    let destination = if ($dest | is-empty) { "." } else { $dest }
    ^powershell -Command $"Expand-Archive '($source)' '($destination)'"
}

# ============================================================================
# GIT WORKFLOW ALIASES
# ============================================================================

# Git shortcuts
alias g = git
alias gs = git status
alias gst = git status -sb
alias ga = git add
alias gaa = git add -A
alias gc = git commit
alias gcm = git commit -m
alias gco = git checkout
alias gb = git branch
alias gba = git branch -a
alias gd = git diff
alias gds = git diff --staged
alias gl = git log --oneline
alias gll = git log --oneline --graph --all
alias gp = git push
alias gpu = git push -u origin
alias gpl = git pull
alias gf = git fetch
alias gr = git remote -v
alias grs = git reset
alias grh = git reset --hard

# ============================================================================
# ENVIRONMENT AND SHELL CONFIGURATION
# ============================================================================

# Environment shortcuts
def env [] { $env | table }
def setenv [name: string, value: string] { $env | upsert $name $value }
def unsetenv [name: string] { hide-env $name }

# Path operations
def path-add [path: string] {
    $env.PATH = ($env.PATH | prepend $path)
}

def path-show [] {
    $env.PATH | each { |p| echo $p }
}

# ============================================================================
# HISTORY AND NAVIGATION
# ============================================================================

# History shortcuts
alias h = history
def hg [pattern: string] { history | where command =~ $pattern }

# Quick navigation (Windows compatible)
def home [] { cd $env.USERPROFILE }
def root [] { cd C:\ }

# ============================================================================
# EXTERNAL COMMANDS INTEGRATION
# ============================================================================

# Git Bash integration for Windows
$env.PATH = ($env.PATH | prepend 'C:\Program Files\Git\bin')

# Text editors (Windows compatible)
# Note: Install via winget, chocolatey, or use built-in editors
# alias vim = ^vim
# alias nano = ^nano
alias notepad = ^notepad
alias more = ^more
# Use Get-Help instead of man
def man [cmd: string] { help $cmd }

# ============================================================================
# BASH-STYLE SHORTCUTS AND ALIASES
# ============================================================================

# Common bash shortcuts
alias c = clear
alias q = exit
alias x = exit

# File viewing
alias cat = open
def more-file [file: string] { open $file | lines | each { |line| print $line } }

# Quick editing
def edit [file: string] { ^$env.EDITOR $file }

# Disk usage shortcuts
def dus [] { du | sort-by size | reverse }
def dush [] { du --max-depth 0 }

# Find equivalents
def find-name [pattern: string] { ls **/* | where name =~ $pattern }
def find-type [type: string] { ls **/* | where type == $type }

# Windows doesn't use chmod - files are executable by extension
# def chmod-x [file: string] { echo "Windows uses file extensions for execution" }

# ============================================================================
# BASH WORKFLOW COMPATIBILITY
# ============================================================================

# Common bash patterns
def ll-grep [pattern: string] { ls -l | where name =~ $pattern }
def ps-grep [pattern: string] { ps | where name =~ $pattern }

# Pipe to less (Windows: more)
def to-less [] { $in | ^more }

# Count lines/files
def count-lines [] { $in | lines | length }
def count-files [] { ls | length }

# ============================================================================
# ADDITIONAL BASH-STYLE FUNCTIONS
# ============================================================================

# Which command
alias which = which

# Locate files
def locate [pattern: string] { ls **/* | where name =~ $pattern | get name }

# Tree view (available in Windows)
alias tree = ^tree

# Disk space (Windows compatible)
def disk-free [] {
    ^wmic logicaldisk get size,freespace,caption
}

# Memory info
def mem-info [] { sys | get mem }

# CPU info
def cpu-info [] { sys | get cpu }

# Load averages
def load-avg [] { sys | get load_avg }

# ============================================================================
# BASH-STYLE COMPLETION AND SHORTCUTS
# ============================================================================

# Quick directory changes for common locations (Windows)
def desktop [] { cd $env.USERPROFILE/Desktop }
def downloads [] { cd $env.USERPROFILE/Downloads }
def documents [] { cd $env.USERPROFILE/Documents }

# Quick config access
def config-nu [] { ^$env.EDITOR $nu.config-path }
# To reload config, restart Nushell or run: nu
def restart-nu [] {
    print "🔄 To reload config, please restart Nushell or run 'nu' command"
}

# ============================================================================
# ADVANCED BASH COMPATIBILITY
# ============================================================================

# Bash-style command substitution helpers
def cmd-output [cmd: string] { nu -c $cmd }

# File test equivalents
def file-exists [path: string] { $path | path exists }
def dir-exists [path: string] {
    ($path | path exists) and (($path | path type) == "dir")
}
def file-readable [path: string] { try { open $path; true } catch { false } }

# Date and time
# Built-in date command already exists
def timestamp [] { date now | format date "%Y-%m-%d %H:%M:%S" }

# Calendar (Windows compatible)
# Use built-in PowerShell Get-Date
def cal [] { ^powershell -Command "Get-Date" }

# Calculator
def calc [expr: string] { nu -c $"math eval \"($expr)\"" }

# Weather (requires curl - install via winget)
# def weather [city?: string] {
#     let location = if ($city | is-empty) { "" } else { $city }
#     ^curl -s $"wttr.in/($location)"
# }

# System cleanup helpers (Windows compatible)
def clean-temp [] {
    let temp_dir = $env.TEMP
    if ($temp_dir | path exists) {
        ls $temp_dir | each { |item| rm -rf $item.name }
    }
}
def clean-logs [] {
    let logs_dir = ($env.USERPROFILE | path join "AppData" "Local" "Temp")
    if ($logs_dir | path exists) {
        ls $logs_dir | each { |item| rm -rf $item.name }
    }
}

# Process helpers (Windows compatible)
def kill-by-name [name: string] { ps | where name =~ $name | each { |p| kill $p.pid } }
def kill-by-port [port: int] {
    ^netstat -ano | lines | where ($it | str contains $":($port) ") | each { |line|
        let pid = ($line | str trim | split row " " | last)
        if ($pid != "PID") { kill ($pid | into int) }
    }
}

# ============================================================================
# FINAL CONFIGURATION
# ============================================================================

# Source additional configuration files if they exist
# if ($env.USERPROFILE | path join ".nushell" "extra.nu" | path exists) {
#     source ($env.USERPROFILE | path join ".nushell" "extra.nu")
# }

print "🐚 Nushell with Bash compatibility loaded!"
print "💡 Use 'help aliases' to see all available aliases"
print "📖 Documentation: https://www.nushell.sh/book/"
