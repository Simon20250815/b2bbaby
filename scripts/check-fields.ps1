$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token
$headers = @{ Authorization = "Bearer $token" }

Write-Host "Checking products fields..."
$fields = Invoke-RestMethod -Uri "http://localhost:8055/fields/products" -Headers $headers
$fields.data | ForEach-Object { Write-Host "  $($_.field): $($_.type)" }

Write-Host ""
Write-Host "Checking directus_fields table..."
$systemFields = Invoke-RestMethod -Uri "http://localhost:8055/items/directus_fields?filter[collection]=products" -Headers $headers
Write-Host "Found $($systemFields.data.Count) field records"