# Example 1 - Very simple example from MS Documentation

"This is a test" | Export-Clixml -Path 'C:\Users\grazi\DuPSUG-2020-10\1. Clixml\sample.xml'

# Example 2 - Export the credentials manually

$cred = Get-Credential
$cred | Export-Clixml "C:\Users\grazi\DuPSUG-2020-10\1. Clixml\my.cred"

# Example 3 - When you don't want to create the file manually

$path = 'C:\Users\grazi\DuPSUG-2020-10\1. Clixml'
# Get the password or the token from a txt file and Convert the password in a Secure String
$password = Get-Content -Path "$path\pwd.txt" | ConvertTo-SecureString -asPlainText -Force
# Remove the password from the file
Set-Content -Path "$path\pwd.txt" -Value ""
# Set the username: either a real username or just anything if the secret is only a token
$username = "token"
# Create a new PSCredential object to link the username and password together
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
# Export the PSCredentail object to the file
$credential | Export-CliXml -Path "$path\file.cred"
