$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token
$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json"
}

Write-Host "Configuring product fields..."

# 隐藏不需要的字段
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/id" -Method PATCH -Body '{"hidden":true}' -Headers $headers | Out-Null; Write-Host "OK: products.id hidden"
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/sort" -Method PATCH -Body '{"hidden":true}' -Headers $headers | Out-Null; Write-Host "OK: products.sort hidden"

# 配置字段显示宽度
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/slug" -Method PATCH -Body '{"width":"half","note":"Product URL slug"}' -Headers $headers | Out-Null; Write-Host "OK: products.slug width"
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/title" -Method PATCH -Body '{"width":"full","note":"Product name"}' -Headers $headers | Out-Null; Write-Host "OK: products.title width"
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/moq" -Method PATCH -Body '{"width":"half","note":"Minimum Order Quantity"}' -Headers $headers | Out-Null; Write-Host "OK: products.moq width"
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/status" -Method PATCH -Body '{"width":"half","note":"Draft or Published"}' -Headers $headers | Out-Null; Write-Host "OK: products.status width"

# 配置字段分组
$groupBody = '{"group":"Basic Info","note":"Essential product details"}'
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/title" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/title_en" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/category" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/slug" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/status" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Write-Host "OK: products Basic Info group"

$groupBody = '{"group":"Description","note":"Product descriptions in multiple languages"}'
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/description" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/description_en" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Write-Host "OK: products Description group"

$groupBody = '{"group":"Pricing & Delivery","note":"MOQ, prices, lead times"}'
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/moq" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/lead_time_sample" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/lead_time_production" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Write-Host "OK: products Pricing & Delivery group"

$groupBody = '{"group":"Media","note":"Product images and gallery"}'
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/image" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/gallery_images" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Write-Host "OK: products Media group"

$groupBody = '{"group":"Details","note":"Certifications, specs, features"}'
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/certifications" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/target_markets" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/specs" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/features" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/custom_options" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Write-Host "OK: products Details group"

Write-Host ""
Write-Host "Configuring FAQ fields..."
Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs/id" -Method PATCH -Body '{"hidden":true}' -Headers $headers | Out-Null; Write-Host "OK: faqs.id hidden"

$groupBody = '{"group":"Basic"}'
Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs/question" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs/question_en" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs/answer" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs/answer_en" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs/category" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs/sort" -Method PATCH -Body '{"hidden":true}' -Headers $headers | Out-Null

Write-Host ""
Write-Host "Configuring Blog fields..."
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/id" -Method PATCH -Body '{"hidden":true}' -Headers $headers | Out-Null; Write-Host "OK: blogs.id hidden"

$groupBody = '{"group":"Basic"}'
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/title" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/title_en" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/slug" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/author" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/status" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/date_published" -Method PATCH -Body $groupBody -Headers $headers | Out-Null

$groupBody = '{"group":"Content"}'
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/excerpt" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/excerpt_en" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/content" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/content_en" -Method PATCH -Body $groupBody -Headers $headers | Out-Null

$groupBody = '{"group":"Media & Tags"}'
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/cover_image" -Method PATCH -Body $groupBody -Headers $headers | Out-Null
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/tags" -Method PATCH -Body $groupBody -Headers $headers | Out-Null

Write-Host ""
Write-Host "Interface configuration complete!"