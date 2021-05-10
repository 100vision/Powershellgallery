$Computers="s2208","s3195","s1051","s3326","s3146","s1489","s1684","s2900"

$msg="你好，这里是资讯部林提祥。你的电脑已经完成了杀毒软件的升级，清你尽快完成一次电脑重启。如有疑问，请电话130-630-84890"

Invoke-WmiMethod -path win32_process -name Create -ArgumentList "msg * $msg" -ComputerName $Computers
