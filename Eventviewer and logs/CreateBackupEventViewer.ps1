# Run on a machine to build logs farther back than 300

$backupLogPath = "$env:TEMP\mylog.evtx"

$logfile = Get-CimInstance Win32_NTEventlogFile | Where-Object LogfileName -EQ "System"

Invoke-CimMethod -InputObject $logfile -MethodName BackupEventLog -Arguments @{ ArchiveFileName = $backupLogPath }