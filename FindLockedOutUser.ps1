If (test-path c:\temp\LockedOut.txt) { del c:\temp\LockedOut.txt }
$Date = Get-Date -format "MM-dd-yyyy"
Add-Content -path c:\temp\LockedOut.txt -Value "LockedOut Status as of $Date"
Add-Content -path c:\temp\LockedOut.txt -Value "Source `tTimeCreated"
## Define the username that's locked out
$Username = 'rcopy'

## Find the domain controller PDCe role
$Pdce = (Get-AdDomain).PDCEmulator

## Build the parameters to pass to Get-WinEvent
$GweParams = @{
     #'Computername' = $Pdce
     'LogName' = 'Security'
     'FilterXPath' = "*[System[EventID=4740] and EventData[Data[@Name='TargetUserName']='$Username']]"
}

## Query the security event log
$Events = Get-WinEvent @GweParams
$Events | foreach {
$IP = $_.properties[1].Value 
$TimeCreated = $_.TimeCreated
Add-Content -path c:\temp\LockedOut.txt -Value "$IP `t$TimeCreated"
}