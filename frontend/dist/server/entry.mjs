import { renderers } from './renderers.mjs';
import { c as createExports, s as serverEntrypointModule } from './chunks/_@astrojs-ssr-adapter_Ce0HJwrO.mjs';
import { manifest } from './manifest_YFnRemcB.mjs';

const _page0 = () => import('./pages/_image.astro.mjs');
const _page1 = () => import('./pages/about.astro.mjs');
const _page2 = () => import('./pages/ai-agent-guidelines.astro.mjs');
const _page3 = () => import('./pages/api/build.astro.mjs');
const _page4 = () => import('./pages/api/send-email.json.astro.mjs');
const _page5 = () => import('./pages/api/test.astro.mjs');
const _page6 = () => import('./pages/api/workflow.astro.mjs');
const _page7 = () => import('./pages/baby-bed-rail-factory.astro.mjs');
const _page8 = () => import('./pages/baby-stroller-factory.astro.mjs');
const _page9 = () => import('./pages/blog/topics.astro.mjs');
const _page10 = () => import('./pages/blog/_slug_.astro.mjs');
const _page11 = () => import('./pages/blog.astro.mjs');
const _page12 = () => import('./pages/contact.astro.mjs');
const _page13 = () => import('./pages/content-standards.astro.mjs');
const _page14 = () => import('./pages/faq.astro.mjs');
const _page15 = () => import('./pages/for-ai.astro.mjs');
const _page16 = () => import('./pages/oem-baby-high-chair-factory.astro.mjs');
const _page17 = () => import('./pages/oem-odm.astro.mjs');
const _page18 = () => import('./pages/products/_slug_.astro.mjs');
const _page19 = () => import('./pages/products.astro.mjs');
const _page20 = () => import('./pages/quote.astro.mjs');
const _page21 = () => import('./pages/shipping-proof/_slug_.astro.mjs');
const _page22 = () => import('./pages/shipping-proof.astro.mjs');
const _page23 = () => import('./pages/test-email.astro.mjs');
const _page24 = () => import('./pages/index.astro.mjs');

const pageMap = new Map([
    ["node_modules/astro/dist/assets/endpoint/node.js", _page0],
    ["src/pages/about/index.astro", _page1],
    ["src/pages/ai-agent-guidelines.astro", _page2],
    ["src/pages/api/build.ts", _page3],
    ["src/pages/api/send-email.json.ts", _page4],
    ["src/pages/api/test.ts", _page5],
    ["src/pages/api/workflow.ts", _page6],
    ["src/pages/baby-bed-rail-factory.astro", _page7],
    ["src/pages/baby-stroller-factory.astro", _page8],
    ["src/pages/blog/topics/index.astro", _page9],
    ["src/pages/blog/[slug]/index.astro", _page10],
    ["src/pages/blog/index.astro", _page11],
    ["src/pages/contact/index.astro", _page12],
    ["src/pages/content-standards.astro", _page13],
    ["src/pages/faq/index.astro", _page14],
    ["src/pages/for-ai.astro", _page15],
    ["src/pages/oem-baby-high-chair-factory.astro", _page16],
    ["src/pages/oem-odm/index.astro", _page17],
    ["src/pages/products/[slug].astro", _page18],
    ["src/pages/products/index.astro", _page19],
    ["src/pages/quote/index.astro", _page20],
    ["src/pages/shipping-proof/[slug].astro", _page21],
    ["src/pages/shipping-proof/index.astro", _page22],
    ["src/pages/test-email.astro", _page23],
    ["src/pages/index.astro", _page24]
]);
const serverIslandMap = new Map();
const _manifest = Object.assign(manifest, {
    pageMap,
    serverIslandMap,
    renderers,
    middleware: () => import('./_astro-internal_middleware.mjs')
});
const _args = {
    "mode": "standalone",
    "serverHost": "0.0.0.0",
    "serverPort": 4321,
    "client": "file:///D:/b2bbaby/frontend/dist/client/",
    "server": "file:///D:/b2bbaby/frontend/dist/server/",
    "host": false,
    "port": 4321,
    "assets": "_astro"
};
const _exports = createExports(_manifest, _args);
const handler = _exports['handler'];
const startServer = _exports['startServer'];
const options = _exports['options'];
const _start = 'start';
{
	serverEntrypointModule[_start](_manifest, _args);
}

export { handler, options, pageMap, startServer };
