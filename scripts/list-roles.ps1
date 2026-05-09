Write-Host "🔐 Logging in to Directus..."

$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token

Write-Host "✅ Logged in successfully!"
Write-Host ""

Write-Host "📋 Listing all roles..."
$roles = Invoke-RestMethod -Uri "http://localhost:8055/roles" -Method Get -Headers @{ Authorization = "Bearer $token" }

foreach ($role in $roles.data) {
    Write-Host "Role ID: $($role.id), Name: '$($role.name)', Public: $($role.public)"
}