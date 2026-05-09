Write-Host "🔐 Logging in..."

$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token

Write-Host "✅ Logged in with token: $($token.Substring(0, 20))..."
Write-Host ""

Write-Host "🔍 Testing admin access to products..."
try {
    $result = Invoke-RestMethod -Uri "http://localhost:8055/items/products" -Method Get -Headers @{ Authorization = "Bearer $token" }
    Write-Host "✅ Admin access successful!"
    Write-Host "Products found: $($result.data.Count)"
} catch {
    Write-Host "❌ Admin access failed: $_"
}

Write-Host ""
Write-Host "🔍 Getting collections..."
try {
    $collections = Invoke-RestMethod -Uri "http://localhost:8055/collections" -Method Get -Headers @{ Authorization = "Bearer $token" }
    Write-Host "✅ Collections found: $($collections.data.Count)"
    $collectionNames = $collections.data | Select-Object -ExpandProperty collection
    Write-Host "Collection names: $($collectionNames -join ', ')"
} catch {
    Write-Host "❌ Failed to get collections: $_"
}