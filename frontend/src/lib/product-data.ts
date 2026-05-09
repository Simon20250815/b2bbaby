export interface ProductSpec {
  label: string;
  value: string;
}

export interface CustomOption {
  label: string;
  available: boolean;
  details?: string | number;
}

export interface Product {
  id: number;
  slug: string;
  title: string;
  title_en: string;
  category: string;
  description: string;
  description_en: string;
  moq: number;
  leadTimeSample: string;
  leadTimeProduction: string;
  certifications: string[];
  targetMarkets: string[];
  testReportNumber?: string;
  exportBatches: number;
  zeroReturnRate: boolean;
  image: string;
  galleryImages: string[];
  specs: Record<string, string>;
  customOptions: Record<string, string | boolean>;
  features: string[];
  applications?: string[];
  packaging?: string;
  status: string;
  sort: number;
}

export const productsData: Product[] = [
  {
    id: 1,
    slug: 'foldable-baby-stroller-astm',
    title: 'ASTM Certified Baby Stroller',
    title_en: 'ASTM Certified Baby Stroller',
    category: 'stroller',
    description: 'Lightweight, foldable baby stroller with ASTM F833-23 certification. Premium aluminum frame with one-hand fold design. Suitable for babies 6-36 months. Export to US, Canada, EU with 247+ batches, zero return rate.',
    description_en: 'Lightweight, foldable baby stroller with ASTM F833-23 certification. Premium aluminum frame with one-hand fold design. Suitable for babies 6-36 months. Export to US, Canada, EU with 247+ batches, zero return rate.',
    moq: 50,
    leadTimeSample: '3-7 days',
    leadTimeProduction: '15-25 days',
    certifications: ['ASTM F833-23', 'CPC', 'EN 1888', 'ISO 9001'],
    targetMarkets: ['United States', 'Canada', 'European Union', 'Australia'],
    testReportNumber: 'BGP-TR-2026-ST001',
    exportBatches: 247,
    zeroReturnRate: true,
    image: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=modern%20lightweight%20baby%20stroller%20in%20blue%20color%2C%20product%20photography%2C%20white%20background&image_size=square_hd',
    galleryImages: [
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=modern%20lightweight%20baby%20stroller%20in%20blue%20color%2C%20product%20photography%2C%20white%20background&image_size=square_hd',
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20stroller%20folded%20compact%20view%2C%20easy%20fold%20design%2C%20product%20photo&image_size=square',
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20stroller%20side%20view%20showing%20storage%20basket%2C%20product%20photo&image_size=square',
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20stroller%20detail%20closeup%205-point%20harness%2C%20product%20photo&image_size=square',
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20stroller%20adjustable%20handlebar%20detail%2C%20product%20photo&image_size=square'
    ],
    specs: {
      'Material': 'Aluminum alloy frame + 600D Oxford fabric',
      'Weight': '6.5kg (net weight)',
      'Folded Size': '55 × 30 × 40cm',
      'Unfolded Size': '85 × 55 × 100cm',
      'Maximum Load': '25kg',
      'Suitable Age': '6-36 months',
      'Wheel Size': '6 inch EVA front / 7 inch PVC rear',
      'Brakes': 'Foot brake on rear wheels'
    },
    customOptions: {
      'Logo Printing': 'Available - Silk screen, embroidery',
      'Color Options': '15+ colors available',
      'Packaging': 'Custom retail box or mail box',
      'MOQ for Custom Color': '100 units',
      'Sample Customization': 'Available'
    },
    features: [
      'One-hand fold system - fold in 2 seconds',
      '5-point safety harness with shoulder pads',
      'Adjustable recline (3 positions)',
      'Adjustable handle height (5 positions)',
      'Large storage basket (capacity 5kg)',
      'UV protection canopy with peek-a-boo window',
      'Front wheels with 360° swivel + lock',
      'JPMA/ASTM certified'
    ],
    applications: ['Daily use', 'Travel', 'Shopping', 'Outdoor activities'],
    packaging: '1pc/ctn, Gross weight 7.5kg, Carton size: 58×32×42cm',
    status: 'published',
    sort: 1
  },
  {
    id: 2,
    slug: 'en-certified-safety-gate',
    title: 'EN Certified Safety Gate',
    title_en: 'EN Certified Safety Gate',
    category: 'safety-gate',
    description: 'EN 1930:2012 certified baby safety gate with pressure mount installation. Auto-close door with double-locking mechanism. Fits doorways 75-100cm width. Ideal for stairs and room entrances.',
    description_en: 'EN 1930:2012 certified baby safety gate with pressure mount installation. Auto-close door with double-locking mechanism. Fits doorways 75-100cm width. Ideal for stairs and room entrances.',
    moq: 100,
    leadTimeSample: '3-7 days',
    leadTimeProduction: '15-25 days',
    certifications: ['EN 1930', 'CPSC', 'CE', 'ASTM F1004'],
    targetMarkets: ['European Union', 'United States', 'Australia', 'UK'],
    testReportNumber: 'BGP-TR-2026-SG001',
    exportBatches: 189,
    zeroReturnRate: true,
    image: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20safety%20gate%20for%20doorway%2C%20white%20metal%20design%2C%20product%20photo%2C%20clean%20background&image_size=square_hd',
    galleryImages: [
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20safety%20gate%20for%20doorway%2C%20white%20metal%20design%2C%20product%20photo%2C%20clean%20background&image_size=square_hd',
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20safety%20gate%20pressure%20mount%20installation%2C%20product%20photo&image_size=square',
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20safety%20gate%20auto-close%20door%20mechanism%2C%20product%20photo&image_size=square',
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20safety%20gate%20double-locking%20detail%2C%20product%20photo&image_size=square',
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20safety%20gate%20installed%20at%20doorway%2C%20lifestyle%20photo&image_size=square'
    ],
    specs: {
      'Material': 'High-grade steel frame',
      'Width': '75-100cm (adjustable)',
      'Height': '76cm',
      'Bar Spacing': '< 6cm (safe for fingers)',
      'Installation': 'Pressure mount / Wall mount',
      'Color': 'White, Silver, Black',
      'Certification': 'EN 1930:2012'
    },
    customOptions: {
      'Logo Printing': 'Available',
      'Color Options': '10+ colors',
      'Width Extension': 'Available (ext kits)',
      'MOQ for Custom Color': '200 units',
      'Sample Customization': 'Available'
    },
    features: [
      'Auto-close door mechanism',
      'Double-locking system (push button + swing)',
      'One-hand operation',
      'Pressure mount - no tools needed',
      'Wall mount option for stairs',
      'Walk-through design',
      'Swing direction adjustable',
      'EN 1930 certified & tested'
    ],
    applications: ['Doorways', 'Staircases', 'Kitchen entrances', 'Room separation'],
    packaging: '1pc/ctn, Gross weight 3.2kg, Carton size: 8×78×82cm',
    status: 'published',
    sort: 2
  },
  {
    id: 3,
    slug: 'cpc-certified-high-chair',
    title: 'CPC Certified High Chair',
    title_en: 'CPC Certified High Chair',
    category: 'high-chair',
    description: 'CPC and ASTM F404 certified baby high chair with 7-position height adjustment and 3-position recline. Removable dishwasher-safe tray. Premium PP+metal construction. For babies 6-36 months.',
    description_en: 'CPC and ASTM F404 certified baby high chair with 7-position height adjustment and 3-position recline. Removable dishwasher-safe tray. Premium PP+metal construction. For babies 6-36 months.',
    moq: 80,
    leadTimeSample: '3-7 days',
    leadTimeProduction: '15-25 days',
    certifications: ['CPC', 'ASTM F404', 'FDA', 'EN 14988'],
    targetMarkets: ['United States', 'Canada', 'European Union'],
    testReportNumber: 'BGP-TR-2026-HC001',
    exportBatches: 205,
    zeroReturnRate: true,
    image: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=modern%20baby%20high%20chair%2C%20gray%20color%2C%20product%20photography%2C%20white%20background&image_size=square_hd',
    galleryImages: [
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=modern%20baby%20high%20chair%2C%20gray%20color%2C%20product%20photography%2C%20white%20background&image_size=square_hd',
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20high%20chair%20folded%20compact%20storage%2C%20product%20photo&image_size=square',
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20high%20chair%20removable%20tray%20detail%2C%20product%20photo&image_size=square',
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20high%20chair%205-point%20harness%20detail%2C%20product%20photo&image_size=square',
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20high%20chair%20height%20adjustment%20mechanism%2C%20product%20photo&image_size=square'
    ],
    specs: {
      'Material': 'PP plastic + powder-coated steel',
      'Weight': '5.8kg (net)',
      'Height Positions': '7 positions',
      'Recline Positions': '3 positions',
      'Tray Width': '54cm (removable)',
      'Seat Width': '28cm',
      'Maximum Load': '25kg',
      'Suitable Age': '6-36 months'
    },
    customOptions: {
      'Logo Printing': 'Available on tray, frame',
      'Color Options': '12+ colors',
      'Packaging': 'Color box or mail box',
      'MOQ for Custom Color': '100 units',
      'Sample Customization': 'Available'
    },
    features: [
      '7-position height adjustment',
      '3-position recline (eating, resting, playing)',
      'Removable dishwasher-safe tray',
      '5-point safety harness',
      'Anti-slip feet pads',
      'Compact fold for storage',
      'CPC/ASTM F404 certified',
      'JPMA certified available'
    ],
    applications: ['Feeding time', 'Play time', 'Family dining'],
    packaging: '1pc/ctn, Gross weight 6.8kg, Carton size: 58×28×68cm',
    status: 'published',
    sort: 3
  },
  {
    id: 4,
    slug: 'baby-bed-rail-safety-guard',
    title: 'Baby Bed Rail Safety Guard',
    title_en: 'Baby Bed Rail Safety Guard',
    category: 'bed-rail',
    description: 'Heightening reinforced baby bed rail with breathable mesh window. Prevents toddler falls during sleep. Adjustable length 120-200cm. EN 1930 and CPSC certified. Tool-free installation.',
    description_en: 'Heightening reinforced baby bed rail with breathable mesh window. Prevents toddler falls during sleep. Adjustable length 120-200cm. EN 1930 and CPSC certified. Tool-free installation.',
    moq: 60,
    leadTimeSample: '3-7 days',
    leadTimeProduction: '15-25 days',
    certifications: ['EN 1930', 'CPSC', 'ASTM F1004', 'CE'],
    targetMarkets: ['European Union', 'United States', 'Canada', 'Australia'],
    testReportNumber: 'BGP-TR-2026-BR001',
    exportBatches: 156,
    zeroReturnRate: true,
    image: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20bed%20rail%20safety%20guard%20in%20gray%20color%2C%20product%20photography%2C%20white%20background&image_size=square_hd',
    galleryImages: [
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20bed%20rail%20safety%20guard%20in%20gray%20color%2C%20product%20photography%2C%20white%20background&image_size=square_hd',
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20bed%20rail%20installation%20on%20bed%2C%20product%20photo&image_size=square',
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20bed%20rail%20breathable%20mesh%20window%20detail%2C%20product%20photo&image_size=square',
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20bed%20rail%20heightening%20design%20explanation%2C%20product%20photo&image_size=square',
      'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=baby%20bed%20rail%20in%20bedroom%20setting%2C%20lifestyle%20photo&image_size=square'
    ],
    specs: {
      'Material': 'Steel frame + 600D Oxford fabric + mesh',
      'Height': '85cm (heightening design)',
      'Length': '120-200cm (adjustable)',
      'Width': '10cm (support tube)',
      'Fits Mattress Height': '20-60cm',
      'Mesh Window': '45×30cm breathable',
      'Installation': 'Fits under mattress (tool-free)'
    },
    customOptions: {
      'Logo Printing': 'Available on fabric',
      'Color Options': '8 colors',
      'Length Extension': 'Available',
      'MOQ for Custom Color': '100 units',
      'Sample Customization': 'Available'
    },
    features: [
      'Heightening reinforcement design',
      'Breathable mesh window for visibility',
      'Tool-free installation under mattress',
      'Folds flat for travel/ storage',
      'Washable fabric cover',
      'EN 1930 + CPSC certified',
      'Steel tube construction',
      'Anti-slip base pads'
    ],
    applications: ['Toddler beds', 'Adult beds', 'Travel', 'Hotel use'],
    packaging: '1pc/ctn, Gross weight 2.5kg, Carton size: 65×12×88cm',
    status: 'published',
    sort: 4
  }
];

export function getProductBySlug(slug: string): Product | undefined {
  return productsData.find(p => p.slug === slug);
}

export function getAllProducts(): Product[] {
  return productsData.filter(p => p.status === 'published').sort((a, b) => a.sort - b.sort);
}

export function getProductsByCategory(category: string): Product[] {
  return productsData.filter(p => p.category === category && p.status === 'published');
}