$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token

Write-Host "Getting workflows..."
$flows = Invoke-RestMethod -Uri "http://localhost:8055/flows" -Headers @{ Authorization = "Bearer $token" }

foreach ($flow in $flows.data) {
    Write-Host "Deleting workflow: $($flow.id)..."
    $deleteUrl = "http://localhost:8055/flows/$($flow.id)"
    Invoke-RestMethod -Uri $deleteUrl -Method Delete -Headers @{ Authorization = "Bearer $token" }
    Write-Host "Deleted successfully!"
}

Write-Host ""
Write-Host "All workflows deleted."