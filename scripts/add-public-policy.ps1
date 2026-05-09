Write-Host "🔐 Logging in..."

$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token

Write-Host "✅ Logged in"
Write-Host ""

Write-Host "🔍 Finding Public role..."
$roles = Invoke-RestMethod -Uri "http://localhost:8055/roles" -Method Get -Headers @{ Authorization = "Bearer $token" }
$publicRole = $roles.data | Where-Object { $_.name -eq "Public" }

if ($publicRole) {
    Write-Host "Found Public role: $($publicRole.id)"
} else {
    Write-Host "Creating Public role..."
    $roleBody = @{ name = "Public" } | ConvertTo-Json
    $publicRole = Invoke-RestMethod -Uri "http://localhost:8055/roles" -Method Post -Body $roleBody -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" }
    Write-Host "Created Public role: $($publicRole.id)"
}

Write-Host ""
Write-Host "📦 Creating public policies..."

$collections = @("products", "faqs", "blogs", "site_config", "directus_files")

foreach ($collection in $collections) {
    Write-Host "🔧 Creating policy for $collection..."
    
    $policyBody = @"
{
    "name": "public-read-$collection",
    "collection": "$collection",
    "action": "read",
    "role": "$($publicRole.id)"
}
"@
    
    try {
        $result = Invoke-RestMethod -Uri "http://localhost:8055/policies" -Method Post -Body $policyBody -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" }
        Write-Host "     ✓ Created policy: $($result.id)"
    } catch {
        Write-Host "     ⚠️  Error: $_"
    }
}

Write-Host ""
Write-Host "🔍 Testing public access..."
try {
    $result = Invoke-RestMethod -Uri "http://localhost:8055/items/products" -Method Get
    Write-Host "✅ SUCCESS! Public access is working!"
    Write-Host "Products found: $($result.data.Count)"
} catch {
    Write-Host "❌ Public access failed: $_"
}