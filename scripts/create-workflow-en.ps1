$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token

$scriptCode = @"
module.exports = async function({ data, env, execution }) {
    const { exec } = require('child_process');
    const { promisify } = require('util');
    const execAsync = promisify(exec);
    
    console.log('Starting frontend build...');
    console.log('Event:', execution.event);
    console.log('Collection:', execution.collection);
    
    try {
        const { stdout, stderr } = await execAsync(
            'cd /app/frontend && npm run build',
            { timeout: 180000 }
        );
        
        if (stdout) console.log('stdout:', stdout.slice(-1000));
        if (stderr) console.log('stderr:', stderr.slice(-1000));
        
        console.log('Build completed successfully!');
        return { success: true, message: 'Build completed' };
    } catch (error) {
        console.error('Build failed:', error.message);
        throw new Error('Build failed: ' + error.message);
    }
};
"@

$workflowBody = @{
    name = "Auto Build Frontend"
    description = "Automatically build frontend when content is updated"
    status = "active"
    trigger = @{
        type = "event"
        event = "items.create,items.update,items.delete"
        collections = @("products", "faqs", "blogs")
    }
    operations = @(
        @{
            key = "build_op"
            name = "Execute Build"
            type = "script"
            position_x = 100
            position_y = 100
            options = @{
                script = $scriptCode
            }
        }
    )
} | ConvertTo-Json -Depth 10

try {
    $response = Invoke-RestMethod -Uri "http://localhost:8055/flows" -Method POST -Body $workflowBody -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" }
    Write-Host "Workflow created successfully!"
    Write-Host ""
    Write-Host "Workflow ID: $($response.id)"
    Write-Host "Workflow Name: $($response.name)"
    Write-Host "Workflow Status: $($response.status)"
} catch {
    Write-Host "Error creating workflow: $_"
}