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
$publicRole = $roles.data | Where-Object { $_.name -eq "Public" } | Select-Object -First 1

if (-not $publicRole) {
    Write-Host "❌ Public role not found!"
    exit
}

Write-Host "Found Public role: $($publicRole.id)"
Write-Host ""

Write-Host "📦 Checking existing permissions..."
$permissions = Invoke-RestMethod -Uri "http://localhost:8055/permissions" -Method Get -Headers @{ Authorization = "Bearer $token" }
$publicPermissions = $permissions.data | Where-Object { $_.role -eq $publicRole.id }
Write-Host "Existing permissions for public role: $($publicPermissions.Count)"

Write-Host ""
Write-Host "🗑️ Deleting existing permissions..."
foreach ($perm in $publicPermissions) {
    Write-Host "Deleting permission $($perm.id)..."
    Invoke-RestMethod -Uri "http://localhost:8055/permissions/$($perm.id)" -Method Delete -Headers @{ Authorization = "Bearer $token" } | Out-Null
}

Write-Host ""
Write-Host "📦 Creating permissions via /permissions endpoint..."

$collections = @("products", "faqs", "blogs", "site_config", "directus_files")

foreach ($collection in $collections) {
    Write-Host "🔧 Creating permission for $collection..."
    
    $permBody = @"
{
    "role": "$($publicRole.id)",
    "collection": "$collection",
    "action": "read"
}
"@
    
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:8055/permissions" -Method Post -Body $permBody -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" }
        Write-Host "     ✓ Created permission: $($response.StatusCode)"
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