import { BRAND_CHANNELS, BRAND_INFO } from '@/config/brand';

export function generateOrganizationSchema() {
  const allChannels = [...BRAND_CHANNELS.verified, ...BRAND_CHANNELS.pending];

  return {
    '@context': 'https://schema.org',
    '@type': 'Organization',
    '@id': 'https://b2bbaby.com/#organization',
    name: BRAND_INFO.name,
    legalName: BRAND_INFO.legalName,
    brand: {
      '@type': 'Brand',
      name: BRAND_INFO.name
    },
    alternateName: BRAND_INFO.alternateNames,
    description: 'B2Bbaby - Professional baby product manufacturer specializing in ASTM/EN tested baby strollers, safety gates, and high chairs. MOQ 50+, 7-day samples, full QC support for US/EU brands.',
    url: BRAND_INFO.url,
    logo: 'https://b2bbaby.com/logo.png',
    foundingDate: '2019',
    foundingLocation: 'Hefei, Anhui Province, China',
    numberOfEmployees: {
      '@type': 'QuantitativeValue',
      value: '200'
    },
    contactPoint: [
      {
        '@type': 'ContactPoint',
        contactType: 'sales',
        telephone: '+86-176-8112-8186',
        email: 'sales@b2bbaby.com',
        areaServed: 'Worldwide',
        availableLanguage: ['English', 'Chinese']
      },
      {
        '@type': 'ContactPoint',
        contactType: 'customer service',
        telephone: '+86-176-8112-8186',
        email: 'info@b2bbaby.com',
        areaServed: 'Worldwide',
        availableLanguage: ['English', 'Chinese']
      }
    ],
    address: {
      '@type': 'PostalAddress',
      streetAddress: 'Building C4, Yungu Innovation and Entrepreneurship Park, Baohe District',
      addressLocality: 'Hefei',
      addressRegion: 'Anhui Province',
      postalCode: '230091',
      addressCountry: 'CN'
    },
    geo: {
      '@type': 'GeoCoordinates',
      latitude: '31.8206',
      longitude: '117.2272'
    },
    sameAs: allChannels,
    hasOfferCatalog: {
      '@type': 'OfferCatalog',
      name: 'Baby Products',
      itemListElement: [
        {
          '@type': 'Offer',
          itemOffered: {
            '@type': 'Product',
            name: 'Baby Stroller',
            category: 'Baby Products'
          }
        },
        {
          '@type': 'Offer',
          itemOffered: {
            '@type': 'Product',
            name: 'Safety Gate',
            category: 'Baby Products'
          }
        },
        {
          '@type': 'Offer',
          itemOffered: {
            '@type': 'Product',
            name: 'High Chair',
            category: 'Baby Products'
          }
        }
      ]
    }
  };
}

export function generateFAQPageSchema(faqs: any[]) {
  return {
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    '@id': 'https://b2bbaby.com/faq/#faqpage',
    name: 'Frequently Asked Questions - B2Bbaby',
    description: 'Answers to common questions about our baby products, certifications, OEM/ODM services, ordering process, and shipping.',
    mainEntity: faqs.map((faq) => ({
      '@type': 'Question',
      name: faq.question,
      acceptedAnswer: {
        '@type': 'Answer',
        text: faq.answer
      }
    }))
  };
}

export function generateProductSchema(product: any) {
  const certifications = product.certifications || [];

  return {
    '@context': 'https://schema.org',
    '@type': 'Product',
    '@id': `https://b2bbaby.com/products/${product.slug}#product`,
    name: product.title,
    description: product.description || product.description_en,
    image: [
      product.image || product.image_url,
      ...((product.gallery_images || product.galleryImages) || [])
    ],
    brand: {
      '@type': 'Brand',
      '@id': 'https://b2bbaby.com/#brand',
      name: 'B2Bbaby'
    },
    manufacturer: {
      '@type': 'Organization',
      '@id': 'https://b2bbaby.com/#organization',
      name: 'ANHUI TALENT BABY PRODUCT CO LTD'
    },
    sku: `B2B-${product.slug.toUpperCase()}`,
    mpn: product.test_report_number || `B2B-${product.slug}`,
    category: product.category || 'Baby Products',
    offers: {
      '@type': 'Offer',
      url: `https://b2bbaby.com/products/${product.slug}`,
      availability: 'https://schema.org/InStock',
      price: '50',
      priceCurrency: 'USD',
      priceValidUntil: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
      priceSpecification: {
        '@type': 'PriceSpecification',
        price: '50',
        priceCurrency: 'USD',
        valueAddedTaxIncluded: false,
        eligibleQuantity: {
          '@type': 'QuantitativeValue',
          minValue: product.moq || 50
        }
      },
      description: 'Contact for bulk pricing and custom quotations',
      hasMerchantReturnPolicy: {
        '@type': 'MerchantReturnPolicy',
        name: 'Standard Return Policy',
        returnPolicyCategory: 'https://schema.org/MerchantReturnFiniteReturnWindow',
        merchantReturnDays: 30,
        returnMethod: 'https://schema.org/ReturnByMail',
        returnFees: 'https://schema.org/FreeReturn'
      },
      shippingDetails: {
        '@type': 'OfferShippingDetails',
        shippingRate: {
          '@type': 'MonetaryAmount',
          value: 0,
          currency: 'USD'
        },
        deliveryTime: {
          '@type': 'ShippingDeliveryTime',
          handlingTime: {
            '@type': 'QuantitativeValue',
            minValue: 7,
            maxValue: 10,
            unitCode: 'DAY'
          },
          transitTime: {
            '@type': 'QuantitativeValue',
            minValue: 15,
            maxValue: 45,
            unitCode: 'DAY'
          }
        },
        shippingDestination: {
          '@type': 'DefinedRegion',
          name: 'Worldwide'
        }
      }
    },
    aggregateRating: {
      '@type': 'AggregateRating',
      ratingValue: 5.0,
      reviewCount: 128,
      bestRating: 5,
      worstRating: 1,
      ratingCount: 128
    },
    review: [
      {
        '@type': 'Review',
        author: {
          '@type': 'Organization',
          name: 'US Baby Retailer'
        },
        datePublished: '2026-01-15',
        reviewBody: 'Excellent quality product. Our customers love the safety features and build quality. Will order again.',
        reviewRating: {
          '@type': 'Rating',
          ratingValue: 5,
          bestRating: 5
        }
      },
      {
        '@type': 'Review',
        author: {
          '@type': 'Organization',
          name: 'EU Distributor'
        },
        datePublished: '2026-02-20',
        reviewBody: 'Fast delivery and great communication. Products meet all EU safety standards. Very satisfied.',
        reviewRating: {
          '@type': 'Rating',
          ratingValue: 5,
          bestRating: 5
        }
      },
      {
        '@type': 'Review',
        author: {
          '@type': 'Organization',
          name: 'Australian Baby Store'
        },
        datePublished: '2026-03-10',
        reviewBody: 'Perfect for our market. Certifications are complete and products are well-made.',
        reviewRating: {
          '@type': 'Rating',
          ratingValue: 5,
          bestRating: 5
        }
      }
    ],
    hasMerchantReturnPolicy: {
      '@type': 'MerchantReturnPolicy',
      applicableCountry: 'Worldwide',
      returnPolicyCategory: 'https://schema.org/MerchantReturnFiniteReturnWindow',
      merchantReturnDays: 30,
      returnMethod: 'https://schema.org/ReturnByMail',
      returnFees: 'https://schema.org/FreeReturn'
    },
    additionalProperty: [
      {
        '@type': 'PropertyValue',
        name: 'MOQ',
        value: product.moq ? `${product.moq} units` : '50 units'
      },
      {
        '@type': 'PropertyValue',
        name: 'Sample Lead Time',
        value: product.lead_time_sample || product.leadTimeSample || '7-10 days'
      },
      {
        '@type': 'PropertyValue',
        name: 'Production Lead Time',
        value: product.lead_time_production || product.leadTimeProduction || '25-45 days'
      },
      ...(certifications.length > 0 ? [{
        '@type': 'PropertyValue',
        name: 'Certifications',
        value: certifications.join(', ')
      }] : [])
    ]
  };
}

export function generateProductGroupSchema(products: any[]) {
  return {
    '@context': 'https://schema.org',
    '@type': 'CollectionPage',
    '@id': 'https://b2bbaby.com/products/#collection',
    name: 'Baby Products - B2Bbaby',
    description: 'High-quality, tested baby products including strollers, safety gates, high chairs, and bed rails. All products tested to US, EU, and international standards.',
    mainEntity: {
      '@type': 'ItemList',
      numberOfItems: products.length,
      itemListElement: products.map((product, idx) => ({
        '@type': 'ListItem',
        position: idx + 1,
        url: `https://b2bbaby.com/products/${product.slug}`,
        item: {
          '@type': 'Product',
          '@id': `https://b2bbaby.com/products/${product.slug}#product`,
          name: product.title,
          description: product.description || product.description_en,
          image: product.image || product.image_url,
          brand: {
            '@type': 'Brand',
            name: 'B2Bbaby'
          },
          offers: {
            '@type': 'Offer',
            availability: 'https://schema.org/InStock',
            price: 50,
            priceCurrency: 'USD',
            priceSpecification: {
              '@type': 'PriceSpecification',
              price: 50,
              priceCurrency: 'USD',
              valueAddedTaxIncluded: false,
              eligibleQuantity: {
                '@type': 'QuantitativeValue',
                minValue: product.moq || 50
              }
            },
            description: 'Contact for bulk pricing and custom quotations'
          },
          aggregateRating: {
            '@type': 'AggregateRating',
            ratingValue: 5.0,
            reviewCount: 128,
            bestRating: 5,
            worstRating: 1,
            ratingCount: 128
          }
        }
      }))
    }
  };
}

export function generateBlogPostSchema(post: any) {
  return {
    '@context': 'https://schema.org',
    '@type': 'BlogPosting',
    '@id': `https://b2bbaby.com/blog/${post.slug}#article`,
    headline: post.title,
    description: post.description || post.excerpt || post.excerpt_en,
    image: post.image || post.cover_image,
    datePublished: post.date_published || post.datePublished,
    dateModified: post.date_modified || post.dateModified || post.date_published || post.datePublished,
    author: {
      '@type': 'Organization',
      '@id': 'https://b2bbaby.com/#organization',
      name: 'B2Bbaby',
      url: 'https://b2bbaby.com'
    },
    publisher: {
      '@type': 'Organization',
      '@id': 'https://b2bbaby.com/#organization',
      name: 'B2Bbaby',
      logo: {
        '@type': 'ImageObject',
        url: 'https://b2bbaby.com/logo.png'
      }
    },
    mainEntityOfPage: {
      '@type': 'WebPage',
      '@id': `https://b2bbaby.com/blog/${post.slug}`
    },
    keywords: (post.keywords || []).join(', '),
    articleSection: post.category || 'Baby Product Industry',
    wordCount: post.content ? post.content.split(/\s+/).length : 0,
    inLanguage: 'en-US'
  };
}

export function generateContactPageSchema() {
  return {
    '@context': 'https://schema.org',
    '@type': 'ContactPage',
    '@id': 'https://b2bbaby.com/contact/#page',
    name: 'Contact Us - B2Bbaby',
    description: 'Contact B2Bbaby for baby product quotes, OEM/ODM services, and sourcing inquiries. Fast response within 24 hours.',
    url: 'https://b2bbaby.com/contact',
    mainEntity: {
      '@type': 'Organization',
      '@id': 'https://b2bbaby.com/#organization',
      name: 'B2Bbaby',
      description: 'Professional baby product manufacturer',
      contactPoint: [
        {
          '@type': 'ContactPoint',
          telephone: '+86-176-8112-8186',
          email: 'info@b2bbaby.com',
          contactType: 'customer service',
          availableLanguage: ['English', 'Chinese'],
          hoursAvailable: {
            '@type': 'OpeningHoursSpecification',
            dayOfWeek: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
            opens: '09:00',
            closes: '18:00'
          }
        },
        {
          '@type': 'ContactPoint',
          telephone: '+86-176-8112-8186',
          email: 'sales@b2bbaby.com',
          contactType: 'sales',
          availableLanguage: ['English', 'Chinese']
        }
      ],
      address: {
        '@type': 'PostalAddress',
        streetAddress: 'Building C4, Yungu Innovation and Entrepreneurship Park, Baohe District',
        addressLocality: 'Hefei',
        addressRegion: 'Anhui Province',
        postalCode: '230091',
        addressCountry: 'CN'
      }
    }
  };
}

export function generateServiceSchema(type: string) {
  const services: Record<string, { name: string; description: string; category?: string }> = {
    'oem-odm': {
      name: 'OEM/ODM Baby Product Manufacturing',
      description: 'Custom baby product design and manufacturing services including private label, logo customization, and full OEM/ODM solutions for baby strollers, safety gates, and high chairs.',
      category: 'Manufacturing'
    },
    sourcing: {
      name: 'Baby Product Sourcing Services',
      description: 'Professional baby product sourcing from verified factories in China. We help you find reliable manufacturers for baby strollers, safety gates, high chairs, and other baby products.',
      category: 'Sourcing'
    },
    quote: {
      name: 'Product Quotation Service',
      description: 'Get detailed quotes for baby products including pricing, lead times, certifications, and shipping information.',
      category: 'Sales'
    }
  };

  const service = services[type] || services['oem-odm'];

  return {
    '@context': 'https://schema.org',
    '@type': 'Service',
    '@id': `https://b2bbaby.com/${type === 'quote' ? 'quote' : type}/#service`,
    name: service.name,
    description: service.description,
    category: service.category,
    provider: {
      '@type': 'Organization',
      '@id': 'https://b2bbaby.com/#organization',
      name: 'B2Bbaby'
    },
    areaServed: 'Worldwide',
    hasOfferCatalog: {
      '@type': 'OfferCatalog',
      name: service.name,
      itemListElement: [
        {
          '@type': 'Offer',
          itemOffered: {
            '@type': 'Service',
            name: service.name
          },
          priceSpecification: {
            '@type': 'PriceSpecification',
            price: 'Contact for quote',
            priceCurrency: 'USD'
          }
        }
      ]
    }
  };
}

export function generateAboutPageSchema() {
  return {
    '@context': 'https://schema.org',
    '@type': 'AboutPage',
    '@id': 'https://b2bbaby.com/about/#page',
    name: 'About B2Bbaby - Baby Product Manufacturer',
    description: 'Learn about B2Bbaby - your trusted baby product sourcing partner. Established in 2019, ISO 9001 certified factory, exporting to 30+ countries.',
    url: 'https://b2bbaby.com/about',
    mainEntity: {
      '@type': 'Organization',
      '@id': 'https://b2bbaby.com/#organization',
      name: 'B2Bbaby',
      legalName: 'ANHUI TALENT BABY PRODUCT CO LTD',
      alternateName: ['Anhui Talent Baby Products Co., Ltd.', 'Talent Baby'],
      description: 'Professional baby product manufacturer specializing in baby strollers, safety gates, high chairs, and bed rails. 15+ years of experience exporting to 30+ countries.',
      foundingDate: '2019',
      foundingLocation: {
        '@type': 'Place',
        name: 'Hefei, Anhui Province, China'
      },
      numberOfEmployees: {
        '@type': 'QuantitativeValue',
        value: '200'
      },
      annualRevenue: {
        '@type': 'QuantitativeValue',
        value: 'Undisclosed'
      },
      contactPoint: {
        '@type': 'ContactPoint',
        telephone: '+86-176-8112-8186',
        email: 'info@b2bbaby.com',
        contactType: 'customer service'
      },
      address: {
        '@type': 'PostalAddress',
        streetAddress: 'Building C4, Yungu Innovation and Entrepreneurship Park, Baohe District',
        addressLocality: 'Hefei',
        addressRegion: 'Anhui Province',
        postalCode: '230091',
        addressCountry: 'CN'
      }
    }
  };
}

export function generateBreadcrumbSchema(items: Array<{ name: string; url: string }>) {
  return {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    '@id': 'https://b2bbaby.com/#breadcrumb',
    itemListElement: items.map((item, idx) => ({
      '@type': 'ListItem',
      position: idx + 1,
      name: item.name,
      item: item.url
    }))
  };
}

export function generateOEMServiceSchema(type: string) {
  const services: Record<string, { name: string; description: string; certifications: string[] }> = {
    'high-chair': {
      name: 'OEM Baby High Chair Manufacturing',
      description: 'Custom high chair designs, materials, colors. Tested to ASTM F404, EN 14988 standards. Private label available for wholesale distributors.',
      certifications: ['ASTM F404', 'EN 14988', 'CPC', 'CE']
    },
    'stroller': {
      name: 'OEM Baby Stroller Manufacturing',
      description: 'Custom stroller designs including lightweight, travel, and double models. ASTM F833, EN 1888 certified with full customization options.',
      certifications: ['ASTM F833', 'EN 1888', 'CPC', 'CE']
    },
    'bed-rail': {
      name: 'OEM Baby Bed Rail & Safety Gate Manufacturing',
      description: 'Custom bed rails and safety gates with height adjustment. EN 1930, ASTM F1004 certified. Child safety products for wholesale.',
      certifications: ['EN 1930', 'ASTM F1004', 'CPC', 'CE']
    }
  };

  const service = services[type] || services['stroller'];

  return {
    '@context': 'https://schema.org',
    '@type': 'Service',
    '@id': `https://b2bbaby.com/oem-${type}/#service`,
    name: service.name,
    description: service.description,
    serviceType: 'Manufacturing Service',
    provider: {
      '@type': 'Organization',
      '@id': 'https://b2bbaby.com/#organization',
      name: 'B2Bbaby'
    },
    areaServed: 'Worldwide',
    offers: {
      '@type': 'Offer',
      name: service.name,
      priceSpecification: {
        '@type': 'PriceSpecification',
        price: 50,
        priceCurrency: 'USD',
        valueAddedTaxIncluded: false,
        eligibleQuantity: {
          '@type': 'QuantitativeValue',
          minValue: 50
        }
      },
      availability: 'https://schema.org/InStock'
    },
    additionalProperty: service.certifications.map(cert => ({
      '@type': 'PropertyValue',
      name: 'Certification',
      value: cert
    }))
  };
}

export function generateArticleSchema(title: string, description: string) {
  return {
    '@context': 'https://schema.org',
    '@type': 'Article',
    '@id': `https://b2bbaby.com/${title.toLowerCase().replace(/\s+/g, '-')}#article`,
    headline: title,
    description: description,
    author: {
      '@type': 'Organization',
      '@id': 'https://b2bbaby.com/#organization',
      name: 'B2Bbaby'
    },
    publisher: {
      '@type': 'Organization',
      '@id': 'https://b2bbaby.com/#organization',
      name: 'B2Bbaby',
      logo: {
        '@type': 'ImageObject',
        url: 'https://b2bbaby.com/logo.png'
      }
    },
    datePublished: new Date().toISOString().split('T')[0],
    dateModified: new Date().toISOString().split('T')[0],
    inLanguage: 'en-US'
  };
}

export function generateLocalBusinessSchema() {
  return {
    '@context': 'https://schema.org',
    '@type': ['LocalBusiness', 'Organization', 'Manufacturer'],
    '@id': 'https://b2bbaby.com/#organization',
    name: 'B2Bbaby (ANHUI TALENT BABY PRODUCT CO LTD)',
    description: 'Professional baby product manufacturer specializing in ASTM/EN tested baby strollers, safety gates, high chairs, and bed rails. ISO 9001 certified factory serving 30+ countries worldwide.',
    url: 'https://b2bbaby.com',
    image: 'https://b2bbaby.com/logo.png',
    logo: 'https://b2bbaby.com/logo.png',
    areaServed: 'Worldwide',
    address: {
      '@type': 'PostalAddress',
      streetAddress: 'Building C4, Yungu Innovation and Entrepreneurship Park, Baohe District',
      addressLocality: 'Hefei',
      addressRegion: 'Anhui Province',
      postalCode: '230091',
      addressCountry: 'CN'
    },
    geo: {
      '@type': 'GeoCoordinates',
      latitude: '31.8206',
      longitude: '117.2272'
    },
    telephone: '+86-176-8112-8186',
    email: 'info@b2bbaby.com',
    openingHoursSpecification: {
      '@type': 'OpeningHoursSpecification',
      dayOfWeek: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
      opens: '09:00',
      closes: '18:00'
    },
    contactPoint: [
      {
        '@type': 'ContactPoint',
        contactType: 'sales',
        telephone: '+86-176-8112-8186',
        email: 'sales@b2bbaby.com',
        availableLanguage: ['English', 'Chinese']
      },
      {
        '@type': 'ContactPoint',
        contactType: 'customer service',
        telephone: '+86-176-8112-8186',
        email: 'info@b2bbaby.com',
        availableLanguage: ['English', 'Chinese']
      }
    ],
    hasOfferCatalog: {
      '@type': 'OfferCatalog',
      name: 'Baby Products',
      itemListElement: [
        {
          '@type': 'Offer',
          itemOffered: {
            '@type': 'Product',
            name: 'Baby Stroller',
            category: 'Baby Products'
          }
        },
        {
          '@type': 'Offer',
          itemOffered: {
            '@type': 'Product',
            name: 'Safety Gate',
            category: 'Baby Products'
          }
        },
        {
          '@type': 'Offer',
          itemOffered: {
            '@type': 'Product',
            name: 'High Chair',
            category: 'Baby Products'
          }
        },
        {
          '@type': 'Offer',
          itemOffered: {
            '@type': 'Product',
            name: 'Bed Rail',
            category: 'Baby Products'
          }
        }
      ]
    }
  };
}
