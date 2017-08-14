
function queryuser\{query user}

$Servername = Get-content "C:\Scripts\rdsh.txt"
foreach ($Server in $Servername) {query user |"$Server"  }