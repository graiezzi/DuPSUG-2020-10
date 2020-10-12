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
