[cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateScript({Test-Path $_})]
        [string]$FilePath,
        [Parameter(Mandatory=$false)]
        [string]$Username="Administrator"
    )

Function Start-InstallProcess()
{

    $LocalSetupFilePath = "C:\AdminPack\SupportTools\SCCM"
    $RemotetSetupFilePath="\\172.20.0.103\sop-file7\MESPREP\SCCM\CCMSETUP"


     if (Test-Path $RemotetSetupFilePath)
     {

         if (Test-Path -Path $LocalSetupFilePath)
         {
            Remove-Item -Path $LocalSetupFilePath -Force -Recurse
          }

         Write-host "开始拷贝文件到$env:COMPUTERNAME ...."
         Copy-Item -Path $RemotetSetupFilePath  -Recurse -force -Destination $LocalSetupFilePath -ErrorAction SilentlyContinue

         Write-host "开始在$env:COMPUTERNAME 上安装SCCM客户端 ...."
         ([WMICLASS]"\\localhost\ROOT\CIMV2:win32_process").Create($LocalSetupFilePath + "\ccmsetup.exe"+" /mp:xmpritsccm01.solex-server.com SMSSITECODE=002 SMSMP=xmpritsccm01.solex-server.com DNSSUFFIX=solex-server.com") |Out-Null

         Write-host "已经在$env:COMPUTERNAME 上成功安装SCCM客户端！"
         Write-Output "$InstallTimeStamp SCCM Installed on $env:COMPUTERNAME successfully!" | Out-File -FilePath ($LocalSetupFilePath+"\Install_log.txt") -Force -Append
         } else {
         Write-host "安装包文件不存在或线边电脑网络异常导致无法访问安装文件所在位置" -ForegroundColor Red}

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
        $ComputersUp += $_


    }else {
       $ComputersDown += $_

       }
}

       $ComputersUp|Out-File -FilePath ($ScriptHomedir + "\ComputersUp.txt")  -Force
       $ComputersDown|Out-File -FilePath ($ScriptHomedir + "\ComputersDown.txt")  -Force

#Call the function to begin install process.
if (![string]::IsNullOrEmpty($ComputersUp)) {Invoke-Command -ComputerName $ComputersUp -Credential (Get-Credential -UserName $Username -Message "请输入线边电脑的管理员密码") -ScriptBlock ${Function:Start-InstallProcess} -ErrorAction SilentlyContinue}