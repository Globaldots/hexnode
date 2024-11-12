param (
    [string]$address
)

[String]$program = "C:\Hexnode\Hexnode Agent\Current\HexnodeAgent.exe"

function Get-InitiatingProcessExecutablePath {
    try {
        # Get the current process ID
        $currentProcessId = $PID

        # Get the current process instance using CIM
        $currentProcess = Get-CimInstance -ClassName Win32_Process -Filter "ProcessId = $currentProcessId"

        if ($currentProcess) {
            # Retrieve the parent process ID
            $parentProcessId = $currentProcess.ParentProcessId

            # Get the parent process details
            $parentProcess = Get-CimInstance -ClassName Win32_Process -Filter "ProcessId = $parentProcessId"

            # Return the executable path if the parent process was found
            if ($parentProcess) {
                return $parentProcess.ExecutablePath
            }
        }
    } catch {
        Write-Output "An error occurred: $_"
    }

    # Return null if parent process or its path is not found
    return $null
}
# Allow outgoing traffic to the specified website on all ports
#New-NetFirewallRule -DisplayName "Allow Outbound to $address" `
#                    -Direction Outbound `
#                    -Action Allow `
#                    -RemoteAddress $address

#New-NetFirewallRule -Name "from Hexnode Allow Port 443" `
#                    -DisplayName "from Hexnode Allow Port 443" `
#                    -Direction Outbound `
#                    -Enabled True `
#                    -Action Allow `
#                    -Protocol TCP `
#                    -RemotePort 443
#
#Remove-NetFirewallRule -Name "from Hexnode Allow Port 443"
$initiatingProcessPath = Get-InitiatingProcessExecutablePath
if ($initiatingProcessPath) {
    Write-Output "The executable path of the initiating process is: $initiatingProcessPath"
} else {
    Write-Output "Could not determine the initiating process executable path."
}

New-NetFirewallRule -Name "Hexnode Internet Access" `
                    -DisplayName "Hexnode Internet Access" `
                    -Direction Outbound `
                    -Program "$initiatingProcessPath" `
                    -Enabled True `
                    -Profile Any `
                    -Action Allow



Write-Output "Firewall rules created to allow outbound access to $initiatingProcessPath."
