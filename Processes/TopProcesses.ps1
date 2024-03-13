# Script to display the top 10 processes for CPU and memory usage for the day

# Get current date
$today = Get-Date -Format "yyyy-MM-dd"

# Get top 10 processes by CPU and memory usage
$topProcesses = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10
$topMemoryProcesses = Get-Process | Sort-Object -Property WorkingSet -Descending | Select-Object -First 10

# Create report content
$report = @"
Top Processes by CPU Usage ($today):
$($topProcesses | Format-Table -AutoSize | Out-String)

Top Processes by Memory Usage ($today):
$($topMemoryProcesses | Format-Table -AutoSize | Out-String)
"@

# Save report to a file
$reportPath = "C:\Reports\TopProcessesReport_$today.txt"
$report | Out-File -FilePath $reportPath