Write-Host "🔐 Logging in to Directus..."

$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token

Write-Host "✅ Logged in successfully!"
Write-Host ""

Write-Host "🔍 Getting public role ID..."
$roles = Invoke-RestMethod -Uri "http://localhost:8055/roles" -Method Get -Headers @{ Authorization = "Bearer $token" }
$publicRole = $roles.data | Where-Object { $_.name -eq "Public" }

if ($publicRole) {
    Write-Host "✅ Found public role: $($publicRole.name) (ID: $($publicRole.id))"
} else {
    Write-Host "❌ Public role not found!"
    exit
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
        Invoke-RestMethod -Uri "http://localhost:8055/permissions" -Method Post -Body $body -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" } | Out-Null
        Write-Host "     ✓ $($perm.action) permission set for $($perm.collection)"
    } catch {
        Write-Host "     ⚠️  Error: $_"
    }
}

Write-Host ""
Write-Host "✅ Permissions configured successfully!"