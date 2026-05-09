$login = Invoke-RestMethod -Uri 'http://localhost:8055/auth/login' -Method Post -Body (@{email='admin@b2bbaby.com';password='admin_password_2026'} | ConvertTo-Json) -ContentType 'application/json'
$token = $login.data.access_token
$headers = @{
    Authorization="Bearer $token"
    "Content-Type"="application/json"
}

Write-Host "Fixing image upload fields..."

# Fix Products image fields
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/image" -Method PATCH -Body '{"interface":"file-image","special":"file"}' -Headers $headers | Out-Null
Write-Host "OK: products.image -> file-image"

Invoke-RestMethod -Uri "http://localhost:8055/fields/products/gallery_images" -Method PATCH -Body '{"interface":"files","special":"files"}' -Headers $headers | Out-Null
Write-Host "OK: products.gallery_images -> files"

# Fix About image fields
Invoke-RestMethod -Uri "http://localhost:8055/fields/about/image" -Method PATCH -Body '{"interface":"file-image","special":"file"}' -Headers $headers | Out-Null
Write-Host "OK: about.image -> file-image"

Invoke-RestMethod -Uri "http://localhost:8055/fields/about/gallery_images" -Method PATCH -Body '{"interface":"files","special":"files"}' -Headers $headers | Out-Null
Write-Host "OK: about.gallery_images -> files"

# Fix OEM image fields
Invoke-RestMethod -Uri "http://localhost:8055/fields/oem_odm/image" -Method PATCH -Body '{"interface":"file-image","special":"file"}' -Headers $headers | Out-Null
Write-Host "OK: oem_odm.image -> file-image"

Invoke-RestMethod -Uri "http://localhost:8055/fields/oem_odm/gallery_images" -Method PATCH -Body '{"interface":"files","special":"files"}' -Headers $headers | Out-Null
Write-Host "OK: oem_odm.gallery_images -> files"

# Fix Home image fields
Invoke-RestMethod -Uri "http://localhost:8055/fields/home/hero_image" -Method PATCH -Body '{"interface":"file-image","special":"file"}' -Headers $headers | Out-Null
Write-Host "OK: home.hero_image -> file-image"

# Fix Blogs image fields
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/cover_image" -Method PATCH -Body '{"interface":"file-image","special":"file"}' -Headers $headers | Out-Null
Write-Host "OK: blogs.cover_image -> file-image"

# Fix Settings image fields
Invoke-RestMethod -Uri "http://localhost:8055/fields/site_settings/logo" -Method PATCH -Body '{"interface":"file-image","special":"file"}' -Headers $headers | Out-Null
Write-Host "OK: site_settings.logo -> file-image"

Invoke-RestMethod -Uri "http://localhost:8055/fields/site_settings/favicon" -Method PATCH -Body '{"interface":"file-image","special":"file"}' -Headers $headers | Out-Null
Write-Host "OK: site_settings.favicon -> file-image"

Write-Host ""
Write-Host "✅ All image fields fixed! Refresh Directus to see upload buttons."