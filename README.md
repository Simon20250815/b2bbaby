# B2B Baby - 专业婴儿用品网站

基于 **Astro** 构建的现代企业网站，配合 **Umami** 进行网站数据分析。

## 技术栈

| 组件 | 技术 | 说明 |
|------|------|------|
| 前端框架 | Astro | 高性能静态站点生成 |
| 样式框架 | Tailwind CSS | 实用优先的 CSS 框架 |
| 网站分析 | Umami | 开源隐私友好分析 |

## 项目结构

```
b2bbaby/
├── frontend/                 # Astro 前端项目
│   ├── content/              # 内容目录
│   │   ├── products/         # 产品内容 (MDX)
│   │   ├── blogs/            # 博客内容 (MDX)
│   │   ├── faqs/             # FAQ 内容 (JSON)
│   │   ├── pages/            # 页面内容 (MDX)
│   │   └── global/           # 全局设置 (JSON)
│   ├── src/
│   │   ├── pages/            # 页面路由
│   │   ├── components/       # 组件
│   │   ├── layouts/          # 布局
│   │   └── lib/              # 工具函数
│   ├── public/               # 静态资源
│   └── astro.config.mjs      # Astro 配置
├── nginx/                    # Nginx 配置
│   └── nginx.conf
├── docker-compose.yml        # Umami Docker 配置
├── .env                      # 环境变量
└── README.md                 # 项目说明
```

## 快速开始

### 1. 安装依赖

```bash
cd frontend
npm install
```

### 2. 开发模式

```bash
npm run dev
```

访问 http://localhost:4321

### 3. 构建生产版本

```bash
npm run build
```

构建产物在 `dist/client/` 目录

## 部署指南

### 前端部署（静态文件）

```bash
# 构建
cd frontend
npm run build

# 上传 dist/client 目录到服务器
# 目标路径: /www/wwwroot/b2bbaby/
```

### Umami 部署（Docker）

```bash
# 启动 Umami
docker-compose up -d
```

### 配置 Umami

1. 访问 http://your-server-ip:3001
2. 默认登录：`admin` / `umami`
3. 修改密码为：`simion`
4. 创建网站，获取 Website ID
5. 在 `frontend/content/global/index.json` 中配置

## 内容管理

直接编辑 `frontend/content/` 目录下的文件：

- **产品**: `content/products/*.mdx`
- **博客**: `content/blogs/*.mdx`
- **FAQ**: `content/faqs/faqs.json`
- **页面**: `content/pages/*.mdx`
- **全局设置**: `content/global/index.json`

## 开发命令

```bash
# 开发模式
npm run dev

# 构建生产版本
npm run build

# 预览构建结果
npm run preview
```

## 许可证

MIT License
