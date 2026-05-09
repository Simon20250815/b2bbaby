const fetch = require('node:fetch');

const DIRECTUS_URL = 'http://localhost:8055';
const EMAIL = 'admin@b2bbaby.com';
const PASSWORD = 'admin_password_2026';

async function login() {
  const response = await fetch(`${DIRECTUS_URL}/auth/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email: EMAIL, password: PASSWORD })
  });
  
  if (!response.ok) {
    throw new Error('Login failed');
  }
  
  const data = await response.json();
  return data.data.access_token;
}

async function createCollection(token, collection) {
  const response = await fetch(`${DIRECTUS_URL}/collections`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`
    },
    body: JSON.stringify(collection)
  });
  
  if (!response.ok) {
    const error = await response.text();
    console.log(`Collection ${collection.collection} creation response:`, response.status, error);
    return;
  }
  
  const data = await response.json();
  console.log(`✓ Created collection: ${collection.collection}`);
  return data;
}

async function createField(token, collection, field) {
  const response = await fetch(`${DIRECTUS_URL}/fields/${collection}`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`
    },
    body: JSON.stringify(field)
  });
  
  if (!response.ok) {
    console.log(`Field ${field.field} for ${collection}:`, response.status);
    return;
  }
  
  console.log(`  ✓ Field: ${field.field}`);
}

async function setupCollections() {
  console.log('🔐 Logging in to Directus...');
  const token = await login();
  console.log('✅ Logged in!\n');

  console.log('📦 Creating Products collection...');
  await createCollection(token, {
    collection: 'products',
    meta: { singleton: false },
    schema: { name: 'products' }
  });

  const productFields = [
    { field: 'slug', type: 'string', meta: { required: true } },
    { field: 'title', type: 'string', meta: { required: true } },
    { field: 'title_en', type: 'string' },
    { field: 'category', type: 'string' },
    { field: 'description', type: 'text' },
    { field: 'description_en', type: 'text' },
    { field: 'moq', type: 'integer' },
    { field: 'lead_time_sample', type: 'string' },
    { field: 'lead_time_production', type: 'string' },
    { field: 'certifications', type: 'json' },
    { field: 'target_markets', type: 'json' },
    { field: 'test_report_number', type: 'string' },
    { field: 'export_batches', type: 'integer' },
    { field: 'zero_return_rate', type: 'boolean' },
    { field: 'image', type: 'text' },
    { field: 'gallery_images', type: 'json' },
    { field: 'specs', type: 'json' },
    { field: 'custom_options', type: 'json' },
    { field: 'features', type: 'json' },
    { field: 'applications', type: 'json' },
    { field: 'packaging', type: 'text' },
    { field: 'status', type: 'string', meta: { default_value: 'draft' } },
    { field: 'sort', type: 'integer', meta: { default_value: 0 } }
  ];

  for (const field of productFields) {
    await createField(token, 'products', field);
  }

  console.log('\n📦 Creating FAQs collection...');
  await createCollection(token, {
    collection: 'faqs',
    meta: { singleton: false },
    schema: { name: 'faqs' }
  });

  const faqFields = [
    { field: 'question', type: 'string', meta: { required: true } },
    { field: 'question_en', type: 'string' },
    { field: 'answer', type: 'text' },
    { field: 'answer_en', type: 'text' },
    { field: 'category', type: 'string' },
    { field: 'sort', type: 'integer', meta: { default_value: 0 } }
  ];

  for (const field of faqFields) {
    await createField(token, 'faqs', field);
  }

  console.log('\n📦 Creating Blogs collection...');
  await createCollection(token, {
    collection: 'blogs',
    meta: { singleton: false },
    schema: { name: 'blogs' }
  });

  const blogFields = [
    { field: 'slug', type: 'string', meta: { required: true } },
    { field: 'title', type: 'string', meta: { required: true } },
    { field: 'title_en', type: 'string' },
    { field: 'excerpt', type: 'text' },
    { field: 'excerpt_en', type: 'text' },
    { field: 'content', type: 'text' },
    { field: 'content_en', type: 'text' },
    { field: 'cover_image', type: 'text' },
    { field: 'author', type: 'string' },
    { field: 'tags', type: 'json' },
    { field: 'date_published', type: 'datetime' },
    { field: 'status', type: 'string', meta: { default_value: 'draft' } }
  ];

  for (const field of blogFields) {
    await createField(token, 'blogs', field);
  }

  console.log('\n📦 Creating Inquiries collection...');
  await createCollection(token, {
    collection: 'inquiries',
    meta: { singleton: false },
    schema: { name: 'inquiries' }
  });

  const inquiryFields = [
    { field: 'name', type: 'string', meta: { required: true } },
    { field: 'email', type: 'string', meta: { required: true } },
    { field: 'company', type: 'string' },
    { field: 'phone', type: 'string' },
    { field: 'product', type: 'string' },
    { field: 'message', type: 'text' },
    { field: 'status', type: 'string', meta: { default_value: 'new' } }
  ];

  for (const field of inquiryFields) {
    await createField(token, 'inquiries', field);
  }

  console.log('\n✅ Directus data model setup complete!');
  console.log('\n📋 Collections created:');
  console.log('   - products (产品)');
  console.log('   - faqs (常见问题)');
  console.log('   - blogs (博客)');
  console.log('   - inquiries (询盘)');
}

setupCollections().catch(console.error);