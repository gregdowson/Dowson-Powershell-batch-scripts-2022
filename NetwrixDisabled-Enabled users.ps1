Get-ADUser -Filter * -SearchBase "OU=Enabled Accts,OU=Netwrix-Deny,DC=ds,DC=usfca,DC=edu" | FT Name, Enabled
