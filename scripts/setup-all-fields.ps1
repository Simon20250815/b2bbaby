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

Write-Host "Configuring Products fields..."
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/title" -Method PATCH -Body '{"interface":"input","options":{"placeholder":"Product Name"},"required":true}' -Headers $headers | Out-Null; Write-Host "OK: products.title"
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/title_en" -Method PATCH -Body '{"interface":"input","options":{"placeholder":"English Title"}}' -Headers $headers | Out-Null; Write-Host "OK: products.title_en"
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/category" -Method PATCH -Body '{"interface":"select-dropdown","options":{"choices":[["Stroller","Stroller"],["Safety Gate","Safety Gate"],["High Chair","High Chair"],["Bed Rail","Bed Rail"]]}}' -Headers $headers | Out-Null; Write-Host "OK: products.category"
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/description" -Method PATCH -Body '{"interface":"textarea","options":{"placeholder":"Product description","rows":6}}' -Headers $headers | Out-Null; Write-Host "OK: products.description"
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/description_en" -Method PATCH -Body '{"interface":"textarea","options":{"placeholder":"English description","rows":6}}' -Headers $headers | Out-Null; Write-Host "OK: products.description_en"
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/moq" -Method PATCH -Body '{"interface":"input","options":{"placeholder":"Minimum Order Quantity","type":"number"}}' -Headers $headers | Out-Null; Write-Host "OK: products.moq"
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/lead_time_sample" -Method PATCH -Body '{"interface":"input","options":{"placeholder":"7-10 days"}}' -Headers $headers | Out-Null; Write-Host "OK: products.lead_time_sample"
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/lead_time_production" -Method PATCH -Body '{"interface":"input","options":{"placeholder":"15-25 days"}}' -Headers $headers | Out-Null; Write-Host "OK: products.lead_time_production"
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/certifications" -Method PATCH -Body '{"interface":"tags","options":{"placeholder":"ASTM, CE, CPC"},"special":"json"}' -Headers $headers | Out-Null; Write-Host "OK: products.certifications"
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/target_markets" -Method PATCH -Body '{"interface":"tags","options":{"placeholder":"US, EU, Canada"},"special":"json"}' -Headers $headers | Out-Null; Write-Host "OK: products.target_markets"
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/image" -Method PATCH -Body '{"interface":"file-image","special":"file"}' -Headers $headers | Out-Null; Write-Host "OK: products.image"
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/gallery_images" -Method PATCH -Body '{"interface":"files","special":"files"}' -Headers $headers | Out-Null; Write-Host "OK: products.gallery_images"
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/status" -Method PATCH -Body '{"interface":"select-dropdown","options":{"choices":[["draft","Draft"],["published","Published"]]}}' -Headers $headers | Out-Null; Write-Host "OK: products.status"
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/sort" -Method PATCH -Body '{"interface":"input","options":{"placeholder":"0","type":"number"}}' -Headers $headers | Out-Null; Write-Host "OK: products.sort"

Write-Host ""
Write-Host "Configuring FAQs fields..."
Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs/question" -Method PATCH -Body '{"interface":"input","options":{"placeholder":"Question"},"required":true}' -Headers $headers | Out-Null; Write-Host "OK: faqs.question"
Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs/question_en" -Method PATCH -Body '{"interface":"input","options":{"placeholder":"English Question"}}' -Headers $headers | Out-Null; Write-Host "OK: faqs.question_en"
Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs/answer" -Method PATCH -Body '{"interface":"textarea","options":{"placeholder":"Answer","rows":6}}' -Headers $headers | Out-Null; Write-Host "OK: faqs.answer"
Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs/answer_en" -Method PATCH -Body '{"interface":"textarea","options":{"placeholder":"English Answer","rows":6}}' -Headers $headers | Out-Null; Write-Host "OK: faqs.answer_en"
Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs/category" -Method PATCH -Body '{"interface":"select-dropdown","options":{"choices":[["Products","Products"],["Orders","Orders"],["Shipping","Shipping"],["Customs","Customs"]]}}' -Headers $headers | Out-Null; Write-Host "OK: faqs.category"
Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs/sort" -Method PATCH -Body '{"interface":"input","options":{"placeholder":"0","type":"number"}}' -Headers $headers | Out-Null; Write-Host "OK: faqs.sort"

Write-Host ""
Write-Host "Configuring Blogs fields..."
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/title" -Method PATCH -Body '{"interface":"input","options":{"placeholder":"Blog Title"},"required":true}' -Headers $headers | Out-Null; Write-Host "OK: blogs.title"
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/title_en" -Method PATCH -Body '{"interface":"input","options":{"placeholder":"English Title"}}' -Headers $headers | Out-Null; Write-Host "OK: blogs.title_en"
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/excerpt" -Method PATCH -Body '{"interface":"textarea","options":{"placeholder":"Short summary","rows":3}}' -Headers $headers | Out-Null; Write-Host "OK: blogs.excerpt"
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/excerpt_en" -Method PATCH -Body '{"interface":"textarea","options":{"placeholder":"English Summary","rows":3}}' -Headers $headers | Out-Null; Write-Host "OK: blogs.excerpt_en"
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/content" -Method PATCH -Body '{"interface":"textarea","options":{"placeholder":"Blog content","rows":10}}' -Headers $headers | Out-Null; Write-Host "OK: blogs.content"
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/content_en" -Method PATCH -Body '{"interface":"textarea","options":{"placeholder":"English Content","rows":10}}' -Headers $headers | Out-Null; Write-Host "OK: blogs.content_en"
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/cover_image" -Method PATCH -Body '{"interface":"file-image","special":"file"}' -Headers $headers | Out-Null; Write-Host "OK: blogs.cover_image"
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/author" -Method PATCH -Body '{"interface":"input","options":{"placeholder":"Author Name"}}' -Headers $headers | Out-Null; Write-Host "OK: blogs.author"
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/tags" -Method PATCH -Body '{"interface":"tags","options":{"placeholder":"baby, stroller, safety"},"special":"json"}' -Headers $headers | Out-Null; Write-Host "OK: blogs.tags"
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/date_published" -Method PATCH -Body '{"interface":"datetime"}' -Headers $headers | Out-Null; Write-Host "OK: blogs.date_published"
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/status" -Method PATCH -Body '{"interface":"select-dropdown","options":{"choices":[["draft","Draft"],["published","Published"]]}}' -Headers $headers | Out-Null; Write-Host "OK: blogs.status"

Write-Host ""
Write-Host "All done!"