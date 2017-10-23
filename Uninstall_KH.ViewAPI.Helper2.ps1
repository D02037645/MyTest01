# Uninstall Script 2

$HOST.UI.RawUI.BackgroundColor = 0
$HOST.UI.RawUI.ForegroundColor = 10

#Uninstall Modules
get-module -listAvailable vmware* | Uninstall-Module -Force -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
get-module -listAvailable PowerShellCookbook | Uninstall-Module -Force -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
get-module -listAvailable Pscx | Uninstall-Module -Force -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

Write-Host 'Completed UnInstall!'
Start-Sleep 5
Write-Host ''

#Exit Script
EXIT