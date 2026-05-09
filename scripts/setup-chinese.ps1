Write-Host "🔐 Logging in to Directus..."

$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token

Write-Host "✅ Logged in successfully!"
Write-Host ""

Write-Host "🌐 Setting admin user language to Chinese..."
$body = @{
    language = "zh-CN"
} | ConvertTo-Json

try {
    Invoke-RestMethod -Uri "http://localhost:8055/users/me" -Method PATCH -Body $body -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" } | Out-Null
    Write-Host "✅ Admin language set to Chinese"
} catch {
    Write-Host "⚠️  Error setting language"
}

Write-Host ""
Write-Host "🎨 Configuring collection display names in Chinese..."

function Update-Collection-Chinese {
    param(
        [string]$collection,
        [string]$displayName
    )
    $body = @{
        meta = @{
            collection = $collection
            display_name = $displayName
        }
    } | ConvertTo-Json
    
    try {
        Invoke-RestMethod -Uri "http://localhost:8055/collections/$collection" -Method PATCH -Body $body -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" } | Out-Null
        Write-Host "   ✓ $collection -> $displayName"
    } catch {
        Write-Host "   ⚠️  Error updating $collection"
    }
}

Update-Collection-Chinese -collection "products" -displayName "产品管理"
Update-Collection-Chinese -collection "faqs" -displayName "常见问题"
Update-Collection-Chinese -collection "blogs" -displayName "博客文章"
Update-Collection-Chinese -collection "inquiries" -displayName "询盘管理"

function Update-Field-Chinese {
    param(
        [string]$collection,
        [string]$field,
        [string]$label
    )
    $body = @{
        meta = @{
            field = $field
            label = $label
        }
    } | ConvertTo-Json
    
    try {
        Invoke-RestMethod -Uri "http://localhost:8055/fields/$collection/$field" -Method PATCH -Body $body -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" } | Out-Null
        Write-Host "     ✓ $field -> $label"
    } catch {
        Write-Host "     ⚠️  Error updating $field"
    }
}

Write-Host ""
Write-Host "📝 Setting Products field labels..."
Update-Field-Chinese -collection "products" -field "slug" -label "URL别名"
Update-Field-Chinese -collection "products" -field "title" -label "产品名称"
Update-Field-Chinese -collection "products" -field "title_en" -label "英文名称"
Update-Field-Chinese -collection "products" -field "category" -label "分类"
Update-Field-Chinese -collection "products" -field "description" -label "产品描述"
Update-Field-Chinese -collection "products" -field "description_en" -label "英文描述"
Update-Field-Chinese -collection "products" -field "moq" -label "最小起订量"
Update-Field-Chinese -collection "products" -field "lead_time_sample" -label "打样周期"
Update-Field-Chinese -collection "products" -field "lead_time_production" -label "生产周期"
Update-Field-Chinese -collection "products" -field "certifications" -label "认证证书"
Update-Field-Chinese -collection "products" -field "target_markets" -label "目标市场"
Update-Field-Chinese -collection "products" -field "image" -label "主图URL"
Update-Field-Chinese -collection "products" -field "gallery_images" -label "相册图片"
Update-Field-Chinese -collection "products" -field "specs" -label "规格参数"
Update-Field-Chinese -collection "products" -field "features" -label "产品特性"
Update-Field-Chinese -collection "products" -field "custom_options" -label "定制选项"
Update-Field-Chinese -collection "products" -field "status" -label "状态"
Update-Field-Chinese -collection "products" -field "sort" -label "排序"

Write-Host ""
Write-Host "📝 Setting FAQs field labels..."
Update-Field-Chinese -collection "faqs" -field "question" -label "问题"
Update-Field-Chinese -collection "faqs" -field "question_en" -label "英文问题"
Update-Field-Chinese -collection "faqs" -field "answer" -label "答案"
Update-Field-Chinese -collection "faqs" -field "answer_en" -label "英文答案"
Update-Field-Chinese -collection "faqs" -field "category" -label "分类"
Update-Field-Chinese -collection "faqs" -field "sort" -label "排序"

Write-Host ""
Write-Host "📝 Setting Blogs field labels..."
Update-Field-Chinese -collection "blogs" -field "slug" -label "URL别名"
Update-Field-Chinese -collection "blogs" -field "title" -label "标题"
Update-Field-Chinese -collection "blogs" -field "title_en" -label "英文标题"
Update-Field-Chinese -collection "blogs" -field "excerpt" -label "摘要"
Update-Field-Chinese -collection "blogs" -field "excerpt_en" -label "英文摘要"
Update-Field-Chinese -collection "blogs" -field "content" -label "内容"
Update-Field-Chinese -collection "blogs" -field "content_en" -label "英文内容"
Update-Field-Chinese -collection "blogs" -field "cover_image" -label "封面图片"
Update-Field-Chinese -collection "blogs" -field "author" -label "作者"
Update-Field-Chinese -collection "blogs" -field "tags" -label "标签"
Update-Field-Chinese -collection "blogs" -field "date_published" -label "发布日期"
Update-Field-Chinese -collection "blogs" -field "status" -label "状态"

Write-Host ""
Write-Host "📝 Setting Inquiries field labels..."
Update-Field-Chinese -collection "inquiries" -field "name" -label "姓名"
Update-Field-Chinese -collection "inquiries" -field "email" -label "邮箱"
Update-Field-Chinese -collection "inquiries" -field "company" -label "公司"
Update-Field-Chinese -collection "inquiries" -field "phone" -label "电话"
Update-Field-Chinese -collection "inquiries" -field "product" -label "感兴趣产品"
Update-Field-Chinese -collection "inquiries" -field "message" -label "留言内容"
Update-Field-Chinese -collection "inquiries" -field "status" -label "状态"

Write-Host ""
Write-Host "✅ 中文界面配置完成!"
Write-Host ""
Write-Host "🌐 重新登录 Directus 后台查看中文界面:"
Write-Host "   http://localhost:8055/admin"