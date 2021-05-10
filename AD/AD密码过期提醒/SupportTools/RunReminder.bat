@echo off
Set PSPath=C:\AdminPack\SupportTools\PasswordChangeNotification.ps1
set PSOptions=-smtpServer solexmail02.solex-server.com -expireInDays 5 -from "itsd@solex.com" -Logging -LogPath "C:\AdminPack\SupportTools\logFiles" -reportTo tixiang_lin@solex.com
set PSExecOption=-NoProfile -NoLogo -NonInteractive -ExecutionPolicy Bypass -File
powershell.exe %PSExecOption% %PSPath% %PSOptions%
