-- Create missing collections
CREATE TABLE IF NOT EXISTS "about" (
  "id" SERIAL PRIMARY KEY,
  "company_name" VARCHAR(255),
  "company_name_en" VARCHAR(255),
  "description" TEXT,
  "description_en" TEXT,
  "story" TEXT,
  "story_en" TEXT,
  "founded" VARCHAR(50),
  "employees" INTEGER,
  "factories" INTEGER,
  "export_countries" INTEGER,
  "address" VARCHAR(500),
  "address_en" VARCHAR(500),
  "phone" VARCHAR(100),
  "email" VARCHAR(255),
  "certifications" JSON,
  "image" TEXT,
  "gallery_images" JSON,
  "status" VARCHAR(50) DEFAULT 'published',
  "date_created" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  "date_updated" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "oem_odm" (
  "id" SERIAL PRIMARY KEY,
  "title" VARCHAR(255),
  "title_en" VARCHAR(255),
  "description" TEXT,
  "description_en" TEXT,
  "services" JSON,
  "process_steps" JSON,
  "min_order" INTEGER,
  "lead_time" VARCHAR(100),
  "contact_email" VARCHAR(255),
  "image" TEXT,
  "gallery_images" JSON,
  "status" VARCHAR(50) DEFAULT 'published',
  "date_created" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  "date_updated" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "contact" (
  "id" SERIAL PRIMARY KEY,
  "company_name" VARCHAR(255),
  "company_name_en" VARCHAR(255),
  "address" TEXT,
  "address_en" TEXT,
  "phone" VARCHAR(100),
  "email" VARCHAR(255),
  "business_hours" VARCHAR(255),
  "map_location" VARCHAR(500),
  "status" VARCHAR(50) DEFAULT 'published',
  "date_created" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  "date_updated" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "site_settings" (
  "id" SERIAL PRIMARY KEY,
  "site_title" VARCHAR(255),
  "site_title_en" VARCHAR(255),
  "site_description" TEXT,
  "site_description_en" TEXT,
  "logo" TEXT,
  "favicon" TEXT,
  "social_links" JSON,
  "copyright" TEXT,
  "copyright_en" TEXT,
  "date_created" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  "date_updated" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "home" (
  "id" SERIAL PRIMARY KEY,
  "hero_title" VARCHAR(500),
  "hero_title_en" VARCHAR(500),
  "hero_subtitle" TEXT,
  "hero_subtitle_en" TEXT,
  "hero_cta" VARCHAR(255),
  "hero_cta_en" VARCHAR(255),
  "hero_image" TEXT,
  "featured_title" VARCHAR(255),
  "featured_title_en" VARCHAR(255),
  "featured_description" TEXT,
  "featured_description_en" TEXT,
  "status" VARCHAR(50) DEFAULT 'published',
  "date_created" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  "date_updated" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert initial data
INSERT INTO "site_settings" (
  "site_title", "site_title_en", "site_description", "site_description_en",
  "copyright", "copyright_en"
) VALUES (
  'B2B Baby - 婴儿产品供应商',
  'B2B Baby - Baby Product Supplier',
  '专业婴儿产品制造商，提供高品质的婴儿推车、安全门、餐椅等产品',
  'Professional baby product manufacturer, providing high quality strollers, safety gates, high chairs and more',
  '© 2025 B2B Baby. All rights reserved.',
  '© 2025 B2B Baby. All rights reserved.'
) ON CONFLICT DO NOTHING;

INSERT INTO "home" (
  "hero_title", "hero_title_en", "hero_subtitle", "hero_subtitle_en",
  "hero_cta", "hero_cta_en"
) VALUES (
  'ASTM/CE 认证的婴儿产品供应商',
  'ASTM/CE Certified Baby Product Supplier',
  '专业的制造商，高品质的婴儿推车、安全门、餐椅等产品，面向批发和OEM订单',
  'Professional manufacturer, high quality strollers, safety gates, high chairs for wholesale and OEM orders',
  '联系我们获取报价',
  'Contact us for quotation'
) ON CONFLICT DO NOTHING;

INSERT INTO "about" (
  "company_name", "company_name_en", "description", "description_en",
  "founded", "employees", "factories", "export_countries",
  "address", "address_en", "phone", "email", "certifications"
) VALUES (
  'B2B Baby 有限公司',
  'B2B Baby Co., Ltd.',
  '我们是专业的婴儿产品制造商，拥有超过15年的行业经验...',
  'We are a professional baby product manufacturer with over 15 years of industry experience...',
  '2009', 200, 2, 50,
  '中国浙江省宁波市鄞州区工业路123号',
  '123 Industrial Road, Yinzhou District, Ningbo, Zhejiang, China',
  '+86-574-12345678',
  'sales@b2bbaby.com',
  '["ASTM", "CE", "CPC", "EN71"]'
) ON CONFLICT DO NOTHING;

INSERT INTO "oem_odm" (
  "title", "title_en", "description", "description_en",
  "min_order", "lead_time", "contact_email"
) VALUES (
  'OEM/ODM 定制服务',
  'OEM/ODM Custom Services',
  '我们提供专业的OEM/ODM服务，包括产品定制、包装设计、品牌定制等',
  'We provide professional OEM/ODM services, including product customization, packaging design, brand customization, etc.',
  100, '25-35 days', 'oem@b2bbaby.com'
) ON CONFLICT DO NOTHING;

INSERT INTO "contact" (
  "company_name", "company_name_en", "address", "address_en",
  "phone", "email", "business_hours"
) VALUES (
  'B2B Baby 有限公司',
  'B2B Baby Co., Ltd.',
  '中国浙江省宁波市鄞州区工业路123号',
  '123 Industrial Road, Yinzhou District, Ningbo, Zhejiang, China',
  '+86-574-12345678',
  'sales@b2bbaby.com',
  'Monday - Friday, 9:00 AM - 6:00 PM (UTC+8)'
) ON CONFLICT DO NOTHING;