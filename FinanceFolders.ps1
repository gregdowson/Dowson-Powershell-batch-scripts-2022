# Comment

<#
.SYNOPSIS
Get the Folders and Sub Folders of D:\NMIShares\Finance
And gets the NTFS Permisions on all folders.

.DESCRIPTION
  Uses the NTFSSecurity to retrive the NTFS permission

.PARAMETER <Parameter_Name>
  <Brief description of parameter input required. Repeat this attribute if required>

.INPUTS Server

.INPUTS Credentials

.OUTPUTS Error Log File
  The script log file stored in c:\temp\permission-err.txt

.NOTES
  Version:        1.0
  Author:         Mike Felkins
  Creation Date:  6/23/2016
  Purpose/Change: Initial script development

.EXAMPLE

  FinanceFolders.ps1.ps1
  
.NOTES
	DFS server is EMV-WIN-DFSS-02
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

$computer = $env:computername
$Date = (Get-Date -format "MM-dd-yyyy")
 
get-childitem -Path "\\nmi.local\Files\NMIShares\Finance" -Directory -recurse | 
Get-NTFSAccess | export-csv "U:\Finance-Folder-$date.csv" -NoTypeInformation
If ($ERROR){err}

