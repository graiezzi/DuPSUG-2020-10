Import-Module MyModule -Force
Import-Module ActiveDirectory

$path = "C:\Scripts\Trello\Trello-User-Deprovision"

# Date to rotate csv file export 
$dateFile = $(get-date -Format dd-MM-yyyy-HH-mm)

# Create a new Transcript logging file everytime the script runs
Start-Transcript -Path  "$path\Transcript-Logs\logs-$dateFile.txt" 

# Get token to access Trello
$creds = Import-Clixml -Path "$path\file.cred"
# Max number of users retrieved per page
$count = 100
# we are looking for all active users under the enterprise license
$filter = 'active eq true&sortBy=displayName'
#prepare uri putting together all the 
$uri = "https://trello.com/scim/v2/users?filter=$filter"

# Call function from MyModule
$userList = Get-RestMethodResultsCursorPaged -Credential $creds -Count $count -Uri $uri 

# Collecting the data we need in a PSCustomObject
$usersInTrelloObj = foreach ($item in $userList) {

    $email = $($item.emails | Where-Object {$_.primary -eq "True"}).value

    [PSCustomObject]@{
        Id = $item.id
        Created = $item.meta.created
        LastActive = $item.meta.lastActive
        Username = $item.username
        FirstName = $item.name.givenName
        LastName = $item.name.familyName
        Email = $email
        Active = $item.active
    }
}

# Prepare variables to call the Trello deactivate endpoint
# Get the token from the secure file to be able to call the end point
$token = $creds.GetNetworkCredential().Password
# Set the header of the API call with authenticaiton and format of the data sent
$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json"
}
# Set the body of the call in the format Trello is expecting the data to be sent to set the active flag to false
$body =@'
{
    "schemas": [
          "urn:ietf:params:scim:api:messages:2.0:PatchOp"
        ],
    "Operations": [ { "op": "replace", "value": { "active": false } } ]
  }
'@

# Search in AD who is disabled and build an object with only this list
foreach ( $user in $usersInTrelloObj ){ 
    $email = $user.Email
    $id = $user.Id
	$ADStatus = $(Get-ADUser -Filter "mail -eq '$email'" -Properties Enabled).Enabled
   
    if(!$ADStatus) {
        Invoke-RestMethod -Uri "https://trello.com/scim/v2/Users/$id" -Method "PATCH" -Headers $headers -Body $body
    }
}

Stop-Transcript