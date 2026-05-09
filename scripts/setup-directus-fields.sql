-- Clear existing custom fields for clean slate
DELETE FROM directus_fields WHERE collection IN ('products', 'faqs', 'blogs');

-- Products Fields
INSERT INTO directus_fields (id, collection, field, type, schema, meta) VALUES
(1, 'products', 'slug', 'string', '{"max_length":255}', '{"interface":"input","options":{"placeholder":"product-url-slug"},"required":true,"readonly":false}'),
(2, 'products', 'title', 'string', '{"max_length":500}', '{"interface":"input","options":{"placeholder":"Product Name"},"required":true}'),
(3, 'products', 'title_en', 'string', '{"max_length":500}', '{"interface":"input","options":{"placeholder":"English Title"}}'),
(4, 'products', 'category', 'string', '{"max_length":100}', '{"interface":"select-dropdown","options":{"choices":[["Stroller","Stroller"],["Safety Gate","Safety Gate"],["High Chair","High Chair"],["Bed Rail","Bed Rail"]]}}'),
(5, 'products', 'description', 'text', '{}', '{"interface":"textarea","options":{"placeholder":"Product description in Chinese"}}'),
(6, 'products', 'description_en', 'text', '{}', '{"interface":"textarea","options":{"placeholder":"Product description in English"}}'),
(7, 'products', 'moq', 'integer', '{}', '{"interface":"input","options":{"placeholder":"Minimum Order Quantity"}}'),
(8, 'products', 'lead_time_sample', 'string', '{"max_length":100}', '{"interface":"input","options":{"placeholder":"7-10 days"}}'),
(9, 'products', 'lead_time_production', 'string', '{"max_length":100}', '{"interface":"input","options":{"placeholder":"15-25 days"}}'),
(10, 'products', 'certifications', 'json', '{}', '{"interface":"tags","options":{"placeholder":"ASTM, CE, CPC"}}'),
(11, 'products', 'target_markets', 'json', '{}', '{"interface":"tags","options":{"placeholder":"US, EU, Canada"}}'),
(12, 'products', 'image', 'text', '{}', '{"interface":"file-image","options":{}}'),
(13, 'products', 'gallery_images', 'json', '{}', '{"interface":"files","options":{}}'),
(14, 'products', 'specs', 'json', '{}', '{"interface":"repeatable","options":{"fields":[{"field":"label","name":"Label","type":"string","meta":{"interface":"input"}},{"field":"value","name":"Value","type":"string","meta":{"interface":"input"}}]}}}'),
(15, 'products', 'features', 'json', '{}', '{"interface":"repeatable","options":{"fields":[{"field":"text","name":"Feature","type":"string","meta":{"interface":"input"}}]}}}'),
(16, 'products', 'custom_options', 'json', '{}', '{"interface":"repeatable","options":{"fields":[{"field":"name","name":"Option Name","type":"string","meta":{"interface":"input"}},{"field":"price","name":"Price","type":"decimal","meta":{"interface":"input"}}]}}}'),
(17, 'products', 'status', 'string', '{"max_length":50}', '{"interface":"select-dropdown","options":{"choices":[["draft","Draft"],["published","Published"]]}}'),
(18, 'products', 'sort', 'integer', '{}', '{"interface":"input","options":{"placeholder":"0"}}');

-- FAQs Fields
INSERT INTO directus_fields (id, collection, field, type, schema, meta) VALUES
(101, 'faqs', 'question', 'string', '{"max_length":500}', '{"interface":"input","options":{"placeholder":"Question in Chinese"},"required":true}'),
(102, 'faqs', 'question_en', 'string', '{"max_length":500}', '{"interface":"input","options":{"placeholder":"Question in English"}}'),
(103, 'faqs', 'answer', 'text', '{}', '{"interface":"textarea","options":{"placeholder":"Answer in Chinese","rows":5}}'),
(104, 'faqs', 'answer_en', 'text', '{}', '{"interface":"textarea","options":{"placeholder":"Answer in English","rows":5}}'),
(105, 'faqs', 'category', 'string', '{"max_length":100}', '{"interface":"select-dropdown","options":{"choices":[["Products","Products"],["Orders","Orders"],["Shipping","Shipping"],["Customs","Customs"],["Payment","Payment"]]}}'),
(106, 'faqs', 'sort', 'integer', '{}', '{"interface":"input","options":{"placeholder":"0"}}');

-- Blogs Fields
INSERT INTO directus_fields (id, collection, field, type, schema, meta) VALUES
(201, 'blogs', 'slug', 'string', '{"max_length":255}', '{"interface":"input","options":{"placeholder":"blog-url-slug"},"required":true}'),
(202, 'blogs', 'title', 'string', '{"max_length":500}', '{"interface":"input","options":{"placeholder":"Blog Title in Chinese"},"required":true}'),
(203, 'blogs', 'title_en', 'string', '{"max_length":500}', '{"interface":"input","options":{"placeholder":"Blog Title in English"}}'),
(204, 'blogs', 'excerpt', 'text', '{}', '{"interface":"textarea","options":{"placeholder":"Short summary in Chinese","rows":3}}'),
(205, 'blogs', 'excerpt_en', 'text', '{}', '{"interface":"textarea","options":{"placeholder":"Short summary in English","rows":3}}'),
(206, 'blogs', 'content', 'text', '{}', '{"interface":"textarea","options":{"placeholder":"Blog content in Chinese","rows":10}}'),
(207, 'blogs', 'content_en', 'text', '{}', '{"interface":"textarea","options":{"placeholder":"Blog content in English","rows":10}}'),
(208, 'blogs', 'cover_image', 'text', '{}', '{"interface":"file-image","options":{}}'),
(209, 'blogs', 'author', 'string', '{"max_length":200}', '{"interface":"input","options":{"placeholder":"Author Name"}}'),
(210, 'blogs', 'tags', 'json', '{}', '{"interface":"tags","options":{"placeholder":"baby, stroller, safety"}}'),
(211, 'blogs', 'date_published', 'datetime', '{}', '{"interface":"datetime","options":{}}'),
(212, 'blogs', 'status', 'string', '{"max_length":50}', '{"interface":"select-dropdown","options":{"choices":[["draft","Draft"],["published","Published"]]}}');
