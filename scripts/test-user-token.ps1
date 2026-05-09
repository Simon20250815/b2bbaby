Write-Host "🔐 Logging in with user credentials..."

$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token

Write-Host "✅ Logged in with token: $($token.Substring(0, 20))..."
Write-Host ""

Write-Host "🔍 Testing access with user token..."
try {
    $result = Invoke-RestMethod -Uri "http://localhost:8055/items/products" -Method Get -Headers @{ Authorization = "Bearer $token" }
    Write-Host "✅ SUCCESS! Access with user token is working!"
    Write-Host "Products found: $($result.data.Count)"
} catch {
    Write-Host "❌ Access failed: $_"
}