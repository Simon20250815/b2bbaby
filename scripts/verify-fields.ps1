$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token
$headers = @{ Authorization = "Bearer $token" }

Write-Host "Products Fields:"
$products = Invoke-RestMethod -Uri "http://localhost:8055/fields/products" -Headers $headers
$products.data | ForEach-Object { Write-Host "  - $($_.field): $($_.type) [interface: $($_.interface)]" }

Write-Host ""
Write-Host "FAQs Fields:"
$faqs = Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs" -Headers $headers
$faqs.data | ForEach-Object { Write-Host "  - $($_.field): $($_.type) [interface: $($_.interface)]" }

Write-Host ""
Write-Host "Blogs Fields:"
$blogs = Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs" -Headers $headers
$blogs.data | ForEach-Object { Write-Host "  - $($_.field): $($_.type) [interface: $($_.interface)]" }