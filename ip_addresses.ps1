E$servers = get-content "c:\scripts\servers.txt"
foreach ($server in $servers) {
  $addresses = [System.Net.Dns]::GetHostAddresses($server)
  foreach($a in $addresses) {
    "{0},{1}" -f $server, $a.IPAddressToString
  }
} > output.txt
