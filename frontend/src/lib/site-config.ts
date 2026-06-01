import siteConfig from '../../content/global/index.json';

export interface SiteConfig {
  site: {
    title: string;
    title_en: string;
    description: string;
    description_en: string;
    logo: string;
    favicon: string;
  };
  company: {
    name: string;
    name_en: string;
    address: string;
    address_en: string;
    phone: string;
    email: string;
    sales_email: string;
    whatsapp: string;
    business_hours: string;
    founded: string;
    employees: string;
    factories: string;
    export_countries: string;
  };
  social: {
    facebook: string;
    instagram: string;
    linkedin: string;
    twitter: string;
    youtube: string;
    made_in_china: string;
  };
  seo: {
    google_site_verification: string;
    google_analytics_id: string;
  };
  umami: {
    website_id: string;
    host_url: string;
  };
}

export function getSiteConfig(): SiteConfig {
  return siteConfig as SiteConfig;
}