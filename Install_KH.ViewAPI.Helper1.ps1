#Install Script 1
$HOST.UI.RawUI.BackgroundColor = 0
$HOST.UI.RawUI.ForegroundColor = 10

Clear-Host
Write-Host 'Installing KH.ViewAPI.Helper.....'

#Setting Variables
$DeployFolderName = "KH.ViewAPI.Helper_1.0"
$TempPath = "C:\Temp"
$KHViewAPIPath = "C:\Temp\KH.ViewAPI.Helper"
$KHViewAPIModuleSource = "\\DTCFP03-VM\Global\Shortcuts\Application Installs\PsSupportFiles\Modules\$DeployFolderName\KH.ViewAPI.Helper"
$AllUsersDesktop = "C:\Users\Public\Desktop"
$KHViewPsPowerCLISource = "\\DTCFP03-VM\Global\Shortcuts\Application Installs\PsSupportFiles\Modules\$DeployFolderName\KH.ViewAPI.Helper\SupportFiles\_Install\KH.ViewAPI.Helper PowerCLI.lnk"
$KHViewPsPowerCLIUninstallSource = "\\DTCFP03-VM\Global\Shortcuts\Application Installs\PsSupportFiles\Modules\$DeployFolderName\KH.ViewAPI.Helper\SupportFiles\_Install\_UnInstall_KH.ViewAPI.Helper.bat"

#Checking Paths
if (test-path -Path $TempPath) { }
else { New-Item $TempPath -ItemType directory -force | Out-Null }
if (test-path -Path $KHViewAPIPath) { }
else { Copy-Item $KHViewAPIModuleSource -Destination $TempPath -Recurse | Out-Null }
if (test-path -Path "$TempPath\_UnInstall_KH.ViewAPI.Helper.bat") { }
else { Copy-Item $KHViewPsPowerCLIUninstallSource -Destination $TempPath -Recurse | Out-Null }
if (Test-Path -Path "$AllUsersDesktop\KH.ViewAPI.Helper PowerCLI.lnk") { }
else { Copy-Item $KHViewPsPowerCLISource -Destination $AllUsersDesktop -Recurse | Out-Null }

Try
{
	Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser -Force -WarningAction SilentlyContinue -ErrorAction Stop
} #End Try
Catch
{
	# Silently Continue
} #End Catch

Try
{
	Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Scope CurrentUser -Force -Confirm:$false -WarningAction SilentlyContinue -ErrorAction Stop | Out-Null
} #end Try
Catch
{
	Write-Warning 'There was a problem installing the NuGet Package Provider'
	Start-Sleep 3
} #End Catch

Try
{
	Install-PackageProvider -Name PowerShellGet -MinimumVersion 1.1.3.1 -Scope AllUsers -Force -Confirm:$false -WarningAction SilentlyContinue -ErrorAction Stop | Out-Null
} #end Try
Catch
{
	Write-Warning 'There was a problem installing the PowerShellGet Package Provider'
	Start-Sleep 3
} #End Catch

Try
{
	Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -WarningAction SilentlyContinue -ErrorAction Stop
} #End Try
Catch
{
	Write-Warning 'There was a problem setting the PSRepository PSGallery'
} #End Catch

Try
{
	Update-Help -Force -Confirm:$False -WarningAction SilentlyContinue -ErrorAction Stop | Out-Null
} #End Try
Catch
{
	# Silently Continue
} #End Catch

#Exit Script

EXIT