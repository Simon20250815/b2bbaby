@echo off
setlocal

echo ==============================================
echo          B2Bbaby 前端更新脚本
echo ==============================================
echo.
echo 此脚本用于在后台内容更新后重新构建前端页面
echo.

cd /d "%~dp0.."

echo 🔄 正在构建前端...
cd frontend
npm run build

if %ERRORLEVEL% equ 0 (
    echo.
    echo ✅ 构建成功！
    echo.
    echo 📁 构建产物已生成在 frontend/dist 目录
    echo 🌐 可以通过 Nginx 或开发服务器预览
    echo.
    echo 📋 更新说明：
    echo   1. 已从 Directus 后台获取最新数据
    echo   2. 前端页面已重新生成
    echo   3. 静态文件已更新
    echo.
) else (
    echo.
    echo ❌ 构建失败，请检查错误信息
    pause
    exit /b 1
)

endlocal