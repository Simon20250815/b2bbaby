export const blogPosts = [
  {
    id: 1,
    slug: 'eu-ce-standard-safety-gates',
    title: 'EU CE Standard for Baby Safety Gates: What You Need to Know',
    description: 'Comprehensive guide to EU CE standards EN 1930:2012 for baby safety gates, including requirements, testing procedures, and compliance documentation.',
    category: 'certification',
    datePublished: '2026-01-15',
    dateModified: '2026-05-05',
    keywords: ['CE standard', 'safety gate', 'EN 1930', 'EU baby products', 'certification'],
    readTime: '8 min',
    image: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20safety%20gate%20certification%20document%20and%20testing%20equipment%2C%20professional%20setup&image_size=landscape_4_3',
    status: 'published'
  },
  {
    id: 2,
    slug: 'us-cpsc-compliance-strollers',
    title: 'US CPSC Compliance for Baby Strollers: Complete Guide',
    description: 'Learn about CPSC requirements, ASTM F833-23 standards, and CPC certification for baby strollers sold in the United States.',
    category: 'certification',
    datePublished: '2026-02-20',
    dateModified: '2026-05-05',
    keywords: ['CPSC', 'ASTM F833', 'CPC', 'baby stroller', 'US compliance'],
    readTime: '10 min',
    image: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20stroller%20quality%20testing%20in%20laboratory%2C%20safety%20certification%20process&image_size=landscape_4_3',
    status: 'published'
  },
  {
    id: 3,
    slug: 'avoid-bad-baby-product-suppliers',
    title: 'How to Avoid Bad Baby Product Suppliers in China',
    description: 'Red flags to watch for and proven strategies to find reliable, certified baby product manufacturers in China.',
    category: 'purchasing',
    datePublished: '2026-03-10',
    dateModified: '2026-05-05',
    keywords: ['supplier sourcing', 'China manufacturing', 'baby products', 'QC', 'factory audit'],
    readTime: '12 min',
    image: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=factory%20audit%20in%20progress%2C%20quality%20inspection%20in%20Chinese%20baby%20product%20factory&image_size=landscape_4_3',
    status: 'published'
  },
  {
    id: 4,
    slug: 'high-chair-safety-standards',
    title: 'What to Check Before Importing Baby High Chairs',
    description: 'Complete checklist for importing baby high chairs, covering ASTM F404, EN 14988 standards, safety features, and QC procedures.',
    category: 'purchasing',
    datePublished: '2026-04-05',
    dateModified: '2026-05-05',
    keywords: ['high chair', 'ASTM F404', 'EN 14988', 'safety standards', 'importing'],
    readTime: '9 min',
    image: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20high%20chair%20safety%20inspection%2C%20quality%20checklist%2C%20professional%20setup&image_size=landscape_4_3',
    status: 'published'
  },
  {
    id: 5,
    slug: 'foldable-vs-standard-strollers',
    title: 'Foldable vs Standard Baby Strollers: Which Is Better for Your Market?',
    description: 'Comparison between foldable travel strollers and standard full-size strollers, including market trends, features, and customization options.',
    category: 'product',
    datePublished: '2026-04-25',
    dateModified: '2026-05-05',
    keywords: ['baby stroller', 'foldable stroller', 'travel stroller', 'product comparison', 'market trends'],
    readTime: '11 min',
    image: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=two%20baby%20strollers%20side%20by%20side%2C%20foldable%20travel%20stroller%20and%20standard%20full%20size%2C%20product%20comparison&image_size=landscape_4_3',
    status: 'published'
  },
  {
    id: 6,
    slug: 'wooden-vs-plastic-safety-gates',
    title: 'Wooden vs Plastic Baby Safety Gates: Pros, Cons, and Market Demand',
    description: 'Comparative analysis of wooden and plastic safety gates, including safety, cost, durability, and which markets prefer each type.',
    category: 'product',
    datePublished: '2026-05-01',
    dateModified: '2026-05-05',
    keywords: ['safety gate', 'wooden gate', 'plastic gate', 'product comparison', 'market demand'],
    readTime: '7 min',
    image: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=wooden%20and%20plastic%20baby%20safety%20gates%20side%20by%20side%2C%20product%20display%2C%20home%20setting&image_size=landscape_4_3',
    status: 'published'
  }
];

export function getBlogBySlug(slug: string) {
  return blogPosts.find(blog => blog.slug === slug);
}
