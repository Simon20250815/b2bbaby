$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token

Write-Host "Getting workflow list..."
$flows = Invoke-RestMethod -Uri "http://localhost:8055/flows" -Headers @{ Authorization = "Bearer $token" }

if ($flows.data.Count -gt 0) {
    Write-Host ""
    Write-Host "Workflow list:"
    $flows.data | ForEach-Object {
        Write-Host ""
        Write-Host "ID: $($_.id)"
        Write-Host "Name: $($_.name)"
        Write-Host "Status: $($_.status)"
        Write-Host "Description: $($_.description)"
    }
} else {
    Write-Host "No workflows found"
}