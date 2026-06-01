import { productsData, type Product } from './product-data';

export interface FAQ {
  id: number;
  category: string;
  question: string;
  answer: string;
  sort: number;
}

export async function getProducts(): Promise<Product[]> {
  const directusUrl = import.meta.env.PUBLIC_DIRECTUS_URL || 'http://localhost:8055';
  
  try {
    const response = await fetch(`${directusUrl}/items/products?filter[status][_eq]=published&sort=sort`);
    
    if (!response.ok) {
      throw new Error('Directus API unavailable');
    }
    
    const data = await response.json();
    return data.data.map((item: any) => ({
      id: item.id,
      slug: item.slug,
      title: item.title_en || item.title,
      title_en: item.title_en,
      category: item.category,
      description: item.description_en || item.description,
      description_en: item.description_en,
      moq: item.moq || 50,
      leadTimeSample: item.lead_time_sample || '3-7 days',
      leadTimeProduction: item.lead_time_production || '15-25 days',
      certifications: item.certifications || [],
      targetMarkets: item.target_markets || [],
      testReportNumber: item.test_report_number,
      exportBatches: item.export_batches || 0,
      zeroReturnRate: item.zero_return_rate || false,
      image: item.image ? `${directusUrl}/assets/${item.image}` : undefined,
      image_url: item.image ? `${directusUrl}/assets/${item.image}` : undefined,
      galleryImages: item.gallery_images ? item.gallery_images.map((img: string) => `${directusUrl}/assets/${img}`) : [],
      specs: item.specs || {},
      customOptions: item.custom_options || {},
      features: item.features || [],
      applications: item.applications || [],
      packaging: item.packaging,
      status: item.status,
      sort: item.sort || 0
    }));
  } catch (error) {
    console.error('Failed to fetch products from Directus:', error);
    return [] as Product[];
  }
}

export async function getFAQs(): Promise<FAQ[]> {
  const directusUrl = import.meta.env.PUBLIC_DIRECTUS_URL || 'http://localhost:8055';
  
  try {
    const response = await fetch(`${directusUrl}/items/faqs?sort=sort`);
    
    if (!response.ok) {
      throw new Error('Directus API unavailable');
    }
    
    const data = await response.json();
    return data.data.map((item: any) => ({
      id: item.id,
      category: item.category,
      question: item.question,
      answer: item.answer,
      sort: item.sort || 0
    }));
  } catch (error) {
    console.error('Failed to fetch FAQs from Directus:', error);
    return [];
  }
}

export async function getProductBySlug(slug: string): Promise<Product | undefined> {
  const products = await getProducts();
  return products.find(p => p.slug === slug);
}
