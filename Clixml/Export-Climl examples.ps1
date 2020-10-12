# Very simple example from MS Documentation

"This is a test" | Export-Clixml -Path sample.xml

# When the script runs with the same user you want to store the credentails of
# E.g. your own account

$cred = Get-Credential
$cred | Export-Clixml my.cred 

# When the script runs with a service account or SYSTEM

# Get the password or the token from a txt file and Convert the password in a Secure String
$password = Get-Content -Path 'C:\Users\giezzi\RIVER\Work\DuPSUG 2020\pwd.txt' | ConvertTo-SecureString -asPlainText -Force
# Remove the password from the file
Set-Content -Path 'C:\Users\giezzi\RIVER\Work\DuPSUG 2020\pwd.txt' -Value ""
# Set the username: either a real username or just anything if the secret is only a token
$username = "token"
# Create a new PSCredential object to link the username and password together
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
# Export the PSCredentail object to the file
$credential | Export-CliXml -Path 'C:\Users\giezzi\RIVER\Work\DuPSUG 2020\file.cred'
