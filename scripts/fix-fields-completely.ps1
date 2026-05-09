$login = Invoke-RestMethod -Uri 'http://localhost:8055/auth/login' -Method Post -Body (@{email='admin@b2bbaby.com';password='admin_password_2026'} | ConvertTo-Json) -ContentType 'application/json'
$token = $login.data.access_token
$headers = @{
    Authorization="Bearer $token"
    "Content-Type"="application/json"
}

function Fix-FileField {
    param($collection, $field, $type, $interface, $special)
    Write-Host "Fixing $collection.$field..."
    
    $body = @{
        type = $type
        interface = $interface
        special = $special
        options = @{}
    } | ConvertTo-Json -Compress
    
    try {
        Invoke-RestMethod -Uri "http://localhost:8055/fields/$collection/$field" -Method PATCH -Body $body -Headers $headers | Out-Null
        Write-Host "OK: $collection.$field -> $interface"
    } catch {
        Write-Host "FAIL: $collection.$field - $($_.Exception.Message)"
    }
}

function Fix-InputField {
    param($collection, $field)
    Write-Host "Fixing $collection.$field..."
    
    $body = @{
        type = "string"
        interface = "input"
        options = @{placeholder="Enter value"}
    } | ConvertTo-Json -Compress
    
    try {
        Invoke-RestMethod -Uri "http://localhost:8055/fields/$collection/$field" -Method PATCH -Body $body -Headers $headers | Out-Null
        Write-Host "OK: $collection.$field -> input"
    } catch {
        Write-Host "FAIL: $collection.$field - $($_.Exception.Message)"
    }
}

function Fix-TextareaField {
    param($collection, $field)
    Write-Host "Fixing $collection.$field..."
    
    $body = @{
        type = "text"
        interface = "textarea"
        options = @{placeholder="Enter content"; rows=5}
    } | ConvertTo-Json -Compress
    
    try {
        Invoke-RestMethod -Uri "http://localhost:8055/fields/$collection/$field" -Method PATCH -Body $body -Headers $headers | Out-Null
        Write-Host "OK: $collection.$field -> textarea"
    } catch {
        Write-Host "FAIL: $collection.$field - $($_.Exception.Message)"
    }
}

Write-Host "`n=== Fixing Products collection ==="
Fix-FileField -collection "products" -field "image" -type "string" -interface "file-image" -special "file"
Fix-FileField -collection "products" -field "gallery_images" -type "string" -interface "files" -special "files"
Fix-InputField -collection "products" -field "title"
Fix-InputField -collection "products" -field "title_en"
Fix-TextareaField -collection "products" -field "description"
Fix-TextareaField -collection "products" -field "description_en"
Fix-InputField -collection "products" -field "category"
Fix-InputField -collection "products" -field "moq"
Fix-InputField -collection "products" -field "price"
Fix-InputField -collection "products" -field "certifications"
Fix-InputField -collection "products" -field "target_markets"

Write-Host "`n=== Fixing About collection ==="
Fix-FileField -collection "about" -field "image" -type "string" -interface "file-image" -special "file"
Fix-FileField -collection "about" -field "gallery_images" -type "string" -interface "files" -special "files"
Fix-InputField -collection "about" -field "company_name"
Fix-InputField -collection "about" -field "company_name_en"
Fix-TextareaField -collection "about" -field "description"
Fix-TextareaField -collection "about" -field "description_en"

Write-Host "`n=== Fixing Home collection ==="
Fix-FileField -collection "home" -field "hero_image" -type "string" -interface "file-image" -special "file"
Fix-InputField -collection "home" -field "hero_title"
Fix-InputField -collection "home" -field "hero_title_en"
Fix-TextareaField -collection "home" -field "hero_subtitle"
Fix-TextareaField -collection "home" -field "hero_subtitle_en"

Write-Host "`n=== Fixing OEM/ODM collection ==="
Fix-FileField -collection "oem_odm" -field "image" -type "string" -interface "file-image" -special "file"
Fix-FileField -collection "oem_odm" -field "gallery_images" -type "string" -interface "files" -special "files"
Fix-InputField -collection "oem_odm" -field "title"
Fix-InputField -collection "oem_odm" -field "title_en"
Fix-TextareaField -collection "oem_odm" -field "description"
Fix-TextareaField -collection "oem_odm" -field "description_en"

Write-Host "`n=== Fixing Blogs collection ==="
Fix-FileField -collection "blogs" -field "cover_image" -type "string" -interface "file-image" -special "file"
Fix-InputField -collection "blogs" -field "title"
Fix-InputField -collection "blogs" -field "title_en"
Fix-TextareaField -collection "blogs" -field "content"
Fix-TextareaField -collection "blogs" -field "content_en"

Write-Host "`n=== Fixing Site Settings collection ==="
Fix-FileField -collection "site_settings" -field "logo" -type "string" -interface "file-image" -special "file"
Fix-FileField -collection "site_settings" -field "favicon" -type "string" -interface "file-image" -special "file"
Fix-InputField -collection "site_settings" -field "site_title"
Fix-InputField -collection "site_settings" -field "site_title_en"

Write-Host "`nAll fields fixed successfully! Refresh Directus admin to see the changes."