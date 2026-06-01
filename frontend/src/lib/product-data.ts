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
  // B2B新增字段
  paymentTerms: string;
  loadingPort: string;
  tradeTerms: string;
  containerLoad: {
    '20GP': number;
    '40GP': number;
    '40HQ': number;
  };
  qcProcess: string;
  afterSalesPolicy: string;
  faq: {
    q: string;
    a: string;
  }[];
}

export const productsData: Product[] = [
  {
    id: 1,
    slug: 'foldable-baby-stroller-astm',
    title: 'ASTM Certified Baby Stroller',
    title_en: 'ASTM Certified Baby Stroller',
    category: 'stroller',
    description: 'High-performance travel stroller with one-hand fold in 2 seconds. ASTM F833-23 & EN 1888 certified, 247+ export batches with zero return rate. Ideal for retailers targeting on-the-go families.',
    description_en: 'High-performance travel stroller with one-hand fold in 2 seconds. ASTM F833-23 & EN 1888 certified, 247+ export batches with zero return rate. Ideal for retailers targeting on-the-go families.',
    moq: 50,
    leadTimeSample: '3-7 days',
    leadTimeProduction: '15-25 days',
    certifications: ['ASTM F833-23', 'CPC', 'EN 1888', 'ISO 9001'],
    targetMarkets: ['United States', 'Canada', 'European Union', 'Australia'],
    testReportNumber: 'BGP-TR-2026-ST001',
    exportBatches: 247,
    zeroReturnRate: true,
    image: '/images/products/stroller/main.jpg',
    galleryImages: [
      '/images/products/stroller/main.jpg',
      '/images/products/stroller/folded.jpg',
      '/images/products/stroller/storage.jpg',
      '/images/products/stroller/harness.jpg',
      '/images/products/stroller/handlebar.jpg'
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
    sort: 1,
    paymentTerms: 'T/T 30% deposit, 70% against copy of B/L',
    loadingPort: 'Shanghai, China',
    tradeTerms: 'FOB Shanghai',
    containerLoad: {
      '20GP': 1200,
      '40GP': 2500,
      '40HQ': 2900
    },
    qcProcess: 'IQC (incoming) → IPQC (production line) → FQC (final assembly) → OQC (container loading check). 100% inspection on safety and function.',
    afterSalesPolicy: '12-month warranty against manufacturing defects. Free replacement parts for quality issues within warranty period.',
    faq: [
      { q: 'What certifications do these strollers have?', a: 'All strollers have ASTM F833-23, CPC, EN 1888, and ISO 9001 certification. We can provide test reports upon request.' },
      { q: 'Can I customize the color and packaging?', a: 'Yes! We offer 15+ color options, custom logo printing, and custom packaging design. MOQ for custom color is 100 units.' },
      { q: 'What is the sample lead time?', a: 'Standard samples take 3-7 days. Customized samples take 7-10 days depending on requirements.' }
    ]
  },
  {
    id: 2,
    slug: 'en-certified-safety-gate',
    title: 'EN Certified Safety Gate',
    title_en: 'EN Certified Safety Gate',
    category: 'safety-gate',
    description: 'Auto-close baby safety gate with double-locking system. EN 1930 & ASTM F1004 certified, 189+ export batches. Extension kits available for wider openings up to 150cm. Perfect for baby-proofing specialists.',
    description_en: 'Auto-close baby safety gate with double-locking system. EN 1930 & ASTM F1004 certified, 189+ export batches. Extension kits available for wider openings up to 150cm. Perfect for baby-proofing specialists.',
    moq: 100,
    leadTimeSample: '3-7 days',
    leadTimeProduction: '15-25 days',
    certifications: ['EN 1930', 'CPSC', 'CE', 'ASTM F1004'],
    targetMarkets: ['European Union', 'United States', 'Australia', 'UK'],
    testReportNumber: 'BGP-TR-2026-SG001',
    exportBatches: 189,
    zeroReturnRate: true,
    image: '/images/products/safety-gate/main.jpg',
    galleryImages: [
      '/images/products/safety-gate/main.jpg',
      '/images/products/safety-gate/install.jpg',
      '/images/products/safety-gate/door.jpg',
      '/images/products/safety-gate/lock.jpg',
      '/images/products/safety-gate/lifestyle.jpg'
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
    sort: 2,
    paymentTerms: 'T/T 30% deposit, 70% against copy of B/L or L/C at sight',
    loadingPort: 'Ningbo, China',
    tradeTerms: 'FOB Ningbo',
    containerLoad: {
      '20GP': 2800,
      '40GP': 5800,
      '40HQ': 6700
    },
    qcProcess: 'Raw material check → Welding inspection → Finish check → Function test → Impact test → Final packing check. 100% open-close testing for each unit.',
    afterSalesPolicy: '12-month warranty. Free replacement parts for manufacturing defects. Technical support available 24/7.',
    faq: [
      { q: 'What is the maximum width this gate can fit?', a: 'Standard size fits 75-100cm. We have extension kits available for wider openings up to 150cm.' },
      { q: 'Is this gate suitable for top of stairs?', a: 'Yes! We provide wall mount hardware for staircase installation. Pressure mount is suitable for doorways.' },
      { q: 'What safety standards does it meet?', a: 'Meets EN 1930:2012 (EU), ASTM F1004 (US), and CPSC safety standards.' }
    ]
  },
  {
    id: 3,
    slug: 'cpc-certified-high-chair',
    title: 'CPC Certified High Chair',
    title_en: 'CPC Certified High Chair',
    category: 'high-chair',
    description: 'Food-grade high chair with FDA & LFGB certified materials. 7-position height + 3-position recline, dishwasher-safe tray. 205+ export batches, 18-month warranty. Ideal for premium baby stores.',
    description_en: 'Food-grade high chair with FDA & LFGB certified materials. 7-position height + 3-position recline, dishwasher-safe tray. 205+ export batches, 18-month warranty. Ideal for premium baby stores.',
    moq: 80,
    leadTimeSample: '3-7 days',
    leadTimeProduction: '15-25 days',
    certifications: ['CPC', 'ASTM F404', 'FDA', 'EN 14988'],
    targetMarkets: ['United States', 'Canada', 'European Union'],
    testReportNumber: 'BGP-TR-2026-HC001',
    exportBatches: 205,
    zeroReturnRate: true,
    image: '/images/products/high-chair/main.jpg',
    galleryImages: [
      '/images/products/high-chair/main.jpg',
      '/images/products/high-chair/folded.jpg',
      '/images/products/high-chair/tray.jpg',
      '/images/products/high-chair/harness.jpg',
      '/images/products/high-chair/height.jpg'
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
    sort: 3,
    paymentTerms: 'T/T 30% deposit, 70% against copy of B/L',
    loadingPort: 'Shanghai, China',
    tradeTerms: 'FOB Shanghai',
    containerLoad: {
      '20GP': 1500,
      '40GP': 3200,
      '40HQ': 3700
    },
    qcProcess: 'Incoming material food-grade check → Assembly line QC → Function test (harness, tray, recline) → Stability test → Final visual inspection.',
    afterSalesPolicy: '18-month warranty for high chairs. Free replacement parts within warranty. Food-safe parts guaranteed.',
    faq: [
      { q: 'Is the tray material food-safe?', a: 'Yes! All food-contact materials are FDA and LFGB certified. Tray is dishwasher-safe and BPA-free.' },
      { q: 'What is the height range?', a: '7-position height adjustment from 45cm to 65cm to fit different table heights.' },
      { q: 'Can it be folded for storage?', a: 'Yes! Compact fold design makes it easy to store when not in use.' }
    ]
  },
  {
    id: 4,
    slug: 'baby-bed-rail-safety-guard',
    title: 'Baby Bed Rail Safety Guard',
    title_en: 'Baby Bed Rail Safety Guard',
    category: 'bed-rail',
    description: 'Heightening bed rail with breathable mesh window for visibility. Adjustable length 120-200cm, fits 20-60cm mattresses. EN 1930 & CPSC certified, 156+ export batches. Great for online marketplaces.',
    description_en: 'Heightening bed rail with breathable mesh window for visibility. Adjustable length 120-200cm, fits 20-60cm mattresses. EN 1930 & CPSC certified, 156+ export batches. Great for online marketplaces.',
    moq: 60,
    leadTimeSample: '3-7 days',
    leadTimeProduction: '15-25 days',
    certifications: ['EN 1930', 'CPSC', 'ASTM F1004', 'CE'],
    targetMarkets: ['European Union', 'United States', 'Canada', 'Australia'],
    testReportNumber: 'BGP-TR-2026-BR001',
    exportBatches: 156,
    zeroReturnRate: true,
    image: '/images/products/bed-rail/main.jpg',
    galleryImages: [
      '/images/products/bed-rail/main.jpg',
      '/images/products/bed-rail/install.jpg',
      '/images/products/bed-rail/mesh.jpg',
      '/images/products/bed-rail/height.jpg',
      '/images/products/bed-rail/lifestyle.jpg'
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
    sort: 4,
    paymentTerms: 'T/T 30% deposit, 70% against copy of B/L or PayPal for small orders',
    loadingPort: 'Ningbo, China',
    tradeTerms: 'FOB Ningbo',
    containerLoad: {
      '20GP': 2000,
      '40GP': 4200,
      '40HQ': 4900
    },
    qcProcess: 'Frame strength test → Fabric tension test → Installation fit test → Fold/unfold test → Final inspection.',
    afterSalesPolicy: '12-month warranty. Free replacement parts for any quality issues. Custom length options available.',
    faq: [
      { q: 'What mattress thickness does it fit?', a: 'Fits mattresses from 20cm to 60cm thickness. Works with most standard and thick mattresses.' },
      { q: 'Can I install on both sides of the bed?', a: 'Yes! Order 2 units for both sides. They work independently and don\'t interfere with each other.' },
      { q: 'Is the fabric washable?', a: 'Yes! The fabric cover is removable and machine washable on gentle cycle.' }
    ]
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