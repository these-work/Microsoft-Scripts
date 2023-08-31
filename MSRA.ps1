# Define the Write-Log function
function Write-Log {
    param(
        [string]$Message,
        [string]$LogFile
    )
    
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $LogMessage = "$Timestamp - $Message"
    $LogMessage | Out-File -Append -FilePath $LogFile
}

# Define the path to the log file in the current directory
$LogFile = Join-Path -Path $PSScriptRoot -ChildPath "LogFile.log"

# Run the first SaRAcmd.exe command with logging
Write-Log "Starting SaRAcmd.exe (OfficeActivationScenario)" -LogFile $LogFile
Start-Process -FilePath ".\SaRAcmd.exe" -ArgumentList "-S OfficeActivationScenario -AcceptEula -CloseOffice -RemoveSCA" -Wait
Write-Log "SaRAcmd.exe (OfficeActivationScenario) completed" -LogFile $LogFile

# Run the second SaRAcmd.exe command with logging
Write-Log "Starting SaRAcmd.exe (OfficeScrubScenario)" -LogFile $LogFile
Start-Process -FilePath ".\SaRAcmd.exe" -ArgumentList "-S OfficeScrubScenario -AcceptEula -OfficeVersion All" -Wait
Write-Log "SaRAcmd.exe (OfficeScrubScenario) completed" -LogFile $LogFile
