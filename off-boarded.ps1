<# the following users have been off-boarded and have had their AD accounts deleted. 
                Michele.L.Wood
................Gabriele.Capps
................Karla.Thomas
................Amy.Nasello
................Delca.Simmons
................Andrew.Hademan
................John.Mathews

If there profile exists, please delete their profile.

 #>

Function err {
    $E1 = $E2 = $E3 = $E4 = " " #Sets variables to null.
	[string]$E1 = $Error #Catches error
	[string]$E2 = $E1.split(":") # divides the string at the ":"
	$E3 = $E2.split(".") # divides the string at the "."
	$E4 = $E3[0] # Selects the part of the string before the "."
    Add-Content -path $LogPath -value $E4 
	$Error.clear()
	}

$ErrorActionPreference = "SilentlyContinue"
$LogPath = "c:\temp\permission-err.txt"

If (Test-Path $LogPath){
	Remove-Item $LogPath
}

if (!(Test-Path $LogPath)) {
            Write-Verbose "Creating $LogPathPath."
            $NewLogFile = New-Item $LogPath -Force -ItemType File
            }
			

function Load-Module
{
    param (
        [parameter(Mandatory = $true)][string] $name
    )
    $retVal = $true
    if (!(Get-Module -Name $name))
    {
        $retVal = Get-Module -ListAvailable | where { $_.Name -eq $name }
        if ($retVal)
        {
            try
            {
                Import-Module $name -ErrorAction SilentlyContinue
            }
            catch
            {
                $retVal = $false
            }
        }
    }
    return $retVal
}

Load-Module NTFSSecurity
Write-Host "If more than one user, edit this script  at line 66"
Read-Host -Prompt "Press Enter to continue"

$users =  Read-host "Enter name of the users to be OffBoarded"
 
 $A = @($users)
 foreach ($i in $a)			
{
	$i = "X:\NMIProfiles\$i.NMI.V2"
    if(test-path $i)
  {
		$owner =  (get-acl $i).owner
		write-host "$owner" -fore Green 
        write-host "Taking ownership of Directory $i" -fore Green 
        get-item $i | set-NTFSowner -Account 'NMI.LOCAL\Domain Admins'  
		
        $items = @()
        $items = $null
        $path = $null
        $items = get-childitem $i -recurse -force
        foreach($item in $items)
            {
            $path = $item.FullName		 
			get-item $path | set-NTFSowner -Account 'NMI.LOCAL\Domain Admins'
            get-childitem $path -recurse | remove-item -force -recurse
			write-host "Deleting $path" -fore Green
            }
			If ($ERROR){err}
	}	
		Else { write-host "$i does not exist" -fore Green}
		If ($ERROR){err}
	}