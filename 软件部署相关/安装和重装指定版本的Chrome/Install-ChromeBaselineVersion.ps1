function Check-FileVersionCompliance()
  {
  param( [string]$filepath,[string]$VerNumber)

  if (test-path $filepath)

  {   $fileVer =  [System.Diagnostics.FileVersionInfo]::GetVersionInfo($filepath).FileVersion
      if ([Version]($fileVer) -lt $VerNumber) { return $true }
      else { return $false}
  }

}


 function Create-ChromeShortcuts()
 {
    $TargetFile   = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    $ShortcutFile = "C:\Users\Public\Desktop\Google Chrome.lnk"
    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut     = $WScriptShell.CreateShortcut($ShortcutFile)
    $Shortcut.TargetPath = $TargetFile
    $Shortcut.Save()
}

function Start-PrecheckCleanUp()
{
     #Terminate running processes
     $mainprocs = Get-WmiObject Win32_Process -Filter "name like 'chrome.exe'" 
     if (![string]::IsNullOrEmpty($mainprocs)) {$mainprocs|foreach{$_.terminate()}}
     $otherprocs = Get-WmiObject Win32_Process -Filter "name like 'Google%.exe'" 
     if (![string]::IsNullOrEmpty($otherprocs)) {$otherprocs|foreach{$_.terminate()}}

     #method1、Uninstall MSI-deployment Installations       
     Wmic product where "name like 'Google%'" call uninstall /nointeractive |out-null
     #Remove Revelant Chrome Registry Remains
     if (test-path -Path HKLM:\SOFTWARE\Policies\Google\Update)
     {
        Remove-Item -Path "HKLM:\SOFTWARE\Policies\Google\Update" -Recurse -force
     }

     #method2、Uninstall Per-user Installations
     $chromeinstances=get-childitem -Path c:\users -Recurse -force -Filter chrome.exe -Exclude 'C:\Users\All Users' -ErrorAction SilentlyContinue 

     if (![string]::IsNullOrEmpty($chromeinstances))
        {
            $chromeinstances|ForEach{
            $AppVer = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($_).FileVersion
            $InstallerDir = $_.DirectoryName+"\"+$AppVer+"\"+"installer\setup.exe"
            Start-Process -FilePath $InstallerDir -ArgumentList "--uninstall --chrome --system-level --force-uninstall"
            #perform cleanup of remaining 
            Remove-Item -Path $_.DirectoryName -Force -Recurse -ErrorAction SilentlyContinue
  
            }  
    
        }
        
        $chromeshortcuts=get-childitem -Path c:\users -Recurse -force -Filter Google*.lnk  -ErrorAction SilentlyContinue
        if (![string]::IsNullOrEmpty($chromeshortcuts))
        {
            $chromeshortcuts|ForEach{
            #perform cleanup of remaining 
            $_.Delete()

  
            } 


    }    

     Create-ChromeShortcuts
  
 }


$BaselineVersion="78.0.3904.108"
$Base_dir=Split-Path -Path $MyInvocation.MyCommand.Definition
#if common install directories
if ((test-path -path "C:\Program Files\Google\Chrome\Application\chrome.exe") -or (test-path -path "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"))

     {
       #if lower versions are present 
        if  ((Check-FileVersionCompliance -filepath "C:\Program Files\Google\Chrome\Application\chrome.exe" -VerNumber $BaselineVersion) -or (Check-FileVersionCompliance -filepath "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" -VerNumber $BaselineVersion))

            {
                 #remove older versions
                $FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
               "$FormattedDate last result: Old version found.Starting the uninstallation... "|out-file $Base_dir\Result.log -Append
                Start-PrecheckCleanUp

                 #starting installation process
                Start-Process -FilePath $Base_dir\Chrome_v78_X64.msi -ArgumentList "/qn" -ErrorAction Continue 
                $FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
               "$FormattedDate last result: Chrome has been upgraded successfully! "|out-file $Base_dir\Result.log -Append
 
             }
             #Approved Chrome already installed
           else {
           $FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
           "$FormattedDate last result: Installed Chrome is already in compliance"|out-file $Base_dir\Result.log -Append
           }  

      
      }
      
      #Reinstall Chrome if not residing in right place
      else
      {
            
         #remove older versions
         Start-PrecheckCleanUp
         #starting installation process
         $Base_dir=Split-Path -Path $MyInvocation.MyCommand.Definition
         Start-Process -FilePath $Base_dir\Chrome_v78_X64.msi -ArgumentList "/qn" -ErrorAction SilentlyContinue 
         $FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        "$FormattedDate last result: Chrome has been reinstalled and relocated"|out-file $Base_dir\Result.log -Append      
 }
 





     


