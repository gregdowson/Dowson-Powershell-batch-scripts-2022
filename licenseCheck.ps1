#add the snapin
asnp Citrix.Licensing.Admin* 
# get the cert hash which is needed for the Get-LicInventory command
$certhash = (get-liccertificate -adminaddress 138.202.84.121).certhash
# get all the licenses where the licenses are actually being used, and discard the start-up license
$license = Get-LicInventory -AdminAddress 138.202.84.121 -CertHash $certhash | ?{($_.licensesinuse -ne "0") -and ($_.LocalizedLicenseProductName -notlike "citrix start-up*")}
# foreach loop will go through each license record in $license, calculate the usage and spit out the results for you
foreach ($lic in $license) {
$percentused = ("{0:P0}" -f ([math]::round(($lic.licensesinuse / $lic.LicensesAvailable),2))) -replace " ",""
$lic.LocalizedLicenseProductName
write-host "In Use:" $lic.licensesinuse
write-host "Total:" $lic.licensesavailable
$remain = $lic.licensesavailable - $lic.licensesinuse
write-host "Remaining:" $remain
write-host "$percentused Used"
}
<# Results will look like this
Citrix XenDesktop Enterprise
In Use: 208
Total: 300
Remaining: 92
69% Used
#>