$originalProgressPreference = $ProgressPreference
$ProgressPreference = 'SilentlyContinue'
Write-Host "Download appx package..."
Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu.appx -UseBasicParsing
Write-Host "Download finished" 
$ProgressPreference = $originalProgressPreference

Write-Host "Installing"

Add-AppxPackage Ubuntu.appx 
