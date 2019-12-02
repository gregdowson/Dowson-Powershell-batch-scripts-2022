function get-localadmin { 
param ($strcomputer) 
 
$admins = Gwmi win32_groupuser –computer $strcomputer  
$admins = $admins |? {$_.groupcomponent –like '*"Remote Desktop Users"'} 
 
$admins |% { 
$_.partcomponent –match “.+Domain\=(.+)\,Name\=(.+)$” > $nul 
$matches[1].trim('"') + “\” + $matches[2].trim('"') 
} 
}

$Servers = Get-Content C:\scripts\servers.txt
Foreach($Server in $Servers) {get-localadmin $Server}
   