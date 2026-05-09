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

if ($publicRole) {
    Write-Host "Found Public role: $($publicRole.id)"
} else {
    Write-Host "❌ Public role not found!"
    exit
}

Write-Host ""
Write-Host "📦 Checking existing policies..."
$policies = Invoke-RestMethod -Uri "http://localhost:8055/policies" -Method Get -Headers @{ Authorization = "Bearer $token" }
Write-Host "Total policies: $($policies.data.Count)"

$publicPolicies = $policies.data | Where-Object { $_.role -eq $publicRole.id }
Write-Host "Public role policies: $($publicPolicies.Count)"

Write-Host ""
Write-Host "🗑️ Deleting existing public policies..."
foreach ($policy in $publicPolicies) {
    Write-Host "Deleting policy $($policy.id)..."
    Invoke-RestMethod -Uri "http://localhost:8055/policies/$($policy.id)" -Method Delete -Headers @{ Authorization = "Bearer $token" } | Out-Null
}

Write-Host ""
Write-Host "📦 Creating new public policies..."

$collections = @("products", "faqs", "blogs", "site_config", "directus_files")

foreach ($collection in $collections) {
    Write-Host "🔧 Creating policy for $collection..."
    
    $policyBody = @"
{
    "name": "public-read-$collection",
    "collection": "$collection",
    "action": "read",
    "role": "$($publicRole.id)",
    "permissions": {},
    "validation": {},
    "presets": {}
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