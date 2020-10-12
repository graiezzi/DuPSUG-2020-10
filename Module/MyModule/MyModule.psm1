# Returns an object containing all the items returned by an API call that uses pagination with cursors
function Get-RestMethodResultsCursorPaged{

    param(
        [Parameter(Mandatory = $true)]
        [pscredential]$Credential,

        [Parameter(Mandatory = $true)]
        [int]$Count,
        
        # number of users retrieved per page
        [Parameter(Mandatory = $true)]
        [uri]$Uri,

        [Parameter(Mandatory = $false)]
        [Microsoft.PowerShell.Commands.WebRequestMethod]
        $Method = 'Get'

    )
	
    # startIndex contains the index of the first user object in every call of the endpoint
    $startIndex = 1
    # Get the token from the encrypted file to pass to the header
    $token = $Credential.GetNetworkCredential().Password
    
    # Prepare the header
    $headers = @{
        "Authorization" = "Bearer $token"
    }
    # call the user endpoint to search for the amount of users under enterprise license
    $resultFirstCall = Invoke-RestMethod -Method $Method -Uri $Uri -Headers $headers
    # Extract the total amount of users from the results
    $totalResults = $resultFirstCall.totalResults
    # Divide it by $count to get how many pages we need to loop into
    $amountOfPages = [System.Math]::Floor(($totalResults / $Count))
    # temp object that has the last results returned from the endpoint called
    $tempObj = [PSCustomObject]@{}
    # array with all the results got from the endpoints called
    $finalList = @()
	
    # call the API for each page updating the counter index
    for ($i = 0; $i -le $amountOfPages; $i++) {
		$tempObj = Invoke-RestMethod -Method $method -Uri "$Uri&count=$Count&startIndex=$startIndex" -Headers $headers
        $finalList += $tempObj.Resources
        $startIndex += $Count
    }
    
    return $finalList

}