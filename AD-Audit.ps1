#requires -version 4
<#
.SYNOPSIS
  <Overview of script>

.DESCRIPTION
  <Brief description of script>

.PARAMETER <Parameter_Name>
  <Brief description of parameter input required. Repeat this attribute if required>

.INPUTS
  <Inputs if any, otherwise state None>

.OUTPUTS Log File
  The script log file stored in C:\Windows\Temp\<name>.log

.NOTES
  Version:        1.0
  Author:         <Name>
  Creation Date:  <Date>
  Purpose/Change: Initial script development

.EXAMPLE
  <Example goes here. Repeat this attribute for more than one example>

  <Example explanation goes here>
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = 'SilentlyContinue'

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$sScriptVersion = '1.0'

#Log File Info
$sLogPath = 'Y:\IT\InfoSec\Audit Stuff\ITGC\2016\SOX Q4 2016\'
$sLogName = 'NMI-Audit-ADUsers.txt'
$sLogFile = Join-Path -Path $sLogPath -ChildPath $sLogName
$date = Get-Date
$rDate = (Get-Date -format "MM-dd-yyyy")
If(test-path $sLogFile) { remove-item $sLogFile }
#-----------------------------------------------------------[Functions]------------------------------------------------------------
Function ConvertTo-Date {
    Param (
        [Parameter(ValueFromPipeline=$true,mandatory=$true)]$accountExpires
    )
    
process {
    $lngValue = $accountExpires
    if(($lngValue -eq 0) -or ($lngValue -gt [DateTime]::MaxValue.Ticks)) {
        $AcctExpires = "<Never>"
    } else {
        $Date = [DateTime]$lngValue
        $AcctExpires = $Date.AddYears(1600).ToLocalTime()
    }
    $AcctExpires 
}
}
#-----------------------------------------------------------[Execution]------------------------------------------------------------

#$Users = Get-ADUser -SearchBase "OU=AllUsers,DC=NMI,DC=local" -Filter {Enabled -eq $true }

$Users = Get-ADUser -Filter * -Properties * 

#|
#?{$_.distinguishedname -notlike "OU=Disabled Accounts" }

add-content -path $sLogFile -value "NMI-ADUsers;$rDate"
add-content -path $sLogFile -value ""
add-content -path $sLogFile -value "Name;User Principal Name;Display Name;sAMAccountName;description;userAccountControl;AccountwhenCreated;Account Enabled;whenChanged;lastLogon;pwdLastSet;accountExpires;Primary Group;MemberOf"

ForEach ($i in $Users){
$Name = $i.name
$Sam = $i.SamAccountName
$UPN = $i.UserPrincipalName
$Status = $i.Enabled
$Cn = $i.cn
$Dn = $i.DisplayName
$description = $i.Description
$userAccountControl = $i.userAccountControl
$AccountwhenCreated = $i.whenCreated
$whenChanged = $i.whenChanged
$lastLogon = $i.LastLogonDate
$pwdLastSet = $i.PasswordLastSet
$accountExpires = $i.accountExpires
$AcctExpires = ConvertTo-Date $accountExpires
$MemberOf = $i.MemberOf
$PrimaryGroup = $i.PrimaryGroup
If ($status -eq "True") { $AccountEnabled = "Enabled" }
If ($status -ne "True") { $AccountEnabled = "Disabled" }
add-content -path $sLogFile -value "$Name;$UPN;$Dn;$Sam;$description;$userAccountControl;$AccountwhenCreated;$AccountEnabled;$whenChanged;$lastLogon;$pwdLastSet;$AcctExpires;$PrimaryGroup;$MemberOf"
}



