Write-Host "🔐 Logging in to Directus..."

$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token

Write-Host "✅ Logged in successfully!"
Write-Host ""

function Delete-Field {
    param(
        [string]$collection,
        [string]$field
    )
    Write-Host "🗑️ Deleting $field from $collection..."
    try {
        Invoke-RestMethod -Uri "http://localhost:8055/fields/$collection/$field" -Method Delete -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" } | Out-Null
        Write-Host "     ✓ Deleted: $field"
    } catch {
        Write-Host "     ⚠️  Error deleting $field : $_"
    }
}

function Create-Field {
    param(
        [string]$collection,
        [string]$field,
        [string]$type,
        [string]$interface,
        [string]$special,
        [string]$collectionField
    )
    Write-Host "➕ Creating $field in $collection..."
    $body = @{
        field = $field
        type = $type
        meta = @{
            interface = $interface
            required = $false
        }
        schema = @{
            name = $field
        }
    }
    
    if ($special) {
        $body['schema']['special'] = $special
    }
    
    if ($collectionField) {
        $body['meta']['options'] = @{
            collection = $collectionField
        }
    }
    
    $bodyJson = $body | ConvertTo-Json -Depth 3
    
    try {
        Invoke-RestMethod -Uri "http://localhost:8055/fields/$collection" -Method Post -Body $bodyJson -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" } | Out-Null
        Write-Host "     ✓ Created: $field"
    } catch {
        Write-Host "     ⚠️  Error creating $field : $_"
    }
}

Write-Host "📦 Fixing products collection image fields..."
Delete-Field -collection "products" -field "image"
Delete-Field -collection "products" -field "gallery_images"

Write-Host ""
Write-Host "➕ Recreating image fields with correct type..."
Create-Field -collection "products" -field "image" -type "files" -interface "file-image" -special "m2o" -collectionField "directus_files"
Create-Field -collection "products" -field "gallery_images" -type "files" -interface "list-o2m" -special "o2m" -collectionField "directus_files"

Write-Host ""
Write-Host "📦 Fixing blogs collection cover_image field..."
Delete-Field -collection "blogs" -field "cover_image"
Create-Field -collection "blogs" -field "cover_image" -type "files" -interface "file-image" -special "m2o" -collectionField "directus_files"

Write-Host ""
Write-Host "✅ Image field fix complete!"
Write-Host ""
Write-Host "🌐 Open: http://localhost:8055/admin"