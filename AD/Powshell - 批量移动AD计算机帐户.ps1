$Destination = "OU=长泰,OU=Computers_PC,DC=solex-server,DC=com"
#solex-server.com/Computers_PC/长泰

Import-Csv -Path "D:\Tim\Dropbox\松霖\工具脚本\ComputerMove\changtai_wrks.csv" | Foreach-Object {Get-ADcomputer $_.ComputerName | Move-ADObject -TargetPath $destination}