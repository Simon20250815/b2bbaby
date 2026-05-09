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

Write-Host "Importing products..."

# Product 1
$body = @{
    slug = "foldable-baby-stroller-astm"
    title = "ASTM Certified Baby Stroller"
    title_en = "ASTM Certified Baby Stroller"
    category = "Stroller"
    description = "高品质婴儿推车，符合ASTM安全标准，50pcs起订"
    description_en = "High quality baby stroller, ASTM safety certified, MOQ 50pcs"
    moq = 50
    lead_time_sample = "7-10 days"
    lead_time_production = "15-25 days"
    certifications = @("ASTM", "CPC", "EN1888")
    target_markets = @("US", "Canada", "UK")
    image = $null
    gallery_images = $null
    status = "published"
    sort = 1
} | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/items/products" -Method Post -Body $body -Headers $headers | Out-Null; Write-Host "OK: Product 1"

# Product 2
$body = @{
    slug = "en-certified-safety-gate"
    title = "EN Certified Safety Gate"
    title_en = "EN Certified Safety Gate"
    category = "Safety Gate"
    description = "符合EN标准婴儿安全门，楼梯门栏"
    description_en = "EN standard baby safety gate"
    moq = 100
    certifications = @("EN71", "EN1930")
    target_markets = @("Europe", "Australia")
    image = $null
    gallery_images = $null
    status = "published"
    sort = 2
} | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/items/products" -Method Post -Body $body -Headers $headers | Out-Null; Write-Host "OK: Product 2"

# Product 3
$body = @{
    slug = "cpc-certified-high-chair"
    title = "CPC Certified High Chair"
    category = "High Chair"
    description = "CPC认证婴儿餐椅可折叠可调高度"
    description_en = "CPC certified high chair"
    moq = 80
    certifications = @("CPC", "EN14988")
    target_markets = @("US", "Mexico", "Canada")
    image = $null
    gallery_images = $null
    status = "published"
    sort = 3
} | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/items/products" -Method Post -Body $body -Headers $headers | Out-Null; Write-Host "OK: Product 3"

# Product 4
$body = @{
    slug = "baby-bed-rail-safety"
    title = "Baby Bed Rail Safety Guard"
    category = "Bed Rail"
    description = "婴儿床安全护栏，防止跌落"
    description_en = "Baby bed safety guard"
    moq = 120
    certifications = @("ASTM")
    target_markets = @("Global", "US")
    image = $null
    gallery_images = $null
    status = "published"
    sort = 4
} | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/items/products" -Method Post -Body $body -Headers $headers | Out-Null; Write-Host "OK: Product 4"

Write-Host ""
Write-Host "Importing FAQs..."

$body = @{
    question = "请问产品的起订量是多少？"
    question_en = "What's your MOQ?"
    answer = "我们的最小起订量是每款产品50-100件，具体取决于产品型号。"
    answer_en = "Our MOQ is 50-100 pcs per model, depending on the product."
    category = "Products"
    sort = 1
} | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/items/faqs" -Method Post -Body $body -Headers $headers | Out-Null; Write-Host "OK: FAQ 1"

$body = @{
    question = "生产周期多长？"
    question_en = "What's the production lead time?"
    answer = "样品交期通常7-10天，大货交期15-25天。"
    answer_en = "Sample lead time is 7-10 days, bulk 15-25 days."
    category = "Orders"
    sort = 2
} | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/items/faqs" -Method Post -Body $body -Headers $headers | Out-Null; Write-Host "OK: FAQ 2"

$body = @{
    question = "可以OEM贴牌吗？"
    question_en = "Can you do OEM?"
    answer = "是的，我们提供OEM/ODM服务。"
    answer_en = "Yes, we provide OEM/ODM services."
    category = "Customs"
    sort = 3
} | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/items/faqs" -Method Post -Body $body -Headers $headers | Out-Null; Write-Host "OK: FAQ 3"

Write-Host ""
Write-Host "Importing Blogs..."

$body = @{
    slug = "baby-safety-standards-guide"
    title = "婴儿产品安全标准指南"
    title_en = "Guide to Baby Product Safety Standards"
    excerpt = "了解婴儿产品的国际安全标准"
    excerpt_en = "Understanding international safety standards"
    content = "婴儿产品安全非常重要..."
    content_en = "Baby product safety is important..."
    cover_image = $null
    author = "B2B Baby Team"
    tags = @("safety", "standards", "ASTM", "EN")
    date_published = (Get-Date -Format "yyyy-MM-dd")
    status = "published"
} | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/items/blogs" -Method Post -Body $body -Headers $headers | Out-Null; Write-Host "OK: Blog 1"

Write-Host ""
Write-Host "All data imported successfully!"