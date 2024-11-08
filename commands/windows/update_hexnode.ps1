param (
    [string]$apikey,
    [string]$deviceid,
    [string]$status
)

function UpdateStatusHexnode {
    param (
        [string]$apikey,
        [string]$deviceid,
        [string]$status
    )

    # Define the URL
    $url = "https://globaldots.hexnodemdm.com/api/v1/devices/"

    # Define headers
    $headers = @{
        "Authorization" = $apikey
        "Content-Type" = "application/json"
    }

    # Define the body of the request
    $body = @{
        "Update_in_bulk" = $false
        "Update_single_device" = $true
        "devicedata" = @(
            @{
                "deviceID" = $deviceid
                "device_notes" = "Upgrade status: $status"
            }
        )
    }

    # Convert the body to JSON
    $jsonBody = $body | ConvertTo-Json -Depth 3

    # Make the POST request
    try {
        $response = Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $jsonBody
        Write-Output "Response: $($response | ConvertTo-Json)"
    }
    catch {
        Write-Output "Error: $_"
    }
}

# Call the function with the parameters provided
UpdateStatusHexnode -apikey $apikey -deviceid $deviceid -status $status
