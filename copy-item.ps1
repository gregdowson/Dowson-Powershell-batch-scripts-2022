$servers= get-content "C:\scripts\rdsh.txt"
foreach ($server in $servers) { copy-item \\fit-win-rdsh-05\C$\users\gayle.lord  \\$server\c$\users\ -force} 