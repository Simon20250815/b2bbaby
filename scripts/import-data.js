const axios = require('axios');

const api = axios.create({
  baseURL: 'http://localhost:8055',
  timeout: 10000
});

async function main() {
  console.log('Getting auth token...');
  const loginRes = await api.post('/auth/login', {
    email: 'admin@b2bbaby.com',
    password: 'admin_password_2026'
  });
  const token = loginRes.data.data.access_token;
  
  api.defaults.headers.common['Authorization'] = `Bearer ${token}`;
  
  console.log('\nImporting products...');
  
  await api.post('/items/products', {
    slug: 'foldable-baby-stroller-astm',
    title: 'ASTM Certified Baby Stroller',
    title_en: 'ASTM Certified Baby Stroller',
    category: 'Stroller',
    description: 'High quality baby stroller, ASTM safety certified, MOQ 50pcs',
    description_en: 'High quality baby stroller, ASTM safety certified, MOQ 50pcs',
    moq: 50,
    lead_time_sample: '7-10 days',
    lead_time_production: '15-25 days',
    certifications: ['ASTM', 'CPC', 'EN1888'],
    target_markets: ['US', 'Canada', 'UK'],
    image: null,
    gallery_images: null,
    specs: null,
    features: null,
    custom_options: null,
    status: 'published',
    sort: 1
  });
  console.log('  OK: Product 1');

  await api.post('/items/products', {
    slug: 'en-certified-safety-gate',
    title: 'EN Certified Safety Gate',
    title_en: 'EN Certified Safety Gate',
    category: 'Safety Gate',
    description: 'EN standard baby safety gate',
    description_en: 'EN standard baby safety gate',
    moq: 100,
    certifications: ['EN71', 'EN1930'],
    target_markets: ['Europe', 'Australia'],
    image: null,
    gallery_images: null,
    status: 'published',
    sort: 2
  });
  console.log('  OK: Product 2');

  await api.post('/items/products', {
    slug: 'cpc-certified-high-chair',
    title: 'CPC Certified High Chair',
    category: 'High Chair',
    description: 'CPC certified high chair',
    description_en: 'CPC certified high chair',
    moq: 80,
    certifications: ['CPC', 'EN14988'],
    target_markets: ['US', 'Mexico', 'Canada'],
    image: null,
    gallery_images: null,
    status: 'published',
    sort: 3
  });
  console.log('  OK: Product 3');

  await api.post('/items/products', {
    slug: 'baby-bed-rail-safety',
    title: 'Baby Bed Rail Safety Guard',
    category: 'Bed Rail',
    description: 'Baby bed safety guard',
    description_en: 'Baby bed safety guard',
    moq: 120,
    certifications: ['ASTM'],
    target_markets: ['Global', 'US'],
    image: null,
    gallery_images: null,
    status: 'published',
    sort: 4
  });
  console.log('  OK: Product 4');

  console.log('\nImporting FAQs...');
  
  await api.post('/items/faqs', {
    question: 'What is your MOQ?',
    question_en: 'What is your MOQ?',
    answer: 'Our MOQ is 50-100 pcs per model, depending on product type.',
    answer_en: 'Our MOQ is 50-100 pcs per model, depending on product type.',
    category: 'Products',
    sort: 1
  });
  console.log('  OK: FAQ 1');

  await api.post('/items/faqs', {
    question: 'What is your production lead time?',
    question_en: 'What is your production lead time?',
    answer: 'Sample lead time 7-10 days, bulk 15-25 days.',
    answer_en: 'Sample lead time 7-10 days, bulk 15-25 days.',
    category: 'Orders',
    sort: 2
  });
  console.log('  OK: FAQ 2');

  await api.post('/items/faqs', {
    question: 'Do you provide OEM/ODM services?',
    question_en: 'Do you provide OEM/ODM services?',
    answer: 'Yes, we provide OEM/ODM services.',
    answer_en: 'Yes, we provide OEM/ODM services.',
    category: 'Customs',
    sort: 3
  });
  console.log('  OK: FAQ 3');

  console.log('\nImporting Blogs...');
  
  await api.post('/items/blogs', {
    slug: 'baby-safety-standards-guide',
    title: 'Guide to Baby Product Safety Standards',
    title_en: 'Guide to Baby Product Safety Standards',
    excerpt: 'Understanding international baby product safety standards',
    excerpt_en: 'Understanding international baby product safety standards',
    content: 'Baby product safety is very important...',
    content_en: 'Baby product safety is very important...',
    cover_image: null,
    author: 'B2B Baby Team',
    tags: ['safety', 'standards', 'ASTM', 'EN'],
    date_published: new Date().toISOString(),
    status: 'published'
  });
  console.log('  OK: Blog 1');

  console.log('\n✅ All data imported successfully!');
}

main().catch(err => {
  console.error('Error:', err.response?.data || err.message);
  process.exit(1);
});