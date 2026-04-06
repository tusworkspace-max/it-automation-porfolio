# რეგიონ: CONFIGURATION
$company   = "YOUR_COMPANY_ID"
$publicKey = "YOUR_PUBLIC_KEY"
$privateKey= "YOUR_PRIVATE_KEY"
$clientId  = "YOUR_CLIENT_ID"
$site      = "https://api-na.myconnectwise.net"

# Base64 encode credentials
$pair = "$($company)+$($publicKey):$($privateKey)"
$encodedCredentials = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($pair))

# Headers
$headers = @{
    Authorization = "Basic $encodedCredentials"
    clientId      = $clientId
    Accept        = "application/json"
}

# Endpoint to get tickets
$endpoint = "$site/v4_6_release/apis/3.0/service/tickets"

try {
    # Call API
    $response = Invoke-RestMethod -Uri $endpoint -Method Get -Headers $headers

    # Output ticket info
    foreach ($ticket in $response) {
        [PSCustomObject]@{
            TicketID = $ticket.id
            Summary  = $ticket.summary
            BoardID  = $ticket.board.id
            BoardName= $ticket.board.name
            Status   = $ticket.status.name
        }
    }
}
catch {
    Write-Error "API call failed: $_"
}
