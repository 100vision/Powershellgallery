﻿$username = "superapi"
$password = "powershellGuru"
$ResourceUri = "https://bastion.solex-server.com/api/v1/assets/assets/"
$AuthUri="https://bastion.solex-server.com/api/v1/authentication/auth/"

$Login = @{
    username= 'superapi'
    password= 'powershellGuru'

}

$json = $Login |ConvertTo-Json



$response=Invoke-RestMethod -Method Post -Uri $AuthUri -Body $json -ContentType 'application/json'
$token=$response.token
$token

$header = @{
"Authorization" ='Bearer '+$token
"Accept" = 'application/json'
"Content-Type" = 'application/json'
}


#$assets=Invoke-RestMethod -Method Get -Uri $ResourceUri  -Headers $header
#$assets

#$assets|Export-Csv -NoTypeInformation -Path C:\users\tixiang_lin\desktop\assets.csv 


$payload=Import-Csv -Path C:\users\tixiang_lin\Desktop\assets1.csv |ConvertTo-Json


#$assets|select hostname,ip,@{Label='protocols';expression={$_.protocols.split(",")}},is_active,admin_user,admin_user_display,@{Label='nodes';expression={$_.nodes.split(",")}},org_id,org_name  |ConvertTo-Json

Invoke-RestMethod -Method Post -Uri $ResourceUri  -Headers $header -Body $payload
