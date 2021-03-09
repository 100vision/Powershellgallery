[cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        #[ValidateScript({Test-Path $_})]
        [string]$ComputerFilePath,
        [Parameter(Mandatory=$true)]
        #[ValidateScript({Test-Path $_})]
        [string]$SourceDirPath,
        [Parameter(Mandatory=$true)]
        #[ValidateScript({Test-Path $_})]
        [string]$TargetDirPath,
        [Parameter(Mandatory=$false)]
        [string]$Username="Administrator"
    )

Function Start-UpdateProcess()
{




     if (Test-Path $SourceDirPath)
     {
            $ReqCheckMessage=-join($env:COMPUTERNAME,"成功访问源文件夹，开始复制文件夹中.....")
            Write-host $ActionMessage -ForegroundColor Green
            Copy-Item -Path $SourceDirPath -force -Destination $TargetDirPath -Recurse  
            Write-host "已经成功复制文件夹到$env:COMPUTERNAME！" -ForegroundColor Yellow
         } else{
            $ReqCheckMessage=-join($env:COMPUTERNAME,"无法成功访问源文件夹或源文件夹不存在，网络异常.....请检查日志文件")
         Write-host $ReqCheckMessage |Out-File -FilePath ($ScriptHomedir + "\UpdateFiles_Reqcheck.txt")  -Force
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
       Write-host (".................." +$_+"不在线！将不会更新。错误写入日志OperationFailure.txt") -ForegroundColor Red
       $ComputersDown += $_

       }
}

       $ComputersUp|Out-File -FilePath ($ScriptHomedir + "\OperationSuccess.txt")  -Force
       $ComputersDown|Out-File -FilePath ($ScriptHomedir + "\OperationFailures.txt")  -Force

#Call the function to begin update process.
if (![string]::IsNullOrEmpty($ComputersUp)) {Invoke-Command -ComputerName $ComputersUp -Credential (Get-Credential -UserName $Username -Message "请输入线边电脑的管理员密码") -ScriptBlock ${Function:Start-UpdateProcess} -ErrorAction SilentlyContinue}