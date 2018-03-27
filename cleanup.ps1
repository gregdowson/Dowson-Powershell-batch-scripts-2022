# Synopsis: This script is used to restart virtual desktops that are frozen on logoff or unregistered
Add-pssnapin Citrix.*
# Variables 
$To = "ITS-cs-desktopeng@usfcs.edu"
$From = "Citrix System"
$smtpServer = "smtp.usfca.edu"
$XenDesktopServer = 'Vmd-XD-mgmt@usfca.edu>:80'
#Sessions disconnected > 2 hours
$Time = (get-date).AddHours(-2)
$Computers = Get-BrokerDesktop -AdminAddress $xenDesktopServer | ?{($Time -gt $_.SessionStateChangeTime) -and ($_.PowerState -eq "On") -and ($_.MachineInternalState -eq 'Unregistered' -or $_.MachineInternalState -eq 'Disconnected')} | Select MachineName

 # Restart the unregistered machines
if ($computers -ne $null) {
    ForEach ($Computer in $Computers) 
    {New-BrokerHostingPowerAction -MachineName $Computer.MachineName -Action Restart}
           
	# Wait 10 Seconds to allow for the restarts to complete
    Start-Sleep -Seconds 30
    
    # Send an Email Notification
    $body = "All,br>br>The Following computers were restarted to resolve disconnected session issues:br>"
    ForEach ($computer in $Computers) { $body +=  " - "+$computer.MachineName+"br>" }
    $body += "br>*Please do not reply to this email."
    Send-MailMessage -SmtpServer $smtpServer -Subject "`'Disconnected Users Cleanup`' - Report." -Body $body -To $To -From $From -BodyAsHtml