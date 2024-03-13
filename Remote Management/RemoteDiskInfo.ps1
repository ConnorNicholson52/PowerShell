# Function to query local disk usage on remote computers
function Get-RemoteDiskUsage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string[]]$ComputerName
    )

    begin {
        $total = $ComputerName.Count
        $counter = 0
    }

    process {
        foreach ($comp in $ComputerName) {
            $counter++
            Write-Progress -Activity "Querying Disk Information" -Status "Computer $comp ($counter/$total)" -PercentComplete (($counter / $total) * 100)

            try {
                $disks = Get-WmiObject Win32_LogicalDisk -ComputerName $comp -ErrorAction Stop | Where-Object { $_.DriveType -eq 3 }
                foreach ($disk in $disks) {
                    [PSCustomObject]@{
                        ComputerName = $comp
                        DriveLetter = $disk.DeviceID
                        FreeSpaceGB = [math]::Round($disk.FreeSpace / 1GB, 2)
                        TotalSpaceGB = [math]::Round($disk.Size / 1GB, 2)
                        UsedSpaceGB = [math]::Round(($disk.Size - $disk.FreeSpace) / 1GB, 2)
                    }
                }
            } catch {
                Write-Warning "Failed to query disk information on computer $comp"
            }
        }
    }

    end {
        Write-Progress -Activity "Querying Disk Information" -Completed
    }
}