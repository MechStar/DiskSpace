# DiskSpace
Displays disk usage in Gigabytes given machines names and credentials.

### Parameter 'ComputerName'
The computer name(s). The default value is localhost.
### Parameter 'Cred'
The domain credentials to access the computer(s).

### Example - Show local machine's disk usage
```DiskSpace```
### Example - Show COMPUTER1 disk usage
```DiskSpace -ComputerName COMPUTER1 -Cred DOMAIN\USERNAME```
### Example - Show COMPUTER1, COMPUTER2 and COMPUTER3 disk usage
```DiskSpace -ComputerName @('COMPUTER1', 'COMPUTER2', 'COMPUTER3') -Cred DOMAIN\USERNAME```
