<# 
 .Synopsis
  Displays disk usage.

 .Description
  Displays disk usage given hosts and credentials.

 .Parameter -ComputerName <String[]>
  Specifies the target computer for the management operation. Enter a fully qualified domain name (FQDN), a NetBIOS name, or an IP address. When the remote computer is in a different domain than the local computer, the fully qualified domain name is required. The default is the local computer. To specify the local computer, such as in a list of computer names, use "localhost", the local computer name, or a dot (.). This parameter does not rely on Windows PowerShell remoting, which uses WS-Management. You can use the ComputerName parameter of Get-WmiObject even if your computer is not configured to run WS-Management remote commands.

 .Parameter -Cred <PSCredential>
  Specifies a user account that has permission to perform this action. The default is the current user. Type a user name, such as User01, Domain01\User01, or User@Contoso.com. Or, enter a PSCredential object, such as an object that is returned by the Get-Credential cmdlet. When you type a user name, you are prompted for a password.

 .Example
   # Show local machine's disk usage.
   PS> DiskSpace 

 .Example
   # Show COMPUTER1 disk usage.
   PS> DiskSpace -ComputerName COMPUTER1 -Cred DOMAIN\USERNAME

 .Example
   # Show COMPUTER1, COMPUTER2 and COMPUTER3 disk usage.
   PS> DiskSpace -ComputerName @('COMPUTER1', 'COMPUTER2', 'COMPUTER3') -Cred DOMAIN\USERNAME
#>

function DiskSpace($ComputerName='.', $Cred) {
    if ($PSBoundParameters.ContainsKey('Cred')) {
        Get-WmiObject Win32_LogicalDisk -ComputerName $ComputerName -Cred $Cred | Select PSComputerName, DeviceID, @{ Name="Size(GB)"; Expression={ [Math]::Round($_.Size/1GB, 2) }}, @{ Name="FreeSpace(GB)"; Expression={ [Math]::Round($_.FreeSpace/1GB, 2) }}
    } else {
        Get-WmiObject Win32_LogicalDisk -ComputerName $ComputerName | Select PSComputerName, DeviceID, @{ Name="Size(GB)"; Expression={ [Math]::Round($_.Size/1GB, 2) }}, @{ Name="FreeSpace(GB)"; Expression={ [Math]::Round($_.FreeSpace/1GB, 2) }}
    }
}

export-modulemember -function DiskSpace
