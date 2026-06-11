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

const blogPosts = [
  'eu-ce-standard-safety-gates',
  'us-cpsc-compliance-strollers',
  'avoid-bad-baby-product-suppliers',
  'high-chair-safety-standards',
  'foldable-vs-standard-strollers',
  'wooden-vs-plastic-safety-gates',
  'oem-customization-process'
];

const products = [
  'foldable-baby-stroller-astm',
  'en-tested-safety-gate',
  'high-chair-tested-astm-f404',
  'baby-bed-rail-safety-guard'
];

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