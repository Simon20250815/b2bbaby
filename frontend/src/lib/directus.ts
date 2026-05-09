const directusUrl = import.meta.env.DIRECTUS_URL || 'http://localhost:8055';

let authToken: string | null = null;

async function getToken(): Promise<string | null> {
    if (authToken) {
        return authToken;
    }

    try {
        const response = await fetch(`${directusUrl}/auth/login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                email: 'admin@b2bbaby.com',
                password: 'admin_password_2026'
            })
        });

        if (!response.ok) {
            throw new Error('Login failed');
        }

        const data = await response.json();
        authToken = data.data.access_token;
        return authToken;
    } catch (error) {
        console.warn('❌ Failed to authenticate:', error);
        return null;
    }
}

interface DirectusFile {
  id: string;
  filename_disk: string;
  filename_download: string;
  url: string;
}

interface DirectusProduct {
  id: number;
  slug: string;
  title: string;
  title_en?: string;
  category?: string;
  description?: string;
  description_en?: string;
  moq?: number;
  lead_time_sample?: string;
  lead_time_production?: string;
  certifications?: string[];
  target_markets?: string[];
  test_report_number?: string;
  export_batches?: number;
  zero_return_rate?: boolean;
  image?: DirectusFile | null;
  gallery_images?: DirectusFile[] | null;
  specs?: Record<string, string>;
  custom_options?: Record<string, string>;
  features?: string[];
  applications?: string[];
  packaging?: string;
  status?: string;
  sort?: number;
  image_url?: string;
  leadTimeSample?: string;
  leadTimeProduction?: string;
  exportBatches?: number;
  zeroReturnRate?: boolean;
  galleryImages?: string[];
}

export interface Product {
  id: number;
  slug: string;
  title: string;
  title_en?: string;
  category?: string;
  description?: string;
  description_en?: string;
  moq?: number;
  lead_time_sample?: string;
  lead_time_production?: string;
  certifications?: string[];
  target_markets?: string[];
  test_report_number?: string;
  export_batches?: number;
  zero_return_rate?: boolean;
  image?: string;
  gallery_images?: string[];
  specs?: Record<string, string>;
  custom_options?: Record<string, string>;
  features?: string[];
  applications?: string[];
  packaging?: string;
  status?: string;
  sort?: number;
  leadTimeSample?: string;
  leadTimeProduction?: string;
  exportBatches?: number;
  zeroReturnRate?: boolean;
}

export interface FAQ {
  id: number;
  question: string;
  question_en?: string;
  answer?: string;
  answer_en?: string;
  category?: string;
  sort?: number;
}

export interface Blog {
  id: number;
  slug: string;
  title: string;
  title_en?: string;
  excerpt?: string;
  excerpt_en?: string;
  content?: string;
  content_en?: string;
  cover_image?: string;
  author?: string;
  tags?: string[];
  date_published?: string;
  status?: string;
}

export interface SiteConfig {
  id: string;
  site_name?: string;
  site_description?: string;
  logo?: string;
  footer_text?: string;
  contact_email?: string;
  contact_phone?: string;
  contact_whatsapp?: string;
}

function transformProduct(product: DirectusProduct): Product {
  const imageUrl = product.image 
    ? `${directusUrl}/assets/${product.image.id}` 
    : product.image_url || '';
  
  const galleryUrls = product.gallery_images 
    ? product.gallery_images.map(img => `${directusUrl}/assets/${img.id}`)
    : [];

  return {
    id: product.id,
    slug: product.slug,
    title: product.title,
    title_en: product.title_en,
    category: product.category,
    description: product.description,
    description_en: product.description_en,
    moq: product.moq,
    lead_time_sample: product.lead_time_sample || product.leadTimeSample,
    lead_time_production: product.lead_time_production || product.leadTimeProduction,
    certifications: product.certifications,
    target_markets: product.target_markets,
    test_report_number: product.test_report_number,
    export_batches: product.export_batches || product.exportBatches,
    zero_return_rate: product.zero_return_rate || product.zeroReturnRate,
    image: imageUrl,
    gallery_images: galleryUrls.length > 0 ? galleryUrls : undefined,
    specs: product.specs,
    custom_options: product.custom_options,
    features: product.features,
    applications: product.applications,
    packaging: product.packaging,
    status: product.status,
    sort: product.sort,
    leadTimeSample: product.lead_time_sample || product.leadTimeSample,
    leadTimeProduction: product.lead_time_production || product.leadTimeProduction,
    exportBatches: product.export_batches || product.exportBatches,
    zeroReturnRate: product.zero_return_rate || product.zeroReturnRate,
  };
}

export async function getProducts(): Promise<Product[]> {
  const token = await getToken();
  
  try {
    const headers: Record<string, string> = { 'Content-Type': 'application/json' };
    if (token) {
        headers['Authorization'] = `Bearer ${token}`;
    }

    const response = await fetch(
      `${directusUrl}/items/products?fields=*,image.*,gallery_images.*&filter={"status":{"_eq":"published"}}&sort=sort`,
      { headers }
    );

    if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
    }

    const result = await response.json();
    return result.data.map((product: DirectusProduct) => transformProduct(product));
  } catch (error) {
    console.warn('Directus API unavailable, using fallback data:', error);
    return [];
  }
}

export async function getProductBySlug(slug: string): Promise<Product | null> {
  const token = await getToken();
  
  try {
    const headers: Record<string, string> = { 'Content-Type': 'application/json' };
    if (token) {
        headers['Authorization'] = `Bearer ${token}`;
    }

    const response = await fetch(
      `${directusUrl}/items/products?fields=*,image.*,gallery_images.*&filter={"slug":{"_eq":"${slug}"},"status":{"_eq":"published"}}&limit=1`,
      { headers }
    );

    if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
    }

    const result = await response.json();
    return result.data[0] ? transformProduct(result.data[0]) : null;
  } catch (error) {
    console.warn('Directus API unavailable:', error);
    return null;
  }
}

export async function getFAQs(): Promise<FAQ[]> {
  const token = await getToken();
  
  try {
    const headers: Record<string, string> = { 'Content-Type': 'application/json' };
    if (token) {
        headers['Authorization'] = `Bearer ${token}`;
    }

    const response = await fetch(`${directusUrl}/items/faqs?sort=sort`, { headers });

    if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
    }

    const result = await response.json();
    return result.data;
  } catch (error) {
    console.warn('Directus API unavailable:', error);
    return [];
  }
}

export async function getBlogs(): Promise<Blog[]> {
  const token = await getToken();
  
  try {
    const headers: Record<string, string> = { 'Content-Type': 'application/json' };
    if (token) {
        headers['Authorization'] = `Bearer ${token}`;
    }

    const response = await fetch(
      `${directusUrl}/items/blogs?fields=*,cover_image.*&filter={"status":{"_eq":"published"}}&sort=[{"date_published":"desc"}]`,
      { headers }
    );

    if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
    }

    const result = await response.json();
    return result.data.map((blog: any) => ({
      ...blog,
      cover_image: blog.cover_image 
        ? `${directusUrl}/assets/${blog.cover_image.id}` 
        : blog.cover_image
    }));
  } catch (error) {
    console.warn('Directus API unavailable:', error);
    return [];
  }
}

export async function getBlogBySlug(slug: string): Promise<Blog | null> {
  const token = await getToken();
  
  try {
    const headers: Record<string, string> = { 'Content-Type': 'application/json' };
    if (token) {
        headers['Authorization'] = `Bearer ${token}`;
    }

    const response = await fetch(
      `${directusUrl}/items/blogs?fields=*,cover_image.*&filter={"slug":{"_eq":"${slug}"},"status":{"_eq":"published"}}&limit=1`,
      { headers }
    );

    if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
    }

    const result = await response.json();
    if (!result.data[0]) return null;
    
    const blog = result.data[0];
    return {
      ...blog,
      cover_image: blog.cover_image 
        ? `${directusUrl}/assets/${blog.cover_image.id}` 
        : blog.cover_image
    };
  } catch (error) {
    console.warn('Directus API unavailable:', error);
    return null;
  }
}

export async function getSiteConfig(): Promise<SiteConfig | null> {
  const token = await getToken();
  
  try {
    const headers: Record<string, string> = { 'Content-Type': 'application/json' };
    if (token) {
        headers['Authorization'] = `Bearer ${token}`;
    }

    const response = await fetch(`${directusUrl}/items/site_config`, { headers });

    if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
    }

    const result = await response.json();
    return result.data;
  } catch (error) {
    console.warn('Site config not found:', error);
    return null;
  }
}