$NeverExpires = 9223372036854775807
$NeverExpires2 = 0
$ExpringIn = (Get-Date).AddDays(0) 

##定义邮件发送邮件器配置
$smtpsettings = @{ 
    #To =  "it-ops@solex.com" 
    To =  "tixiang_lin@solex.com" 
    From = "ADAlert@solex.com" 
    Subject = "AD每周维护消息：以下离职人员账号已经被系统禁用" 
    SmtpServer = "solexmail02.solex-server.com" 
    } 


#查询符合条件的离职人员
$users = Get-ADUser -Filter * -SearchBase "OU=Users_离职人员,DC=solex-server,DC=com" -Properties accountExpires | 
Where-Object {$_.accountExpires -ne $NeverExpires -and $_.accountExpires -ne $NeverExpires2 -and [datetime]::FromFileTime([int64]::Parse($_.accountExpires)) -lt $ExpringIn -and $_.Enabled -ne $false}

$emailBody=""

#禁用账号
foreach($user in $users)

　　{disable-ADAccount -identity $User}



#清除组成员身份，只保留domain users组
foreach($user in $users)

　　{
　　　　$Membership = Get-ADPrincipalGroupMembership $User
　　　　$group = $Membership.distinguishedName -ne "CN=Domain Users,CN=Users,DC=solex-server,DC=com"
        Remove-ADPrincipalGroupMembership -identity $User -MemberOf $group -confirm:$False

        #定义邮件通知内容
         $emailBody = $emailBody +"`n" +$user.name + "------> " + $user.samaccountName + "----->离职日期：" + [datetime]::FromFileTime([int64]::Parse($user.accountExpires))
        
        }

#发送邮件通知
if ($emailBody){Send-MailMessage @smtpsettings -Body  $emailBody -Priority High -Encoding utf8}