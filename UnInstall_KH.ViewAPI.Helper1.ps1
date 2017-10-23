# Uninstall Script 1
$KHViewAPIModuleDir = "C:\Temp\KH.ViewAPI.Helper"
$AllUsersDesktop = "C:\Users\Public\Desktop"

if (test-path -Path $KHViewAPIModuleDir) { Remove-Item $KHViewAPIModuleDir -Force -Recurse }
if (test-path -Path "$AllUsersDesktop\KH.ViewAPI.Helper PowerCLI.lnk") { Remove-Item "$AllUsersDesktop\KH.ViewAPI.Helper PowerCLI.lnk" -Force -Recurse }

$HOST.UI.RawUI.BackgroundColor = 0
$HOST.UI.RawUI.ForegroundColor = 10

Clear-Host
Write-Host ''
Write-Host 'UnInstalling......'
Write-Host ''

#Uninstall Modules
get-module -listAvailable vmware* | Uninstall-Module -Force -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
get-module -listAvailable PowerShellCookbook | Uninstall-Module -Force -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
get-module -listAvailable Pscx | Uninstall-Module -Force -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
#Exit Script
EXIT