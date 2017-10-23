#Staging and Production servers:

$sLogFile = "U:\logs\CheckFile.txt"

$Srvs = @("FIT-WIN-EPHS-06","FIT-WIN-EPHS-07","FIT-WIN-EPHS-08","FIT-WIN-EPHS-09",`
"FIT-WIN-EPHS-10","FIT-WIN-EPHS-11","FIT-WIN-EPHS-12","FIT-WIN-EPHS-13",`
"MSP-WIN-EPHS-05","MSP-WIN-EPHS-07","MSP-WIN-EPHS-08","MSP-WIN-EPHS-09")

Foreach ($i in $Srvs) {
		$DIR = "\\$i\D$\Ephesoft\Apache2.2\conf\"
		sl $DIR
		$File1 = Test-Path $DIR\server.crt
		$File2 = Test-Path $DIR\server.csr
		$File3 = Test-Path $DIR\server.key
	If ($file1) {add-content -path $sLogFile -value "$DIR\server.crt exists"}
	If ($file1) {add-content -path $sLogFile -value "$DIR\server.csr exists"}
	If ($file1) {add-content -path $sLogFile -value "$DIR\server.key exists"}
	add-content -path $sLogFile -value "r"
}
