$sftpHost = "ip address"

$port = "1255"

$userName = "yourUserName"
$userPassword = "yourPassword"
$remotedirectory = "/usr/home/transfer"
$localFileList = "C:\file1.txt", "C:\file2.txt", "C:\file3.txt"
$sftp = Open-SFTPServer -serverAddress $sftpHost -userName $userName -userPassword $userPassword
$sftp.Put($remotedirectory)
#Upload the local file to another folder on the SFTP server
$sftp.Put($remotedirectory, "/SomeFolder")
#Upload the local file to the root folder on the SFTP server with a specific filename
$sftp.Put($remotedirectory, "/downloadedFile.txt")
#Upload a list of local files to the root folder on the SFTP server
$sftp.Put($localFileList)
#Upload a list of local files to another folder on the SFTP server
$sftp.Put($localFileList, "/SomeFolder")

#Close the SFTP connection
$sftp.Close()