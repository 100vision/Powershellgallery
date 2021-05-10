$Dest_dir= "c:\AdminPack"
$Base_dir=Split-Path -Path $MyInvocation.MyCommand.Definition -Parent 

if (Test-Path $Dest_dir)
{
  Copy-Item  $Base_dir $Dest_dir -Recurse -Force 
  Start-Process -FilePath C:\AdminPack\工具脚本\*.txt
  }
else
{
New-Item -ItemType directory -Path $Dest_dir
  Copy-Item $Base_dir  $Dest_dir -Recurse -Force
  }


