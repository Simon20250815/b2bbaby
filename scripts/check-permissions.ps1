Write-Host "🔐 Checking Directus permissions..."

$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token

Write-Host "✅ Logged in successfully!"
Write-Host ""

Write-Host "📋 Getting public role permissions..."
$permissions = Invoke-RestMethod -Uri "http://localhost:8055/permissions?filter={""role"":""public""}" -Method Get -Headers @{ Authorization = "Bearer $token" }

Write-Host "Public role permissions found: $($permissions.data.Count)"
Write-Host ""

foreach ($perm in $permissions.data) {
    Write-Host "Collection: $($perm.collection), Action: $($perm.action)"
}

Write-Host ""

Write-Host "🔍 Testing public access to products..."
try {
    $result = Invoke-RestMethod -Uri "http://localhost:8055/items/products" -Method Get
    Write-Host "✅ Public access to products is working!"
    Write-Host "Total products: $($result.data.Count)"
} catch {
    Write-Host "❌ Public access failed: $_"
}