@echo off
echo ============================================
echo         B2B Baby 一键更新到公网
echo ============================================
echo.
echo 正在构建前端...
echo.

cd c:\Users\Administrator\Desktop\b2bbaby\newbaby\frontend
npm run build

echo.
echo ============================================
echo              更新完成！
echo ============================================
echo.
echo 公网页面已更新，请访问：
echo http://localhost:80
echo.
echo 按任意键退出...
pause >nul


