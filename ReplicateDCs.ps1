Import-Module ActiveDirectory

$DCs = Get-ADDomainController -Filter *
Foreach ($DC in $DCs) {
$replicate = 'repadmin /syncall /A /d /e ' +$DC
iex $replicate
}
