[cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        #[ValidateScript({Test-Path $_})]
        [string]$FilePath,
        [Parameter(Mandatory=$false)]
        [string]$Username="Administrator"
    )

Function Start-UpdateProcess()
{

    $LocalSetupFilePath= ("C:\Users\Public\OrBit Systems Inc\OrBit-Browser + R15\BrowserPro.exe.config")
    $RemotetSetupFilePath= "\\172.20.0.103\sop-file7\MESPREP\Updates\ClientConfig\BrowserPro.exe.config"




     if (Test-Path $RemotetSetupFilePath)
     {

            #Terminate running processes
            if (![string]::IsNullOrEmpty($mainprocs)) {$mainprocs|foreach{$_.terminate()}}
            Write-host "开始更新客户端配置文件到$env:COMPUTERNAME ...."
            Copy-Item -Path $RemotetSetupFilePath   -force -Destination $LocalSetupFilePath -ErrorAction SilentlyContinue


            $UpdateTimeStamp=[datetime]::Now
            
             Write-host "已经在$env:COMPUTERNAME 上成功更新配置文件！" -ForegroundColor Yellow
             #Write-Output "$UpdateTimeStamp Orbit ScreenSaver Updated on $env:COMPUTERNAME successfully!" | Out-File -FilePath ($LocalSetupFilePath+"\Updates_log.txt") -Force -Append
         } else{
         Write-host "存在错误。源配置文件\\172.20.0.103\sop-file7\MESPREP\Updates\ClientConfig\BrowserPro.exe.config不存在或网络是否正常" |Out-File -FilePath ($ScriptHomedir + "\UpdateClntConf_Reqcheck.txt")  -Force
         }


}

#Retrieve the script working directory
$ScriptHomedir=Split-Path -Path $MyInvocation.MyCommand.Definition
Enable-PSRemoting -Force |Out-Null

#Allow this local computer to trust ALL remote PS sessions.
Set-item wsman:\localhost\client\trustedhosts -value * -Force |Out-Null

#Check if the remote computer is online before starting a PS remote session
$Computers=Get-Content -Path $FilePath
$ComputersUp=@()
$ComputersDown=@()
$Computers|foreach{

    if(Test-Connection -ComputerName $_ -Quiet )
    {
        
        Write-host "测试线边电脑是否在线...." 
        Write-host ("......................" +$_+"在线！") -ForegroundColor Green
        $ComputersUp += $_


    }else {
       Write-host "测试线边电脑是否在线...."       
       Write-host (".................." +$_+"不在线！将不会更新.并写入日志UpdateClntConf_Failures.txt") -ForegroundColor Red
       $ComputersDown += $_

       }
}

       $ComputersUP|foreach{Write-Output (-join($_,"配置文件更新成功!"))|Out-File -FilePath ($ScriptHomedir + "\UpdateClntConf_Success.txt")  -Force -Append}
       $ComputersDown|foreach{ Write-Output (-join($ComputersDown,"不在线，配置文件更新失败!"))|Out-File -FilePath ($ScriptHomedir + "\UpdateClntConf_Failures.txt")  -Force}

#Call the function to begin install process.
if (![string]::IsNullOrEmpty($ComputersUp)) {Invoke-Command -ComputerName $ComputersUp -Credential (Get-Credential -UserName $Username -Message "请输入线边电脑的管理员密码") -ScriptBlock ${Function:Start-UpdateProcess} -ErrorAction SilentlyContinue}