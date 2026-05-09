Write-Host "🔐 正在登录 Directus..."

$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

try {
    $loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json" -TimeoutSec 30
    $token = $loginResponse.data.access_token
    Write-Host "✅ 登录成功!"
} catch {
    Write-Host "❌ 登录失败: $_"
    exit 1
}

Write-Host ""
Write-Host "🔧 正在创建工作流..."

$workflowBody = @{
    name = "前端自动构建"
    description = "当产品、FAQ、博客内容更新时自动触发前端构建"
    status = "active"
    trigger = @{
        type = "event"
        event = "items.create,items.update,items.delete"
        collections = @("products", "faqs", "blogs")
    }
    operations = @(
        @{
            key = "operation_1"
            name = "执行前端构建"
            type = "script"
            position_x = 100
            position_y = 100
            options = @{
                script = @"
module.exports = async function({ data, env, execution }) {
    const { exec } = require('child_process');
    const { promisify } = require('util');
    const execAsync = promisify(exec);
    
    console.log('🔄 开始前端构建...');
    console.log('触发事件:', execution.event);
    console.log('修改集合:', execution.collection);
    
    try {
        const { stdout, stderr } = await execAsync(
            'cd /app/frontend && npm run build',
            { timeout: 180000 }
        );
        
        if (stdout) console.log('stdout:', stdout.slice(-1000));
        if (stderr) console.log('stderr:', stderr.slice(-1000));
        
        console.log('✅ 前端构建完成!');
        return { success: true, message: 'Build completed successfully' };
    } catch (error) {
        console.error('❌ 构建失败:', error.message);
        throw new Error('Build failed: ' + error.message);
    }
};
"@
            }
        }
    )
} | ConvertTo-Json -Depth 10

try {
    $response = Invoke-RestMethod -Uri "http://localhost:8055/flows" -Method POST -Body $workflowBody -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" } -TimeoutSec 30
    Write-Host "✅ 工作流创建成功!"
    Write-Host ""
    Write-Host "🎯 工作流信息:"
    Write-Host "   ID: $($response.id)"
    Write-Host "   名称: $($response.name)"
    Write-Host "   状态: $($response.status)"
    Write-Host ""
    Write-Host "📋 触发条件:"
    Write-Host "   - 事件: items.create, items.update, items.delete"
    Write-Host "   - 集合: products, faqs, blogs"
    Write-Host ""
    Write-Host "✅ 现在当你在后台修改内容并保存时，会自动触发前端构建!"
} catch {
    Write-Host "❌ 创建工作流失败: $_"
}