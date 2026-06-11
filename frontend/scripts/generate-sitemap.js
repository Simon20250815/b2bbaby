import fs from 'fs';
import path from 'path';

const pages = [
  { loc: '/', priority: '1.0', changefreq: 'weekly' },
  { loc: '/about', priority: '0.8', changefreq: 'monthly' },
  { loc: '/products', priority: '0.9', changefreq: 'weekly' },
  { loc: '/blog', priority: '0.8', changefreq: 'weekly' },
  { loc: '/faq', priority: '0.8', changefreq: 'monthly' },
  { loc: '/contact', priority: '0.8', changefreq: 'monthly' },
  { loc: '/oem-odm', priority: '0.8', changefreq: 'monthly' },
  { loc: '/quote', priority: '0.8', changefreq: 'monthly' },
  { loc: '/shipping-proof', priority: '0.7', changefreq: 'monthly' }
];

async function getBlogPosts() {
  try {
    const blogDataPath = path.join(process.cwd(), 'src', 'lib', 'blog-data.ts');
    const content = fs.readFileSync(blogDataPath, 'utf-8');
    
    const match = content.match(/blogPosts:\s*(\[.*?\])/s);
    if (match) {
      const jsonStr = match[1]
        .replace(/'/g, '"')
        .replace(/(\w+):/g, '"$1":')
        .replace(/,\s*(\]|\})/g, '$1');
      const posts = JSON.parse(jsonStr);
      return posts.filter(p => p.status === 'published').map(p => p.slug);
    }
  } catch (error) {
    console.warn('⚠️  Failed to read blog data, using fallback');
  }
  return [
    'eu-ce-standard-safety-gates',
    'us-cpsc-compliance-strollers',
    'avoid-bad-baby-product-suppliers',
    'high-chair-safety-standards',
    'foldable-vs-standard-strollers',
    'wooden-vs-plastic-safety-gates',
    'oem-customization-process'
  ];
}

async function getProducts() {
  try {
    const productDataPath = path.join(process.cwd(), 'src', 'lib', 'product-data.ts');
    const content = fs.readFileSync(productDataPath, 'utf-8');
    
    const match = content.match(/productsData:\s*(\[.*?\])/s);
    if (match) {
      const jsonStr = match[1]
        .replace(/'/g, '"')
        .replace(/(\w+):/g, '"$1":')
        .replace(/,\s*(\]|\})/g, '$1');
      const products = JSON.parse(jsonStr);
      return products.filter(p => p.status === 'published').map(p => p.slug);
    }
  } catch (error) {
    console.warn('⚠️  Failed to read product data, using fallback');
  }
  return [
    'foldable-baby-stroller-astm',
    'en-certified-safety-gate',
    'cpc-certified-high-chair',
    'baby-bed-rail-safety-guard'
  ];
}

async function generateSitemap() {
  const blogPosts = await getBlogPosts();
  const products = await getProducts();

  const urlset = pages.map(page => `
  <url>
    <loc>https://b2bbaby.com${page.loc}</loc>
    <lastmod>${new Date().toISOString().split('T')[0]}</lastmod>
    <changefreq>${page.changefreq}</changefreq>
    <priority>${page.priority}</priority>
  </url>`).join('');

  const blogUrls = blogPosts.map(slug => `
  <url>
    <loc>https://b2bbaby.com/blog/${slug}</loc>
    <lastmod>${new Date().toISOString().split('T')[0]}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.7</priority>
  </url>`).join('');

  const productUrls = products.map(slug => `
  <url>
    <loc>https://b2bbaby.com/products/${slug}</loc>
    <lastmod>${new Date().toISOString().split('T')[0]}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.8</priority>
  </url>`).join('');

  const sitemap = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">${urlset}${blogUrls}${productUrls}
</urlset>`;

  const distDir = path.join(process.cwd(), 'dist', 'client');
  if (!fs.existsSync(distDir)) {
    fs.mkdirSync(distDir, { recursive: true });
  }

  fs.writeFileSync(path.join(distDir, 'sitemap.xml'), sitemap);

  console.log('✅ sitemap.xml generated successfully!');
  console.log(`📄 Location: ${path.join(distDir, 'sitemap.xml')}`);
  console.log(`📊 Total URLs: ${pages.length + blogPosts.length + products.length}`);
  console.log(`📝 Blog posts: ${blogPosts.length}`);
  console.log(`🛒 Products: ${products.length}`);
}

generateSitemap();