import { renderers } from './renderers.mjs';
import { c as createExports, s as serverEntrypointModule } from './chunks/_@astrojs-ssr-adapter_CIISi1fh.mjs';
import { manifest } from './manifest_C2y9qWVn.mjs';

const _page0 = () => import('./pages/_image.astro.mjs');
const _page1 = () => import('./pages/about.astro.mjs');
const _page2 = () => import('./pages/api/build.astro.mjs');
const _page3 = () => import('./pages/api/workflow.astro.mjs');
const _page4 = () => import('./pages/blog/_slug_.astro.mjs');
const _page5 = () => import('./pages/blog.astro.mjs');
const _page6 = () => import('./pages/contact.astro.mjs');
const _page7 = () => import('./pages/faq.astro.mjs');
const _page8 = () => import('./pages/oem-odm.astro.mjs');
const _page9 = () => import('./pages/products/_slug_.astro.mjs');
const _page10 = () => import('./pages/products.astro.mjs');
const _page11 = () => import('./pages/index.astro.mjs');

const pageMap = new Map([
    ["node_modules/astro/dist/assets/endpoint/node.js", _page0],
    ["src/pages/about/index.astro", _page1],
    ["src/pages/api/build.ts", _page2],
    ["src/pages/api/workflow.ts", _page3],
    ["src/pages/blog/[slug]/index.astro", _page4],
    ["src/pages/blog/index.astro", _page5],
    ["src/pages/contact/index.astro", _page6],
    ["src/pages/faq/index.astro", _page7],
    ["src/pages/oem-odm/index.astro", _page8],
    ["src/pages/products/[slug].astro", _page9],
    ["src/pages/products/index.astro", _page10],
    ["src/pages/index.astro", _page11]
]);
const serverIslandMap = new Map();
const _manifest = Object.assign(manifest, {
    pageMap,
    serverIslandMap,
    renderers,
    middleware: () => import('./_noop-middleware.mjs')
});
const _args = {
    "mode": "standalone",
    "client": "file:///C:/Users/Administrator/Desktop/b2bbaby/newbaby/frontend/dist/client/",
    "server": "file:///C:/Users/Administrator/Desktop/b2bbaby/newbaby/frontend/dist/server/",
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
