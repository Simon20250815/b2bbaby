## CI/CD 自动部署配置指南

### 一、配置流程

#### 1. 生成 SSH 密钥对

在本地终端执行以下命令生成 SSH 密钥（用于 GitHub Actions 连接服务器）：

```bash
ssh-keygen -t ed25519 -C "github-actions-deploy" -f ~/.ssh/github-actions-deploy
```

- **公钥** (`github-actions-deploy.pub`) - 放到服务器的 `~/.ssh/authorized_keys`
- **私钥** (`github-actions-deploy`) - 作为 GitHub Secrets

#### 2. 将公钥上传到服务器

```bash
# 将公钥复制到服务器
ssh-copy-id -i ~/.ssh/github-actions-deploy.pub your_username@your_server_ip

# 或者手动复制
cat ~/.ssh/github-actions-deploy.pub | ssh your_username@your_server_ip "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

#### 3. 在 GitHub 仓库设置 Secrets

进入你的 GitHub 仓库 → Settings → Secrets and variables → Actions → New repository secret

添加以下 Secrets：

| Secret 名称 | 值 | 说明 |
|------------|-----|------|
| SERVER_HOST | 服务器IP地址 | 你的服务器公网IP |
| SERVER_USER | 服务器用户名 | 如 root 或 www |
| SERVER_SSH_KEY | 私钥内容 | `cat ~/.ssh/github-actions-deploy` 的输出 |
| SERVER_PORT | 22 | SSH端口，默认22 |

#### 4. 服务器端准备

确保服务器已安装 PM2 且配置正确：

```bash
# 安装 PM2（如未安装）
npm install -g pm2

# 确保项目目录存在且有正确权限
mkdir -p /www/wwwroot/b2bbaby/frontend/dist
chown -R www:www /www/wwwroot/b2bbaby
```

### 二、使用流程

1. **开发代码**：在本地修改代码
2. **提交代码**：
```bash
git add .
git commit -m "描述你的修改"
git push origin main
```

3. **自动部署**：
   - 推送到 `main` 分支后，GitHub Actions 会自动触发
   - 自动构建前端项目
   - 自动上传到服务器
   - 自动重启 PM2

### 三、工作流说明

创建的工作流文件：`.github/workflows/deploy.yml`

**工作流包含两个阶段：**

1. **Build 阶段**：
   - 拉取代码
   - 安装依赖
   - 构建前端项目
   - 上传构建产物作为 Artifact

2. **Deploy 阶段**：
   - 下载构建产物
   - 备份旧的 dist 目录
   - 上传新的 dist 文件到服务器
   - 重启 PM2 服务

### 四、验证部署

#### 查看 GitHub Actions 状态
- 进入仓库 → Actions → 查看最新的 workflow run
- 点击进入可查看详细日志

#### 服务器端验证
```bash
# 查看 PM2 状态
pm2 status

# 查看日志
pm2 logs b2bbaby-ssr

# 查看部署目录
ls -la /www/wwwroot/b2bbaby/frontend/dist
```

### 五、注意事项

1. **分支保护**：建议在 GitHub 开启 main 分支保护，要求 PR 审核后才能合并
2. **密钥安全**：不要将私钥提交到代码仓库，使用 GitHub Secrets 管理
3. **服务器防火墙**：确保服务器防火墙允许 SSH 访问（端口 22）
4. **备份机制**：工作流会自动备份旧的 dist 目录到 dist.bak，如部署失败可回滚
5. **环境变量**：确保服务器上的环境变量配置正确（参考 ecosystem.config.cjs）

### 六、手动部署回退（如需要）

```bash
# 进入项目目录
cd /www/wwwroot/b2bbaby/frontend

# 停止服务
pm2 stop b2bbaby-ssr

# 回滚到备份
rm -rf dist
mv dist.bak dist

# 重启服务
pm2 restart b2bbaby-ssr
```