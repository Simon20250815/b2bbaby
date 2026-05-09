import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import node from '@astrojs/node';

export default defineConfig({
  site: 'https://b2bbaby.com',
  output: 'hybrid',
  adapter: node({ mode: 'standalone' }),
  integrations: [tailwind()],
  build: {
    concurrency: 2,
  },
  vite: {
    server: {
      host: true,
    },
  },
});
