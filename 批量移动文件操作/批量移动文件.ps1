$listofFiles =   [System.IO.Directory]::EnumerateFiles("D:\test","*.*","TopDirectoryOnly")

$listofFiles |% {
   $file = New-Object System.IO.FileInfo($_)    
   $date = Get-Date ($file.CreationTime)
   $filepath = ("{0}\{1:00}\{2:00}-{3}\{4:00}\" -f "D:\archives", $date.year, 
   $date.month, $date.toString("MMM"), $date.day)
   Write-Output ("Move: {0} to {1}" -f $file.Fullname, $filepath)

   if (! (Test-Path $filepath)) {       
      new-item -type Directory -path $filepath      
   }

   move-item $file $filepath
}   