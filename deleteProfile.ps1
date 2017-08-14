function delete-remotefile {
    PROCESS {
                $file = "\\$_\c$\users\gayle.lord"
               
                Remove-Item $file -force 
                       }
            }

 
 
Get-Content  C:\Scripts\rdsh.txt | delete-remotefile 
