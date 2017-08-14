#By Metos 14 Sept 2013 
#This script create DNS A Record and associate Reverse PTR
#Create records.csv file with Computer,IP information
#see example below add first line to your csv file
#
#Computer,IP
#Computer,192.168.0.1
#Computer1,192.168.0.2
#Computer2,192.168.0.3
#
#Change with your dns server info $Servername and $Domain
$ServerName = "NMIH-INTAD05"
$domain = "nmi.local"
Import-Csv .\Records.csv | ForEach-Object {

#Def variable
$Computer = "$($_.Name)" #.$domain"
$addr = $_.IP -split "\."
$rzone = "$($addr[2]).$($addr[1]).$($addr[0]).in-addr.arpa"
Write-host "$computer `t$domain `t$addr `t$rzone"
#Create Dns entries

dnscmd $Servername /recordadd $domain "$($_.Computer)" A "$($_.IP)"

#Create New Reverse Zone if zone already exist, system return a normal error
dnscmd $Servername /zoneadd $rzone /primary

#Create reverse DNS
dnscmd $Servername /recordadd $rzone "$($addr[3])" PTR $Computer
}cls


# Retrieving IP addresses for all VMs
Get-VM | Get-VMGuest | Format-Table VM, IPAddress

#Add CNAME
Add-DnsServerResourceRecordCName -Name "labsrv1" -HostNameAlias "srv1.lab.contoso.com" -ZoneName "contoso.com"


<# Example 1: Create a primary zone
This command creates an Active Directory-integrated forward lookup zone called west01.contoso.com with Forest-wide replication scope.
Windows PowerShell #>
Add-DnsServerPrimaryZone -Name "west01.contoso.com" -ReplicationScope "Forest" -PassThru 

<# Example 2: Create a file-backed primary zone
This command creates a file-backed primary forward lookup zone called west02.contoso.com with the specified DNS file.
Windows PowerShell #>
Add-DnsServerPrimaryZone -Name "west02.contoso.com" -ZoneFile "west02.contoso.com.dns"

<# Example 3: Create a reverse lookup zone
This command creates the Active Directory-integrated class C reverse lookup zone 0.1.10.in-addr.arpa with Forest-wide replication scope.
Windows PowerShell #>
Add-DnsServerPrimaryZone -NetworkID "10.1.0.0/24" -ReplicationScope "Forest" 

<# Example 4: Create a file-backed reverse lookup zone
This command creates the file-backed reverse lookup zone 0.3.10.in-addr.arpa.
Windows PowerShell #>
Add-DnsServerPrimaryZone -NetworkID 10.3.0.0/24 -ZoneFile "0.3.10.in-addr.arp"


# To query using them you add the property after RecordData, for instance :
Get-DnsServerResourceRecord -ZoneName "nmi.local" | Where-Object {$_.RecordData.IPv4Address -eq "192.168.0.1"}