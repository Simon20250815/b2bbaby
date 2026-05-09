Write-Host "🔐 Using ADMIN_TOKEN to set permissions..."

$adminToken = "admin-token-for-directus-2026"

Write-Host "🔍 Checking for existing public role..."
$roles = Invoke-RestMethod -Uri "http://localhost:8055/roles" -Method Get -Headers @{ Authorization = "Bearer $adminToken" }
$publicRole = $roles.data | Where-Object { $_.public -eq $true }

if ($publicRole) {
    Write-Host "✅ Found existing public role: $($publicRole.name) (ID: $($publicRole.id))"
} else {
    Write-Host "📝 Creating new public role..."
    $roleBody = @{
        name = "Public"
        public = $true
        admin_access = $false
        app_access = $false
    } | ConvertTo-Json
    
    $publicRole = Invoke-RestMethod -Uri "http://localhost:8055/roles" -Method Post -Body $roleBody -ContentType "application/json" -Headers @{ Authorization = "Bearer $adminToken" }
    Write-Host "✅ Created public role: $($publicRole.name) (ID: $($publicRole.id))"
}

Write-Host ""
Write-Host "📦 Setting permissions for public role..."

$permissions = @(
    @{ collection = "products"; action = "read" },
    @{ collection = "faqs"; action = "read" },
    @{ collection = "blogs"; action = "read" },
    @{ collection = "site_config"; action = "read" },
    @{ collection = "directus_files"; action = "read" }
)

foreach ($perm in $permissions) {
    Write-Host "🔧 Setting $($perm.action) permission for $($perm.collection)..."
    
    $body = @{
        role = $publicRole.id
        collection = $perm.collection
        action = $perm.action
        policy = @{
            name = "public-$($perm.action)-$($perm.collection)"
        }
        validation = @{}
        presets = @{}
    } | ConvertTo-Json -Depth 3
    
    try {
        Invoke-RestMethod -Uri "http://localhost:8055/permissions" -Method Post -Body $body -ContentType "application/json" -Headers @{ Authorization = "Bearer $adminToken" } | Out-Null
        Write-Host "     ✓ $($perm.action) permission set for $($perm.collection)"
    } catch {
        Write-Host "     ⚠️  Error: $_"
    }
}

Write-Host ""
Write-Host "✅ Public role and permissions configured successfully!"

Write-Host ""
Write-Host "🔍 Testing public access to products..."
try {
    $result = Invoke-RestMethod -Uri "http://localhost:8055/items/products" -Method Get
    Write-Host "✅ Public access to products is working!"
    Write-Host "Total products: $($result.data.Count)"
} catch {
    Write-Host "❌ Public access failed: $_"
}