$LastLogonDate= (Get-Date).AddDays(-180)
Get-ADUser -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate } -SearchBase 'dc=Solex-server,dc=com'  `
|?{$_.Enabled –eq $True}  `
| Sort LastLogonTimeStamp  `
| FT Name, @{N='lastlogontimestamp'; E={[DateTime]::FromFileTime($_.lastlogontimestamp)}} -AutoSize