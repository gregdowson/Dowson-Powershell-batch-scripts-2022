function Expand-ZIPFile($file, $destination)
{
$shell = new-object -com shell.application
$zip = $shell.NameSpace($file)
foreach($item in $zip.items())
{
$shell.Namespace($destination).copyhere($item)
}
}
$servers= get-content "C:\scripts\rdsh.txt"
foreach ($server in $servers)
{Expand-ZIPFile –File “\\$server\c$\users\gayle.lord.zip” –Destination “\\$server\c$\users” }


