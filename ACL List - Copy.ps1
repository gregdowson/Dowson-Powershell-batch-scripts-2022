Invoke-Command -Computer fit-win-dfss-02 -ScriptBlock {get-acl d:\nmishares\analytics | 
select -expand access } |
export-csv c:\temp\permissions_to_Analytics_folder.csv