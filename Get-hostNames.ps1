
#Set Error Action to Silently Continue
$ErrorActionPreference = 'SilentlyContinue'

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$sScriptVersion = '1.0'

#Log File Info
$sLogPath = 'U:\'
$sLogName = 'HostLog.txt'
$sLogFile = Join-Path -Path $sLogPath -ChildPath $sLogName
$date = Get-Date
$rDate = (Get-Date -format "MM-dd-yyyy")
If(test-path $sLogFile) { remove-item $sLogFile }
add-content -path $sLogFile -value "NMI-ADServers `t$rDate"
add-content -path $sLogFile -value ""
add-content -path $sLogFile -value "Name `tCanonical Name"
$list = gc "D:\scripts\HostFileList.txt"
foreach ($i in $list) {
$comp = " "
	If (Test-connection -Count 1 -ComputerName $i) {
	[string]$comp = get-adcomputer $i -properties * | select "CanonicalName" 
	add-content -path $sLogFile -value "$i `t$comp"
	}
	Else { add-content -path $sLogFile -value "$i `tNo connection"
		}
}
