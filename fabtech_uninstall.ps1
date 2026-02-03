Write-Host "Gathering installed programs. Please wait. Takes about 10 sec."

$fab_installed = Get-WmiObject Win32_Product | Where-Object { $_.Vendor -like "FabulaTech" }

Clear-Host

foreach ($row in $fab_installed) {        
    if ($row -like "*scanner*") {
    Write-Host "Uninstalling version: " $row.Name
    Get-Package -Name $row.Name | Uninstall-Package -Force
    }elseif ($row -like "*usb*") {
    Write-Host "Uninstalling version: " $row.Name
    Get-Package -Name $row.Name | Uninstall-Package -Force
    }elseif ($row -like "*webcam*") {
    Write-Host "Uninstalling version: " $row.Name
    Get-Package -Name $row.Name | Uninstall-Package -Force
    }elseif ($row -like "*sound*") {
    Write-Host "Uninstalling version: " $row.Name
    Get-Package -Name $row.Name | Uninstall-Package -Force
    }
}

Write-Host "Please reboot the computer and run the Install script."