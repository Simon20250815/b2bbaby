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

function Create-Field {
    param($collection, $fieldName, $type, $interface, $options, $required = $false, $special = $null)

    $body = @{
        collection = $collection
        field = $fieldName
        type = $type
        interface = $interface
        options = $options
        required = $required
    }

    if ($special) {
        $body.special = $special
    }

    try {
        $response = Invoke-RestMethod -Uri "http://localhost:8055/fields/$collection" -Method POST -Body ($body | ConvertTo-Json) -Headers $headers
        Write-Host "OK: $collection.$fieldName"
    } catch {
        Write-Host "SKIP: $collection.$fieldName - $($_.Exception.Message.Split('"')[2])"
    }
}

Write-Host "Configuring Products fields..."
Create-Field -collection "products" -fieldName "title" -type "string" -interface "input" -options (@{placeholder="Product Name"} | ConvertTo-Json) -required $true
Create-Field -collection "products" -fieldName "title_en" -type "string" -interface "input" -options (@{placeholder="English Title"} | ConvertTo-Json)
Create-Field -collection "products" -fieldName "category" -type "string" -interface "select-dropdown" -options (@{choices=@(@("Stroller","Stroller"),@("Safety Gate","Safety Gate"),@("High Chair","High Chair"),@("Bed Rail","Bed Rail"))} | ConvertTo-Json)
Create-Field -collection "products" -fieldName "description" -type "text" -interface "textarea" -options (@{placeholder="Product description in Chinese";rows=5} | ConvertTo-Json)
Create-Field -collection "products" -fieldName "description_en" -type "text" -interface "textarea" -options (@{placeholder="Product description in English";rows=5} | ConvertTo-Json)
Create-Field -collection "products" -fieldName "moq" -type "integer" -interface "input" -options (@{placeholder="Minimum Order Quantity"} | ConvertTo-Json)
Create-Field -collection "products" -fieldName "lead_time_sample" -type "string" -interface "input" -options (@{placeholder="7-10 days"} | ConvertTo-Json)
Create-Field -collection "products" -fieldName "lead_time_production" -type "string" -interface "input" -options (@{placeholder="15-25 days"} | ConvertTo-Json)
Create-Field -collection "products" -fieldName "certifications" -type "json" -interface "tags" -options (@{placeholder="ASTM, CE, CPC"} | ConvertTo-Json) -special "json"
Create-Field -collection "products" -fieldName "target_markets" -type "json" -interface "tags" -options (@{placeholder="US, EU, Canada"} | ConvertTo-Json) -special "json"
Create-Field -collection "products" -fieldName "image" -type "text" -interface "file-image" -options (@{} | ConvertTo-Json) -special "file"
Create-Field -collection "products" -fieldName "gallery_images" -type "json" -interface "files" -options (@{} | ConvertTo-Json) -special "files"
Create-Field -collection "products" -fieldName "specs" -type "json" -interface "repeatable" -options (@{heading="Specifications";fields=@(@{field="label";name="Label";type="string";meta=@{interface="input"}},@{field="value";name="Value";type="string";meta=@{interface="input"}})} | ConvertTo-Json) -special "json"
Create-Field -collection "products" -fieldName "features" -type "json" -interface "repeatable" -options (@{heading="Features";fields=@(@{field="text";name="Feature";type="string";meta=@{interface="input"}})} | ConvertTo-Json) -special "json"
Create-Field -collection "products" -fieldName "custom_options" -type "json" -interface "repeatable" -options (@{heading="Custom Options";fields=@(@{field="name";name="Option Name";type="string";meta=@{interface="input"}},@{field="price";name="Price";type="decimal";meta=@{interface="input"}})} | ConvertTo-Json) -special "json"
Create-Field -collection "products" -fieldName "status" -type "string" -interface "select-dropdown" -options (@{choices=@(@("draft","Draft"),@("published","Published"))} | ConvertTo-Json)
Create-Field -collection "products" -fieldName "sort" -type "integer" -interface "input" -options (@{placeholder="0"} | ConvertTo-Json)

Write-Host ""
Write-Host "Configuring FAQs fields..."
Create-Field -collection "faqs" -fieldName "question" -type "string" -interface "input" -options (@{placeholder="Question in Chinese"} | ConvertTo-Json) -required $true
Create-Field -collection "faqs" -fieldName "question_en" -type "string" -interface "input" -options (@{placeholder="Question in English"} | ConvertTo-Json)
Create-Field -collection "faqs" -fieldName "answer" -type "text" -interface "textarea" -options (@{placeholder="Answer in Chinese";rows=5} | ConvertTo-Json)
Create-Field -collection "faqs" -fieldName "answer_en" -type "text" -interface "textarea" -options (@{placeholder="Answer in English";rows=5} | ConvertTo-Json)
Create-Field -collection "faqs" -fieldName "category" -type "string" -interface "select-dropdown" -options (@{choices=@(@("Products","Products"),@("Orders","Orders"),@("Shipping","Shipping"),@("Customs","Customs"),@("Payment","Payment"))} | ConvertTo-Json)
Create-Field -collection "faqs" -fieldName "sort" -type "integer" -interface "input" -options (@{placeholder="0"} | ConvertTo-Json)

Write-Host ""
Write-Host "Configuring Blogs fields..."
Create-Field -collection "blogs" -fieldName "title" -type "string" -interface "input" -options (@{placeholder="Blog Title in Chinese"} | ConvertTo-Json) -required $true
Create-Field -collection "blogs" -fieldName "title_en" -type "string" -interface "input" -options (@{placeholder="Blog Title in English"} | ConvertTo-Json)
Create-Field -collection "blogs" -fieldName "excerpt" -type "text" -interface "textarea" -options (@{placeholder="Short summary in Chinese";rows=3} | ConvertTo-Json)
Create-Field -collection "blogs" -fieldName "excerpt_en" -type "text" -interface "textarea" -options (@{placeholder="Short summary in English";rows=3} | ConvertTo-Json)
Create-Field -collection "blogs" -fieldName "content" -type "text" -interface "textarea" -options (@{placeholder="Blog content in Chinese";rows=10} | ConvertTo-Json)
Create-Field -collection "blogs" -fieldName "content_en" -type "text" -interface "textarea" -options (@{placeholder="Blog content in English";rows=10} | ConvertTo-Json)
Create-Field -collection "blogs" -fieldName "cover_image" -type "text" -interface "file-image" -options (@{} | ConvertTo-Json) -special "file"
Create-Field -collection "blogs" -fieldName "author" -type "string" -interface "input" -options (@{placeholder="Author Name"} | ConvertTo-Json)
Create-Field -collection "blogs" -fieldName "tags" -type "json" -interface "tags" -options (@{placeholder="baby, stroller, safety"} | ConvertTo-Json) -special "json"
Create-Field -collection "blogs" -fieldName "date_published" -type "datetime" -interface "datetime" -options (@{} | ConvertTo-Json)
Create-Field -collection "blogs" -fieldName "status" -type "string" -interface "select-dropdown" -options (@{choices=@(@("draft","Draft"),@("published","Published"))} | ConvertTo-Json)

Write-Host ""
Write-Host "All fields configured via Directus API!"