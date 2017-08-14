#Set Error Action to Silently Continue
$ErrorActionPreference = 'SilentlyContinue'

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$sScriptVersion = '1.0'
$rDate = (Get-Date -format "MM-dd-yyyy")
#Log File Info
$sLogPath = 'C:\Temp'
$sLogName = "NMI-Disabled-ADUsers-$rDate.csv"
$sLogFile = Join-Path -Path $sLogPath -ChildPath $sLogName
$date = Get-Date

#-----------------------------------------------------------[Functions]------------------------------------------------------------

#-----------------------------------------------------------[Execution]------------------------------------------------------------

#$Users = Get-ADUser -SearchBase "OU=AllUsers,DC=NMI,DC=local" -Filter {Enabled -eq $true }

$Users = get-aduser -searchbase "OU=Disabled Accounts,OU=AllUsers,DC=NMI,DC=local" -filter *

add-content -path $sLogFile -value "NMI-Disabled-ADUsers,$rDate"
add-content -path $sLogFile -value ""
add-content -path $sLogFile -value "Name, SamAccountName, UserPrincipalName, Enabled"
ForEach ($i in $Users){

$Name = $i.name
$San = $i.SamAccountName
$UPN = $i.UserPrincipalName
$Status = $i.Enabled
add-content -path $sLogFile -value "$Name, $San, $UPN, $Status"
}
