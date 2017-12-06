<# 
 .Synopsis
  Displays disk usage.

 .Description
  Displays disk usage in Gigabytes given machines names and credentials.

 .Parameter ComputerName
  The computer name(s). The default value is localhost.

 .Parameter Cred
  The domain credentials to access the computer(s).

 .Example
   # Show local machine's disk usage.
   DiskSpace 

 .Example
   # Show COMPUTER1 disk usage.
   DiskSpace -ComputerName COMPUTER1 -Cred DOMAIN\USERNAME

 .Example
   # Show COMPUTER1, COMPUTER2 and COMPUTER3 disk usage.
   DiskSpace -ComputerName @('COMPUTER1', 'COMPUTER2', 'COMPUTER3') -Cred DOMAIN\USERNAME
#>

function DiskSpace($ComputerName='.', $Cred) {
    if ($PSBoundParameters.ContainsKey('Cred')) {
        Get-WmiObject Win32_LogicalDisk -ComputerName $ComputerName -Cred $Cred | Select PSComputerName, DeviceID, @{ Name="Size(GB)"; Expression={ [Math]::Round($_.Size/1GB, 2) }}, @{ Name="FreeSpace(GB)"; Expression={ [Math]::Round($_.FreeSpace/1GB, 2) }}
    } else {
        Get-WmiObject Win32_LogicalDisk -ComputerName $ComputerName | Select PSComputerName, DeviceID, @{ Name="Size(GB)"; Expression={ [Math]::Round($_.Size/1GB, 2) }}, @{ Name="FreeSpace(GB)"; Expression={ [Math]::Round($_.FreeSpace/1GB, 2) }}
    }
}

export-modulemember -function DiskSpace
