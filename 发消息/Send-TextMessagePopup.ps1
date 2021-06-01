$Computers="s0830","s0632"

$msg="你好，这里是资讯部林提祥。你的电脑已经完成了杀毒软件的升级，清你尽快完成一次电脑重启。如有疑问，请电话130-630-84890"

Invoke-WmiMethod -path win32_process -name Create -ArgumentList "msg * $msg" -ComputerName $Computers





#################

$Computers="s0830","s0632","s0998","g010"

$msg="你好，这里是资讯部林提祥。你的电脑已经完成了补丁KB4474419的安装，清你尽快完成一次电脑重启。如有疑问，请电话130-630-84890"

Invoke-WmiMethod -path win32_process -name Create -ArgumentList "msg * $msg" -ComputerName $Computers


###########

while(1)
{
    if (!(Test-NetConnection -ComputerName s3787).PingSucceed)
    {
        write-host " Computer reboot in progress"
        return
    }

$msg="你好，这里是资讯部林提祥。你的电脑已经完成了补丁KB4474419的安装，清你尽快完成一次电脑重启。如有疑问，请电话130-630-84890"

Invoke-WmiMethod -path win32_process -name Create -ArgumentList "msg * $msg" -ComputerName s3787

Start-Sleep -Seconds 5


    }