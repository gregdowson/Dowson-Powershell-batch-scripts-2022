$computers = unregistered.txt
ForEach ($computer in $computers){restart-servce -Servicename BrokerAgent}