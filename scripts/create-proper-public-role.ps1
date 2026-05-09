Write-Host "🔐 Logging in..."

$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token

Write-Host "✅ Logged in"
Write-Host ""

Write-Host "🗑️ Deleting existing Public roles..."
$roles = Invoke-RestMethod -Uri "http://localhost:8055/roles" -Method Get -Headers @{ Authorization = "Bearer $token" }

foreach ($role in $roles.data) {
    if ($role.name -eq "Public") {
        Write-Host "Deleting role $($role.id)..."
        try {
            Invoke-RestMethod -Uri "http://localhost:8055/roles/$($role.id)" -Method Delete -Headers @{ Authorization = "Bearer $token" } | Out-Null
            Write-Host "     ✓ Deleted"
        } catch {
            Write-Host "     ⚠️  Error: $_"
        }
    }
}

Write-Host ""
Write-Host "📝 Creating proper public role..."

$roleBody = @"
{
    "name": "Public",
    "public": true,
    "admin_access": false,
    "app_access": false
}
"@

$newRole = Invoke-RestMethod -Uri "http://localhost:8055/roles" -Method Post -Body $roleBody -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" }
Write-Host "✅ Created public role with ID: $($newRole.id)"

Write-Host ""
Write-Host "📦 Setting permissions..."

$collections = @("products", "faqs", "blogs", "site_config", "directus_files")

foreach ($collection in $collections) {
    Write-Host "🔧 Setting read permission for $collection..."
    
    $permBody = @"
{
    "role": "$($newRole.id)",
    "collection": "$collection",
    "action": "read",
    "policy": {
        "name": "public-read-$collection"
    },
    "validation": {},
    "presets": {}
}
"@
    
    try {
        Invoke-RestMethod -Uri "http://localhost:8055/permissions" -Method Post -Body $permBody -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" } | Out-Null
        Write-Host "     ✓ Success"
    } catch {
        Write-Host "     ⚠️  Error: $_"
    }
}

Write-Host ""
Write-Host "🔍 Verifying public role..."
$roles = Invoke-RestMethod -Uri "http://localhost:8055/roles" -Method Get -Headers @{ Authorization = "Bearer $token" }
$publicRole = $roles.data | Where-Object { $_.public }

if ($publicRole) {
    Write-Host "✅ Found public role: $($publicRole.name) (ID: $($publicRole.id))"
    Write-Host "Public property: $($publicRole.public)"
} else {
    Write-Host "❌ No public role found!"
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