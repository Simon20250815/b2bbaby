$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token
$headers = @{ Authorization = "Bearer $token" }

function Create-Field {
    param(
        [string]$collection,
        [string]$field,
        [string]$type,
        [string]$schema,
        [string]$meta
    )

    $body = @{
        collection = $collection
        field = $field
        type = $type
        schema = $schema
        meta = $meta
    } | ConvertTo-Json

    try {
        Invoke-RestMethod -Uri "http://localhost:8055/fields/$collection" -Method POST -Body $body -ContentType "application/json" -Headers $headers | Out-Null
        Write-Host "  OK: $field ($type)"
    } catch {
        Write-Host "  Skip: $field - $($_.Exception.Message.Split('"')[2])"
    }
}

Write-Host "Configuring Products fields..."
Create-Field -collection "products" -field "slug" -type "string" -schema '{"data_type":"varchar","max_length":255,"is_nullable":false}' -meta '{"interface":"input","options":{"placeholder":"product-url-slug"},"required":true}'
Create-Field -collection "products" -field "title" -type "string" -schema '{"data_type":"varchar","max_length":500,"is_nullable":false}' -meta '{"interface":"input","options":{"placeholder":"Product Name"},"required":true}'
Create-Field -collection "products" -field "title_en" -type "string" -schema '{"data_type":"varchar","max_length":500,"is_nullable":true}' -meta '{"interface":"input","options":{"placeholder":"English Title"}}'
Create-Field -collection "products" -field "category" -type "string" -schema '{"data_type":"varchar","max_length":100,"is_nullable":true}' -meta '{"interface":"select-dropdown","options":{"choices":[["Stroller","Stroller"],["Safety Gate","Safety Gate"],["High Chair","High Chair"],["Bed Rail","Bed Rail"]]}}'
Create-Field -collection "products" -field "description" -type "text" -schema '{"data_type":"text","max_length":null,"is_nullable":true}' -meta '{"interface":"textarea","options":{"placeholder":"Product description"}}'
Create-Field -collection "products" -field "description_en" -type "text" -schema '{"data_type":"text","max_length":null,"is_nullable":true}' -meta '{"interface":"textarea","options":{"placeholder":"English Description"}}'
Create-Field -collection "products" -field "moq" -type "integer" -schema '{"data_type":"integer","max_length":null,"is_nullable":true}' -meta '{"interface":"input","options":{"placeholder":"Minimum Order Quantity"}}'
Create-Field -collection "products" -field "lead_time_sample" -type "string" -schema '{"data_type":"varchar","max_length":100,"is_nullable":true}' -meta '{"interface":"input","options":{"placeholder":"7-10 days"}}'
Create-Field -collection "products" -field "lead_time_production" -type "string" -schema '{"data_type":"varchar","max_length":100,"is_nullable":true}' -meta '{"interface":"input","options":{"placeholder":"15-25 days"}}'
Create-Field -collection "products" -field "certifications" -type "json" -schema '{"data_type":"json","max_length":null,"is_nullable":true}' -meta '{"special":"json","interface":"tags","options":{"placeholder":"ASTM, CE, CPC"}}'
Create-Field -collection "products" -field "target_markets" -type "json" -schema '{"data_type":"json","max_length":null,"is_nullable":true}' -meta '{"special":"json","interface":"tags","options":{"placeholder":"US, EU, Canada"}}'
Create-Field -collection "products" -field "image" -type "text" -schema '{"data_type":"text","max_length":null,"is_nullable":true}' -meta '{"special":"file","interface":"file"}'
Create-Field -collection "products" -field "gallery_images" -type "json" -schema '{"data_type":"json","max_length":null,"is_nullable":true}' -meta '{"special":"json","interface":"repeatable"}'
Create-Field -collection "products" -field "specs" -type "json" -schema '{"data_type":"json","max_length":null,"is_nullable":true}' -meta '{"special":"json","interface":"repeatable"}'
Create-Field -collection "products" -field "features" -type "json" -schema '{"data_type":"json","max_length":null,"is_nullable":true}' -meta '{"special":"json","interface":"repeatable"}'
Create-Field -collection "products" -field "custom_options" -type "json" -schema '{"data_type":"json","max_length":null,"is_nullable":true}' -meta '{"special":"json","interface":"repeatable"}'
Create-Field -collection "products" -field "status" -type "string" -schema '{"data_type":"varchar","max_length":50,"is_nullable":true}' -meta '{"interface":"select-dropdown","options":{"choices":[["draft","Draft"],["published","Published"]]}}'
Create-Field -collection "products" -field "sort" -type "integer" -schema '{"data_type":"integer","max_length":null,"is_nullable":true}' -meta '{"interface":"input","options":{"placeholder":"0"}}'

Write-Host ""
Write-Host "Configuring FAQs fields..."
Create-Field -collection "faqs" -field "question" -type "string" -schema '{"data_type":"varchar","max_length":500,"is_nullable":false}' -meta '{"interface":"input","options":{"placeholder":"Question"},"required":true}'
Create-Field -collection "faqs" -field "question_en" -type "string" -schema '{"data_type":"varchar","max_length":500,"is_nullable":true}' -meta '{"interface":"input","options":{"placeholder":"English Question"}}'
Create-Field -collection "faqs" -field "answer" -type "text" -schema '{"data_type":"text","max_length":null,"is_nullable":true}' -meta '{"interface":"textarea","options":{"placeholder":"Answer"}}'
Create-Field -collection "faqs" -field "answer_en" -type "text" -schema '{"data_type":"text","max_length":null,"is_nullable":true}' -meta '{"interface":"textarea","options":{"placeholder":"English Answer"}}'
Create-Field -collection "faqs" -field "category" -type "string" -schema '{"data_type":"varchar","max_length":100,"is_nullable":true}' -meta '{"interface":"select-dropdown","options":{"choices":[["Products","Products"],["Orders","Orders"],["Shipping","Shipping"],["Customs","Customs"]]}}'
Create-Field -collection "faqs" -field "sort" -type "integer" -schema '{"data_type":"integer","max_length":null,"is_nullable":true}' -meta '{"interface":"input","options":{"placeholder":"0"}}'

Write-Host ""
Write-Host "Configuring Blogs fields..."
Create-Field -collection "blogs" -field "slug" -type "string" -schema '{"data_type":"varchar","max_length":255,"is_nullable":false}' -meta '{"interface":"input","options":{"placeholder":"blog-url-slug"},"required":true}'
Create-Field -collection "blogs" -field "title" -type "string" -schema '{"data_type":"varchar","max_length":500,"is_nullable":false}' -meta '{"interface":"input","options":{"placeholder":"Blog Title"},"required":true}'
Create-Field -collection "blogs" -field "title_en" -type "string" -schema '{"data_type":"varchar","max_length":500,"is_nullable":true}' -meta '{"interface":"input","options":{"placeholder":"English Title"}}'
Create-Field -collection "blogs" -field "excerpt" -type "text" -schema '{"data_type":"text","max_length":null,"is_nullable":true}' -meta '{"interface":"textarea","options":{"placeholder":"Short summary"}}'
Create-Field -collection "blogs" -field "excerpt_en" -type "text" -schema '{"data_type":"text","max_length":null,"is_nullable":true}' -meta '{"interface":"textarea","options":{"placeholder":"English Summary"}}'
Create-Field -collection "blogs" -field "content" -type "text" -schema '{"data_type":"text","max_length":null,"is_nullable":true}' -meta '{"interface":"textarea","options":{"placeholder":"Blog content"}}'
Create-Field -collection "blogs" -field "content_en" -type "text" -schema '{"data_type":"text","max_length":null,"is_nullable":true}' -meta '{"interface":"textarea","options":{"placeholder":"English Content"}}'
Create-Field -collection "blogs" -field "cover_image" -type "text" -schema '{"data_type":"text","max_length":null,"is_nullable":true}' -meta '{"special":"file","interface":"file"}'
Create-Field -collection "blogs" -field "author" -type "string" -schema '{"data_type":"varchar","max_length":200,"is_nullable":true}' -meta '{"interface":"input"}'
Create-Field -collection "blogs" -field "tags" -type "json" -schema '{"data_type":"json","max_length":null,"is_nullable":true}' -meta '{"special":"json","interface":"tags"}'
Create-Field -collection "blogs" -field "date_published" -type "datetime" -schema '{"data_type":"datetime","max_length":null,"is_nullable":true}' -meta '{"interface":"datetime"}'
Create-Field -collection "blogs" -field "status" -type "string" -schema '{"data_type":"varchar","max_length":50,"is_nullable":true}' -meta '{"interface":"select-dropdown","options":{"choices":[["draft","Draft"],["published","Published"]]}}'

Write-Host ""
Write-Host "All fields configured!"