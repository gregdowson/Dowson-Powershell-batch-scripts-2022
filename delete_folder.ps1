

function delete-remotefolder {
PROCESS { 
    $folder = "\\$_\c$\users\gayle.lord"
    if (test-path $folder) 
    {echo "$_gayle.lord exists"
     Remove-Item $folder -force
    echo "$_gayle.lord file deleted"}



























    $folder | % {$_.Delete } } }
 
    
