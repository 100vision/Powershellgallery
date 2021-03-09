 $credential = get-credential -UserName Administrator
 $IPaddresses="172.20.1.123","172.20.1.125","172.20.1.133","172.20.1.138","172.20.1.110"
 $IPaddresses|foreach {invoke-command -ComputerName $_ -Credential $credential -ScriptBlock {$IntIndex=Get-NetAdapter |?{$_.status -eq "Up"}|select ifIndex;Set-DnsClientServerAddress -ServerAddresses ("192.168.0.14","192.168.0.24") -InterfaceIndex $IntIndex.ifIndex}}
