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

    $LocalSetupFilePath= ($env:SystemRoot + "\system32\OrBitScreenSaver.scr")
    $RemotetSetupFilePath= "\\172.20.0.103\sop-file7\MESPREP\Updates\ScreenSavers\OrBitScreenSaver.scr"




     if (Test-Path $RemotetSetupFilePath)
     {
            Write-host -join($env:COMPUTERNAME,"成功访问源文件\\172.20.0.103\sop-file7\MESPREP\Updates\ScreenSavers\OrBitScreenSaver.scr ...") -ForegroundColor Green
            #Terminate running processes
            $mainprocs = Get-WmiObject Win32_Process -Filter "name like 'O%.scr'" 
            if (![string]::IsNullOrEmpty($mainprocs)) {$mainprocs|foreach{$_.terminate()}}
            Write-host "开始更新屏保文件到$env:COMPUTERNAME ...."
            Copy-Item -Path $RemotetSetupFilePath   -force -Destination $LocalSetupFilePath 


            $UpdateTimeStamp=[datetime]::Now
            
             Write-host "已经在$env:COMPUTERNAME 上成功更新OrbitScreenSaver！" -ForegroundColor Yellow
             #Write-Output "$UpdateTimeStamp Orbit ScreenSaver Updated on $env:COMPUTERNAME successfully!" | Out-File -FilePath ($LocalSetupFilePath+"\Updates_log.txt") -Force -Append
         } else{
         Write-host -join($env:COMPUTERNAME,"无法访问源文件\\172.20.0.103\sop-file7\MESPREP\Updates\ScreenSavers\OrBitScreenSaver.scr不存在或网络是否正常.详情请查看日志UpdateClntConf_Reqcheck.txt") |Out-File -FilePath ($ScriptHomedir + "\UpdateClntConf_Reqcheck.txt")  -Force
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
       Write-host (".................." +$_+"不在线！将不会更新。错误写入日志UpdateSCRFailure.txt") -ForegroundColor Red
       $ComputersDown += $_

       }
}

       $ComputersUp|Out-File -FilePath ($ScriptHomedir + "\UpdateSCRSuccess.txt")  -Force
       $ComputersDown|Out-File -FilePath ($ScriptHomedir + "\UpdateSCRFailures.txt")  -Force

#Call the function to begin update process.
if (![string]::IsNullOrEmpty($ComputersUp)) {Invoke-Command -ComputerName $ComputersUp -Credential (Get-Credential -UserName $Username -Message "请输入线边电脑的管理员密码") -ScriptBlock ${Function:Start-UpdateProcess} -ErrorAction SilentlyContinue}