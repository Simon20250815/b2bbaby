Write-Host "🔐 Logging in..."

$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token

Write-Host "✅ Logged in"
Write-Host ""

Write-Host "🔍 Finding and fixing public role..."

$roles = Invoke-RestMethod -Uri "http://localhost:8055/roles" -Method Get -Headers @{ Authorization = "Bearer $token" }

foreach ($role in $roles.data) {
    if ($role.name -eq "Public") {
        Write-Host "Updating role $($role.id) to be public..."
        
        $updateBody = @"
{
    "name": "Public",
    "public": true,
    "admin_access": false,
    "app_access": false
}
"@
        
        try {
            $result = Invoke-RestMethod -Uri "http://localhost:8055/roles/$($role.id)" -Method Patch -Body $updateBody -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" }
            Write-Host "     ✓ Updated successfully"
        } catch {
            Write-Host "     ⚠️  Error: $_"
        }
    }
}

Write-Host ""
Write-Host "🔍 Verifying public role..."
$roles = Invoke-RestMethod -Uri "http://localhost:8055/roles" -Method Get -Headers @{ Authorization = "Bearer $token" }
$publicRole = $roles.data | Where-Object { $_.public -eq $true }

if ($publicRole) {
    Write-Host "✅ Found public role: $($publicRole.name) (ID: $($publicRole.id))"
} else {
    Write-Host "❌ No public role found!"
}

Write-Host ""
Write-Host "🔍 Testing public access..."
try {
    $result = Invoke-RestMethod -Uri "http://localhost:8055/items/products" -Method Get
    Write-Host "✅ SUCCESS! Public access is working!"
    Write-Host "Products: $($result.data.Count)"
} catch {
    Write-Host "❌ Public access failed: $_"
}