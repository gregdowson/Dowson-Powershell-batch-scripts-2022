$appsec = gc AppsecAccount.txt
Foreach ($i in $appsec){
Disable-ADAccount -Identity $i }

