Write-Host "🔐 Logging in..."

$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token

Write-Host "✅ Logged in with token: $($token.Substring(0, 20))..."
Write-Host ""

Write-Host "📝 Creating public role and capturing raw response..."

$roleBody = @"
{
    "name": "Public",
    "public": true,
    "admin_access": false,
    "app_access": false
}
"@

$response = Invoke-WebRequest -Uri "http://localhost:8055/roles" -Method Post -Body $roleBody -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" }
Write-Host "Response status: $($response.StatusCode)"
Write-Host "Response content:"
Write-Host $response.Content

Write-Host ""
Write-Host "🔍 Checking all roles..."
$roles = Invoke-RestMethod -Uri "http://localhost:8055/roles" -Method Get -Headers @{ Authorization = "Bearer $token" }
Write-Host "Roles count: $($roles.data.Count)"
foreach ($role in $roles.data) {
    Write-Host "---"
    Write-Host "Role object:"
    Write-Host ($role | ConvertTo-Json)
}