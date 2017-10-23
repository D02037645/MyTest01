<#	
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2017 v5.4.140
	 Created on:   	6/23/2017 11:56 AM
	 Created by:   	admin.vaughan
	 Organization: 	
	 Filename:     	KH.ViewAPI.Helper.psm1
	-------------------------------------------------------------------------
	 Module Name: KH.ViewAPI.Helper
	===========================================================================
#>

function Start-KHPool
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $true)]
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[ValidateNotNullOrEmpty()]
		[String[]]$Pool_Id
	) #End Param
	begin
	{
		# Silently Continue
	} #End Begin
	Process
	{
		Try
		{
			foreach ($POOL in $Pool_ID)
			{
				Set-PoolState -Pool_Id $POOL -Action 'Start'
				Start-Sleep 5
				$PoolStatus = (Get-KHPool -Pool_Id $global:Pool_Id).DesktopSettings.Enabled
				$ProvStatus = (Get-KHPool -Pool_Id $global:Pool_Id).automatedDesktopData.virtualCenterProvisioningSettings.enableProvisioning
				Write-Host "[$POOL] Pool Enabled? $PoolStatus"
				Write-Host "[$POOL] Provisioning Enabled? $ProvStatus"
			} #End ForEach
		} #End Try
		Catch
		{
			Write-Warning "There was a problem setting the pool state on pool: $global:Pool_Id"
		} #End Catch
	} #End Process
	End
	{
		# Silently Continue
	} #End End
} #End Start-KHPool Function

function Stop-KHPool
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $true)]
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[ValidateNotNullOrEmpty()]
		[String[]]$Pool_Id
	) #End Param
	begin
	{
		# Silently Continue
	} #End Begin
	Process
	{
		Try
		{
			foreach ($POOL in $Pool_ID)
			{
				Set-PoolState -Pool_Id $POOL -Action 'Stop'
				Start-Sleep 5
				$PoolStatus = (Get-KHPool -Pool_Id $global:Pool_Id).DesktopSettings.Enabled
				$ProvStatus = (Get-KHPool -Pool_Id $global:Pool_Id).automatedDesktopData.virtualCenterProvisioningSettings.enableProvisioning
				Write-Host "[$POOL] Pool Enabled? $PoolStatus"
				Write-Host "[$POOL] Provisioning Enabled? $ProvStatus"
			} #End ForEach
		} #End Try
		Catch
		{
			Write-Warning "There was a problem setting the pool state on pool: $global:Pool_Id"
		} #End Catch
	} #End Process
	End
	{
		# Silently Continue
	} #End End
} #End Stop-KHPool Function

function Disable-KHPool
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $true)]
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[ValidateNotNullOrEmpty()]
		[String[]]$Pool_Id
	) #End Param
	begin
	{
		# Silently Continue
	} #End Begin
	Process
	{
		Try
		{
			foreach ($POOL in $Pool_ID)
			{
				Set-PoolState -Pool_Id $POOL -Action 'Disable'
				Start-Sleep 5
				$PoolStatus = (Get-KHPool -Pool_Id $global:Pool_Id).DesktopSettings.Enabled
				$ProvStatus = (Get-KHPool -Pool_Id $global:Pool_Id).automatedDesktopData.virtualCenterProvisioningSettings.enableProvisioning
				Write-Host "[$POOL] Pool Enabled? $PoolStatus"
				Write-Host "[$POOL] Provisioning Enabled? $ProvStatus"
			} #End ForEach
		} #End Try
		Catch
		{
			Write-Warning "There was a problem setting the pool state on pool: $global:Pool_Id"
		} #End Catch
	} #End Process
	End
	{
		# Silently Continue
	} #End End
} #End Disable-Pool FunctionAZ

function Enable-KHPool
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $true)]
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[ValidateNotNullOrEmpty()]
		[String[]]$Pool_Id
	) #End Param
	begin
	{
		# Silently Continue
	} #End Begin
	Process
	{
		Try
		{
			foreach ($POOL in $Pool_ID)
			{
				Set-PoolState -Pool_Id $POOL -Action 'Enable'
				Start-Sleep 5
				$PoolStatus = (Get-KHPool -Pool_Id $global:Pool_Id).DesktopSettings.Enabled
				$ProvStatus = (Get-KHPool -Pool_Id $global:Pool_Id).automatedDesktopData.virtualCenterProvisioningSettings.enableProvisioning
				Write-Host "[$POOL] Pool Enabled? $PoolStatus"
				Write-Host "[$POOL] Provisioning Enabled? $ProvStatus"
			} #End ForEach
		} #End Try
		Catch
		{
			Write-Warning "There was a problem setting the pool state on pool: $global:Pool_Id"
		} #End Catch
	} #End Process
	End
	{
		# Silently Continue
	} #End End
} #End Enable-Pool Function

function Get-KHPoolSpec
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $True)]
	Param (
		[Parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$Pool_Id,
		[Parameter(Mandatory = $false, Position = 1)]
		[switch]$Silent
	) #End Param
	PROCESS
	{
		$GETDATE = Get-Date -format "dd-MMM-yyyy_hhmmtt" -ErrorAction SilentlyContinue
		$JsonFileName = "PoolSpec-$POOL_ID-$GETDATE.json"
		
		New-Variable -Name $($Pool_Id + '_SpecPath') -Value "$global:ExportedPoolsPath\$JsonFileName" -Scope Global -ErrorAction SilentlyContinue
		$SpecPath = (Get-Variable $($Pool_Id + "_SpecPath")).Value
		
		If ($Silent)
		{
			Set-PoolVarGetSpec $Pool_Id | Get-HVPoolSpec -FilePath $SpecPath -ErrorAction SilentlyContinue | Out-Null
		} #End If
		Else
		{
			Set-PoolVarGetSpec $Pool_Id | Get-HVPoolSpec -FilePath $SpecPath -ErrorAction SilentlyContinue
		} #End Else
		
		$FromSpecPathObj = Get-JsonObject -specfile $SpecPath
		New-Variable -Name $($Pool_Id + '_SpecObj') -Value $FromSpecPathObj -Scope Global -ErrorAction SilentlyContinue
		
		$MyArray = @()
		$MyArray += New-Object -TypeName psobject -Property @{ Pool_Id = "$Pool_Id" } -ErrorAction SilentlyContinue
		$MyArray.psobject.TypeNames.Insert(0, "KH.Pool_Id")
		$MyArray | Set-PoolVar
		
		$PoolInfo = (Get-Variable $($Pool_Id + "_Info")).Value
		$PoolSum = (Get-Variable $($Pool_Id + "_sum")).Value
		If (!$Silent)
		{
			$HOST.UI.RawUI.ForegroundColor = 2
			Write-Host ''; Write-Host ''
			Write-Host "[`$Global:VC_Idobj]" -ForegroundColor DarkGray
			Write-Host "---------------------------" -ForegroundColor DarkGray
			$Global:VC_Idobj.Id
			Write-Host ''; Write-Host ''
			Write-Host "[`$$Pool_ID`_SpecPath]" -ForegroundColor DarkGray
			Write-Host "---------------------------" -ForegroundColor DarkGray
			$SpecPath
			Write-Host ''; Write-Host ''
			Write-Host "[`$$Pool_ID`_SpecObj]" -ForegroundColor DarkGray
			Write-Host "---------------------------" -ForegroundColor DarkGray
			$FromSpecPathObj
			Write-Host ''; Write-Host ''
			Write-Host "[`$$Pool_ID`_info]" -ForegroundColor DarkGray
			Write-Host "---------------------------" -ForegroundColor DarkGray
			$PoolInfo
			Write-Host ''
			Write-Host "[`$$Pool_ID`_sum]" -ForegroundColor DarkGray
			Write-Host "---------------------------" -ForegroundColor DarkGray
			$PoolSum
			$HOST.UI.RawUI.ForegroundColor = 15
		} #End If
	} #End Process
} #End Get-KHPoolSpecFunction

Function New-KHPool
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $True)]
	Param (
		[Parameter(Mandatory = $true)]
		[string]$ParentVM,
		[Parameter(Mandatory = $true)]
		[string]$Pool_ID,
		[Parameter(Mandatory = $true)]
		[string]$DisplayName,
		[Parameter(Mandatory = $true)]
		[string]$VMNamePrefix,
		[Parameter(Mandatory = $true)]
		[string]$Region,
		[Parameter(Mandatory = $true)]
		[string]$Office,
		[Parameter(Mandatory = $false)]
		[switch]$File
	) #End Param
	BEGIN
	{
		$PreErrorActionPref = $ErrorActionPreference
		$ErrorActionPreference = 'Stop'
		$MyArray = @()
	} #End Begin
	PROCESS
	{
		[string]$global:ParentVM = $ParentVM
		[string]$global:Pool_Id = $Pool_ID
		[string]$global:DisplayName = $DisplayName
		[string]$global:VMNamePrefix = $VMNamePrefix
		[string]$global:Office = $Office
		[string]$global:Region = $Region
		$global:TestParentVM = Try { Get-VM $global:ParentVM -ErrorAction Stop }
		Catch { }
		If (Get-IsNull($global:TestParentVM)) { Write-Warning "The VM provided does not exist" }
		Else
		{
			# Get-Date, used for the Description and Filenames
			$GETDATE = Get-Date -format "dd-MMM-yyyy_hhmmtt"
			
			Try
			{
				# Collecting the HostName from the ParentVM
				$global:Hostname_Fxd = (get-vm $global:ParentVM | get-vmhost).name
			} #End Try
			Catch
			{
				Write-Warning "There was a problem resolving the VMHost from the ParentVM Name"
			} #End Catch
			
			#VM Folder Path
			$global:VMFolderPath_Fxd = "/$global:DatacenterVar/vm/$global:Region/$global:Office"
			# ResourcePool PAth Fxd
			$global:ResourcePoolPath_Fxd = "/$global:DatacenterVar/host/$global:Region/$global:HOSTNAME_FXD/Resources"
			# Setting the Description
			$global:PoolDescription = "'$GetDate, Created via Powershell Script'"
			
			Try
			{
				# Get Snapshot Name (Last one created)
				$global:GetVMSnap = Get-VM $global:ParentVM | Get-Snapshot
				$global:SnapshotName = ($global:GetVMSnap | Where-Object Created -eq ($global:GetVMSnap.CREATED | Select-Object -Last 1)).Name
				If ($global:SnapshotName -eq $null)
				{
					Write-Warning "NO Snapshots On [$Global:ParentVM]"
					BREAK
				} #End If
			} #End Try
			Catch
			{
				Write-Warning "There was a problem getting the Snapshot Name"
			} #End Catch
			
			Try
			{
				# Get Datastore Path
				$global:DatastoreLeaf = (get-vmHost $global:Hostname_Fxd | Get-Datastore).Name
			} #End Try
			Catch
			{
				Write-Warning "There was a problem getting the Datastore Name/Path"
			} #End Catch
			
			$global:DatastorePath = "/$global:DatacenterVar/host/$global:Region/$global:Hostname_Fxd/$global:DatastoreLeaf"
			# PathToHost (For HostorCluster)
			$global:PathToHost = "/$global:DatacenterVar/host/$global:Region/$global:Hostname_Fxd"
			#Get Orginizational Unit
			$global:OrganizationalUnit_Fxd = "OU=$global:Office,OU=$global:Region,OU=$global:AD_OU"
			#Getting the View Folder ID
			$global:FolderId_Fxd = $global:Region
			
			# Write Verbose Output
			("[LINE ") + (Get-MyLine) + ("] `r
			`$global:PoolDescription: $global:PoolDescription `r
			`$global:FolderId_Fxd: $global:FolderId_Fxd `r
			`$global:Pool_Id: $global:Pool_Id `r
			`$global:DisplayName: $global:DisplayName `r
			`$global:ParentVM: $global:ParentVM `r
			`$global:PathToHost: $global:PathToHost `r
			`$global:ResourcePoolPath_Fxd: $global:ResourcePoolPath_Fxd `r
			`$global:SnapshotName: $global:SnapshotName `r
			`$global:VMFolderPath_Fxd: $global:VMFolderPath_Fxd `r
			`$global:DatastorePath: $global:DatastorePath `r
			`$global:OrganizationalUnit_Fxd: $global:OrganizationalUnit_Fxd `r
			`$global:VMNamePrefix: $global:VMNamePrefix `r
			`$GETDATE: $GETDATE `n ") | Write-Verbose
			
			# Load JSON TMPLT into Variable
			$global:MyJsonObject = Get-JsonObject -specfile $global:AutoJsonTmpltPath
			
			Try
			{
				# Make edits to the JSON Object
				$global:MyJsonObject.Base.description = $global:PoolDescription
				$global:MyJsonObject.Base.accessGroup = $global:FolderID_Fxd
				$global:MyJsonObject.Base.name = $global:Pool_Id
				$global:MyJsonObject.Base.displayName = $global:DisplayName
				$global:MyJsonObject.AutomatedDesktopSpec.virtualCenterProvisioningSettings.VirtualCenterProvisioningData.parentVm = $global:ParentVM
				$global:MyJsonObject.AutomatedDesktopSpec.virtualCenterProvisioningSettings.VirtualCenterProvisioningData.hostOrCluster = $global:PathToHost
				$global:MyJsonObject.AutomatedDesktopSpec.virtualCenterProvisioningSettings.VirtualCenterProvisioningData.resourcePool = $global:ResourcePoolPath_Fxd
				$global:MyJsonObject.AutomatedDesktopSpec.virtualCenterProvisioningSettings.VirtualCenterProvisioningData.snapshot = $global:SnapshotName
				$global:MyJsonObject.AutomatedDesktopSpec.virtualCenterProvisioningSettings.VirtualCenterProvisioningData.vmFolder = $global:VMFolderPath_Fxd
				$global:MyJsonObject.AutomatedDesktopSpec.virtualCenterProvisioningSettings.VirtualCenterStorageSettings.Datastores.datastore = $global:DatastorePath
				$global:MyJsonObject.AutomatedDesktopSpec.customizationSettings.AdContainer = $global:OrganizationalUnit_Fxd
				$global:MyJsonObject.AutomatedDesktopSpec.vmNamingSpec.patternNamingSettings.NamingPattern = $global:VMNamePrefix
			} #End Try
			Catch
			{
				Write-Warning "Problem applying changes to the JSON File"
			} #End Catch
			
			<# Convert the Variable we had modified back into a JSON format
			.Build fileName that will be used to save the spec
			.Out-File the Json Object to a Json File for use with the NewHVPool cmd
			.Run the NewPool CMD and use splatting for params #>
			
			$global:MySpecJsonObject = ($global:MyJsonObject | ConvertTo-Json -Depth 14)
			$global:FileName = "AutoSpec-$global:Region-$global:Office-$global:Pool_Id-$GETDATE.json"
			$global:MySpecJsonObject | Out-File "$global:NewPoolsPath\$global:FileName"
			
			If (!$File)
			{
				New-HVPool -Spec "$global:NewPoolsPath\$global:FileName"
			} #End If
		} #End IfGet-IsNull 'TESTPARENTVM''
	} #End Process
	END
	{
		If (!$File)
		{
			Try
			{
				Start-Sleep 7
				New-HVEntitlement -Type 'Group' -User $global:ViewPoolAccessUser -ResourceName $global:Pool_Id -ResourceType Desktop
				New-HVEntitlement -Type 'Group' -User $global:ViewAdminUser -ResourceName $global:Pool_Id -ResourceType Desktop
			} #End Try
			Catch
			{
				Write-Warning "Problem Setting Pool Entitlements!"
			} #End Catch
		} #End If
		
		If ($File)
		{
			Write-Host ''
			Write-Host "File-Path: $global:NewPoolsPath\$global:FileName"
		} #End If
		
		$MyArray += New-Object -TypeName psobject -Property @{ Pool_Id = "$global:Pool_Id" }
		$MyArray.psobject.TypeNames.Insert(0, "KH.Pool_Id")
		$MyArray #Write to pipeline
		
		#Switch ErrorAction back
		$ErrorActionPreference = $PreErrorActionPref
	} #End End
} # End of New-KHPool Function

function Export-KHPool
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true, Position = 0)]
		[ValidateNotNullOrEmpty()]
		[String]$Pool_Id
	) #End Param
	begin
	{
		$PreErrorActionPref = $ErrorActionPreference
		$ErrorActionPreference = 'Stop'
		
		# Build FileNames
		$GETDATE = Get-Date -format "dd-MMM-yyyy_hhmmtt" -ErrorAction SilentlyContinue
		$JsonFileName = "PoolSpec-$POOL_ID-$GETDATE.json"
		$XmlFileName = "ExportXml-$POOL_ID-$GETDATE.Xml"
		# Create my array
		$ExportPoolArray = @()
		# Get Pool Specs
		
		Try
		{
			$GetHvPoolObj = Get-KHPool $Pool_Id
			$DesktopId = $GetHvPoolObj.Id.Id
		} #End Try
		Catch
		{
			Write-Warning "There was a problem getting View Pool specs"
		} #End Catch
		# If Not available, this will run to get UserGroup Info
		If (Get-IsNull($Global:UserGroupSummary))
		{
			# Running a Query to get all User/Group Entitlements
			$query_service = New-Object "Vmware.Hv.QueryServiceService" -WarningAction SilentlyContinue
			$query = New-Object "Vmware.Hv.QueryDefinition" -WarningAction SilentlyContinue
			$query.queryEntityType = 'EntitledUserOrGroupLocalSummaryView'
			$Results = $query_service.QueryService_Query($global:HVServices, $query)
			# Putting the results into a global Variable
			$Global:UserGroupSummary = $Results.Results
		} #End If
		
		# Matching up the User/Group Entitlments to the DesktopId
		$EntObject = $Global:UserGroupSummary | Where-Object { $_.LocalData.Desktops.Id -match "$DesktopId" }
		$EntitledUsers = $EntObject.Base.DisplayName
		
	} #End Begin
	Process
	{
		New-Variable -Name $($Pool_Id + '_SpecPath') -Value "$global:ExportedPoolsPath\$JsonFileName" -Scope Global -ErrorAction SilentlyContinue
		$SpecPath = (Get-Variable $($Pool_Id + "_SpecPath")).Value
		Set-PoolVarGetSpec $Pool_Id | Get-HVPoolSpec -FilePath $SpecPath -ErrorAction SilentlyContinue | Out-Null
		$FromSpecPathObj = Get-JsonObject -specfile $SpecPath
		
		$AccessGroup = $FromSpecPathObj.Base.accessGroup -replace "OU=", ""
		$Description = "$GETDATE, Created via Powershell Script"
		$Pool_Id = $FromSpecPathObj.Base.name
		$DisplayName = $FromSpecPathObj.Base.displayName
		$PoolType = $FromSpecPathObj.Type
		
		If ($FromSpecPathObj.Type -eq 'AUTOMATED')
		{
			$ParentVM = split-path -leaf $GetHvPoolObj.AutomatedDesktopData.VirtualCenterNamesData.ParentVmPath
			$HostNameOfPool = $FromSpecPathObj.AutomatedDesktopSpec.virtualCenterProvisioningSettings.VirtualCenterProvisioningData.hostOrCluster
			$ResourcePool = $FromSpecPathObj.AutomatedDesktopSpec.virtualCenterProvisioningSettings.VirtualCenterProvisioningData.resourcePool
			$SnapshotInUse = $FromSpecPathObj.AutomatedDesktopSpec.virtualCenterProvisioningSettings.VirtualCenterProvisioningData.snapshot
			$VMFolder = $FromSpecPathObj.AutomatedDesktopSpec.virtualCenterProvisioningSettings.VirtualCenterProvisioningData.vmFolder
			$DatastoreInUse = $FromSpecPathObj.AutomatedDesktopSpec.virtualCenterProvisioningSettings.VirtualCenterStorageSettings.Datastores.datastore
			$ADContainer = $FromSpecPathObj.AutomatedDesktopSpec.customizationSettings.AdContainer
			$NamingPattern = $FromSpecPathObj.AutomatedDesktopSpec.vmNamingSpec.patternNamingSettings.NamingPattern
			$MaxMachinesInPool = $FromSpecPathObj.AutomatedDesktopSpec.vmNamingSpec.patternNamingSettings.MaxNumberOfMachines
			$HeadRoomCount = $FromSpecPathObj.AutomatedDesktopSpec.vmNamingSpec.patternNamingSettings.NumberOfSpareMachines
			$MinMachinesInPool = $FromSpecPathObj.AutomatedDesktopSpec.vmNamingSpec.patternNamingSettings.MinNumberOfMachines
			
			$ExportPoolArray += New-Object -TypeName psobject -Property @{
				PoolType   = "$PoolType"
				AccessGroup = "$AccessGroup"
				Description = "$Description"
				Pool_Id    = "$Pool_Id"
				DisplayName = "$DisplayName"
				ParentVM   = "$ParentVM"
				HostNameOfPool = "$HostNameOfPool"
				ResourcePool = "$ResourcePool"
				SnapshotInUse = "$SnapshotInUse"
				VMFolder   = "$VMFolder"
				DatastoreInUse = "$DatastoreInUse"
				ADContainer = "$ADContainer"
				NamingPattern = "$NamingPattern"
				MaxMachinesInPool = "$MaxMachinesInPool"
				HeadRoomCount = "$HeadRoomCount"
				MinMachinesInPool = "$MaxMachinesInPool"
				EntitledUsers = $EntitledUsers
			} #End Array
		} #End If
		If ($FromSpecPathObj.Type -eq 'MANUAL')
		{
			# Running query of all machines and then matching them up to the pool_id
			$query_service = New-Object "Vmware.Hv.QueryServiceService" -WarningAction SilentlyContinue
			$query = New-Object "Vmware.Hv.QueryDefinition" -WarningAction SilentlyContinue
			$query.queryEntityType = 'MachineNamesView'
			$Machines = $query_service.QueryService_Query($global:HVServices, $query)
			$MachinesResults = $Machines.Results
			
			# matching up the Machines to the Pool_Id
			$MachineData = $MachinesResults | Where-Object { $_.NamesData.DesktopName -eq $Pool_id }
			$ManPoolHostName = $MachineData.ManagedMachineNamesData.HostName
			$ManVMName = $MachineData.Base.Name
			$ManVMID = $MachineData.Id.Id
			$LogoffPolicy = $FromSpecPathObj.DesktopSettings.logoffSettings.automaticLogoffPolicy
			$LogoffTime = $FromSpecPathObj.DesktopSettings.logoffSettings.automaticLogoffMinutes
			
			$ExportPoolArray += New-Object -TypeName psobject -Property @{
				PoolType	   = "$PoolType"
				AccessGroup    = "$AccessGroup"
				Description    = "$Description"
				Pool_Id	       = "$Pool_Id"
				DisplayName    = "$DisplayName"
				HostName	   = "$ManPoolHostName"
				ManVMName      = "$ManVMName"
				ManVMID	       = $ManVMID
				LogOffPolicy   = "$LogOffPolicy"
				LogOffTime	   = "$LogOffTime"
				EntitledUsers  = $EntitledUsers
			} #End Array
		} #End If
	} #End Process
	End
	{
		$global:ExportPoolArray = $ExportPoolArray
		$global:ExportPoolArray | Export-CliXml -Path "$global:ExportedPoolsPath\$XmlFileName"
		Write-Host ''
		Write-Host "File: $global:ExportedPoolsPath\$XmlFileName"
		$ErrorActionPreference = $PreErrorActionPref
		$global:ExportPoolArray
	} #End End
} #End Export-KHPool Function

Function Import-KHPool
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding()]
	Param (
	) #End Param
	BEGIN
	{
		$PreErrorActionPref = $ErrorActionPreference
		$ErrorActionPreference = 'Stop'
		
		$global:ENTERTOCONTINUE = Read-Host -Prompt 'Hit Enter to select the Pool (XML) file to import, or [EXIT] to quit'
		If ($global:ENTERTOCONTINUE -eq "EXIT") { BREAK }
		$FILENAME = get-filename
	} #End Begin
	PROCESS
	{
		# Import XML File that contains the object
		$PoolImportObj = Import-CliXml -Path $FILENAME
		# Setting Entitled Users
		$EntitledUsers = $PoolImportObj.EntitledUsers
		$ImportPoolType = $PoolImportObj.PoolType
		
		# Load JSON TMPLT into Variable
		If ($ImportPoolType -eq 'AUTOMATED')
		{
			$global:MyJsonObject = Get-JsonObject -specfile $global:AutoJsonTmpltPath
		} #End If
		
		If ($ImportPoolType -eq 'MANUAL')
		{
			$global:MyJsonObject = Get-JsonObject -specfile $global:ManJsonTmpltPath
		} #End If
		
		$Pool_Id = $PoolImportObj.Pool_Id
		$AccessGroup = $PoolImportObj.AccessGroup
		
		If ($ImportPoolType -eq 'AUTOMATED')
		{
			Try
			{
				# Make edits to the JSON Object
				$global:MyJsonObject.Base.description = $PoolImportObj.Description
				$global:MyJsonObject.Base.accessGroup = $PoolImportObj.AccessGroup
				$global:MyJsonObject.Base.name = $PoolImportObj.Pool_Id
				$global:MyJsonObject.Base.displayName = $PoolImportObj.DisplayName
				$global:MyJsonObject.AutomatedDesktopSpec.virtualCenterProvisioningSettings.VirtualCenterProvisioningData.parentVm = $PoolImportObj.ParentVM
				$global:MyJsonObject.AutomatedDesktopSpec.virtualCenterProvisioningSettings.VirtualCenterProvisioningData.hostOrCluster = $PoolImportObj.HostNameOfPool
				$global:MyJsonObject.AutomatedDesktopSpec.virtualCenterProvisioningSettings.VirtualCenterProvisioningData.resourcePool = $PoolImportObj.ResourcePool
				$global:MyJsonObject.AutomatedDesktopSpec.virtualCenterProvisioningSettings.VirtualCenterProvisioningData.snapshot = $PoolImportObj.SnapshotInUse
				$global:MyJsonObject.AutomatedDesktopSpec.virtualCenterProvisioningSettings.VirtualCenterProvisioningData.vmFolder = $PoolImportObj.VMFolder
				$global:MyJsonObject.AutomatedDesktopSpec.virtualCenterProvisioningSettings.VirtualCenterStorageSettings.Datastores.datastore = $PoolImportObj.DatastoreInUse
				$global:MyJsonObject.AutomatedDesktopSpec.customizationSettings.AdContainer = $PoolImportObj.ADContainer
				$global:MyJsonObject.AutomatedDesktopSpec.vmNamingSpec.patternNamingSettings.NamingPattern = $PoolImportObj.NamingPattern
				$global:MyJsonObject.AutomatedDesktopSpec.vmNamingSpec.patternNamingSettings.MaxNumberOfMachines = $PoolImportObj.MaxMachinesInPool
				$global:MyJsonObject.AutomatedDesktopSpec.vmNamingSpec.patternNamingSettings.NumberOfSpareMachines = $PoolImportObj.HeadRoomCount
				$global:MyJsonObject.AutomatedDesktopSpec.vmNamingSpec.patternNamingSettings.MinNumberOfMachines = $PoolImportObj.MinMachinesInPool
			} #End Try
			Catch
			{
				Write-Warning "Problem applying changes to the JSON File"
			} #End Catch
		} #End If
		
		If ($ImportPoolType -eq 'MANUAL')
		{
			Try
			{
				# Make edits to the JSON Object
				$global:MyJsonObject.Base.description = $PoolImportObj.Description
				$global:MyJsonObject.Base.accessGroup = $PoolImportObj.AccessGroup
				$global:MyJsonObject.Base.name = $PoolImportObj.Pool_Id
				$global:MyJsonObject.Base.displayName = $PoolImportObj.DisplayName
				$global:MyJsonObject.DesktopSettings.logoffSettings.automaticLogoffPolicy = $PoolImportObj.LogOffPolicy
				If ($PoolImportObj.LogOffTime)
				{
					$global:MyJsonObject.DesktopSettings.logoffSettings.automaticLogoffMinutes = $PoolImportObj.LogOffTime
				} #End If
			} #End Try
			Catch
			{
				Write-Warning "Problem applying changes to the JSON File"
			} #End Catch
		} #End If
		
		<# Convert the Variable we had modified back into a JSON format
		.Build fileName that will be used to save the spec
		.Out-File the Json Object to a Json File for use with the NewHVPool cmd
		.Run the NewPool CMD and use splatting for params #>
		
		$global:MySpecJsonObject = ($global:MyJsonObject | ConvertTo-Json -Depth 14)
		$global:FileName = "$ImportPoolType-$AccessGroup-$Pool_Id-$GETDATE.json"
		$global:MySpecJsonObject | Out-File "$global:NewPoolsPath\$global:FileName"
		
		If ($ImportPoolType -eq 'AUTOMATED')
		{
			New-HVPool -Spec "$global:NewPoolsPath\$global:FileName"
		} #End If
		
		If ($ImportPoolType -eq 'MANUAL')
		{
			$ManVMName = $PoolImportObj.ManVMName
			New-HVPool -Spec "$global:NewPoolsPath\$global:FileName" -VM $ManVMName
		} #End If
		
	} #End Process
	END
	{
		Try
		{
			Start-Sleep 7
			foreach ($User in $EntitledUsers)
			{
				$ObjectClass = ''
				try
				{
					$ObjectClass = ((Get-ADUser ($User -replace "Kimley-horn.com\\", "") -ErrorAction Stop -WarningAction SilentlyContinue)).ObjectClass
				} #End Try
				catch
				{
					$ObjectClass = "Group"
				} #End Catch
				
				If ($ObjectClass -eq "Group")
				{
					New-HVEntitlement -Type 'Group' -User $User -ResourceName $Pool_Id -ResourceType Desktop -ErrorAction Stop -WarningAction SilentlyContinue
				} #End If
				Else
				{
					New-HVEntitlement -Type 'User' -User $User -ResourceName $Pool_Id -ResourceType Desktop -ErrorAction Stop -WarningAction SilentlyContinue
				} #End Else
			} #End ForEach
		} #End Try
		Catch
		{
			Write-Warning "Problem Setting Pool Entitlements!"
		} #End Catch
		#Switch ErrorAction back
		$ErrorActionPreference = $PreErrorActionPref
	} #End End
} # End of Import-KHPool Function

function Send-KHRecompose
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $True)]
	Param (
		[Parameter(Mandatory = $true)]
		[string]$Pool_ID
	) #End Param
	begin
	{
		$PreErrorActionPref = $ErrorActionPreference
		$ErrorActionPreference = 'Stop'
		Try
		{
			# Getting vCenter ID Object
			$vc_service_helper = New-Object VMware.Hv.VirtualCenterService
			$vcList = $vc_service_helper.VirtualCenter_List($global:HVServices)
			$Vcid = ($vcList | Where-Object { $_.ServerSpec.ServerName -eq $global:VC_FQDN }).id
		} #End Try
		Catch
		{
			Write-Warning "There was a problem getting the vCenter ID Object."
		} #End Catch
		
		Try
		{
			# Running API Desktop Summary Query
			Get-KHDesktopSummary
			$PoolResults = $global:PoolResults
		} #End Try
		Catch
		{
			Write-Warning "There Was A Problem Running API Desktop Summary Query."
			
		} #End Catch
		
		# Pool Summary Data | # Pool Desktop Info | # Pool Spec Data (Saved in global:SpecObject)
		$Pool = $PoolResults | Where-Object { $_.DesktopSummaryData.Name -eq "$Pool_Id" }
		$Item = $Global:HVServices.Desktop.Desktop_Get($Pool.Id)
		Get-APoolSpec -Pool_Id $Pool_Id -Silent
	} #End Begin
	Process
	{
		Try
		{
			# Collect the required Paramters (All from the Pool_Id Paramter supplied by the function paramter)
			$ParentVM = split-path -leaf $Item.AutomatedDesktopData.VirtualCenterNamesData.ParentVmPath
			$SnapshotVM = ((Get-VM $ParentVM | Get-Snapshot) | Where-Object { $_.Created -eq ($_.CREATED | Select-Object -Last 1) }).Name
		} #End Try
		Catch
		{
			Write-Warning "There was a problem collecting the ParentVM Name and the SnapshotVM."
		} #End Catch
		# Static Settings | # If StartTime is Unset, the operation will begin right away
		
		Try
		{
			$StopOnFirstError = $True
			$logoffSetting = 'WAIT_FOR_LOGOFF'
			$StartTime = ''
			$Id = $item.id
			$Name = $item.base.name
			$Source = $item.source
			$Type = $item.type
			$Operation = 'RECOMPOSE'
			$spec = Get-HVTaskSpec -Source $Source -poolName $Name -operation $operation -taskSpecName 'DesktopRecomposeSpec' -desktopId $Id
		} #End Try
		Catch
		{
			Write-Warning "There was a problem setting required variables."
		} #End Catch
		
		Try
		{
			$baseimage_helper = New-Object VMware.Hv.BaseImageVmService
			$parentList = $baseimage_helper.BaseImageVm_List($global:HVServices, $vcID)
			$parentVMObj = $parentList | Where-Object { $_.name -eq $parentVM }
			$spec.ParentVm = $parentVMObj.id
		} #End Try
		Catch
		{
			Write-Warning "There was a problem running the BaseImageVM Query."
		} #End Catch
		
		Try
		{
			$baseimage_snapshot_helper = New-Object VMware.Hv.BaseImageSnapshotService
			$snapshotList = $baseimage_snapshot_helper.BaseImageSnapshot_List($global:HVServices, $spec.ParentVm)
			$snapshotVMObj = $snapshotList | Where-Object { $_.name -eq $snapshotVM }
			$spec.Snapshot = $snapshotVMObj.id
		} #End Try
		Catch
		{
			Write-Warning "There was a problem running the BaseImageSnapshot Query."
		} #End Catch
		
		Try
		{
			$spec = Set-HVPoolSpec -vcId $VcID -spec $spec
			$desktop_helper = New-Object VMware.Hv.DesktopService
			$desktop_helper.Desktop_Recompose($global:HVServices, $Id, $spec)
		} #End Try
		Catch
		{
			Write-Warning "There was a problem setting HVPoolSpec, and running the Recompose operation."
		} #End Catch
		
		Try
		{
			# Update the pool settings/config
			$updates = @()
			$updates += Get-MapEntry -key 'automatedDesktopData.virtualCenterProvisioningSettings.virtualCenterProvisioningData.parentVm' -value $spec.ParentVM
			$updates += Get-MapEntry -key 'automatedDesktopData.virtualCenterProvisioningSettings.virtualCenterProvisioningData.snapshot' -value $spec.Snapshot
			$desktop_helper.Desktop_Update($global:HVServices, $Id, $updates)
		} #End Try
		Catch
		{
			Write-Warning "There was a problem setting HVPool settings."
		} #End Catch
	} #End Process
	End
	{
		$ErrorActionPreference = $PreErrorActionPref
	} #End End
} #End Send-KHRecompose Function

function Remove-KHPool
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $True)]
	Param (
		[Parameter(Mandatory = $true)]
		[string]$Pool_ID
	) #End Param
	begin
	{
		# Setting Error Action Pref
		$PreErrorActionPref = $ErrorActionPreference
		$ErrorActionPreference = 'Stop'
		Try
		{
			Get-KHDesktopSummary
			$PoolResults = $global:PoolResults
		} #End Try
		Catch
		{
			Write-Warning "There was a problem running the DesktopSummaryView Query"
		} #End Catch
	} #End Begin
	Process
	{
		# Getting my Pool from the PoolList Var
		$MyPool = $PoolResults | Where-Object { $_.DesktopSummaryData.Name -eq $Pool_Id }
		# Getting the Type of Pool
		$HVPoolType = $MyPool.DesktopSummaryData.Type
		
		If ($HVPoolType -eq "AUTOMATED")
		{
			$deleteFromDisk = $true
			$desktop_service_helper = New-Object VMware.Hv.DesktopService
			$deleteSpec = New-Object VMware.Hv.DesktopDeleteSpec
			$deleteSpec.DeleteFromDisk = $deleteFromDisk
			
			Write-Host "Deleting Pool: $Pool_Id..." -NoNewline
			Try
			{
				$desktop_service_helper.Desktop_Delete($global:HVServices, $MyPool.id, $deleteSpec)
			} #End Try
			Catch
			{
				Write-Warning "There was a problem deleting the pool: $Pool_Id"
			} #End Catch
			
			<# Setting up a While Loop to check to see if the pool has been deleted
			.If the pool has been deleted then the MyPoolTest var will be empty	#>
			
			[int]$MyLoopCount = 0
			$KeepGoing = ''
			while ($KeepGoing -ne "Exit")
			{
				$MyPoolTest = Get-KHPool -Pool_Id $Pool_Id -Silent
				If ($MyPoolTest)
				{
					$MyLoopCount++
					Write-Host "." -NoNewline
					Start-Sleep 2
				} #End If
				Else
				{
					Write-Host "Confirmed" -ForegroundColor DarkCyan
					$KeepGoing = "Exit"
				} #End Else
			} #End While
			Write-Host "`r"
		} #End If
		If ($HVPoolType -eq "MANUAL")
		{
			$deleteFromDisk = $false
			$desktop_service_helper = New-Object VMware.Hv.DesktopService
			$deleteSpec = New-Object VMware.Hv.DesktopDeleteSpec
			$deleteSpec.DeleteFromDisk = $deleteFromDisk
			
			Write-Host "Deleting Pool: $Pool_ID"
			Try
			{
				$desktop_service_helper.Desktop_Delete($global:HVServices, $MyPool.id, $deleteSpec)
			} #End Try
			Catch
			{
				Write-Warning "There was a problem deleting the pool: $Pool_Id"
			} #End Catch
		} #End Else
	} #End Process
	End
	{
		# Setting the ErrorActionPref back
		$ErrorActionPreference = $PreErrorActionPref
	} #End End
} #End Remove-KHPool Function

function Remove-KHSession
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess)]
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[ValidateNotNullOrEmpty()]
		[ValidatePattern("\w+\.\w+")]
		[string]$UserName,
		[Parameter(Mandatory = $false, Position = 1)]
		[switch]$Silent
	) #End Param
	begin
	{
		$PreErrorActionPref = $ErrorActionPreference
		$ErrorActionPreference = 'Stop'
		
		Try
		{
			$query_service = New-Object "Vmware.Hv.QueryServiceService" -WarningAction SilentlyContinue
			$query = New-Object "Vmware.Hv.QueryDefinition" -WarningAction SilentlyContinue
			$query.queryEntityType = 'SessionLocalSummaryView'
			$QueryResults = $query_service.QueryService_Query($global:HVServices, $query)
			$Sessions = $QueryResults.Results
		} #End Try
		Catch
		{
			Write-Warning "There was a problem running the SessionLocalSummary Query"
		} #End Catch
		$MyArray = @()
	} #End Begin
	Process
	{
		Try
		{
			$TargetSession = $Sessions | Where-Object { $_.NamesData.UserName -match $UserName }
			$TargetID = $TargetSession.Id
			$TargetPool_Id = $TargetSession.NamesData.DesktopName
		} #End Try
		Catch
		{
			Write-Warning "There was a problem locating the target session"
		} #End Catch
		Try
		{
			$global:HVServices.Session.Session_LogoffForced($TargetID)
		} #End Try
		Catch
		{
			Write-Warning "There was a problem Logging off the session for [$UserName]"
		} #End Catch
		
		$MyArray += New-Object -TypeName psobject -Property @{ UserName = "$UserName" }
	} #End Process
	End
	{
		If (!$Silent)
		{
			Write-Host "Logging Off [$UserName] from Pool [$TargetPool_Id]"
			$MyArray
		} #End If
		$ErrorActionPreference = $PreErrorActionPref
	} #End End
} #End Remove-KHSession Function

function Run-Viewdbchk
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess)]
	Param (
	) #End Param
	
	begin
	{
		#Silently Continue
	} #End Begin
	Process
	{
		$CMD0 = "Remove-Item -Path $global:ViewDbChkPath -Force -ErrorAction SilentlyContinue -WarningAction SilentlyContinue"
		$CMD1 = $global:ViewDbChkBat
		$CMD2 = "Get-Content -Path $global:ViewDbChkPath"
		$CMD3 = "Remove-Item -Path $global:ViewDbChkPath -Force -ErrorAction SilentlyContinue -WarningAction SilentlyContinue"
		
		Try
		{
			$CMD0X = [scriptblock]::Create("$CMD0")
			$CMD1X = [scriptblock]::Create("$CMD1")
			$CMD2X = [scriptblock]::Create("$CMD2")
			$CMD3X = [scriptblock]::Create("$CMD3")
		} #End Try
		Catch
		{
			Write-Warning "There was a problem Setting up the Scriptblocks"
		} #End Catch
		
		Try
		{
			Invoke-Command -ScriptBlock $CMD0X -Session $global:BROKERSession
			Invoke-Command -ScriptBlock $CMD1X -Session $global:BROKERSession | Out-Null
			$CMD2Invoke = Invoke-Command -ScriptBlock $CMD2X -Session $global:BROKERSession
			Invoke-Command -ScriptBlock $CMD3X -Session $global:BROKERSession
		} #End Try
		Catch
		{
			Write-Warning "There was a problem invoking the Scriptblock Commands"
		} #End Catch
		
	} #End Process
	End
	{
		$CMD2Invoke
	} #End End
} #End Run-Viewdbchk Function

function Get-KHSession
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $false, Position = 0)]
		[switch]$Format
	)
	begin
	{
		$PreErrorActionPref = $ErrorActionPreference
		$ErrorActionPreference = 'Stop'
		
		Try
		{
			$query_service = New-Object "Vmware.Hv.QueryServiceService" -WarningAction SilentlyContinue
			$query = New-Object "Vmware.Hv.QueryDefinition" -WarningAction SilentlyContinue
			$query.queryEntityType = 'SessionLocalSummaryView'
			$QueryResults = $query_service.QueryService_Query($global:HVServices, $query)
			$Sessions = $QueryResults.Results
		} #End Try
		Catch
		{
			Write-Warning "There was a problem running the Session Summary Query"
		} #End Catch
		$MyArray = @()
	} #End Begin
	Process
	{
		foreach ($Session in $Sessions)
		{
			$SessionUserName = $Session.NamesData.UserName
			$SessionPool_Id = $Session.NamesData.DesktopName
			$SessionMachineName = $Session.NamesData.MachineOrRDSServerName
			$SessionState = $Session.SessionData.SessionState
			$SessionPoolType = $Session.NamesData.DesktopType
			$SessionProtocol = $Session.SessionData.SessionProtocol
			$SessionStartTime = $Session.SessionData.StartTime
			$SessionDisconnectTime = $Session.SessionData.DisconnectTime
			$SessionID = $Session.Id
			
			$MyArray += New-Object -TypeName psobject -Property @{
				UserName				 = "$SessionUserName";
				Pool_Id				     = "$SessionPool_Id";
				MachineName			     = "$SessionMachineName";
				SessionState			 = "$SessionState";
				PoolType				 = "$SessionPoolType";
				Protocol				 = $SessionProtocol;
				SessionStartTime		 = "$SessionStartTime";
				SessionDisconnectTime    = "$SessionDisconnectTime";
				SessionID			     = $SessionID
			} #End Array
		} #End ForEach
	} #End Process
	End
	{
		If ($Format)
		{
			Write-Host "Data Stored In [`$global:MySessionArray]" -ForegroundColor DarkGray
			$global:MySessionArray = $MyArray
			$global:MySessionArray | Sort-Object Pool_Id | Format-Table UserName, Pool_Id, MachineName, SessionState, PoolType, Protocol, SessionStartTime, SessionDisconnectTime, SessionID
		} #End If
		$ErrorActionPreference = $PreErrorActionPref
		If (!$Format)
		{
			Return $MyArray
		} #End If
	} #End End
} #End Get-KHSession Function

function Get-KHPool
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess)]
	Param (
		[Parameter(Mandatory = $false, Position = 0)]
		[string]$Pool_Id,
		[Parameter(Mandatory = $false, Position = 1)]
		[switch]$Silent
	) #End Param
	begin
	{
		$PreErrorActionPref = $ErrorActionPreference
		$ErrorActionPreference = 'Stop'
		Try
		{
			Get-KHDesktopSummary
			$PoolResults = $global:PoolResults
		} #End Try
		Catch
		{
			Write-Warning "There was a problem running the DesktopSummaryQuery"
		} #End Catch
	} #End Begin
	Process
	{
		
		If ($Pool_Id)
		{
			Try
			{
				$CurrentPool = $PoolResults | Where-Object { $_.desktopsummarydata.Name -eq $Pool_Id }
				$DesktopInfo = $Global:HVServices.Desktop.Desktop_Get($CurrentPool.Id)
			} #End Try
			Catch
			{
				If (!$Silent)
				{
					Write-Warning "There was a problem getting the Desktop Info for Pool: [$Pool_Id]"
				} #End If
			} #End Catch
			$DesktopInfo
		} #End If
		Else
		{
			foreach ($Pool in $PoolResults)
			{
				Try
				{
					$Global:HVServices.Desktop.Desktop_Get($Pool.Id)
				} #End Try
				Catch
				{
					If (!$Silent)
					{
						Write-Warning "There was a problem getting the Desktop info for Pool: [$Pool]"
					} #End If
				} #End Catch
			} #End ForEach
		} #End Else
	} #End Process
	End
	{
		$ErrorActionPreference = $PreErrorActionPref
	} #End End
} #End Get-KHPool Function

function Check-KHPools
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess)]
	Param ()
	begin
	{
		$PreErrorActionPref = $ErrorActionPreference
		$ErrorActionPreference = 'Stop'
		Try
		{
			Get-KHDesktopSummary
			$PoolResults = $global:PoolResults
		} #End Try
		Catch
		{
			Write-Warning "There was a problem running the DesktopSummaryQuery"
		} #End Catch
		
		Try
		{
			$query_service = New-Object "Vmware.Hv.QueryServiceService" -WarningAction SilentlyContinue
			$query = New-Object "Vmware.Hv.QueryDefinition" -WarningAction SilentlyContinue
			$query.queryEntityType = 'MachineNamesView'
			$Machines = $query_service.QueryService_Query($global:HVServices, $query)
			$MachinesResults = $Machines.Results
		} #End Try
		Catch
		{
			Write-Warning "There was a problem running the Machine Names Query"
		} #End Catch
	} #End Begin
	Process
	{
		foreach ($Pool in $PoolResults)
		{
			Try
			{
				$DesktopInfo = $Global:HVServices.Desktop.Desktop_Get($Pool.Id)
				$PoolName = $Pool.desktopsummarydata.Name
				$PoolEnabled = $Pool.desktopsummarydata.Enabled
				$ProvEnabled = $Pool.desktopsummarydata.provisioningenabled
				$LastError = $DesktopInfo.AutomatedDesktopData.ProvisioningStatusData.LastProvisioningError
				$LastErrorTime = $DesktopInfo.AutomatedDesktopData.ProvisioningStatusData.LastProvisioningErrorTime
			} #End Try
			Catch
			{
				Write-Warning "There was a problem collecting data from the Pool: [$Pool]"
			} #End Catch
			
			If ($DesktopInfo.Type -eq "AUTOMATED")
			{
				$MachineData = $MachinesResults | Where-Object { $_.NamesData.DesktopName -eq $PoolName }
				$PoolVMAvailable = $MachineData | Where-Object { $_.Base.BasicState -eq "AVAILABLE" }
				If (!$PoolVMAvailable)
				{
					$AutoNoVMs = $true
				} #End If
			} #End If
			
			If ($PoolEnabled -eq $False -or $ProvEnabled -eq $false -or $AutoNoVMs -eq $true)
			{
				Write-Host "-----------------------------------------------------" -ForegroundColor DarkGray
				# POOL ENABLED
				If ($PoolEnabled -eq $True)
				{
					Write-Host "[$PoolName] Pool is Currently Enabled"
				} #End If
				Else
				{
					Write-Host "[$PoolName] Pool is Currently Disabled" -ForegroundColor DarkRed
				} #End Else
				
				# PROV ENABLED
				If ($ProvEnabled -eq $True)
				{
					Write-Host "[$PoolName] Provisioning is Currently Enabled"
				} #End If
				Else
				{
					Write-Host "[$PoolName] Provisioning is Currently Disabled" -ForegroundColor DarkRed
				} #End Else
				
				If ($AutoNoVMs -eq $true)
				{
					Write-Host "[$PoolName] There Are Currently No Available VM's" -ForegroundColor DarkYellow
					$AutoNoVMs = $null
				} #End If
				
				If ($LastError)
				{
					Write-Host "[$PoolName] Last Provisioning Error: $LastError"
					Write-Host "[$PoolName] Last Provisioning Error Time: $LastErrorTime"
				} #End If
				Write-Host ''
			} #End If
		} #End ForEach
	} #End Process
	End
	{
		$ErrorActionPreference = $PreErrorActionPref
	} #End End
} #End Check-KHPools Function

function Get-KHEvent
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess)]
	param (
		[Parameter(Mandatory = $false, Position = 0)]
		[string]$UserName,
		[Parameter(Mandatory = $false, Position = 1)]
		[string]$String,
		[Parameter(Mandatory = $false, Position = 2)]
		[int]$Days = '7',
		[Parameter(Mandatory = $false, Position = 3)]
		[switch]$Format
	) #End Param
	begin
	{
		$PreErrorActionPref = $ErrorActionPreference
		$ErrorActionPreference = 'Stop'
		
		# Set Vars
		$userFilter = $UserName
		$messageFilter = $String
		
		Try
		{
			# Collecting Event DB Info from View API
			$EventDatabaseInfo = $global:HVServices.EventDatabase.EventDatabase_Get()
		} # End Try
		Catch
		{
			Write-Warning "There was a problem running EventDatabase_Get"
		} #End Catch
		
		$dbServer = $EventDatabaseInfo.Database.server
		$dbType = $EventDatabaseInfo.Database.type
		$dbPort = $EventDatabaseInfo.Database.port
		$dbName = $EventDatabaseInfo.Database.name
		$dbTablePrefix = $EventDatabaseInfo.Database.tablePrefix
		
		Try
		{
			# Getting password ready
			$password = ConvertTo-SecureString $global:HVDbPassword -AsPlainText -Force
			$password.MakeReadOnly()
		} #End Try
		Catch
		{
			Write-Warning "There was a problem setting the pwd to a secure string"
		} #End Catch
		
		Try
		{
			# Setting up SQL Connection
			$connectionString = "Data Source=$dbServer, $dbPort; Initial Catalog=$dbName;"
			$connection = New-Object System.Data.SqlClient.SqlConnection ($connectionString)
			$connection.Credential = New-Object System.Data.SqlClient.SqlCredential($global:HVDbUserName, $password);
			$connection.Open()
		} #End Try
		Catch
		{
			Write-Warning "There was a problem setting up the SQL connection"
		} #End Catch
		
		# Saving DB Connection into a Var
		$hvDbServer = New-Object pscustomobject -Property @{ dbConnection = $connection; dbTablePrefix = $dbTablePrefix; }
		$dbConnection = $hvDbServer.dbConnection
		$dbTablePrefix = $hvDbServer.dbTablePrefix
		
		# Defining Db Tables
		$eventTable = $dbTablePrefix + "event"
		$eventDataTable = $dbTablePrefix + "event_data"
	} #End Begin
	Process
	{
		# Creating SQL command
		$command = New-Object System.Data.Sqlclient.Sqlcommand
		$adapter = New-Object System.Data.SqlClient.SqlDataAdapter
		$command.Connection = $dbConnection
		
		# Extract the filter parameters and build the filterQuery string
		$filterQuery = ""
		
		if ($userFilter -ne "")
		{
			$filterQuery = $filterQuery + " UserSID.StrValue"
			$filterQuery = $filterQuery + " LIKE '%$userFilter%'"
		} #End If
		
		if ($messageFilter -ne "")
		{
			if ($filterQuery -ne "") { $filterQuery = $filterQuery + " AND" }
			$filterQuery = $filterQuery + " ModuleAndEventText"
			$filterQuery = $filterQuery + " LIKE '%$messageFilter%'"
		} #End If
		
		$timeInDays = $Days
		$query = "SELECT CURRENT_TIMESTAMP"
		
		$command.CommandText = $query
		$adapter.SelectCommand = $command
		$DataTable = New-Object System.Data.DataTable
		$adapter.Fill($DataTable) | Out-Null
		
		$toDate = $DataTable.Rows[0][0]
		$fromDate = $toDate.AddDays(- ($timeInDays))
		
		$timePeriodQuery = " FORMAT(Time, 'MM/dd/yyyy HH:mm:ss.fff')   BETWEEN '" + $fromDate + "' AND  '" + $toDate + "'"
		
		Try
		{
			# Build the Query string based on the database type and filter parameters
			$query = "SELECT  UserSID.StrValue AS UserName, Severity, FORMAT(Time, 'MM/dd/yyyy HH:mm:ss.fff') as EventTime, Module, ModuleAndEventText AS Message FROM $eventTable " +
			" LEFT OUTER JOIN (SELECT EventID, StrValue FROM $eventDataTable WITH (NOLOCK)  WHERE (Name = 'UserDisplayName')) UserSID ON $eventTable.EventID = UserSID.EventID "
			$query = $query + " WHERE $timePeriodQuery"
			if ($filterQuery -ne "") { $query = $query + " AND $filterQuery" }
			$query = $query + " ORDER BY EventTime DESC"
			
			$command.CommandText = $query
			$adapter.SelectCommand = $command
			
			$DataTable = New-Object System.Data.DataTable
			$adapter.Fill($DataTable) | Out-Null
		} #End Try
		Catch
		{
			Write-Warning "There was a problem running the SQL Query"
		} #End Catch
		
		Write-Host "Number of records found : " $DataTable.Rows.Count
	} #End Process
	End
	{
		$global:MyDataTable = $DataTable
		If ($Format)
		{
			$global:MyDataTable | Format-Table
		}
		
		# Return Results
		return New-Object pscustomobject -Property @{ Events = $DataTable; }
		
		# Close DB Connection
		($global:hvDbServer.dbConnection).close()
		
		# Set Error Action back to default
		$ErrorActionPreference = $PreErrorActionPref
		
		# Cleanup
		[System.gc]::collect()
	} #End End
} #End Get-KHEvent function

Function Get-MyADUser
{ # .ExternalHelp ..\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $True)]
	Param (
		[Parameter(Mandatory = $true)]
		[string]$UserName
	) #End Param
	BEGIN
	{
		
	} #End Begin
	PROCESS
	{
		Get-ADUser $UserName -Properties *
	} #End Process
	END
	{
		
	} #End End
} #End Get-MyADUser Function

function Get-PersonaScript
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess)]
	Param (
		[Parameter(Mandatory = $true, Position = 0)]
		[string]$FPServer
	) #End Param
	
	begin
	{
		$MigUserNames = Get-ChildItem \\"$FPServer"\viewpersona\* | Select-Object Name | Where-Object { $_ -match "\w+\.V2" }
		$GETDATE = Get-Date -format "dd-MMM-yyyy_hhmmtt" -ErrorAction SilentlyContinue
		$FileNameNew = "Profile_Migration-$FPServer-$GETDATE.ps1"
		$PathToFile = "$global:ScriptsPath\$FileNameNew"
		New-Item -ItemType File -Path $PathToFile | Out-Null
		
	} #End Begin
	Process
	{
		foreach ($CurrentMigFolder in $MigUserNames)
		{
			$CurrentMigFolderX = $CurrentMigFolder.Name
			$MigProfileCommand = "cmd.exe /c " + "`"$global:MigProfileExePath`"" + " `/s:\\$FPServer\viewpersona\$CurrentMigFolderX /V2toV6 /Takeownership"
			$MigProfileCommand | Out-File -FilePath $PathToFile -Append
		} #End ForEach
	} #End Process
	End
	{
		If (Get-Content $PathToFile)
		{
			Write-Host "Run this script on the SLVR-VM" -ForegroundColor DarkCyan
			Write-Host "[$PathToFile]"
		} #End If
		Else
		{
			Write-Warning "No Data Captured. Verify Access to [\\$FPServer\viewpersona]"
		} #End Else
	} #End End
} #End Migrate-Persona Function

#################################### Helper Functions (DCV) ####################################

Function Get-FileName($initialDirectory) #End Param
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	BEGIN
	{
		
	} #End Begin
	PROCESS
	{
		[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
		$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
		$OpenFileDialog.initialDirectory = $initialDirectory
		$OpenFileDialog.filter = "All files (*.*)| *.*"
		$OpenFileDialog.ShowDialog() | Out-Null
		$OpenFileDialog.filename
	} #End Process
	End
	{
		
	} #End End
} #End Get-FileName Function

function prompt
{
	Write-Host 'KH.ViewAPI ' -ForegroundColor Green -NoNewline
	"$($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) "
} #End Function

Function Get-MyLine
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $True)]
	Param ()
	BEGIN
	{
		
	} #End Begin
	PROCESS
	{
		$MyInvocation.ScriptLineNumber
	} #End Process
	END
	{
		
	} #End End
} #End Get-MyLine Function

Function Exit-Script
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $True)]
	Param ()
	BEGIN
	{
		
	} #End Begin
	PROCESS
	{
		$HOST.UI.RawUI.ForegroundColor = 15
		Write-Host ''
		Write-Host '#Removing PSSession'
		Get-PSSession | Remove-PSSession
		Write-Host '#END Script'
		Write-Host ''
		EXIT
	} #End Process
	End
	{
		
	} #End End
} #End Exit-Script Function

function Get-APoolSpec
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true, Position = 0)]
		[ValidateNotNullOrEmpty()]
		[String]$Pool_Id,
		[Parameter(Mandatory = $false, Position = 1)]
		[switch]$Silent
	) #End Param
	begin
	{
		$GETDATE = Get-Date -format "dd-MMM-yyyy_hhmmtt" -ErrorAction SilentlyContinue
		$JsonFileName = "PoolSpec-$POOL_ID-$GETDATE.json"
	} #End Begin
	Process
	{
		New-Variable -Name $($Pool_Id + '_SpecPath') -Value "$global:ExportedPoolsPath\$JsonFileName" -Scope Global -ErrorAction SilentlyContinue
		$SpecPath = (Get-Variable $($Pool_Id + "_SpecPath")).Value
		Set-PoolVarGetSpec $Pool_Id | Get-HVPoolSpec -FilePath $SpecPath -ErrorAction SilentlyContinue | Out-Null
		$FromSpecPathObj = Get-JsonObject -specfile $SpecPath
	} #End Process
	End
	{
		$Global:SpecObject = $FromSpecPathObj
		If (!$Silent)
		{
			Write-Host "Spec Object Located In: `$Global:SpecObject"
		} #End If
		#Switch ErrorAction back
		$ErrorActionPreference = $PreErrorActionPref
	} #End End
} #End Get-APoolSpec Function

function Set-PoolVarGetSpec
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $True)]
	Param (
		[Parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$Pool_Id
	) #End Param
	BEGIN
	{
		$PreErrorActionPref = $ErrorActionPreference
		$ErrorActionPreference = 'Stop'
		Try
		{
			<# Setting the ErrorAction Pref to Stop
			.Setting up the Query service, and collecting the Pool.Results
			.Creating the PoolList array #>
			
			Get-KHDesktopSummary
			$PoolResults = $global:PoolResults

		} #End Try
		Catch
		{
			Write-Warning 'There was a problem with the Query'
		} #End Catch	
	}
	PROCESS
	{
		foreach ($Pool in $PoolResults)
		{
			If ($POOL_ID -match $Pool.DesktopSummaryData.Name)
			{
				Try
				{
					$ThisPoolInfo = $Global:HVServices.Desktop.Desktop_Get($Pool.Id)
				} #End Try
				Catch
				{
					$WarningPoolName = $Pool.DesktopSummaryData.Name
					Write-Warning "Problem creating Info/Sum Variables for Pool_ID: [$WarningPoolName]"
				} #end Catch
			} #End If
		} #End ForEach
	} #End Process
	END
	{
		# Setting the ErrorAction Pref back
		$ErrorActionPreference = $PreErrorActionPref
		Return $ThisPoolInfo
	} #End End
} #End Set-PoolVarGetSpec Function

Function Set-Con
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $True)]
	Param (
		[Parameter(Mandatory = $false, Position = 0)]
		[ValidateNotNullOrEmpty()]
		[switch]$Clear
	)
	BEGIN
	{
		Try
		{
			Get-PSSession | Remove-PSSession -WarningAction SilentlyContinue -ErrorAction Stop
			If ($global:Credential -eq $null) { $global:Credential = Get-Credential }
			If ($global:Broker -eq $null) { [string]$global:Broker = 'DTCVIEW7CS02-VM' }
			If ($global:VC -eq $null) { [string]$global:VC = 'DTCVCVIEW7-VM' }
		} #End Try
		Catch
		{
			Write-Warning "Problem establishing Connections"
		} #End Catch
	} #End Begin
	PROCESS
	{
		Try
		{
			#Declaring Connection Broker Server Connection Path
			$global:ServerBroker = $global:Broker
			#Declaring vCenter Server Connection Path
			$global:ServerVCenter = $global:VC
			#Declaring PowerShell Session on Connection Broker using Declared PowerShell Credential
			$global:BROKERSession = New-PSSession -ComputerName $global:ServerBroker -Credential $global:Credential -ErrorAction Stop
			#Adding PowerShell SnapIn 'vmware.view.broker' to session on Connection Server"
			$global:AddSnapinBroker = { add-pssnapin VMware.View.Broker }
			Invoke-Command -Session $global:BROKERSession -ScriptBlock $global:AddSnapinBroker -ErrorAction Stop
		} #End Try
		Catch
		{
			Write-Warning "There was a problem establishing a PSSession to the Broker: $global:Broker"
		} #End Catch
		Try
		{
			#Importing Module 'vmware.vimautomation.core' to Local Session
			Import-Module VMware.Vimautomation.Core -ErrorAction Stop
			#Connecting to Virutual Infrastructure Server on the Local Session
			Try
			{
				Disconnect-viserver -server $global:ServerVCenter -Force -Confirm:$false -ErrorAction Stop -WarningAction SilentlyContinue | Out-Null
			} #End Try
			Catch
			{
				#Silently Continue	
			} #End Catch
			$global:VCENTER = ''
			$global:VCENTER = connect-viserver -server $global:ServerVCenter -Credential $global:Credential -force -ErrorAction Stop -WarningAction SilentlyContinue
		} #End Try
		Catch [Exception]
		{
			$status = 1
			$exception = $_.Exception
			Write-Warning "There was a problem establishing a connection to vCenter"
		} #End Catch
		Try
		{
			Try
			{
				Disconnect-HVServer -Server $global:ServerBroker -Force -Confirm:$false -ErrorAction Stop -WarningAction SilentlyContinue | Out-Null
			} #End Try
			Catch
			{
				#Silently Continue	
			} #End Catch
			Connect-HVServer -Server $global:ServerBroker -Credential $global:Credential -Domain $global:KHDomain -ErrorAction Stop -WarningAction SilentlyContinue | Out-Null
			$global:HVServices = $global:DefaultHVServers.ExtensionData
		} #End Try
		Catch
		{
			Write-Warning "There was a problem Connecting HVServer on [$Global:Broker]"
		} #End Catch
	} #End Process
	END
	{
		If ($Clear)
		{
			# Clear Variables
			Get-Variable | ForEach-Object { If ($global:StartupVars.Name -notcontains $_.Name -and $_.Name -ne "StartupVars") { Remove-Variable -Name $_.Name -Force -Scope 'Global' -ErrorAction SilentlyContinue } }
			# Clear Host
			Clear-Host
			# Run Initalize
			C:\Temp\KH.ViewAPI.Helper\ModuleScripts\KH.ViewAPI.Helper-Initialize.ps1
		} #End If
	} #End End
} #End Set-Con Function

Function Get-IsNull($objectToCheck)
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	If ($objectToCheck -eq $null) { return $true }
	If ($objectToCheck -is [String] -and $objectToCheck -eq [String]::Empty) { return $true }
	If ($objectToCheck -is [DBNull] -or $objectToCheck -is [System.Management.Automation.Language.NullString]) { return $true }
	return $false
} #End of Get-IsNull() Function

Function Get-VMSnapshotFolderPath
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	Param (
		[Parameter(
				   Mandatory = $true,
				   HelpMessage = "the snapshot for which to discern the path to the root",
				   ValueFromPipeline = $true
				   )]
		[VMware.VimAutomation.ViCore.Impl.V1.VIObjectImpl]$Snapshot,
		# I suggest not taking the default. There's always a chance that  

		#   we'll need to talk to an arbitrary number of VCenter instances

		#   during one script invocation.

		[Parameter(
				   Mandatory = $false,
				   HelpMessage = "the VIServer connection to a VCenter instance"
				   )]
		[String]$Server = $global:DefaultVIServer,
		[Parameter(
				   Mandatory = $false,
				   HelpMessage = "the default folder separator to use when building a string from the path"
				   )]
		[String]$FolderSep = '/',
		[Parameter(
				   Mandatory = $false,
				   HelpMessage = "the path (constructed from descendent to ancestor) from the target snapshot to the current snapshot (for internal use)"
				   )]
		[String]$_BuiltPath = ''
	) #End Params
	If ($Snapshot.ParentSnapshotId)
	{
		return `
		Get-Snapshot `
					 -Server $Server `
					 -VM $Snapshot.VM `
					 -Id $Snapshot.ParentSnapshot.Id `
		| Get-VMSnapshotFolderPath `
								   -_BuiltPath ($FolderSep + $Snapshot.Name + $_BuiltPath)
	} #End If
	Else
	{
		return ($FolderSep + $Snapshot.Name + $_BuiltPath)
	} #End Else
} #End Get-VMSnapshotFolderPath

<#
.Synopsis
Display WSMan Connection Info
.DESCRIPTION
This is a wrapper to Get-WSManInstance
.EXAMPLE
Get-RemotePSSession ServerABC
.EXAMPLE
$s = Get-RemotePSSession ServerABC
$s | Remove-RemotePSSession
#>
function Get-RemotePSSession
{
	[CmdletBinding()]
	Param
	(
		# Computer to query.
		[Parameter(Mandatory = $true,
				   ValueFromPipeline = $true,
				   Position = 0)]
		[string]$ComputerName,
		# use SSL
		[switch]$UseSSL
	) #End Param
	Begin
	{
		try
		{
			Add-Type  @"
namespace JRICH{
public class PSSessionInfo
            {
                public string Owner;
public string ClientIP;
public string SessionTime;
public string IdleTime;
public string ShellID;
public string ConnectionURI;
public bool UseSSL=false;
            }}
"@
		} #End Try
		catch { }
		$results = @()
	} #End Begin
	Process
	{
		$port = if ($usessl) { 5986 }
		else { 5985 }
		$URI = "http://$($computername):$port/wsman"
		$sessions = Get-WSManInstance -ConnectionURI $URI shell -Enumerate
		
		foreach ($session in $sessions)
		{
			$obj = New-Object jrich.pssessioninfo
			$obj.owner = $session.owner
			$obj.clientip = $session.clientIp
			$obj.sessiontime = [System.Xml.XmlConvert]::ToTimeSpan($session.shellRunTime).tostring()
			$obj.idletime = [System.Xml.XmlConvert]::ToTimeSpan($session.shellInactivity).tostring()
			$obj.shellid = $session.shellid
			$obj.connectionuri = $uri
			$obj.UseSSL = $usessl
			$results += $obj
		} #End ForEach
	} #End Process
	End
	{
		$results
	} #End End
} #End Get-RemotePSSession Function

<#
.Synopsis
Logoff remote WSMAN session
.DESCRIPTION
   This function will take a JRICH.PSSessionInfo object and disconnect it
.EXAMPLE
$s = Get-RemotePSSession ServerABC
$s | Remove-RemotePSSession
#>
function Remove-RemotePSSession
{
	[CmdletBinding()]
	Param
	(
		# Session to be removed.
		[Parameter(Mandatory = $true,
				   ValueFromPipeline = $true,
				   Position = 0)]
		[jrich.pssessioninfo[]]$Session
	) #End Param
	Process
	{
		foreach ($connection in $session)
		{
			Remove-WSManInstance -ConnectionURI $connection.connectionuri shell @{ ShellID = $connection.shellid }
		} #End ForEach
	} #End Process
} #End Remove-RemotePSSession Function

Function Step-IP
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $True)]
	Param (
		[Parameter(Mandatory = $true)]
		[string]$HOSTNAME
	) #End Param
	BEGIN
	{
		
	} #End Begin
	PROCESS
	{
		Try
		{
			$BUMPIP = [System.Net.Dns]::GetHostAddresses("$HOSTNAME")[0].IPAddressToString
			#Get IP Addr from HostName
			#Split the IP at each '.'
			$NEWBUMPIP = $BUMPIP.split('.')
			#Selecting the last object
			[int]$MyINT = $NEWBUMPIP[-1]
			#Increasing the object by 1
			$MyINT++ | Out-Null -ErrorAction Stop
			#Setting to MYINT var
			$NEWBUMPIP[-1] = $MyINT
			#Joining the IP back together
			$global:MYNEWIP = $NEWBUMPIP -join '.'
		} #End Try
		Catch { }
	} #End Process
} #End Step-IP Function

function Set-PoolVar
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $True)]
	Param (
		[Parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true)]
		[ValidateNotNullOrEmpty()]
		[String[]]$Pool_Id
	) #End Param
	BEGIN
	{
		$PreErrorActionPref = $ErrorActionPreference
		$ErrorActionPreference = 'Stop'
		Try
		{
			<# Setting the ErrorAction Pref to Stop
			.Setting up the Query service, and collecting the Pool.Results
			.Creating the PoolList array #>
			
			Get-KHDesktopSummary
			$PoolResults = $global:PoolResults

		} #End Try
		Catch
		{
			Write-Warning 'There was a problem with the Query'
		} #End Catch	
	}
	PROCESS
	{
		foreach ($Pool in $PoolResults)
		{
			If ($POOL_ID -match $Pool.DesktopSummaryData.Name)
			{
				Try
				{
					New-Variable -Name $($Pool.DesktopSummaryData.Name + '_info') -Value $Global:HVServices.Desktop.Desktop_Get($Pool.Id) -Scope Global
					New-Variable -Name $($Pool.DesktopSummaryData.Name + '_sum') -Value ($Pool.DesktopSummaryData) -Scope Global
				} #End Try
				Catch
				{
					$WarningPoolName = $Pool.DesktopSummaryData.Name
					if ((Get-Variable $($WarningPoolName + "_Info") -ErrorAction SilentlyContinue).Value)
					{
						# Silently Continue
					} #End If
					else
					{
						Write-Warning "Problem creating Info/Sum Variables for Pool_ID: [$WarningPoolName]"
					} #End Else
				} #end Catch
			} #End If
		} #End ForEach
	} #End Process
	END
	{
		# Setting the ErrorAction Pref back
		$ErrorActionPreference = $PreErrorActionPref
	} #End End
} #End Set-PoolVar Function

Function Get-VMHostVersion
{ # No Help Yet
	[CmdletBinding (SupportsShouldProcess)]
	param
	(
		[parameter(Mandatory = $false, Position = 0)]
		[string[]]$HostName,
		[Parameter(Mandatory = $false, Position = 1)]
		[switch]$All
	) #End Param
	begin
	{
		If ($HostName -eq $null -and $All -eq $false)
		{
			$All = $true
		} #End If
	} #End Begin
	Process
	{
		If ($All)
		{
			get-vmhost | Sort-Object Parent, Version | Format-Table Parent, Name, Version, Build
		} #End If
		Else
		{
			get-vmhost $HostName | Format-Table Parent, Name, Version, Build
		} #End Else
		
	} #End Process
	End
	{
		# Silently End
	} #End End
} #End Get-VMHostVersion Function

function Set-PoolState
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $True)]
	Param (
		[Parameter(Mandatory = $true, Position = 0)]
		[ValidateNotNullOrEmpty()]
		[String[]]$Pool_Id,
		[Parameter(Mandatory = $true, Position = 1)]
		[ValidateNotNullOrEmpty()]
		[ValidateSet("Enable", "Disable", "Start", "Stop", "Other")]
		[String]$Action,
		[Parameter(Mandatory = $false, Position = 2)]
		[ValidateNotNullOrEmpty()]
		[String]$Key,
		[Parameter(Mandatory = $false, Position = 3)]
		[ValidateNotNullOrEmpty()]
		[System.Management.Automation.PSObject]$Value,
		[Parameter(Mandatory = $false, Position = 4)]
		[switch]$Silent
	) #End Param
	BEGIN
	{
		$PreErrorActionPref = $ErrorActionPreference
		$ErrorActionPreference = 'Stop'
		Try
		{
			<# Setting the ErrorAction Pref to Stop
			.Setting up the Query service, and collecting the Pool.Results
			.Creating the PoolList array #>
	
			Get-KHDesktopSummary
			$PoolResults = $global:PoolResults
			$poolList = @{ }
		} #End Try
		Catch
		{
			Write-Warning 'There was a problem with the Query'
		} #End Catch	
	}
	PROCESS
	{
		foreach ($Pool in $PoolResults)
		{
			If ($POOL_ID -match $Pool.DesktopSummaryData.Name)
			{
				$poolList.add($Pool.id, $Pool.DesktopSummaryData.Name)
			} #End If
		} #End ForEach
		
		<# Creating the Updates Array, then running the Action Variable through the Switch to match a Value
		.The Update array will contain the key/value pair of an object type VMware.HV.HVMapEntry
		.Setup the Desktop_Helper Service #>
		
		$updates = @()
		switch ($Action)
		{
			"Enable" { $updates += Get-MapEntry -key 'desktopSettings.enabled' -value $true; BREAK }
			"Disable" { $updates += Get-MapEntry -key 'desktopSettings.enabled' -value $false; BREAK }
			"Start" { $updates += Get-MapEntry -key 'automatedDesktopData.virtualCenterProvisioningSettings.enableProvisioning' -value $true; BREAK }
			"Stop" { $updates += Get-MapEntry -key 'automatedDesktopData.virtualCenterProvisioningSettings.enableProvisioning' -value $false; BREAK }
			"Other" { $updates += Get-MapEntry -key $Key -value $Value; BREAK }
		} #End Switch
		
		# Write Verbose Output
		("[LINE ") + (Get-MyLine) + ("] `
				`$updates: $updates `
				`$Pool: $Pool `
				`$poolList: $poolList `
				`$Pool_Id: $Pool_Id `n ") | Write-Verbose
		
		#Setting up the Desktop Helper Service
		$desktop_helper = New-Object VMware.Hv.DesktopService
		
		#Each Item that matched the criteria will be updated
		foreach ($item in $poolList.Keys)
		{
			Try
			{
				#Attempt to make the changes. If there is a problem it will try again in the catch
				[String]$Global:Pool_Id = $PoolList.$Item
				If (!$Silent)
				{
					Write-Host "Updating the Pool: " $poolList.$item
				} #End If
				$desktop_helper.Desktop_Update($global:HVServices, $item, $updates)
				
				# Write Verbose Output
				("[LINE ") + (Get-MyLine) + ("] `
				`$Global:Pool_Id: $Global:Pool_Id `
				`$item: $item `
				`$updates: $updates `
				`$Pool_Id: $Pool_Id `n ") | Write-Verbose
				
			} #End Try
			Catch
			{
				Write-Warning "Could not perform the Action [$Action] on Pool [$Global:Pool_Id]"
			} #End Catch
		} #End ForEach
	} #End Process
	END
	{
		# Setting the ErrorAction Pref back
		$ErrorActionPreference = $PreErrorActionPref
	} #End End
} #End Set-PoolState Function

#################################### vSphere Functions (DCV) ####################################

Function Get-VMHostUptime
{ # .ExternalHelp ..\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $True)]
	Param (
		[Parameter(ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)]
		[Alias('Name')]
		[string]$VMHost,
		[string]$Cluster
	) #End Param
	PROCESS
	{
		If ($VMHost)
		{
			ForEach ($Host In $VMHost) { Get-View -ViewType hostsystem -Property name, runtime.boottime -Filter @{ "name" = "$Host" } | Select-Object Name, @{ N = "UptimeDays"; E = { [math]::round((((Get-Date) - ($_.Runtime.BootTime)).TotalDays), 1) } } }
		} #End If
		ElseIf ($Cluster)
		{
			ForEach ($Host In (Get-VMHost -Location $Cluster))
			{
				Get-View -ViewType hostsystem -Property name, runtime.boottime -Filter @{ "name" = "$Host" } | Select-Object Name, @{ N = "UptimeDays"; E = { [math]::round((((Get-Date) - ($_.Runtime.BootTime)).TotalDays), 1) } }
			} #End ForEach
		} #End ElseIf
		Else
		{
			Get-View -ViewType hostsystem -Property name, runtime.boottime | Select-Object Name, @{ N = "UptimeDays"; E = { [math]::round((((Get-Date) - ($_.Runtime.BootTime)).TotalDays), 1) } }
		} #End Else
	} #End Process
} #End of Get-VMHostUpTime

Function Add-Host
{ # .ExternalHelp ..\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $True)]
	Param (
		[Parameter(Mandatory = $true)]
		[string]$HostName,
		[Parameter(Mandatory = $true)]
		[string]$Office,
		[Parameter(Mandatory = $true)]
		[string]$Region
	) #End Param
	BEGIN
	{
		
	} #End Begin
	PROCESS
	{
		[string]$global:VMHostName = $HostName
		[string]$global:Office = $Office
		[string]$global:Region = $Region
		#Writing multi-color line to screen#
		Write-Host "Adding Host" -NoNewline
		Write-Host " [$global:VMHostName] " -ForegroundColor cyan -NoNewline
		Write-Host "to" -NoNewline
		Write-HOST " [$global:VC]" -ForegroundColor cyan
		#Checking if the Office Folder specified exists. If it doesn't then it will be created under the Region specified.
		If (Get-Datacenter -Server $global:ServerVCenter -Name $global:DatacenterVar | Get-Folder -Name $global:Office -Type VM -ErrorAction SilentlyContinue) { }
		Else
		{ (Get-Datacenter -Server $global:ServerVCenter -Name $global:DatacenterVar | Get-Folder -Name $global:Region -Type VM | New-Folder -Name $global:Office | Out-Null) }
		#Setting up the Folder Var, this is required to put the host in the correcrt HostandCluster Folder
		$global:FOLDER = Get-Datacenter -Server $global:ServerVCenter -Name $global:DatacenterVar | Get-Folder -Name $global:Region -Type HostAndCluster -ErrorAction SilentlyContinue
		#Prompting for the Root Password for the selected host to join it to vCenter. This will be used later when adding the host to the new vCenter
		$global:VMHOSTCREDS = Get-Credential -UserName root -Message "Enter the ESXi root password for [$global:VMHostName]"
		#Executing the Add-VMHOST command using the Folder var, and the cred var we just setup.
		$global:InvokeADDVMHOST = (Add-VMHost -Server $global:ServerVCenter -Name $global:VMHostName -Location $global:Folder -User $global:VMHOSTCREDS.UserName -Password $global:VMHOSTCREDS.GetNetworkCredential().Password -Force -RunAsync) | Out-Null
		#Checking to see if the host has been added to vCenter before moving the VM's to the correct Region/Office folder
		$global:HOSTCONNECTIONSTATE = ''
		While ($global:HOSTCONNECTIONSTATE -ne "Connected")
		{
			$global:HOSTCONNECTIONSTATE = (Get-VMHost -Server $global:ServerVCenter -name $global:VMHostName -ErrorAction SilentlyContinue).ConnectionState
		} #End While
		#Moving all the VM's registered on the Host to the Office Folder under VMandTmplts. The folder was created above.
		$global:InvokeMOVEVMS = (Get-VMHost -Server $global:ServerVCenter -name $global:VMHostName | get-vm | ForEach-Object { Move-Inventory -Item $_ -Destination (Get-Datacenter -Server $global:ServerVCenter -Name $global:DatacenterVar | Get-Folder -Name $global:Office -Type VM) }) | Out-Null
		#Moving all the Datastores registered on the Host to the Regional folder under Datastore view
		$global:InvokeMOVEDATASTORE = (Get-VMHost -Server $global:ServerVCenter -name $global:VMHostName | Get-Datastore | ForEach-Object { Move-Datastore -Datastore $_ -Destination (Get-Datacenter -Server $global:ServerVCenter -Name $global:DatacenterVar | Get-Folder -Name $global:Region -Type Datastore) }) | Out-Null
		########Moving all the PortGroups registered on the Host to the Regional folder under Networking view###########
		#Get Portgroups on the host
		$global:PORTGROUPLIST = (get-vmhost -Server $global:ServerVCenter -name $global:VMHostName | get-virtualportgroup).name
		#Set equal to the Host selected
		$esxName = $global:VMHostName
		#Where we want to move the Portgroups to
		$tgtFolder = $global:Region
		#Running GET-VMHOST
		$esxImpl = Get-VMHost -Server $global:ServerVCenter -name $global:VMHostName
		#Running a ForEach Loop to run the below code on each Portgroup
		ForEach ($pgName In $global:PORTGROUPLIST)
		{
			# Get network folder
			$esx = $esxImpl | Get-View
			$dc = Get-Datacenter -VMHost $esxImpl | Get-View
			$netFolder = Get-View $dc.NetworkFolder
			# Find portgroup
			$netFolder.ChildEntity | Where-Object { $_.Type -eq 'Network' } | ForEach-Object{
				$child = Get-View $_
				If ($child.Name -eq $pgName)
				{
					$pgMoRef = $child.MoRef
				} #End If
			} #End ForEach
			# Move portgroup into folder
			$netFolder.ChildEntity | Where-Object { $_.Type -eq 'Folder' } | ForEach-Object{
				$child = Get-View $_
				Try
				{
					If ($child.Name -eq $tgtFolder)
					{
						$child.MoveIntoFolder($pgMoRef)
					} #End If
				} #End Try
				Catch { }
			} #End ForEach
		} #PORTGROUPLIST 'ForEach LOOP Exit'
		Write-HOST "-Host Addition Complete-"
	} #End Process
	END
	{
		
	} #End End
} #End Add-Host Function

Function Send-ESXCLI
{ # .ExternalHelp ..\KH.ViewAPI.Helper.psm1-Help.xml
	
	[CmdletBinding(SupportsShouldProcess = $True)]
	Param (
		[Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
		[ValidateNotNullOrEmpty()]
		[System.Management.Automation.PSObject]$VMHOSTNAME,
		[Parameter(Mandatory = $true, Position = 1)]
		[ValidateNotNullOrEmpty()]
		[string]$PW,
		[Parameter(Mandatory = $true, Position = 2)]
		[ValidateNotNullOrEmpty()]
		[string]$CMD
	) #End Param
	BEGIN
	{
		$pipelineInput = -not $PSBoundParameters.ContainsKey('VMHOSTNAME')
		$MyArray = @()
	} #End Begin
	PROCESS
	{
		ForEach ($CURRENTVMHOST In $VMHOSTNAME)
		{
			$VMHOST = Get-VMHost $CURRENTVMHOST
			[string]$PARENTNAME = $VMHOST.Parent
			[string]$STARTEDSSH = ''
			[string]$CURRENTVMHOST = $VMHOST.Name
			Write-Host '-------------------------------------------------------'
			Write-Host $VMHOST.Name
			Write-Host $VMHOST.Model
			$VMHOSTSSH = Get-VmHostService -VMHost $CURRENTVMHOST | Where-Object { $_.Key -eq "TSM-SSH" }
			[string]$ISVMHOSTSSH = $VMHOSTSSH.Running
			If ($ISVMHOSTSSH -eq "False")
			{
				$STARTSERVICE = Start-VMHostService -HostService $VMHOSTSSH -Confirm:$false
				$STARTEDSSH = '1'
			} #End If
			Test-Path .\Support\plink\
			$PLinkCommandY = "echo Y | $global:PlinkExePath -ssh $CURRENTVMHOST -l $global:ROOTUN -pw $PW Exit >$global:nul1 2>$global:nul2"
			$PLinkCommandIF = "$global:PlinkExePath -ssh $CURRENTVMHOST -l $global:ROOTUN -pw $PW $CMD"
			$pLinkOutputY = Invoke-Expression -Command $pLinkCommandY
			$pLinkOutputIF = Invoke-Expression -Command $pLinkCommandIF
			$pLinkOutputIF | Format-Table
			
			If ($STARTEDSSH -eq '1')
			{
				$STOPSERVICE = Stop-VMHostService -HostService $VMHOSTSSH -Confirm:$false
				$STARTEDSSH = '0'
			} #End If
			$MyArray += New-Object -TypeName psobject -Property @{ VMHOST = "$CURRENTVMHOST"; VMHOSTNAME = "$CURRENTVMHOST"; HOST = "$CURRENTVMHOST" }
		} #End ForEach
	} #End Process
	END
	{
		$pipelineInput = $null
		$MyArray.psobject.TypeNames.Insert(0, "KH.VMHost")
		$MyArray #This will output to the Console	
	} #End End
} #End Send-ESXCLI Function

Function Send-ESXCLIX
{ # .ExternalHelp ..\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $True)]
	Param (
		[Parameter(Mandatory = $true)]
		[string]$FilterProperty,
		[Parameter(Mandatory = $true)]
		[string]$FilterValue,
		[Parameter(Mandatory = $true)]
		[string]$CMD,
		[Parameter(Mandatory = $false)]
		[string]$CMD2
	) #End Param
	BEGIN
	{
		
	} #End Begin
	PROCESS
	{
		Try
		{
			$GETVMHOST = Get-VMHost
			ForEach ($VMHOST In $GETVMHOST)
			{
				$VMHOSTX = $VMHOST
				If ($VMHOSTX.$FilterProperty -match "$FilterValue")
				{
					[string]$VMHOSTNAME = $VMHOSTX.Name
					Write-Host '-------------------------------------------------------'
					Write-Host $VMHOSTNAME
					Write-Host $VMHOST.$FilterProperty
					[string]$Invoke = ".Invoke()"
					$esxcli = get-esxcli -vmhost $VMHOSTNAME -V2 -Server $global:VC -WarningAction SilentlyContinue
					[string]$esxcliCMD = ($CMD -Replace " ", ".") -replace "esxcli", ""
					[string]$esxcliCMD2 = ($CMD2 -Replace " ", ".") -replace "esxcli", ""
					[string]$CMDcommand = "`$esxcli$esxcliCMD$Invoke"
					[string]$CMDcommand2 = "`$esxcli$esxcliCMD2$Invoke"
					$InvokeCMDcommand = Invoke-Expression -Command $CMDcommand -ErrorAction Stop
					If (Get-IsNull($CMD2)) { }
					Else { $InvokeCMDcommand2 = Invoke-Expression -Command $CMDcommand2 -ErrorAction Stop }
					$InvokeCMDcommand
					If (Get-IsNull($CMD2)) { }
					Else { $InvokeCMDcommand2 | Format-Table }
				} #End If 'VMHOST.FilterProperty -eq FilterValue'
			} #End ForEach 'VMHOST In GETVMHOST'
		} #End Try
		Catch { Write-Warning "There was a problem executing the command" }
	} #End Process
	END
	{
		
	} #End End
} #End Send-ESXCLIX Function

Function Send-ESXCLIP
{ # .ExternalHelp ..\KH.ViewAPI.Helper.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess = $True)]
	Param (
		[Parameter(Mandatory = $true)]
		[string]$FilterProperty,
		[Parameter(Mandatory = $true)]
		[string]$FilterValue,
		[Parameter(Mandatory = $true)]
		[string]$CMD,
		[Parameter(Mandatory = $false)]
		[string]$CMD2
	) #End Param
	BEGIN
	{
		
	} #End Begin
	PROCESS
	{
		If (test-path -Path "$global:PlinkPath\nul1.txt") { }
		Else { New-Item "$global:PlinkPath\nul1.txt" -ItemType file -force | Out-Null }
		If (test-path -Path "$global:PlinkPath\nul2.txt") { }
		Else { New-Item "$global:PlinkPath\nul2.txt" -ItemType file -force | Out-Null }
		$GETVMHOST = Get-VMHost
		ForEach ($VMHOST In $GETVMHOST)
		{
			$VMHOSTX = $VMHOST
			[string]$PARENTNAME = $VMHOSTX.Parent
			If ($PARENTNAME -eq "AT") { $PW = $global:ATROOTPSWD }
			If ($PARENTNAME -eq "CA") { $PW = $global:CAROOTPSWD }
			If ($PARENTNAME -eq "FL") { $PW = $global:FLROOTPSWD }
			If ($PARENTNAME -eq "MT") { $PW = $global:MTROOTPSWD }
			If ($PARENTNAME -eq "MW") { $PW = $global:MWROOTPSWD }
			If ($PARENTNAME -eq "SE") { $PW = $global:SEROOTPSWD }
			If ($PARENTNAME -eq "TX") { $PW = $global:TXROOTPSWD }
			If ($PARENTNAME -notmatch "CA|FL|MT|SE|TX") { Write-Host " -MW/AT- [SKIP]" }
			Else
			{
				If ($VMHOSTX.$FilterProperty -eq "$FilterValue")
				{
					[string]$STARTEDSSH = ''
					[string]$VMHOSTNAME = $VMHOSTX.Name
					Write-Host '-------------------------------------------------------'
					Write-Host $VMHOSTNAME
					Write-Host $VMHOST.$FilterProperty
					$VMHOSTSSH = Get-VmHostService -VMHost $VMHOSTNAME | Where-Object { $_.Key -eq "TSM-SSH" }
					[string]$ISVMHOSTSSH = $VMHOSTSSH.Running
					If ($ISVMHOSTSSH -eq "False")
					{
						$STARTSERVICE = Start-VMHostService -HostService $VMHOSTSSH -Confirm:$false
						$STARTEDSSH = '1'
					} #End If
					$PLinkCommandY = "echo Y | $global:PlinkExePath -ssh $VMHOSTNAME -l $global:ROOTUN -pw $PW Exit >$global:nul1 2>$global:nul2"
					$PLinkCommandIF = "$global:PlinkExePath -ssh $VMHOSTNAME -l $global:ROOTUN -pw $PW $CMD"
					$PLinkCommandIF2 = "$global:PlinkExePath -ssh $VMHOSTNAME -l $global:ROOTUN -pw $PW $CMD2"
					$pLinkOutputY = Invoke-Expression -Command $pLinkCommandY
					$pLinkOutputIF = Invoke-Expression -Command $pLinkCommandIF
					If (Get-IsNull($CMD2)) { }
					Else { $pLinkOutputIF2 = Invoke-Expression -Command $pLinkCommandIF2 }
					$pLinkOutputIF | Format-Table
					If (Get-IsNull($CMD2)) { }
					Else { $pLinkOutputIF2 | Format-Table }
					
					If ($STARTEDSSH -eq '1')
					{
						$STOPSERVICE = Stop-VMHostService -HostService $VMHOSTSSH -Confirm:$false
						$STARTEDSSH = '0'
					} #End If
				} #End If 'VMHOST.FilterProperty -eq FilterValue'
			} #End If 'PARENTNAME -notmatch CA|FL|MT|SE|TX'
		} #End ForEach 'VMHOST In GETVMHOST'
	} #End Process
	END
	{
		
	} #End End
} #End Send-ESXCLIP Function

#################################### Modified VMware.HV.Helper Code Below ####################################

# From VMware.HV.Helper (Modified 'Services')
function Get-Machine ($Pool, $MachineList)
{
	[VMware.Hv.MachineId[]]$machines = @()
	$remainingCount = 1 # run through loop at least once
	$query = New-Object VMware.Hv.QueryDefinition
	$query.queryEntityType = 'MachineSummaryView'
	$poolFilter = New-Object VMware.Hv.QueryFilterEquals -Property @{ 'MemberName' = 'base.desktop'; 'value' = $pool }
	if ($machineList)
	{
		$machineFilters = [vmware.hv.queryFilter[]]@()
		foreach ($name in $machineList)
		{
			$machineFilters += (New-Object VMware.Hv.QueryFilterEquals -Property @{ 'memberName' = 'base.name'; 'value' = $name })
		}
		$machineList = New-Object VMware.Hv.QueryFilterOr -Property @{ 'filters' = $machineFilters }
		$treeList = @()
		$treeList += $machineList
		$treelist += $poolFilter
		$query.Filter = New-Object VMware.Hv.QueryFilterAnd -Property @{ 'filters' = $treeList }
	}
	else
	{
		$query.Filter = $poolFilter
	}
	while ($remainingCount -ge 1)
	{
		$query_service_helper = New-Object VMware.Hv.QueryServiceService
		$queryResults = $query_service_helper.QueryService_Query($global:HVServices, $query)
		$results = $queryResults.results
		$machines += $results.id
		$query.StartingOffset = $query.StartingOffset + $queryResults.results.Count
		$remainingCount = $queryResults.RemainingCount
	}
	return $machines
}

# From VMware.HV.Helper
function Get-HVTaskSpec
{
	param (
		[Parameter(Mandatory = $true)]
		[string]$Source,
		[Parameter(Mandatory = $true)]
		[string]$PoolName,
		[Parameter(Mandatory = $true)]
		[string]$Operation,
		[Parameter(Mandatory = $true)]
		[string]$TaskSpecName,
		[Parameter(Mandatory = $true)]
		$DesktopId
		
	)
	if ($source -ne 'VIEW_COMPOSER')
	{
		Write-Error "$operation task is not supported for pool type: [$source]"
		return $null
	}
	$machineList = Get-Machine $desktopId $machines
	if ($machineList.Length -eq 0)
	{
		Write-Error "Failed to get any Virtual Center machines with the given pool name: [$poolName]"
		return $null
	}
	$spec = Get-HVObject -TypeName $taskSpecName
	$spec.LogoffSetting = $logoffSetting
	$spec.StopOnFirstError = $stopOnFirstError
	$spec.Machines = $machineList
	if ($startTime) { $spec.startTime = $startTime }
	return $spec
}

# From VMware.HV.Helper
function Get-HVObject
{
	param (
		[Parameter(Mandatory = $true)]
		[string]$TypeName,
		[Parameter(Mandatory = $false)]
		[System.Collections.Hashtable]$PropertyName
	)
	$objStr = 'VMware.Hv.' + $typeName
	return New-Object $objStr -Property $propertyName
}

# From VMware.HV.Helper
function Set-HVPoolSpec
{
	param (
		[Parameter(Mandatory = $true)]
		[VMware.Hv.VirtualCenterId]$VcID,
		[Parameter(Mandatory = $true)]
		$Spec
	)
	if ($parentVM)
	{
		$baseimage_helper = New-Object VMware.Hv.BaseImageVmService
		$parentList = $baseimage_helper.BaseImageVm_List($global:HVServices, $vcID)
		$parentVMObj = $parentList | Where-Object { $_.name -eq $parentVM }
		$spec.ParentVm = $parentVMObj.id
	}
	if ($snapshotVM)
	{
		$baseimage_snapshot_helper = New-Object VMware.Hv.BaseImageSnapshotService
		$snapshotList = $baseimage_snapshot_helper.BaseImageSnapshot_List($global:HVServices, $spec.ParentVm)
		$snapshotVMObj = $snapshotList | Where-Object { $_.name -eq $snapshotVM }
		$spec.Snapshot = $snapshotVMObj.id
	}
	return $spec
}

function Get-MapEntry
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	param (
		[Parameter(Mandatory = $true)]
		$Key,
		[Parameter(Mandatory = $true)]
		$Value
	)
	
	$update = New-Object VMware.Hv.MapEntry
	$update.key = $key
	$update.value = $value
	return $update
}

function Get-JsonObject
{ # .ExternalHelp .\KH.ViewAPI.Helper.psm1-Help.xml
	param (
		[Parameter(Mandatory = $true)]
		[string]$SpecFile
	) #End Param
	try
	{
		return Get-Content -Raw $specFile | ConvertFrom-Json
	} #End Try
	catch
	{
		throw "Failed to read json file [$specFile], $_"
	} #End Catch
} #End Get-JsonObject Function

# DCV KHView Functions
export-modulemember -Function Start-KHPool
export-modulemember -Function Stop-KHPool
export-modulemember -Function Enable-KHPool
export-modulemember -Function Disable-KHPool
export-modulemember -Function Import-KHPool
export-modulemember -Function Export-KHPool
export-modulemember -Function New-KHPool
export-modulemember -Function Remove-KHPool
export-modulemember -Function Send-KHRecompose
export-modulemember -Function Get-KHPoolSpec
export-modulemember -Function Get-KHEvent
export-modulemember -Function Run-Viewdbchk
export-modulemember -Function Remove-KHSession
export-modulemember -Function Check-KHPools
export-modulemember -Function Get-KHPool
export-modulemember -Function Get-KHSession
export-modulemember -Function Get-PersonaScript

# DCV KHView Helper Functions
export-modulemember -Function Get-FileName
export-modulemember -Function Prompt
export-modulemember -Function Get-UserGroupSummary
export-modulemember -Function Get-MyLine
export-modulemember -Function Exit-Script
export-modulemember -Function Set-Con
export-modulemember -Function Step-IP
export-modulemember -Function Set-PoolVar
export-modulemember -Function Set-PoolVarGetSpec
export-modulemember -Function Set-PoolState
export-modulemember -Function Get-APoolSpec
export-modulemember -Function Get-VMHostVersion

# Other Functions (Wrote Myself)
export-modulemember -Function Get-MyADUser
export-modulemember -Function Add-Host
export-modulemember -Function Send-ESXCLI
export-modulemember -Function Send-ESXCLIX
export-modulemember -Function Send-ESXCLIP

# Other Functions (Got Online)
export-modulemember -Function Get-VMSnapshotFolderPath
export-modulemember -Function Get-IsNull
export-modulemember -Function Get-VMHostUptime
export-modulemember -Function Get-RemotePSSession
export-modulemember -Function Remove-RemotePSSession

# Modified Functions From VMware.HV.Helper.psm1
export-modulemember -Function Get-Machine
export-modulemember -Function Get-HVTaskSpec
export-modulemember -Function Get-HVObject
export-modulemember -Function Set-HVPoolSpec
export-modulemember -Function Get-MapEntry
export-modulemember -Function Get-JsonObject