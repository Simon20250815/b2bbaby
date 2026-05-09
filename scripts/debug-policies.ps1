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
    Write-Host "Found Public role:"
    Write-Host "  ID: $($publicRole.id)"
    Write-Host "  Name: $($publicRole.name)"
    Write-Host "  Public attribute present: $($publicRole.PSObject.Properties.Name -contains 'public')"
    if ($publicRole.PSObject.Properties.Name -contains 'public') {
        Write-Host "  Public value: $($publicRole.public)"
    }
} else {
    Write-Host "❌ Public role not found!"
    exit
}

Write-Host ""
Write-Host "📦 Creating policy for products with full response..."

$policyBody = @{
    name = "public-read-products-debug"
    collection = "products"
    action = "read"
    role = $publicRole.id
    permissions = @{}
    validation = @{}
    presets = @{}
} | ConvertTo-Json

$response = Invoke-WebRequest -Uri "http://localhost:8055/policies" -Method Post -Body $policyBody -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" }
Write-Host "Response status: $($response.StatusCode)"
Write-Host "Response content:"
Write-Host $response.Content

Write-Host ""
Write-Host "🔍 Checking all policies for public role..."
$policies = Invoke-RestMethod -Uri "http://localhost:8055/policies" -Method Get -Headers @{ Authorization = "Bearer $token" }
$publicPolicies = $policies.data | Where-Object { $_.role -eq $publicRole.id }

Write-Host "Total policies for public role: $($publicPolicies.Count)"
foreach ($policy in $publicPolicies) {
    Write-Host "---"
    Write-Host "Policy:"
    Write-Host ($policy | ConvertTo-Json)
}

Write-Host ""
Write-Host "🔍 Testing public access..."
try {
    $result = Invoke-RestMethod -Uri "http://localhost:8055/items/products" -Method Get
    Write-Host "✅ SUCCESS! Public access is working!"
} catch {
    Write-Host "❌ Public access failed"
}