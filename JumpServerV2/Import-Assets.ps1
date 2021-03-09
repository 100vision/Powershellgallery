$username = "superapi"
$password = "powershellGuru"
$ResourceUri = "https://bastion.solex-server.com/api/v1/assets/assets/"
$AuthUri="https://bastion.solex-server.com/api/v1/authentication/auth/"

$Login = @{
    username= 'superapi'
    password= 'powershellGuru'

}

#Login to get token
$json = $Login |ConvertTo-Json
$response=Invoke-RestMethod -Method Post -Uri $AuthUri -Body $json -ContentType 'application/json'
$token=$response.token


$header = @{
"Authorization" ='Bearer '+$token
"Accept" = 'application/json'
"Content-Type" = 'application/json'
}




$data = Import-Csv -Path C:\users\tixiang_lin\Desktop\assets_network_sw_list.csv  -Delimiter ","
$data |foreach{

[System.Collections.ArrayList]$arrnodes = @()
$arrnodes.Add($_.nodes.split(",")[0])
$arrnodes.Add($_.nodes.split(",")[1])

[System.Collections.ArrayList]$arrprotocols = @()
$arrprotocols.Add($_.protocols.split(","))


$data|add-member -MemberType NoteProperty -Name nodes -Force -Value $arrnodes 
$data|add-member -MemberType NoteProperty -Name protocols -Force -Value $arrprotocols
} 

$data|ConvertTo-Json
$json=$data|ConvertTo-Json


Invoke-RestMethod -Method Post -Uri $ResourceUri  -Headers $header -Body $json
