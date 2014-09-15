$ServerName = Get-Content "c:\scripts\Computers2.txt"  
  
foreach ($Server in $ServerName) {  
  
        if (test-Connection -ComputerName $Server -Count 2 -Quiet ) {   
          
            "$Server is Pinging "  
          
                    } else  
                      
                    {"$Server not pinging"  
              
                    }      
          
} 
