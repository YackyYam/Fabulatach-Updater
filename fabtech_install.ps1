$fab_app_scanner = "https://www.fabulatech.com/dists/scanrdp/scanner-for-remote-desktop-server-64bit.msi"
$fab_file_scanner = "scanner-for-remote-desktop-server-64bit.msi"
$fab_app_usb = "https://www.fabulatech.com/dists/usbrdp/usb-for-remote-desktop-server-64bit.msi"
$fab_file_usb = "usb-for-remote-desktop-server-64bit.msi"
$fab_app_webcam = "https://www.fabulatech.com/dists/camrdp/webcam-for-remote-desktop-server-64bit.msi"
$fab_file_webcam = "webcam-for-remote-desktop-server-64bit.msi"
$fab_app_sound = "https://www.fabulatech.com/dists/sndrdp/sound-for-remote-desktop-server-64bit.msi"
$fab_file_sound = "sound-for-remote-desktop-server-64bit.msi"

$ProgressPreference = 'SilentlyContinue'

Clear-Host

Write-host "Downloading: " $fab_file_scanner
Invoke-WebRequest -Uri $fab_app_scanner -OutFile $fab_file_scanner
Write-host "Installing."
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", "`"$fab_file_scanner`"", "/qn", "/norestart" -Wait   

Write-host "Downloading: " $fab_file_usb
Invoke-WebRequest -Uri $fab_app_usb -OutFile $fab_file_usb
Write-host "Installing."
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", "`"$fab_file_usb`"", "/qn", "/norestart" -Wait   

Write-host "Downloading: " $fab_file_webcam
Invoke-WebRequest -Uri $fab_app_webcam -OutFile $fab_file_webcam
Write-host "Installing."
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", "`"$fab_file_webcam`"", "/qn", "/norestart" -Wait   

Write-host "Downloading: " $fab_file_sound
Invoke-WebRequest -Uri $fab_app_sound -OutFile $fab_file_sound
Write-host "Installing."
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", "`"$fab_file_sound`"", "/qn", "/norestart" -Wait   

Clear-Host

Write-host "Cleaning up files."
Write-host "Deleteing: " $fab_file_scanner
Write-host "Deleteing: " $fab_file_usb
Write-host "Deleteing: " $fab_file_webcam
Write-host "Deleteing: " $fab_file_sound

Write-host ""
Write-host ""

Write-host "Setting up Fabulatech services."
Write-host ""
Write-host "Setting 'ftnlsv3' to Delayed Start."
Set-Service -Name "ftnlsv3" -StartupType AutomaticDelayedStart
Write-host "Setting 'ftscansvc' to Delayed Start."
Set-Service -Name "ftscansvc" -StartupType AutomaticDelayedStart
Write-host "Setting 'ftsndsvc' to Delayed Start."
Set-Service -Name "ftsndsvc" -StartupType AutomaticDelayedStart
Write-host "Setting 'ftusbrdsrv' to Delayed Start."
Set-Service -Name "ftusbrdsrv" -StartupType AutomaticDelayedStart
Write-host "Setting 'ftwebcamlicsvc' to Delayed Start."
Set-Service -Name "ftwebcamlicsvc" -StartupType AutomaticDelayedStart
sc stop ftusbrdsrv
reg delete HKLM\SYSTEM\CurrentControlSet\Enum\FABULATECH.COM  /v ftusbrdsrv /f
sc start ftusbrdsrv
sc stop ftwebcamlicsvc
reg delete HKLM\SYSTEM\CurrentControlSet\Enum\FABULATECH.COM  /v ftwebcamlicsvc /f
sc start ftwebcamlicsvc
sc stop ftscansvc
reg delete HKLM\SYSTEM\CurrentControlSet\Enum\FABULATECH.COM  /v ftscansvc /f
sc start ftscansvc
sc stop ftsndsvc
reg delete HKLM\SYSTEM\CurrentControlSet\Enum\FABULATECH.COM  /v ftsndsvc /f
sc start ftsndsvc

Write-host ""
Write-host ""
Write-host "Done."