import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import node from '@astrojs/node';

export default defineConfig({
  site: 'https://b2bbaby.com',
  output: 'hybrid',
  adapter: node({ 
    mode: 'standalone',
    serverHost: '0.0.0.0',
    serverPort: 4321,
  }),
  integrations: [tailwind()],
  build: {
    concurrency: 2,
  },
  vite: {
    server: {
      host: '0.0.0.0',
      port: 4321,
    },
    ssr: {
      resolve: {
        conditions: ['production'],
      },
    },
    build: {
      rollupOptions: {
        output: {
          manualChunks: {
            vendor: ['react', 'react-dom'],
          },
        },
      },
      minify: 'esbuild',
      assetsInlineLimit: 4096,
    },
  },
});