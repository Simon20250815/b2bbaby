Write-Host "🔐 Logging in to Directus..."

$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

try {
    $loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
    $token = $loginResponse.data.access_token
    Write-Host "✅ Logged in successfully!"
} catch {
    Write-Host "❌ Login failed: $_"
    exit
}

Write-Host ""
Write-Host "🔍 Getting all roles..."
$roles = Invoke-RestMethod -Uri "http://localhost:8055/roles" -Method Get -Headers @{ Authorization = "Bearer $token" }
Write-Host "Found $($roles.data.Count) roles"

$publicRole = $roles.data | Where-Object { $_.public -eq $true }

if ($publicRole) {
    Write-Host "✅ Found public role: $($publicRole.name) (ID: $($publicRole.id))"
} else {
    Write-Host "📝 Creating public role..."
    $roleBody = @{
        name = "Public"
        public = $true
        admin_access = $false
        app_access = $false
    } | ConvertTo-Json
    
    $publicRole = Invoke-RestMethod -Uri "http://localhost:8055/roles" -Method Post -Body $roleBody -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" }
    Write-Host "✅ Created public role with ID: $($publicRole.id)"
}

Write-Host ""
Write-Host "📦 Setting permissions..."

$collections = @("products", "faqs", "blogs", "site_config", "directus_files")

foreach ($collection in $collections) {
    Write-Host "🔧 Setting read permission for $collection..."
    
    $body = @{
        role = $publicRole.id
        collection = $collection
        action = "read"
        policy = @{
            name = "public-read-$collection"
        }
        validation = @{}
        presets = @{}
    } | ConvertTo-Json -Depth 3
    
    try {
        Invoke-RestMethod -Uri "http://localhost:8055/permissions" -Method Post -Body $body -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" } | Out-Null
        Write-Host "     ✓ Success"
    } catch {
        Write-Host "     ⚠️  Error: $_"
    }
}

Write-Host ""
Write-Host "🔍 Verifying permissions..."
$perms = Invoke-RestMethod -Uri "http://localhost:8055/permissions" -Method Get -Headers @{ Authorization = "Bearer $token" }
Write-Host "Total permissions: $($perms.data.Count)"

Write-Host ""
Write-Host "🔍 Testing public access..."
try {
    $result = Invoke-RestMethod -Uri "http://localhost:8055/items/products" -Method Get
    Write-Host "✅ SUCCESS! Public access is working!"
    Write-Host "Products found: $($result.data.Count)"
} catch {
    Write-Host "❌ Public access still not working: $_"
}