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
$sLogPath = 'D:\logs'
$sLogName = 'NMI-ADUsers.txt'
$sLogFile = Join-Path -Path $sLogPath -ChildPath $sLogName
$date = Get-Date
$rDate = (Get-Date -format "MM-dd-yyyy")
If(test-path $sLogFile) { remove-item $sLogFile }
#-----------------------------------------------------------[Functions]------------------------------------------------------------

#-----------------------------------------------------------[Execution]------------------------------------------------------------

#$Users = Get-ADUser -SearchBase "OU=AllUsers,DC=NMI,DC=local" -Filter {Enabled -eq $true }

$Users = Get-ADUser -Filter * -Properties * -SearchBase "OU=AllUsers,DC=NMI,DC=local" |
?{$_.distinguishedname -notlike "OU=Disabled Accounts" }

add-content -path $sLogFile -value "NMI-ADUsers;$rDate"
add-content -path $sLogFile -value ""
add-content -path $sLogFile -value "Name;User Principal Name;Display Name;sAMAccountName;description;userAccountControl;AccountwhenCreated;Account Enabled;whenChanged;lastLogon;pwdLastSet;accountExpires;Primary Group;MemberOf"

ForEach ($i in $Users){
$Dn = $i.DisplayName
$eMail = $i.EmailAddress
add-content -path $sLogFile -value "$Dn,$EMail"
}



