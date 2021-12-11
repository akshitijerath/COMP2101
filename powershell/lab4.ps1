#System information
function get-sysinfo{
    $sys = Get-WmiObject -class win32_computersystem | Select-Object Description 
    
    $sys.PSObject.Properties | ForEach-Object {
        if( $_.Value  -eq $null ){$_.Value = "data unavailable"}
    }
    $sys | format-list
}
# OS details
function get-osinfo{
    $os = Get-WmiObject -class win32_operatingsystem | Select-Object Name, Version
    $os.PSObject.Properties | ForEach-Object {
        if( $_.Value  -eq $null ){$_.Value = "data unavailable"}
    }
    $os | format-list  
}

# Processor Info
function get-processorinfo{
        $cpu = Get-WmiObject -class win32_processor | Select-Object Description , CurrentClockSpeed, NumberOfCores, L1CacheSize, L2CacheSize, L3CacheSize 
        $cpu.PSObject.Properties | ForEach-Object {
            if( $_.Value  -eq $null ){$_.Value = "data unavailable"}
        }
	    $cpu | format-list        

}
    
# Network information
function get-networkinfo{
    $network_details = Get-WmiObject -class win32_networkadapterconfiguration | 
        where IPEnabled -eq "True" | 
            Select-Object Description, Index, IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder
    $network_details.PSObject.Properties | ForEach-Object {
        if( $_.Value  -eq $null ){$_.Value = "data unavailable"}
    }
	$network_details | format-table -auto
}

# Memory Information
function get-memoryinfo{
    $memory = Get-WmiObject -class win32_physicalmemory
    $total = '' + $($memory.Capacity / 1mb -as [int]) + "MB"
    $memory = $memory | Select-Object Manufacturer,Description ,Capacity, BankLabel, PositionInRow 
    $memory.PSObject.Properties | ForEach-Object {
        if( $_.Value  -eq $null ){$_.Value = "data unavailable"}
    }
	$memory | format-table -auto
    Write-Host "Total RAM installed: $total"
    Write-Host ""
}
    
function get-diskinfo {
    $diskdrives = Get-CIMInstance CIM_diskdrive
    
    foreach ($disk in $diskdrives) {
          $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
          foreach ($partition in $partitions) {
                $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
                foreach ($logicaldisk in $logicaldisks) {
                         $part = new-object -typename psobject -property @{
                            Manufacturer=$disk.Manufacturer
                            Location=$partition.deviceid
                            Drive=$logicaldisk.deviceid
                            "Size(GB)"=$logicaldisk.size / 1gb -as [int]
                         }
                         $part | format-table
               }
          }
      }
}

function get-videoinfo{
    $video = Get-WmiObject -class win32_videocontroller
    $video_details=new-object -typename psobject -property @{
        Vendor=$video.VideoProcessor
	# Size=$(if($video.TimeOfLastReset -ne $null){$video.TimeOfLastReset}else{"data unavailable"})
        Description=$video.Description
        Resolution='' + $video.CurrentHorizontalResolution +' X '+ $video.CurrentVerticalResolution
    } 
    $video_details.PSObject.Properties | ForEach-Object {
        if( $_.Value  -eq $null ){$_.Value = "data unavailable"}
    }
	$video_details | format-list
}

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
