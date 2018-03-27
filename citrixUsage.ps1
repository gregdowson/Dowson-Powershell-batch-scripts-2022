#Region Settings
#Your License Server
$CitrixLicenseServer = “vmd-xd-mgmt”

#Do you want to report on licenses with 0 users?
$ShowUnusedLicenses = $true

#Toggle an alert above this percentage of licenses used
$UsageAlertThreshold = 0

#EndRegion Settings
#Region CollectData
#retrieve license information from the license server
$LicenseData = Get-WmiObject -class "Citrix_GT_License_Pool"  -namespace “ROOT\CitrixLicensing” -ComputerName $CitrixLicenseServer
$usageReport = @()
$LicenseData | select-object pld -unique | foreach {
$CurrentLicenseInfo = “” | Select-Object License, Count, Usage, pctUsed, Alert
$CurrentLicenseInfo.License = $_.pld
$CurrentLicenseInfo.Count = ($LicenseData | where-object {$_.PLD -eq $CurrentLicenseInfo.License } | measure-object -property Count -sum).sum
$CurrentLicenseInfo.Usage = ($LicenseData | where-object {$_.PLD -eq $CurrentLicenseInfo.License } | measure-object -property InUseCount -sum).sum
$CurrentLicenseInfo.pctUsed = [Math]::Round($CurrentLicenseInfo.Usage / $CurrentLicenseInfo.Count * 100,2)
$CurrentLicenseInfo.Alert = ($CurrentLicenseInfo.pctUsed -gt $UsageAlertThreshold)
if ($ShowUnusedLicenses -and $CurrentLicenseInfo.Usage -eq 0) {
$usageReport += $CurrentLicenseInfo
} elseif ($CurrentLicenseInfo.Usage -ne 0) {
$usageReport += $CurrentLicenseInfo
}
}
#EndRegion CollectData
$usageReport |Select-Object @{name=’Date-time’;Expression={Get-Date} },License,Count,Usage,PctUsed,Alert|ft -AutoSize|Out-File -Append C:\report_do_not_delete\$(get-date -uformat “%Y-%m-%d”).txt
