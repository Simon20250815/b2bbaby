export function generateOrganizationSchema() {
  return {
    '@context': 'https://schema.org',
    '@type': 'Organization',
    name: 'B2Bbaby',
    description: 'Professional baby product manufacturer and sourcing specialist',
    url: 'https://b2bbaby.com',
    contactPoint: {
      '@type': 'ContactPoint',
      contactType: 'sales',
      availableLanguage: ['English']
    },
    knowsAbout: [
      'Baby Stroller Manufacturing',
      'Safety Gate OEM',
      'High Chair ODM',
      'China Factory Sourcing'
    ],
    areaServed: ['United States', 'Europe', 'Australia']
  };
}

export function generateProductSchema(product: any) {
  const leadTime = product.leadTimeProduction || product.leadTime || product.lead_time_production || '15-25 days';
  
  return {
    '@context': 'https://schema.org',
    '@type': 'Product',
    name: product.title,
    description: product.description,
    image: product.image || product.images?.[0],
    brand: {
      '@type': 'Brand',
      name: 'B2Bbaby'
    },
    manufacturer: {
      '@type': 'Organization',
      name: 'B2Bbaby Manufacturing Co.'
    },
    category: product.category,
    sku: product.slug,
    offers: {
      '@type': 'Offer',
      url: `https://b2bbaby.com/products/${product.slug}`,
      availability: 'https://schema.org/InStock',
      minOrderQuantity: product.moq
    },
    additionalProperty: [
      {
        '@type': 'PropertyValue',
        name: 'MOQ',
        value: product.moq
      },
      {
        '@type': 'PropertyValue',
        name: 'LeadTime',
        value: leadTime
      },
      {
        '@type': 'PropertyValue',
        name: 'LeadTimeSample',
        value: product.leadTimeSample || product.lead_time_sample || '3-7 days'
      },
      {
        '@type': 'PropertyValue',
        name: 'Certifications',
        value: product.certifications?.join(', ') || ''
      },
      {
        '@type': 'PropertyValue',
        name: 'Test Report Number',
        value: product.test_report_number || ''
      },
      {
        '@type': 'PropertyValue',
        name: 'Export Batches',
        value: product.exportBatches || product.export_batches || 0
      },
      {
        '@type': 'PropertyValue',
        name: 'Target Markets',
        value: product.targetMarkets?.join(', ') || product.target_markets?.join(', ') || ''
      }
    ],
    review: {
      '@type': 'Review',
      reviewBody: product.zero_return_rate ? 'Zero return rate across all export batches' : 'High quality products with excellent customer feedback',
      rating: {
        '@type': 'Rating',
        ratingValue: '5',
        bestRating: '5'
      }
    }
  };
}

export function generateFAQPageSchema(faqs: any[]) {
  return {
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    mainEntity: faqs.map(faq => ({
      '@type': 'Question',
      name: faq.question,
      acceptedAnswer: {
        '@type': 'Answer',
        text: faq.answer
      }
    }))
  };
}

export function generateServiceSchema(serviceType: 'oem-odm' | 'sourcing') {
  const services = {
    'oem-odm': {
      name: 'OEM/ODM Customization Service',
      description: 'Professional baby product OEM/ODM customization including custom logo, color, packaging, and product design modifications.',
      provider: {
        '@type': 'Organization',
        name: 'B2Bbaby'
      },
      areaServed: ['United States', 'Europe', 'Australia'],
      serviceType: 'Product Customization'
    },
    'sourcing': {
      name: 'Factory Sourcing Service',
      description: 'Professional baby product factory sourcing from verified Chinese manufacturers with quality control and order management.',
      provider: {
        '@type': 'Organization',
        name: 'B2Bbaby'
      },
      areaServed: ['United States', 'Europe', 'Australia'],
      serviceType: 'Product Sourcing'
    }
  };
  return {
    '@context': 'https://schema.org',
    '@type': 'Service',
    ...services[serviceType]
  };
}

export function generateBlogPostSchema(blog: any) {
  return {
    '@context': 'https://schema.org',
    '@type': 'BlogPosting',
    headline: blog.title,
    description: blog.description,
    author: {
      '@type': 'Organization',
      name: 'B2Bbaby'
    },
    publisher: {
      '@type': 'Organization',
      name: 'B2Bbaby'
    },
    datePublished: blog.datePublished,
    dateModified: blog.dateModified,
    keywords: blog.keywords,
    about: 'Baby Products Manufacturing',
    mainEntityOfPage: {
      '@type': 'WebPage',
      '@id': `https://b2bbaby.com/blog/${blog.slug}`
    }
  };
}

export function generateProductGroupSchema(products: any[]) {
  return {
    '@context': 'https://schema.org',
    '@type': 'ProductGroup',
    name: 'Baby Products Collection',
    description: 'High-quality, certified baby products including strollers, safety gates, high chairs, and bed rails from B2Bbaby',
    hasVariant: products.map(product => ({
      '@type': 'Product',
      name: product.title,
      description: product.description,
      sku: product.slug,
      offers: {
        '@type': 'Offer',
        minOrderQuantity: product.moq,
        availability: 'https://schema.org/InStock'
      },
      additionalProperty: [{
        '@type': 'PropertyValue',
        name: 'LeadTime',
        value: product.leadTime || '7-30 days'
      }]
    }))
  };
}

export function generateContactPageSchema() {
  return {
    '@context': 'https://schema.org',
    '@type': 'ContactPage',
    name: 'Contact Us',
    description: 'Contact B2Bbaby for baby product sourcing, OEM/ODM customization, and factory inquiries',
    mainContentOfPage: {
      '@type': 'WebPageElement',
      content: 'Contact form and contact information for B2Bbaby'
    },
    contactPoint: {
      '@type': 'ContactPoint',
      contactType: 'sales',
      email: 'sourcing@b2bbaby.com',
      telephone: '+8617681128186',
      availableLanguage: ['English', 'Chinese'],
      hoursAvailable: 'Monday-Friday 9:00-18:00 CST',
      serviceArea: ['United States', 'Europe', 'Australia', 'Canada'],
      description: 'B2B sales inquiries for baby products'
    }
  };
}
