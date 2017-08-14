<#
.SYNOPSIS
   <A brief description of the script>
.DESCRIPTION
   <A detailed description of the script>
.PARAMETER <paramName>
   <Description of script parameter>
.EXAMPLE
   <An example of using the script>
#>

Clear-Host

$Date = (Get-Date -format "MM-dd-yyyy")

Write-Host "Pick a Ephesoft Enviroment by Number"
Write-Host "1 Delegated"
Write-Host "2 Non-Delegated"
Write-Host "3 Staging"

$a = Read-Host "Enter your Ephesoft Number"

switch ($a) 
    { 
        1 {
		$DAR = @("FIT-WIN-EPHS-06","FIT-WIN-EPHS-07","FIT-WIN-EPHS-08","FIT-WIN-EPHS-09")
		Foreach ($i in $DAR) {
		#$LastFile = "ephesoftenterprise-stderr.2017-05-18.log"
		#$LastFile2 = "ephesoftenterprise-stdout.2017-05-18.log"
		$LastFile = "ephesoftenterprise-stderr*"
		$LastFile2 = "ephesoftenterprise-stdout*"
		$DIR = "\\$i\D$\Ephesoft\JavaAppServer\logs"
		sl $DIR
		$File = GCI $DIR -Filter $LastFile | select -Last 1
		
		$F = $File.Name
		md D:\Logs\Ephesoft\$i
		robocopy $DIR "D:\Logs\Ephesoft\$i\" $F /w:0 /r:0
		
		$File = GCI $DIR -Filter $LastFile2 | select -Last 1
		#zip $File.Name "$DIR\$File.ZIP"
		$F = $File.Name
		robocopy $DIR "D:\Logs\Ephesoft\$i\" $F /w:0 /r:0
			} 
		} 
		
		2 {
		
		$ND = @("FIT-WIN-EPHS-10","FIT-WIN-EPHS-11","FIT-WIN-EPHS-12","FIT-WIN-EPHS-13")
		If (test-path U:\){
		
		Foreach ($i in $ND) {
		$LastFile = "ephesoftenterprise-stderr.2017-06-10.log*"
		$LastFile2 = "ephesoftenterprise-stdout.2017-06-10.log"
		#$LastFile = "ephesoftenterprise-stderr*"
		#$LastFile2 = "ephesoftenterprise-stdout*"
		$DIR = "\\$i\D$\Ephesoft\JavaAppServer\logs"
		sl $DIR
		$File = GCI $DIR -Filter $LastFile | select -Last 1
		
		$F = $File.Name
		robocopy $DIR "U:\Logs\$i\" $F /w:0 /r:0
		
		$File = GCI $DIR -Filter $LastFile2 | select -Last 1
		#zip $File.Name "$DIR\$File.ZIP"
		$F = $File.Name
		robocopy $DIR "U:\Logs\$i\" $F /w:0 /r:0
				}
			}
		Else {write-host "U: drive not mapped"}
		}
		
		3 {
		
		$Stg = @("MSP-WIN-EPHS-05","MSP-WIN-EPHS-07","MSP-WIN-EPHS-08","MSP-WIN-EPHS-09")
        If (test-path U:\){
		Foreach ($i in $STG) {
		$LastFile = "ephesoftenterprise-stderr*"
		$LastFile2 = "ephesoftenterprise-stdout*"
		$DIR = "\\$i\D$\Ephesoft\JavaAppServer\logs"
		sl $DIR
		$File = GCI $DIR -Filter $LastFile | select -Last 1
		
		$F = $File.Name
		robocopy $DIR "U:\Logs\$i\" $F /w:0 /r:0
		
		$File = GCI $DIR -Filter $LastFile2 | select -Last 1
		
		$F = $File.Name
		robocopy $DIR "U:\Logs\$i\" $F /w:0 /r:0
				}
			}
			Else {write-host "U: drive not mapped"}
		}
		default {Write-Host "The Enviroment could not be determined."}
    }
	
	sl D:\scripts\ps1

