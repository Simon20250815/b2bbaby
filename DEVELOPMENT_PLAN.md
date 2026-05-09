# 🚀 BabyGEO Pro 新系统开发计划

> **技术架构**: Directus v11 + Astro 4.0 + PostgreSQL + Nginx  
> **开发日期**: 2026-05-08  
> **目标**: 彻底解决后台修改不生效、Webhook 不可靠、配置复杂等问题

---

## 📐 架构设计

```
┌─────────────────────────────────────────────────────────────────┐
│                        用户访问层                                │
│  https://b2bbaby.com → Nginx → 静态 HTML 文件                   │
└─────────────────────────────────────────────────────────────────┘
                              ▲
                              │ 构建输出
┌─────────────────────────────────────────────────────────────────┐
│                        构建层                                    │
│  Astro Build → 纯静态 HTML + JSON-LD + 图片优化                 │
└─────────────────────────────────────────────────────────────────┘
                              ▲
                              │ 数据拉取
┌─────────────────────────────────────────────────────────────────┐
│                        CMS 层                                    │
│  Directus v11 (端口 8055) → 可视化后台管理                       │
│  ├── Flows 自动触发构建                                          │
│  ├── 媒体库管理                                                  │
│  └── 多语言支持                                                  │
└─────────────────────────────────────────────────────────────────┘
                              ▲
                              │ 数据存储
┌─────────────────────────────────────────────────────────────────┐
│                        数据层                                    │
│  PostgreSQL 16 → 产品/FAQ/博客/页面数据                          │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🛠️ 技术栈

| 组件 | 技术 | 版本 | 说明 |
|------|------|------|------|
| CMS 后台 | Directus | v11 | 可视化后台，拖拽建模，Flows 自动化 |
| 前端框架 | Astro | 4.x | 纯静态输出，构建极快，SEO 友好 |
| 数据库 | PostgreSQL | 16-alpine | 数据存储，备份简单 |
| 静态服务 | Nginx | alpine | 高性能静态文件服务 |
| 容器化 | Docker Compose | 3.8 | 一键部署，环境隔离 |

---

## 📋 开发阶段

### 阶段一：基础架构搭建 (Day 1)

#### 1.1 创建项目结构
```
newbaby/
├── docker-compose.yml          # Docker 编排配置
├── directus/                   # Directus 配置
│   ├── extensions/             # 扩展目录
│   └── uploads/                # 上传文件目录
├── frontend/                   # Astro 前端
│   ├── src/
│   │   ├── pages/              # 页面
│   │   ├── components/         # 组件
│   │   ├── layouts/            # 布局
│   │   └── lib/                # 工具函数
│   ├── public/                 # 静态资源
│   └── astro.config.mjs        # Astro 配置
├── nginx/                      # Nginx 配置
│   └── nginx.conf
├── scripts/                    # 脚本
│   ├── rebuild.sh              # 构建脚本
│   └── backup.sh               # 备份脚本
└── data/                       # 数据迁移
    ├── products.json           # 产品数据
    ├── faqs.json               # FAQ 数据
    ├── blogs.json              # 博客数据
    └── images/                 # 图片资源
```

#### 1.2 Docker Compose 配置
```yaml
version: "3.8"

services:
  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: directus
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - db_data:/var/lib/postgresql/data
    restart: unless-stopped

  directus:
    image: directus/directus:11
    ports:
      - "8055:8055"
    environment:
      KEY: ${DIRECTUS_KEY}
      SECRET: ${DIRECTUS_SECRET}
      DB_CLIENT: "pg"
      DB_HOST: "db"
      DB_PORT: "5432"
      DB_DATABASE: "directus"
      DB_USER: "admin"
      DB_PASSWORD: ${DB_PASSWORD}
      ADMIN_EMAIL: "admin@b2bbaby.com"
      ADMIN_PASSWORD: ${ADMIN_PASSWORD}
      PUBLIC_URL: "https://b2bbaby.com"
    volumes:
      - ./directus/uploads:/directus/uploads
      - ./directus/extensions:/directus/extensions
    depends_on:
      - db
    restart: unless-stopped

  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./frontend/dist:/usr/share/nginx/html:ro
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
    restart: unless-stopped

volumes:
  db_data:
```

---

### 阶段二：Directus 后台配置 (Day 2)

#### 2.1 数据模型设计

**Products 集合**
```json
{
  "fields": [
    { "field": "id", "type": "integer", "meta": { "interface": "input", "readonly": true } },
    { "field": "slug", "type": "string", "meta": { "interface": "input", "required": true } },
    { "field": "title", "type": "string", "meta": { "interface": "input", "required": true } },
    { "field": "title_en", "type": "string" },
    { "field": "description", "type": "text" },
    { "field": "description_en", "type": "text" },
    { "field": "moq", "type": "integer" },
    { "field": "certifications", "type": "json" },
    { "field": "features", "type": "json" },
    { "field": "images", "type": "json" },
    { "field": "category", "type": "string" },
    { "field": "status", "type": "string", "default_value": "draft" },
    { "field": "sort", "type": "integer", "default_value": 0 },
    { "field": "date_created", "type": "datetime" },
    { "field": "date_updated", "type": "datetime" }
  ]
}
```

**FAQs 集合**
```json
{
  "fields": [
    { "field": "id", "type": "integer" },
    { "field": "question", "type": "string", "meta": { "required": true } },
    { "field": "question_en", "type": "string" },
    { "field": "answer", "type": "text" },
    { "field": "answer_en", "type": "text" },
    { "field": "category", "type": "string" },
    { "field": "sort", "type": "integer" }
  ]
}
```

**Blogs 集合**
```json
{
  "fields": [
    { "field": "id", "type": "integer" },
    { "field": "slug", "type": "string", "meta": { "required": true } },
    { "field": "title", "type": "string", "meta": { "required": true } },
    { "field": "title_en", "type": "string" },
    { "field": "excerpt", "type": "text" },
    { "field": "excerpt_en", "type": "text" },
    { "field": "content", "type": "text" },
    { "field": "content_en", "type": "text" },
    { "field": "cover_image", "type": "string" },
    { "field": "author", "type": "string" },
    { "field": "tags", "type": "json" },
    { "field": "date_published", "type": "datetime" },
    { "field": "status", "type": "string", "default_value": "draft" }
  ]
}
```

#### 2.2 Directus Flows 配置

**Flow 1: 自动构建触发**
```
Trigger: items.create / items.update
Collection: products, faqs, blogs, pages
Action: Execute Script (Node.js)
```

```javascript
module.exports = async function ({ data, env, services }) {
  const { exec } = require('child_process');
  const { promisify } = require('util');
  const execAsync = promisify(exec);

  try {
    console.log('🔄 开始构建前端...');
    
    const { stdout, stderr } = await execAsync(
      'cd /app/frontend && npm run build',
      { timeout: 120000 }
    );
    
    console.log('✅ 构建完成');
    
    return { success: true, output: stdout };
  } catch (error) {
    console.error('❌ 构建失败:', error.message);
    
    // 发送告警邮件
    await services.mail({
      to: 'admin@b2bbaby.com',
      subject: '构建失败告警',
      body: `构建失败: ${error.message}`
    });
    
    throw error;
  }
};
```

---

### 阶段三：Astro 前端开发 (Day 3-4)

#### 3.1 项目初始化
```bash
cd newbaby
npm create astro@latest frontend
cd frontend
npm install @astrojs/sitemap @astrojs/image
```

#### 3.2 数据拉取配置
```typescript
// src/lib/directus.ts
import { createDirectus, rest, readItems } from '@directus/sdk';

const DIRECTUS_URL = import.meta.env.DIRECTUS_URL || 'http://localhost:8055';

const client = createDirectus(DIRECTUS_URL).with(rest());

export async function getProducts() {
  return client.request(
    readItems('products', {
      filter: { status: { _eq: 'published' } },
      sort: ['sort'],
      limit: 100
    })
  );
}

export async function getProductBySlug(slug: string) {
  const items = await client.request(
    readItems('products', {
      filter: { slug: { _eq: slug } },
      limit: 1
    })
  );
  return items[0];
}

export async function getFAQs() {
  return client.request(
    readItems('faqs', {
      sort: ['sort']
    })
  );
}

export async function getBlogs() {
  return client.request(
    readItems('blogs', {
      filter: { status: { _eq: 'published' } },
      sort: ['-date_published'],
      limit: 50
    })
  );
}
```

#### 3.3 页面结构
```
src/pages/
├── index.astro              # 首页
├── products/
│   ├── index.astro          # 产品列表
│   └── [slug].astro         # 产品详情
├── blog/
│   ├── index.astro          # 博客列表
│   └── [slug].astro         # 博客详情
├── faq/
│   └── index.astro          # FAQ 页面
├── about/
│   └── index.astro          # 关于我们
├── contact/
│   └── index.astro          # 联系我们
└── oem-odm/
    └── index.astro          # OEM/ODM 服务
```

#### 3.4 SEO 组件
```astro
---
// src/components/SEOHead.astro
interface Props {
  title: string;
  description: string;
  canonical?: string;
  ogImage?: string;
  schema?: object;
}

const { title, description, canonical, ogImage, schema } = Astro.props;
---

<head>
  <title>{title} | BabyGEO Pro</title>
  <meta name="description" content={description} />
  <meta name="robots" content="index, follow" />
  
  {canonical && <link rel="canonical" href={canonical} />}
  
  <!-- Open Graph -->
  <meta property="og:title" content={title} />
  <meta property="og:description" content={description} />
  <meta property="og:type" content="website" />
  {ogImage && <meta property="og:image" content={ogImage} />}
  
  <!-- JSON-LD Schema -->
  {schema && (
    <script type="application/ld+json" set:html={JSON.stringify(schema)} />
  )}
</head>
```

---

### 阶段四：数据迁移 (Day 5)

#### 4.1 数据导出脚本
```javascript
// scripts/export-data.js
const fs = require('fs');
const path = require('path');

// 从旧系统导出数据
const products = require('../babygeo/data/products.json');
const faqs = require('../babygeo/data/faqs.json');

// 转换为 Directus 格式
const directusProducts = products.map(p => ({
  slug: p.slug,
  title: p.title,
  title_en: p.title_en || p.title,
  description: p.description,
  description_en: p.description_en || p.description,
  moq: p.moq || 100,
  certifications: p.certifications || [],
  features: p.features || [],
  images: p.images || [],
  category: p.category || 'general',
  status: 'published',
  sort: p.sort || 0
}));

fs.writeFileSync(
  path.join(__dirname, '../data/products.json'),
  JSON.stringify(directusProducts, null, 2)
);

console.log('✅ 数据导出完成');
```

#### 4.2 图片下载脚本
```javascript
// scripts/download-images.js
const https = require('https');
const http = require('http');
const fs = require('fs');
const path = require('path');

async function downloadImage(url, destPath) {
  return new Promise((resolve, reject) => {
    const protocol = url.startsWith('https') ? https : http;
    const file = fs.createWriteStream(destPath);
    
    protocol.get(url, (response) => {
      if (response.statusCode === 301 || response.statusCode === 302) {
        downloadImage(response.headers.location, destPath)
          .then(resolve)
          .catch(reject);
        return;
      }
      
      response.pipe(file);
      file.on('finish', () => {
        file.close();
        resolve(destPath);
      });
    }).on('error', (err) => {
      fs.unlink(destPath, () => {});
      reject(err);
    });
  });
}

async function downloadAllImages() {
  const products = require('../babygeo/data/products.json');
  const imageDir = path.join(__dirname, '../data/images');
  
  if (!fs.existsSync(imageDir)) {
    fs.mkdirSync(imageDir, { recursive: true });
  }
  
  for (const product of products) {
    if (product.images && product.images.length > 0) {
      for (let i = 0; i < product.images.length; i++) {
        const imageUrl = product.images[i];
        const ext = path.extname(new URL(imageUrl).pathname) || '.jpg';
        const filename = `${product.slug}-${i + 1}${ext}`;
        const destPath = path.join(imageDir, filename);
        
        try {
          console.log(`下载: ${imageUrl}`);
          await downloadImage(imageUrl, destPath);
          console.log(`✅ 已保存: ${filename}`);
          
          // 更新本地路径
          product.images[i] = `/images/${filename}`;
        } catch (err) {
          console.error(`❌ 下载失败: ${imageUrl}`, err.message);
        }
      }
    }
  }
  
  fs.writeFileSync(
    path.join(__dirname, '../data/products-local.json'),
    JSON.stringify(products, null, 2)
  );
  
  console.log('✅ 所有图片下载完成');
}

downloadAllImages();
```

---

## ⚠️ 重点避坑指南

### 坑 1: Directus Flows 无法执行 Shell 命令

**问题**: Directus 默认安全策略禁止执行系统命令

**解决方案**:
```yaml
# docker-compose.yml
directus:
  environment:
    DIRECTUS_RUN_SCRIPT_ALLOW_LIST: "exec,spawn"  # 允许执行命令
  security_opt:
    - seccomp:unconfined  # 解除安全限制
```

**替代方案**: 使用 Webhook 调用外部构建服务
```javascript
// Directus Flow Action
module.exports = async function ({ data, env }) {
  const response = await fetch('http://builder:3001/build', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ collection: data.collection })
  });
  return response.json();
};
```

---

### 坑 2: Astro 构建时无法连接 Directus

**问题**: Docker 网络隔离导致构建容器无法访问 Directus

**解决方案**:
```yaml
# docker-compose.yml
services:
  builder:
    network_mode: "host"  # 使用主机网络
    # 或者
    extra_hosts:
      - "directus:host-gateway"  # 解析到主机 IP
```

```javascript
// astro.config.mjs
export default defineConfig({
  vite: {
    server: {
      host: true  # 允许外部访问
    }
  }
});
```

---

### 坑 3: 图片路径迁移后失效

**问题**: 旧系统图片 URL 与新系统路径不一致

**解决方案**:
```javascript
// 构建时重写图片路径
// src/lib/image-utils.ts
export function normalizeImageUrl(url) {
  if (url.startsWith('http')) {
    // 远程图片：下载到本地或使用 CDN
    return url;
  }
  
  // 本地图片：确保路径正确
  if (!url.startsWith('/')) {
    return `/${url}`;
  }
  
  return url;
}
```

---

### 坑 4: 多语言内容缺失

**问题**: 旧系统部分内容只有中文，缺少英文

**解决方案**:
```typescript
// src/lib/i18n.ts
export function getLocalizedContent(item, field, locale = 'en') {
  const localizedField = `${field}_${locale}`;
  
  // 优先返回本地化内容，否则回退到默认语言
  return item[localizedField] || item[field] || '';
}
```

---

### 坑 5: 构建超时失败

**问题**: 产品数量多时构建超过 2 分钟超时

**解决方案**:
```javascript
// astro.config.mjs
export default defineConfig({
  output: 'static',
  build: {
    concurrency: 2  // 并发构建
  },
  vite: {
    build: {
      cssMinify: true,
      minify: 'terser'
    }
  }
});
```

**增量构建方案**:
```javascript
// scripts/incremental-build.js
const { execSync } = require('child_process');
const fs = require('fs');

const lastBuildFile = '.last-build';
const now = Date.now();

if (fs.existsSync(lastBuildFile)) {
  const lastBuild = parseInt(fs.readFileSync(lastBuildFile, 'utf8'));
  const hoursSinceLastBuild = (now - lastBuild) / (1000 * 60 * 60);
  
  if (hoursSinceLastBuild < 24) {
    console.log('使用增量构建...');
    execSync('npm run build:incremental', { stdio: 'inherit' });
  } else {
    console.log('执行全量构建...');
    execSync('npm run build', { stdio: 'inherit' });
  }
} else {
  execSync('npm run build', { stdio: 'inherit' });
}

fs.writeFileSync(lastBuildFile, now.toString());
```

---

### 坑 6: Nginx 配置导致静态文件 404

**问题**: Nginx 未正确配置静态文件路径

**解决方案**:
```nginx
# nginx/nginx.conf
server {
    listen 80;
    server_name b2bbaby.com;
    
    root /usr/share/nginx/html;
    index index.html;
    
    # 静态文件缓存
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
    
    # SPA 路由支持
    location / {
        try_files $uri $uri/ /index.html;
    }
    
    # 图片目录
    location /images/ {
        alias /usr/share/nginx/html/images/;
        autoindex off;
    }
}
```

---

### 坑 7: Directus 认证 Cookie 跨域问题

**问题**: 前端和后台不在同域导致登录态丢失

**解决方案**:
```yaml
# docker-compose.yml
directus:
  environment:
    REFRESH_TOKEN_COOKIE: "true"
    REFRESH_TOKEN_COOKIE_DOMAIN: ".b2bbaby.com"  # 支持子域名
    REFRESH_TOKEN_COOKIE_SECURE: "true"
    REFRESH_TOKEN_COOKIE_SAME_SITE: "Lax"
```

---

### 坑 8: 数据库迁移编码问题

**问题**: 中文内容迁移后乱码

**解决方案**:
```bash
# 导出时指定编码
pg_dump -U postgres -d babygeo_pro --encoding=UTF8 > backup.sql

# 导入时指定编码
psql -U postgres -d directus --encoding=UTF8 < backup.sql
```

```javascript
// 数据迁移脚本确保 UTF-8
fs.writeFileSync(
  'data/products.json',
  JSON.stringify(products, null, 2),
  { encoding: 'utf8' }
);
```

---

## ✅ 验收标准

### 功能验收
- [ ] Directus 后台可正常访问 `http://localhost:8055/admin`
- [ ] 后台登录无无限重定向
- [ ] 产品/FAQ/博客数据可正常增删改查
- [ ] 保存内容后自动触发构建
- [ ] 前端页面可正常访问
- [ ] 所有图片正常显示
- [ ] 询盘表单可正常提交

### 性能验收
- [ ] 首页加载时间 < 2 秒
- [ ] 产品详情页加载时间 < 1.5 秒
- [ ] 构建时间 < 60 秒
- [ ] Lighthouse 性能分数 > 90

### SEO 验收
- [ ] 所有页面包含正确的 JSON-LD Schema
- [ ] robots.txt 可访问
- [ ] sitemap.xml 自动生成
- [ ] hreflang 标签正确配置
- [ ] Google Rich Results Test 通过

---

## 📅 开发时间表

| 阶段 | 任务 | 预计时间 |
|------|------|----------|
| Day 1 | 基础架构搭建 | 4 小时 |
| Day 2 | Directus 后台配置 | 4 小时 |
| Day 3 | Astro 前端开发 (页面) | 6 小时 |
| Day 4 | Astro 前端开发 (组件/SEO) | 4 小时 |
| Day 5 | 数据迁移 + 测试 | 4 小时 |
| Day 6 | 部署 + 验收 | 2 小时 |

**总计**: 约 24 小时（3-4 个工作日）

---

## 📝 备注

1. **备份数据**: 迁移前务必备份原数据库
2. **测试环境**: 先在本地测试完整流程再部署生产
3. **监控告警**: 配置构建失败告警通知
4. **文档更新**: 完成后更新运维手册

---

**创建日期**: 2026-05-08  
**最后更新**: 2026-05-08
