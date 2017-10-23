#Install Script 2
$HOST.UI.RawUI.BackgroundColor = 0
$HOST.UI.RawUI.ForegroundColor = 10

Try
{
	Install-Module -Name VMware.PowerCLI –Scope CurrentUser -AllowClobber -Force -Confirm:$false -SkipPublisherCheck:$True -WarningAction SilentlyContinue -ErrorAction Stop | Out-Null
} #End Try
Catch
{
	Write-Warning 'There was a problem installing PowerCLI'
	Start-Sleep 3
} #End Catch

Try
{
	Install-Module -Name PowerShellCookbook –Scope CurrentUser -AllowClobber -Force -Confirm:$false -SkipPublisherCheck:$True -WarningAction SilentlyContinue -ErrorAction Stop | Out-Null
} #End Try
Catch
{
	Write-Warning 'There was a problem installing PowerShell Cookbook Module'
	Start-Sleep 3
} #End Catch

Try
{
	Install-Module -Name Pscx –Scope CurrentUser -AllowClobber -Force -Confirm:$false -SkipPublisherCheck:$True -WarningAction SilentlyContinue -ErrorAction Stop | Out-Null
} #End Try
Catch
{
	Write-Warning 'There was a problem installing Pscx'
	Start-Sleep 3
} #End Catch

Write-Host ''
Write-Host 'Completed Install!'
Write-Host 'Launch [KH.ViewAPI.Helper] from the [Desktop Shortcut]'
Start-Sleep 5

#Exit Script
EXIT