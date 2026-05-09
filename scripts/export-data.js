const fs = require('fs');
const path = require('path');

const productsData = [
  {
    id: 1,
    slug: 'foldable-baby-stroller-astm',
    title: 'ASTM Certified Baby Stroller',
    title_en: 'ASTM Certified Baby Stroller',
    description: 'Lightweight, foldable, ASTM F833 certified baby stroller with adjustable handle and storage basket.',
    description_en: 'Lightweight, foldable, ASTM F833 certified baby stroller with adjustable handle and storage basket.',
    moq: 50,
    certifications: ['ASTM F833-23', 'CPC', 'ISO 9001'],
    features: ['Lightweight aluminum frame', 'One-hand fold design', '5-point safety harness', 'Large storage basket'],
    images: [
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=modern%20lightweight%20baby%20stroller%20in%20blue%20color%2C%20product%20photography%2C%20white%20background&image_size=square_hd',
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20stroller%20side%20view%2C%20showing%20storage%20basket%2C%20product%20photography&image_size=square_hd'
    ],
    category: 'stroller',
    status: 'published',
    sort: 1
  },
  {
    id: 2,
    slug: 'en-certified-safety-gate',
    title: 'EN Certified Safety Gate',
    title_en: 'EN Certified Safety Gate',
    description: 'EN 1930 certified safety gate with auto-close mechanism and pressure mounting.',
    description_en: 'EN 1930 certified safety gate with auto-close mechanism and pressure mounting.',
    moq: 100,
    certifications: ['EN 1930', 'CPSC', 'CE'],
    features: ['Auto-close door', 'Pressure mount installation', 'Double-locking mechanism', 'Adjustable width'],
    images: [
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20safety%20gate%20for%20doorway%2C%20white%20metal%20design%2C%20product%20photo%2C%20clean%20background&image_size=square_hd'
    ],
    category: 'safety-gate',
    status: 'published',
    sort: 2
  },
  {
    id: 3,
    slug: 'cpc-certified-high-chair',
    title: 'CPC Certified High Chair',
    title_en: 'CPC Certified High Chair',
    description: 'CPC certified baby high chair with adjustable height and removable tray.',
    description_en: 'CPC certified baby high chair with adjustable height and removable tray.',
    moq: 80,
    certifications: ['CPC', 'ASTM F404', 'FDA'],
    features: ['3-position height adjustment', 'Removable dishwasher-safe tray', '5-point harness', 'Compact fold'],
    images: [
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=modern%20baby%20high%20chair%2C%20gray%20color%2C%20product%20photography%2C%20white%20background&image_size=square_hd'
    ],
    category: 'high-chair',
    status: 'published',
    sort: 3
  },
  {
    id: 4,
    slug: 'baby-bed-rail-safety-guard',
    title: 'Baby Bed Rail Safety Guard',
    title_en: 'Baby Bed Rail Safety Guard',
    description: 'Heightening reinforcement bed rail for toddler safety, fits most standard beds.',
    description_en: 'Heightening reinforcement bed rail for toddler safety, fits most standard beds.',
    moq: 60,
    certifications: ['EN 1930', 'CPSC', 'ASTM F1004'],
    features: ['Extra tall design', 'Tool-free installation', 'Breathable mesh window', 'Foldable for storage'],
    images: [
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20bed%20rail%20safety%20guard%20in%20gray%20color%2C%20product%20photography%2C%20white%20background&image_size=square_hd'
    ],
    category: 'bed-rail',
    status: 'published',
    sort: 4
  }
];

const faqsData = [
  {
    id: 1,
    question: 'What certifications do your baby products have?',
    question_en: 'What certifications do your baby products have?',
    answer: 'Our baby products are certified with ASTM F833-23 (strollers), EN 1930 (safety gates), CPC (Children\'s Product Certificate), ISO 9001 (quality management), and CE marking. All certifications are verifiable with test report numbers provided upon request.',
    answer_en: 'Our baby products are certified with ASTM F833-23 (strollers), EN 1930 (safety gates), CPC (Children\'s Product Certificate), ISO 9001 (quality management), and CE marking. All certifications are verifiable with test report numbers provided upon request.',
    category: 'Certification',
    sort: 1
  },
  {
    id: 2,
    question: 'What is the minimum order quantity (MOQ) for your products?',
    question_en: 'What is the minimum order quantity (MOQ) for your products?',
    answer: 'Our MOQ varies by product: Baby Stroller - 50 units, Safety Gate - 100 units, High Chair - 80 units. For startups and first-time orders, we can negotiate lower MOQs with a small surcharge of 10-15%.',
    answer_en: 'Our MOQ varies by product: Baby Stroller - 50 units, Safety Gate - 100 units, High Chair - 80 units. For startups and first-time orders, we can negotiate lower MOQs with a small surcharge of 10-15%.',
    category: 'Purchasing',
    sort: 2
  },
  {
    id: 3,
    question: 'Can you do OEM/ODM customization for our brand?',
    question_en: 'Can you do OEM/ODM customization for our brand?',
    answer: 'Yes! We provide comprehensive OEM/ODM services including custom logo printing, color customization, packaging design, product design modifications, and exclusive labeling. Our design team can help develop custom products from concept to production.',
    answer_en: 'Yes! We provide comprehensive OEM/ODM services including custom logo printing, color customization, packaging design, product design modifications, and exclusive labeling. Our design team can help develop custom products from concept to production.',
    category: 'Services',
    sort: 3
  },
  {
    id: 4,
    question: 'What materials do you use for your baby products?',
    question_en: 'What materials do you use for your baby products?',
    answer: 'We use only premium, baby-safe materials: High-grade aluminum alloy frames, 600D Oxford fabric (waterproof, non-toxic), food-grade PP/ABS plastics, and high-density foam padding. All materials pass EN 71-3 and CPSIA safety standards.',
    answer_en: 'We use only premium, baby-safe materials: High-grade aluminum alloy frames, 600D Oxford fabric (waterproof, non-toxic), food-grade PP/ABS plastics, and high-density foam padding. All materials pass EN 71-3 and CPSIA safety standards.',
    category: 'Product',
    sort: 4
  },
  {
    id: 5,
    question: 'Can I order a sample before placing a bulk order?',
    question_en: 'Can I order a sample before placing a bulk order?',
    answer: 'Absolutely! Sample pricing is typically 2x the bulk price and fully refundable when you place a bulk order over $5,000. Sample lead time is 3-7 days.',
    answer_en: 'Absolutely! Sample pricing is typically 2x the bulk price and fully refundable when you place a bulk order over $5,000. Sample lead time is 3-7 days.',
    category: 'Purchasing',
    sort: 5
  },
  {
    id: 6,
    question: 'What is your production lead time?',
    question_en: 'What is your production lead time?',
    answer: 'Production lead time varies by product: Sample - 3-7 days, MOQ order - 7-15 days, Large orders - 15-30 days. Rush orders can be accommodated with prior arrangement.',
    answer_en: 'Production lead time varies by product: Sample - 3-7 days, MOQ order - 7-15 days, Large orders - 15-30 days. Rush orders can be accommodated with prior arrangement.',
    category: 'Purchasing',
    sort: 6
  },
  {
    id: 7,
    question: 'Do you provide quality control inspections?',
    question_en: 'Do you provide quality control inspections?',
    answer: 'Yes! We have a dedicated QC team that performs inspections at three stages: raw material inspection, in-process inspection, and pre-shipment inspection. We can also arrange third-party inspections (SGS, BV, Intertek) upon request.',
    answer_en: 'Yes! We have a dedicated QC team that performs inspections at three stages: raw material inspection, in-process inspection, and pre-shipment inspection. We can also arrange third-party inspections (SGS, BV, Intertek) upon request.',
    category: 'Quality',
    sort: 7
  },
  {
    id: 8,
    question: 'What is your payment term?',
    question_en: 'What is your payment term?',
    answer: 'Our standard payment term is 30% deposit by T/T, balance before shipment. For established customers, we offer more flexible terms including L/C at sight or D/P. PayPal is accepted for sample orders.',
    answer_en: 'Our standard payment term is 30% deposit by T/T, balance before shipment. For established customers, we offer more flexible terms including L/C at sight or D/P. PayPal is accepted for sample orders.',
    category: 'Purchasing',
    sort: 8
  },
  {
    id: 9,
    question: 'Do you handle shipping and logistics?',
    question_en: 'Do you handle shipping and logistics?',
    answer: 'Yes, we provide door-to-door shipping services via sea, air, or express (DHL, FedEx, UPS). Our logistics team will help you choose the most cost-effective shipping method based on your requirements.',
    answer_en: 'Yes, we provide door-to-door shipping services via sea, air, or express (DHL, FedEx, UPS). Our logistics team will help you choose the most cost-effective shipping method based on your requirements.',
    category: 'Services',
    sort: 9
  },
  {
    id: 10,
    question: 'What is your return policy?',
    question_en: 'What is your return policy?',
    answer: 'We guarantee product quality. If you receive defective products, we will replace them free of charge. Returns are accepted within 30 days of delivery for manufacturing defects. Customized products are non-returnable unless defective.',
    answer_en: 'We guarantee product quality. If you receive defective products, we will replace them free of charge. Returns are accepted within 30 days of delivery for manufacturing defects. Customized products are non-returnable unless defective.',
    category: 'Services',
    sort: 10
  }
];

const blogsData = [
  {
    id: 1,
    slug: 'eu-ce-standard-safety-gates',
    title: 'EU CE Standard for Baby Safety Gates: What You Need to Know',
    title_en: 'EU CE Standard for Baby Safety Gates: What You Need to Know',
    excerpt: 'Comprehensive guide to EU CE standards EN 1930:2012 for baby safety gates, including requirements, testing procedures, and compliance documentation.',
    excerpt_en: 'Comprehensive guide to EU CE standards EN 1930:2012 for baby safety gates, including requirements, testing procedures, and compliance documentation.',
    content: '<p>The EU CE standard EN 1930:2012 specifies safety requirements for baby safety gates. This comprehensive guide covers the essential requirements including:</p><ul><li>Gap sizes and mesh openings</li><li>Locking mechanisms</li><li>Strength and durability testing</li><li>Warning label requirements</li></ul>',
    content_en: '<p>The EU CE standard EN 1930:2012 specifies safety requirements for baby safety gates. This comprehensive guide covers the essential requirements including:</p><ul><li>Gap sizes and mesh openings</li><li>Locking mechanisms</li><li>Strength and durability testing</li><li>Warning label requirements</li></ul>',
    cover_image: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20safety%20gate%20certification%20document%20and%20testing%20equipment%2C%20professional%20setup&image_size=landscape_4_3',
    author: 'BabyGEO Pro Team',
    tags: ['CE standard', 'safety gate', 'EN 1930', 'EU baby products', 'certification'],
    date_published: '2026-01-15',
    status: 'published'
  },
  {
    id: 2,
    slug: 'us-cpsc-compliance-strollers',
    title: 'US CPSC Compliance for Baby Strollers: Complete Guide',
    title_en: 'US CPSC Compliance for Baby Strollers: Complete Guide',
    excerpt: 'Learn about CPSC requirements, ASTM F833-23 standards, and CPC certification for baby strollers sold in the United States.',
    excerpt_en: 'Learn about CPSC requirements, ASTM F833-23 standards, and CPC certification for baby strollers sold in the United States.',
    content: '<p>Selling baby strollers in the US requires compliance with CPSC regulations and ASTM F833-23 standards. This guide covers:</p><ul><li>CPSC safety requirements</li><li>ASTM F833-23 testing methods</li><li>Children\'s Product Certificate (CPC)</li><li>Labeling requirements</li></ul>',
    content_en: '<p>Selling baby strollers in the US requires compliance with CPSC regulations and ASTM F833-23 standards. This guide covers:</p><ul><li>CPSC safety requirements</li><li>ASTM F833-23 testing methods</li><li>Children\'s Product Certificate (CPC)</li><li>Labeling requirements</li></ul>',
    cover_image: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20stroller%20quality%20testing%20in%20laboratory%2C%20safety%20certification%20process&image_size=landscape_4_3',
    author: 'BabyGEO Pro Team',
    tags: ['CPSC', 'ASTM F833', 'CPC', 'baby stroller', 'US compliance'],
    date_published: '2026-02-20',
    status: 'published'
  },
  {
    id: 3,
    slug: 'avoid-bad-baby-product-suppliers',
    title: 'How to Avoid Bad Baby Product Suppliers in China',
    title_en: 'How to Avoid Bad Baby Product Suppliers in China',
    excerpt: 'Red flags to watch for and proven strategies to find reliable, certified baby product manufacturers in China.',
    excerpt_en: 'Red flags to watch for and proven strategies to find reliable, certified baby product manufacturers in China.',
    content: '<p>Finding reliable baby product suppliers in China can be challenging. This article helps you identify red flags and find trustworthy partners:</p><ul><li>Verifying certifications</li><li>Factory audit checklists</li><li>Communication red flags</li><li>Quality control expectations</li></ul>',
    content_en: '<p>Finding reliable baby product suppliers in China can be challenging. This article helps you identify red flags and find trustworthy partners:</p><ul><li>Verifying certifications</li><li>Factory audit checklists</li><li>Communication red flags</li><li>Quality control expectations</li></ul>',
    cover_image: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=factory%20audit%20in%20progress%2C%20quality%20inspection%20in%20Chinese%20baby%20product%20factory&image_size=landscape_4_3',
    author: 'BabyGEO Pro Team',
    tags: ['supplier sourcing', 'China manufacturing', 'baby products', 'QC', 'factory audit'],
    date_published: '2026-03-10',
    status: 'published'
  },
  {
    id: 4,
    slug: 'high-chair-safety-standards',
    title: 'What to Check Before Importing Baby High Chairs',
    title_en: 'What to Check Before Importing Baby High Chairs',
    excerpt: 'Complete checklist for importing baby high chairs, covering ASTM F404, EN 14988 standards, safety features, and QC procedures.',
    excerpt_en: 'Complete checklist for importing baby high chairs, covering ASTM F404, EN 14988 standards, safety features, and QC procedures.',
    content: '<p>Importing baby high chairs requires careful attention to safety standards. This comprehensive checklist covers:</p><ul><li>ASTM F404 and EN 14988 compliance</li><li>Essential safety features</li><li>Material safety considerations</li><li>Packaging requirements</li></ul>',
    content_en: '<p>Importing baby high chairs requires careful attention to safety standards. This comprehensive checklist covers:</p><ul><li>ASTM F404 and EN 14988 compliance</li><li>Essential safety features</li><li>Material safety considerations</li><li>Packaging requirements</li></ul>',
    cover_image: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20high%20chair%20safety%20inspection%2C%20quality%20checklist%2C%20professional%20setup&image_size=landscape_4_3',
    author: 'BabyGEO Pro Team',
    tags: ['high chair', 'ASTM F404', 'EN 14988', 'safety standards', 'importing'],
    date_published: '2026-04-05',
    status: 'published'
  },
  {
    id: 5,
    slug: 'foldable-vs-standard-strollers',
    title: 'Foldable vs Standard Baby Strollers: Which Is Better for Your Market?',
    title_en: 'Foldable vs Standard Baby Strollers: Which Is Better for Your Market?',
    excerpt: 'Comparison between foldable travel strollers and standard full-size strollers, including market trends, features, and customization options.',
    excerpt_en: 'Comparison between foldable travel strollers and standard full-size strollers, including market trends, features, and customization options.',
    content: '<p>Choosing between foldable and standard strollers depends on your target market. This article compares:</p><ul><li>Portability vs comfort</li><li>Price points</li><li>Market demand by region</li><li>Customization possibilities</li></ul>',
    content_en: '<p>Choosing between foldable and standard strollers depends on your target market. This article compares:</p><ul><li>Portability vs comfort</li><li>Price points</li><li>Market demand by region</li><li>Customization possibilities</li></ul>',
    cover_image: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=two%20baby%20strollers%20side%20by%20side%2C%20foldable%20travel%20stroller%20and%20standard%20full%20size%2C%20product%20comparison&image_size=landscape_4_3',
    author: 'BabyGEO Pro Team',
    tags: ['baby stroller', 'foldable stroller', 'travel stroller', 'product comparison', 'market trends'],
    date_published: '2026-04-25',
    status: 'published'
  },
  {
    id: 6,
    slug: 'wooden-vs-plastic-safety-gates',
    title: 'Wooden vs Plastic Baby Safety Gates: Pros, Cons, and Market Demand',
    title_en: 'Wooden vs Plastic Baby Safety Gates: Pros, Cons, and Market Demand',
    excerpt: 'Comparative analysis of wooden and plastic safety gates, including safety, cost, durability, and which markets prefer each type.',
    excerpt_en: 'Comparative analysis of wooden and plastic safety gates, including safety, cost, durability, and which markets prefer each type.',
    content: '<p>Wooden and plastic safety gates each have their advantages. This analysis covers:</p><ul><li>Safety considerations</li><li>Cost comparison</li><li>Durability factors</li><li>Regional market preferences</li></ul>',
    content_en: '<p>Wooden and plastic safety gates each have their advantages. This analysis covers:</p><ul><li>Safety considerations</li><li>Cost comparison</li><li>Durability factors</li><li>Regional market preferences</li></ul>',
    cover_image: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=wooden%20and%20plastic%20baby%20safety%20gates%20side%20by%20side%2C%20product%20display%2C%20home%20setting&image_size=landscape_4_3',
    author: 'BabyGEO Pro Team',
    tags: ['safety gate', 'wooden gate', 'plastic gate', 'product comparison', 'market demand'],
    date_published: '2026-05-01',
    status: 'published'
  }
];

const outputDir = path.join(__dirname, '../data');

if (!fs.existsSync(outputDir)) {
  fs.mkdirSync(outputDir, { recursive: true });
}

fs.writeFileSync(
  path.join(outputDir, 'products.json'),
  JSON.stringify(productsData, null, 2),
  { encoding: 'utf8' }
);

fs.writeFileSync(
  path.join(outputDir, 'faqs.json'),
  JSON.stringify(faqsData, null, 2),
  { encoding: 'utf8' }
);

fs.writeFileSync(
  path.join(outputDir, 'blogs.json'),
  JSON.stringify(blogsData, null, 2),
  { encoding: 'utf8' }
);

console.log('✅ 数据导出完成');
console.log('📁 输出目录:', outputDir);
console.log('📦 导出文件: products.json, faqs.json, blogs.json');