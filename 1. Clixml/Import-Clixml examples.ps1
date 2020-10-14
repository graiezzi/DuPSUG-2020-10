# Retrieve the credential object from the secure file
$credential = Import-Clixml -Path "C:\Users\grazi\DuPSUG-2020-10\1. Clixml\file.cred"

# Retrieve username and password or the token from the secure file
$username = $credential.GetNetworkCredential().Username 
$password = $credential.GetNetworkCredential().Password

# Retrieve the token from the secure file
$token = $credential.GetNetworkCredential().Password

# Example 2 
# This works if you run the script from the shell but not in the task scheduled
$credential = Import-Clixml -Path .\file.cred
$token = $credential.GetNetworkCredential().Password