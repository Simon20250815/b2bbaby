import { createDirectus, rest, readItems, readSingleton, createItem, updateItem, deleteItem, readItem } from '@directus/sdk';

const directusUrl = import.meta.env.DIRECTUS_URL || 'http://localhost:8055';

const client = createDirectus(directusUrl).with(rest());

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

export async function getProducts(): Promise<Product[]> {
  try {
    const response = await client.request(
      readItems('products', {
        filter: { status: { _eq: 'published' } },
        sort: ['sort']
      })
    );
    return response;
  } catch (error) {
    console.warn('Directus API unavailable, using fallback data');
    return [];
  }
}

export async function getProductBySlug(slug: string): Promise<Product | null> {
  try {
    const response = await client.request(
      readItems('products', {
        filter: { slug: { _eq: slug }, status: { _eq: 'published' } },
        limit: 1
      })
    );
    return response[0] || null;
  } catch (error) {
    console.warn('Directus API unavailable');
    return null;
  }
}

export async function getFAQs(): Promise<FAQ[]> {
  try {
    const response = await client.request(
      readItems('faqs', {
        sort: ['sort']
      })
    );
    return response;
  } catch (error) {
    console.warn('Directus API unavailable');
    return [];
  }
}

export async function getBlogs(): Promise<Blog[]> {
  try {
    const response = await client.request(
      readItems('blogs', {
        filter: { status: { _eq: 'published' } },
        sort: [{ date_published: 'desc' }]
      })
    );
    return response;
  } catch (error) {
    console.warn('Directus API unavailable');
    return [];
  }
}

export async function getBlogBySlug(slug: string): Promise<Blog | null> {
  try {
    const response = await client.request(
      readItems('blogs', {
        filter: { slug: { _eq: slug }, status: { _eq: 'published' } },
        limit: 1
      })
    );
    return response[0] || null;
  } catch (error) {
    console.warn('Directus API unavailable');
    return null;
  }
}

export async function getSiteConfig(): Promise<SiteConfig | null> {
  try {
    const response = await client.request(readSingleton('site_config'));
    return response;
  } catch (error) {
    console.warn('Site config not found');
    return null;
  }
}

export { client };