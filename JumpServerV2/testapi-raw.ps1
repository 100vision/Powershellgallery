$username = "superapi"
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


$data = Import-Csv -Path C:\users\tixiang_lin\Desktop\assets.csv  -Delimiter ","
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
