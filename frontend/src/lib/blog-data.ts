export interface BlogPost {
  id: number;
  slug: string;
  title: string;
  description: string;
  category: string;
  datePublished: string;
  dateModified: string;
  keywords: string[];
  readTime: string;
  image: string;
  status: string;
}

export const blogPosts: BlogPost[] = [
  {
    id: 1,
    slug: 'eu-ce-standard-safety-gates',
    title: 'EU CE Standard for Baby Safety Gates: What You Need to Know',
    description: 'Comprehensive guide to EU CE standards EN 1930:2012 for baby safety gates, including requirements, testing procedures, and compliance documentation.',
    category: 'compliance',
    datePublished: '2026-01-15',
    dateModified: '2026-05-05',
    keywords: ['CE standard', 'safety gate', 'EN 1930', 'EU baby products', 'certification'],
    readTime: '8 min',
    image: '/images/pages/blog/certification.jpg',
    status: 'published'
  },
  {
    id: 2,
    slug: 'us-cpsc-compliance-strollers',
    title: 'US CPSC Compliance for Baby Strollers: Complete Guide',
    description: 'Learn about CPSC requirements, ASTM F833-23 standards, and CPC certification for baby strollers sold in the United States.',
    category: 'compliance',
    datePublished: '2026-02-20',
    dateModified: '2026-05-05',
    keywords: ['CPSC', 'ASTM F833', 'CPC', 'baby stroller', 'US compliance'],
    readTime: '10 min',
    image: '/images/pages/blog/testing.jpg',
    status: 'published'
  },
  {
    id: 3,
    slug: 'avoid-bad-baby-product-suppliers',
    title: 'How to Avoid Bad Baby Product Suppliers in China',
    description: 'Red flags to watch for and proven strategies to find reliable, certified baby product manufacturers in China.',
    category: 'buying-guide',
    datePublished: '2026-03-10',
    dateModified: '2026-05-05',
    keywords: ['supplier sourcing', 'China manufacturing', 'baby products', 'QC', 'factory audit'],
    readTime: '12 min',
    image: '/images/pages/blog/audit.jpg',
    status: 'published'
  },
  {
    id: 4,
    slug: 'high-chair-safety-standards',
    title: 'What to Check Before Importing Baby High Chairs',
    description: 'Complete checklist for importing baby high chairs, covering ASTM F404, EN 14988 standards, safety features, and QC procedures.',
    category: 'buying-guide',
    datePublished: '2026-04-05',
    dateModified: '2026-05-05',
    keywords: ['high chair', 'ASTM F404', 'EN 14988', 'safety standards', 'importing'],
    readTime: '9 min',
    image: '/images/pages/blog/safety.jpg',
    status: 'published'
  },
  {
    id: 5,
    slug: 'foldable-vs-standard-strollers',
    title: 'Foldable vs Standard Baby Strollers: Which Is Better for Your Market?',
    description: 'Comparison between foldable travel strollers and standard full-size strollers, including market trends, features, and customization options.',
    category: 'market-trends',
    datePublished: '2026-04-25',
    dateModified: '2026-05-05',
    keywords: ['baby stroller', 'foldable stroller', 'travel stroller', 'product comparison', 'market trends'],
    readTime: '11 min',
    image: '/images/pages/blog/comparison.jpg',
    status: 'published'
  },
  {
    id: 6,
    slug: 'wooden-vs-plastic-safety-gates',
    title: 'Wooden vs Plastic Baby Safety Gates: Pros, Cons, and Market Demand',
    description: 'Comparative analysis of wooden and plastic safety gates, including safety, cost, durability, and which markets prefer each type.',
    category: 'market-trends',
    datePublished: '2026-05-01',
    dateModified: '2026-05-05',
    keywords: ['safety gate', 'wooden gate', 'plastic gate', 'product comparison', 'market demand'],
    readTime: '7 min',
    image: '/images/pages/blog/gates.jpg',
    status: 'published'
  }
];

export function getBlogBySlug(slug: string): BlogPost | undefined {
  return blogPosts.find(blog => blog.slug === slug);
}
