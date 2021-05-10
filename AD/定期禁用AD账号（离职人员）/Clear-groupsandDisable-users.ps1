#Load Exchange Management Shell Module
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn

$NeverExpires = 9223372036854775807
$NeverExpires2 = 0
$ExpringIn = (Get-Date).AddDays(0) 
$myDir = Split-Path -Parent $MyInvocation.MyCommand.Path


##定义邮件发送邮件器配置
$smtpsettings = @{ 
    #运维课邮件组
    To =  "it-ops@solex.com" 
    #To =  "tixiang_lin@solex.com" 
    From = "ADAlert@solex.com" 
    Subject = "AD每日维护消息：以下离职人员账号和Exchange邮箱已经被系统禁用" 

    #邮件服务器地址
    SmtpServer = "solexmail02.solex-server.com" 
    } 


#查询符合条件的离职人员
$users = Get-ADUser -Filter * -SearchBase "OU=Users_离职人员,DC=solex-server,DC=com" -Properties accountExpires | 
Where-Object {$_.accountExpires -ne $NeverExpires -and $_.accountExpires -ne $NeverExpires2 -and [datetime]::FromFileTime([int64]::Parse($_.accountExpires)) -lt $ExpringIn -and $_.Enabled -ne $false}

$emailBody=""

if($users)

{

    foreach($user in $users)

　　  {
        
            #禁用账号
            disable-ADAccount -identity $User

            #禁用Exchange邮箱
            $mailbox=get-mailbox -identity $User.SamAccountName
            if($mailbox) {disable-mailbox -identity $User.SamAccountName -confirm:$False}

         

            #清除组成员身份，只保留domain users组
　　　　    $Membership = Get-ADPrincipalGroupMembership $User
　　　　    $group = $Membership.distinguishedName -ne "CN=Domain Users,CN=Users,DC=solex-server,DC=com"
            if($group) {Remove-ADPrincipalGroupMembership -identity $User -MemberOf $group -confirm:$False}

            #写入日志
            $timestamp = Get-Date -DisplayHint Time
            "$timestamp  已经禁用账号$User.SamAccountName" |out-file "$myDir\actionLog.txt" -Append


            #定义邮件通知内容
             $emailBody = $emailBody +"`n" +$user.name + "------> " + $user.samaccountName + "----->离职日期：" + [datetime]::FromFileTime([int64]::Parse($user.accountExpires))
          }

          #发送邮件通知
if ($emailBody){Send-MailMessage @smtpsettings -Body  $emailBody -Priority High -Encoding utf8}


}




