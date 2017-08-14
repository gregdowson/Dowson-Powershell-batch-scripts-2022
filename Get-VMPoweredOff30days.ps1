$vms = Get-VM | where {$_.PowerState -eq "PoweredOff"}
$vmPoweredOff = $vms | %{$_.Name}
$events = Get-VIEvent -Start (Get-Date).AddDays(-30) -Entity $vms | 
  where{$_.FullFormattedMessage -like "*is powered off"}
$lastMonthVM = $events | %{$_.Vm.Name}
$moreThan1Month = $vmPoweredOff | where {!($lastMonthVM -contains $_)} 

$moreThan1Month | Export-CSV "U:\VMWare\VMsOff30days.csv"