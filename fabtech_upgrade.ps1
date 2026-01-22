$fab_app_scanner = "https://www.fabulatech.com/dists/scanrdp/scanner-for-remote-desktop-server-64bit.msi"
$fab_file_scanner = "scanner-for-remote-desktop-server-64bit.msi"
$fab_url_scanner = "https://www.fabulatech.com/scanner-for-remote-desktop-download.html"
$fab_app_usb = "https://www.fabulatech.com/dists/usbrdp/usb-for-remote-desktop-server-64bit.msi"
$fab_file_usb = "usb-for-remote-desktop-server-64bit.msi"
$fab_url_usb = "https://www.fabulatech.com/usb-for-remote-desktop-download.html"
$fab_app_webcam = "https://www.fabulatech.com/dists/camrdp/webcam-for-remote-desktop-server-64bit.msi"
$fab_file_webcam = "webcam-for-remote-desktop-server-64bit.msi"
$fab_url_webcam = "https://www.fabulatech.com/webcam-for-remote-desktop-download.html"
$fab_app_sound = "https://www.fabulatech.com/dists/sndrdp/sound-for-remote-desktop-server-64bit.msi"
$fab_file_sound = "sound-for-remote-desktop-server-64bit.msi"
$fab_url_sound = "https://www.fabulatech.com/sound-over-rdp-download.html"

$IsIn_scanner = 0
$IsIn_usb = 0
$IsIn_webcam = 0
$IsIn_sound = 0

$ProgressPreference = 'SilentlyContinue'

function Get-WebPageVersion {
    param (
        [Parameter(Mandatory)]
        [string]$Url
    )
    $start = "</strong> "
    $end   = "</h4>"

    $html = Invoke-WebRequest $url -UseBasicParsing
    $content = $html.Content

    if ($content -match [regex]::Escape($start) + "(.*?)" + [regex]::Escape($end)) {
        $result = $matches[1]
        $result
    }
}

Clear-Host

Write-Host "Gathering installed programs. Please wait. Takes about 10 sec."

$fab_installed = Get-WmiObject Win32_Product | Where-Object { $_.Vendor -like "FabulaTech" }
Clear-Host
foreach ($row in $fab_installed){
    if ($row -like "*scanner*") {
        $IsIn_scanner = 1
        Write-Host "Installed version: " $row.Name
        $version = Get-WebPageVersion -Url $fab_url_scanner
        Write-Host "Current version "$version
        $yesNo = Read-Host -Prompt "Would you like to upgrade? (Y/N)"
        if ($yesno -eq "Y") {
            Get-Package -Name $row.Name | Uninstall-Package -Force
            Write-host "Downloading: " $fab_file_scanner
            Invoke-WebRequest -Uri $fab_app_scanner -OutFile $fab_file_scanner
            Write-host "Installing."
            Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", "`"$fab_file_scanner`"", "/qn", "/norestart" -Wait   
        }
        else {
            write-host "No"
        }
    }
    elseif ($row -like "*usb*") {
        $IsIn_usb = 1
        Write-Host "Installed version: " $row.Name
        $version = Get-WebPageVersion -Url $fab_url_usb
        Write-Host "Current version "$version
        $yesNo = Read-Host -Prompt "Would you like to upgrade? (Y/N)"
        if ($yesno -eq "Y") {
            Write-Host "Uninstalling " $row.Name
            Get-Package -Name $row.Name | Uninstall-Package -Force
            Write-host "Downloading: " $fab_file_usb
            Invoke-WebRequest -Uri $fab_app_usb -OutFile $fab_file_usb
            Write-host "Installing."
            Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", "`"$fab_file_usb`"", "/qn", "/norestart" -Wait 
        }
        else {
            write-host "No"
        }
    }
    elseif ($row -like "*webcam*") {
        $IsIn_webcam = 1
        Write-Host "Installed version: " $row.Name
        $version = Get-WebPageVersion -Url $fab_url_webcam
        Write-Host "Current version "$version
        $yesNo = Read-Host -Prompt "Would you like to upgrade? (Y/N)"
        if ($yesno -eq "Y") {
            Write-Host "Uninstalling " $row.Name
            Get-Package -Name $row.Name | Uninstall-Package -Force
            Write-host "Downloading: " $fab_file_webcam
            Invoke-WebRequest -Uri $fab_app_webcam -OutFile $fab_file_webcam
            Write-host "Installing."
            Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", "`"$fab_file_webcam`"", "/qn", "/norestart" -Wait 
        }
        else {
            write-host "No"
        }
    }
    elseif ($row -like "*sound*") {
        $IsIn_sound = 1
        Write-Host "Installed version: " $row.Name
        $version = Get-WebPageVersion -Url $fab_url_sound
        Write-Host "Current version "$version
        $yesNo = Read-Host -Prompt "Would you like to upgrade? (Y/N)"
        if ($yesno -eq "Y") {
            Write-Host "Uninstalling " $row.Name
            Get-Package -Name $row.Name | Uninstall-Package -Force
            Write-host "Downloading: " $fab_file_sound
            Invoke-WebRequest -Uri $fab_app_sound -OutFile $fab_file_sound
            Write-host "Installing."
            Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", "`"$fab_file_sound`"", "/qn", "/norestart" -Wait  
        }
        else {
            write-host "No"
        }
    }
}

Clear-Host
If ($IsIn_scanner -eq 0){
    Write-Host "Fabulatech Scanner software not installed."
    $yesNo = Read-Host -Prompt "You you like to install? (Y/N): "
    if($yesNo -eq "Y"){
        Write-host "Downloading: " $fab_file_scanner
        Invoke-WebRequest -Uri $fab_app_scanner -OutFile $fab_file_scanner
        Write-host "Installing."
        Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", "`"$fab_file_scanner`"", "/qn", "/norestart" -Wait   
    }
}
If ($IsIn_usb -eq 0){
    Write-Host "Fabulatech usb software not installed."
    $yesNo = Read-Host -Prompt "You you like to install? (Y/N): "
    if($yesNo -eq "Y"){
        Write-host "Downloading: " $fab_file_usb
        Invoke-WebRequest -Uri $fab_app_usb -OutFile $fab_file_usb
        Write-host "Installing."
        Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", "`"$fab_file_usb`"", "/qn", "/norestart" -Wait   
    }
}
If ($IsIn_webcam -eq 0){
    Write-Host "Fabulatech webcam software not installed."
    $yesNo = Read-Host -Prompt "You you like to install? (Y/N): "
    if($yesNo -eq "Y"){
        Write-host "Downloading: " $fab_file_webcam
        Invoke-WebRequest -Uri $fab_app_webcam -OutFile $fab_file_webcam
        Write-host "Installing."
        Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", "`"$fab_file_webcam`"", "/qn", "/norestart" -Wait   
    }
}
If ($IsIn_sound -eq 0){
    Write-Host "Fabulatech sound software not installed."
    $yesNo = Read-Host -Prompt "You you like to install? (Y/N): "
    if($yesNo -eq "Y"){
        Write-host "Downloading: " $fab_file_sound
        Invoke-WebRequest -Uri $fab_app_sound -OutFile $fab_file_sound
        Write-host "Installing."
        Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", "`"$fab_file_sound`"", "/qn", "/norestart" -Wait   
    }
}

Write-Host "Please reboot the computer."