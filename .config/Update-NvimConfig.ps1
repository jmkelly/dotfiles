#syncs the current dotfiles nvim config on windows
$ErrorActionPreference = "Stop"

# Define paths
$currentConfigPath = "$HOME\AppData\Local\nvim"
$backupPath = "$HOME\AppData\Local\nvim_backup"
$dotfilesPath = "$HOME\Documents\code\dotfiles"
$newConfigSource = "$dotfilesPath\.config\nvim"

# Ensure the source directory exists
if (-Not (Test-Path -Path $newConfigSource)) {
    Write-Error "The source configuration path does not exist: $newConfigSource"
    exit 1
}

# Back up current configuration
if (Test-Path -Path $currentConfigPath) {
    Write-Host "Backing up current NeoVim configuration..."
    if (Test-Path -Path $backupPath) {
        Remove-Item -Recurse -Force -Path $backupPath
    }
    Rename-Item -Path $currentConfigPath -NewName $backupPath
    Write-Host "Backup completed: $backupPath"
} else {
    Write-Host "No existing configuration found. Creating a new configuration directory..."
    New-Item -ItemType Directory -Path $currentConfigPath | Out-Null
}

# Replace with new configuration
Write-Host "Replacing NeoVim configuration..."
Copy-Item -Recurse -Force -Path $newConfigSource -Destination $currentConfigPath

Write-Host "NeoVim configuration has been replaced successfully."

