#!/bin/bash

set -e

echo "🚀 开始构建 BabyGEO Pro 项目..."

echo "📦 安装前端依赖..."
cd frontend
if [ ! -d "node_modules" ]; then
    npm install
fi

echo "🔨 执行构建..."
npm run build

echo "✅ 构建完成!"
echo "📁 输出目录: frontend/dist"