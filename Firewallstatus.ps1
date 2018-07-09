$ComputerList = gc "c:\scripts\computers.txt"
$ScriptBlock = { @(netsh advfirewall show domain state)[3] -replace 'State' -replace '\s' }
 
foreach ($Computer in $ComputerList) {
    if (Test-Connection -ComputerName $Computer -Quiet -Count 1) {
        try {
            $Status = Invoke-Command -ComputerName $Computer -ErrorAction Stop -ScriptBlock $ScriptBlock
        }
        catch {
            $Status = "Unable to retrieve firewall status"
        }
    }
    else {
        $Status = "Unreachable"
    }
    $Object = [PSCustomObject]@{
        Computer = $Computer
        Status = $Status
    }
 
    Write-Output $Object
    $Object | Export-Csv -Path "C:\scripts\FirewallStatus.csv" -Append -NoTypeInformation
 
}