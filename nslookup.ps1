function nslookup\{nslookup}

$IPAddress = Get-content \\nmi.local\files\nmidocs\greg.dowson\Documents\Scripts\Servers3.txt
foreach ($IP in $IPAddress) {nslookup $IP}