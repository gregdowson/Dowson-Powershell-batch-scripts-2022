
$Servers = Get-content "C:\Scripts\Servers2.txt"
foreach ($Server in $Servers) {Get-ADComputer -Filter * -Property * | Format-Table Name,OperatingSystem,OperatingSystemServicePack,OperatingSystemVersion -Wrap –Auto}
