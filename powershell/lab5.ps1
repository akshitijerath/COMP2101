param ($System, $Disks, $Network)

if ($System -ne $null){

    Write-Host "Operating System"
    Write-Host "================"
    get-osinfo
    Write-Host "CPU Information"
    Write-Host "==============="
    get-processorinfo
    Write-Host "Memory Information"
    Write-Host "==============="
    get-memoryinfo
    Write-Host "System Hardware"
    Write-Host "==============="
    get-sysinfo

    Write-Host "Video Card Information"
    Write-Host "==============="
    get-videoinfo

} elseif ($Disks -ne $null){
    Write-Host "Physical Disks Information"
    Write-Host "==============="
    get-diskinfo
} elseif ($Network){
    Write-Host "Network Information"
    Write-Host "==============="
    get-networkinfo
} else {
    Write-Host "System Hardware"
    Write-Host "==============="
    get-sysinfo
    Write-Host "Operating System"
    Write-Host "================"
    get-osinfo
    Write-Host "CPU Information"
    Write-Host "==============="
    get-processorinfo
    Write-Host "Memory Information"
    Write-Host "==============="
    get-memoryinfo
    Write-Host "Physical Disks Information"
    Write-Host "==============="
    get-diskinfo
    Write-Host ""
    Write-Host "Network Information"
    Write-Host "==============="
    get-networkinfo
    Write-Host "Video Card Information"
    Write-Host "==============="
    get-videoinfo

}
