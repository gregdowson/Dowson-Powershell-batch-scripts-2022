

 
	
# This is the file that contains the list of computers you want 
# to copy the folder and files to. Change this path IAW your folder structure.
$computers = gc "C:\scripts\rdsh.txt"
 
# This is the directory you want to copy to the computer (IE. c:\folder_to_be_copied)
$source = "c:\scripts\gayle.lord.zip"
 
# On the desination computer, where do you want the folder to be copied?
#$dest = "C$\users"
 
foreach ($computer in $computers) {
    if (test-Connection -Cn $computer -quiet) {
        Copy-Item $source -Destination \\$computer\C$\users -Recurse
    } else {
        "$computer is not online"
    }
 
}