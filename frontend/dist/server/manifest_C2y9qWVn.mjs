import '@astrojs/internal-helpers/path';
import 'cookie';
import 'kleur/colors';
import { N as NOOP_MIDDLEWARE_FN } from './chunks/astro-designed-error-pages_DL41QJ01.mjs';
import 'es-module-lexer';
import { n as decodeKey } from './chunks/astro/server_DSxN40bN.mjs';
import 'clsx';

function sanitizeParams(params) {
  return Object.fromEntries(
    Object.entries(params).map(([key, value]) => {
      if (typeof value === "string") {
        return [key, value.normalize().replace(/#/g, "%23").replace(/\?/g, "%3F")];
      }
      return [key, value];
    })
  );
}
function getParameter(part, params) {
  if (part.spread) {
    return params[part.content.slice(3)] || "";
  }
  if (part.dynamic) {
    if (!params[part.content]) {
      throw new TypeError(`Missing parameter: ${part.content}`);
    }
    return params[part.content];
  }
  return part.content.normalize().replace(/\?/g, "%3F").replace(/#/g, "%23").replace(/%5B/g, "[").replace(/%5D/g, "]");
}
function getSegment(segment, params) {
  const segmentPath = segment.map((part) => getParameter(part, params)).join("");
  return segmentPath ? "/" + segmentPath : "";
}
function getRouteGenerator(segments, addTrailingSlash) {
  return (params) => {
    const sanitizedParams = sanitizeParams(params);
    let trailing = "";
    if (addTrailingSlash === "always" && segments.length) {
      trailing = "/";
    }
    const path = segments.map((segment) => getSegment(segment, sanitizedParams)).join("") + trailing;
    return path || "/";
  };
}

function deserializeRouteData(rawRouteData) {
  return {
    route: rawRouteData.route,
    type: rawRouteData.type,
    pattern: new RegExp(rawRouteData.pattern),
    params: rawRouteData.params,
    component: rawRouteData.component,
    generate: getRouteGenerator(rawRouteData.segments, rawRouteData._meta.trailingSlash),
    pathname: rawRouteData.pathname || void 0,
    segments: rawRouteData.segments,
    prerender: rawRouteData.prerender,
    redirect: rawRouteData.redirect,
    redirectRoute: rawRouteData.redirectRoute ? deserializeRouteData(rawRouteData.redirectRoute) : void 0,
    fallbackRoutes: rawRouteData.fallbackRoutes.map((fallback) => {
      return deserializeRouteData(fallback);
    }),
    isIndex: rawRouteData.isIndex
  };
}

function deserializeManifest(serializedManifest) {
  const routes = [];
  for (const serializedRoute of serializedManifest.routes) {
    routes.push({
      ...serializedRoute,
      routeData: deserializeRouteData(serializedRoute.routeData)
    });
    const route = serializedRoute;
    route.routeData = deserializeRouteData(serializedRoute.routeData);
  }
  const assets = new Set(serializedManifest.assets);
  const componentMetadata = new Map(serializedManifest.componentMetadata);
  const inlinedScripts = new Map(serializedManifest.inlinedScripts);
  const clientDirectives = new Map(serializedManifest.clientDirectives);
  const serverIslandNameMap = new Map(serializedManifest.serverIslandNameMap);
  const key = decodeKey(serializedManifest.key);
  return {
    // in case user middleware exists, this no-op middleware will be reassigned (see plugin-ssr.ts)
    middleware() {
      return { onRequest: NOOP_MIDDLEWARE_FN };
    },
    ...serializedManifest,
    assets,
    componentMetadata,
    inlinedScripts,
    clientDirectives,
    routes,
    serverIslandNameMap,
    key
  };
}

const manifest = deserializeManifest({"hrefRoot":"file:///C:/Users/Administrator/Desktop/b2bbaby/newbaby/frontend/","adapterName":"@astrojs/node","routes":[{"file":"about/index.html","links":[],"scripts":[],"styles":[],"routeData":{"route":"/about","isIndex":true,"type":"page","pattern":"^\\/about\\/?$","segments":[[{"content":"about","dynamic":false,"spread":false}]],"params":[],"component":"src/pages/about/index.astro","pathname":"/about","prerender":true,"fallbackRoutes":[],"_meta":{"trailingSlash":"ignore"}}},{"file":"api/build","links":[],"scripts":[],"styles":[],"routeData":{"route":"/api/build","isIndex":false,"type":"endpoint","pattern":"^\\/api\\/build\\/?$","segments":[[{"content":"api","dynamic":false,"spread":false}],[{"content":"build","dynamic":false,"spread":false}]],"params":[],"component":"src/pages/api/build.ts","pathname":"/api/build","prerender":true,"fallbackRoutes":[],"_meta":{"trailingSlash":"ignore"}}},{"file":"api/workflow","links":[],"scripts":[],"styles":[],"routeData":{"route":"/api/workflow","isIndex":false,"type":"endpoint","pattern":"^\\/api\\/workflow\\/?$","segments":[[{"content":"api","dynamic":false,"spread":false}],[{"content":"workflow","dynamic":false,"spread":false}]],"params":[],"component":"src/pages/api/workflow.ts","pathname":"/api/workflow","prerender":true,"fallbackRoutes":[],"_meta":{"trailingSlash":"ignore"}}},{"file":"blog/index.html","links":[],"scripts":[],"styles":[],"routeData":{"route":"/blog","isIndex":true,"type":"page","pattern":"^\\/blog\\/?$","segments":[[{"content":"blog","dynamic":false,"spread":false}]],"params":[],"component":"src/pages/blog/index.astro","pathname":"/blog","prerender":true,"fallbackRoutes":[],"_meta":{"trailingSlash":"ignore"}}},{"file":"contact/index.html","links":[],"scripts":[],"styles":[],"routeData":{"route":"/contact","isIndex":true,"type":"page","pattern":"^\\/contact\\/?$","segments":[[{"content":"contact","dynamic":false,"spread":false}]],"params":[],"component":"src/pages/contact/index.astro","pathname":"/contact","prerender":true,"fallbackRoutes":[],"_meta":{"trailingSlash":"ignore"}}},{"file":"faq/index.html","links":[],"scripts":[],"styles":[],"routeData":{"route":"/faq","isIndex":true,"type":"page","pattern":"^\\/faq\\/?$","segments":[[{"content":"faq","dynamic":false,"spread":false}]],"params":[],"component":"src/pages/faq/index.astro","pathname":"/faq","prerender":true,"fallbackRoutes":[],"_meta":{"trailingSlash":"ignore"}}},{"file":"oem-odm/index.html","links":[],"scripts":[],"styles":[],"routeData":{"route":"/oem-odm","isIndex":true,"type":"page","pattern":"^\\/oem-odm\\/?$","segments":[[{"content":"oem-odm","dynamic":false,"spread":false}]],"params":[],"component":"src/pages/oem-odm/index.astro","pathname":"/oem-odm","prerender":true,"fallbackRoutes":[],"_meta":{"trailingSlash":"ignore"}}},{"file":"products/index.html","links":[],"scripts":[],"styles":[],"routeData":{"route":"/products","isIndex":true,"type":"page","pattern":"^\\/products\\/?$","segments":[[{"content":"products","dynamic":false,"spread":false}]],"params":[],"component":"src/pages/products/index.astro","pathname":"/products","prerender":true,"fallbackRoutes":[],"_meta":{"trailingSlash":"ignore"}}},{"file":"index.html","links":[],"scripts":[],"styles":[],"routeData":{"route":"/","isIndex":true,"type":"page","pattern":"^\\/$","segments":[],"params":[],"component":"src/pages/index.astro","pathname":"/","prerender":true,"fallbackRoutes":[],"_meta":{"trailingSlash":"ignore"}}},{"file":"","links":[],"scripts":[],"styles":[],"routeData":{"type":"endpoint","isIndex":false,"route":"/_image","pattern":"^\\/_image$","segments":[[{"content":"_image","dynamic":false,"spread":false}]],"params":[],"component":"node_modules/astro/dist/assets/endpoint/node.js","pathname":"/_image","prerender":false,"fallbackRoutes":[],"_meta":{"trailingSlash":"ignore"}}}],"site":"https://b2bbaby.com","base":"/","trailingSlash":"ignore","compressHTML":true,"componentMetadata":[["C:/Users/Administrator/Desktop/b2bbaby/newbaby/frontend/src/pages/about/index.astro",{"propagation":"none","containsHead":true}],["C:/Users/Administrator/Desktop/b2bbaby/newbaby/frontend/src/pages/blog/[slug]/index.astro",{"propagation":"none","containsHead":true}],["C:/Users/Administrator/Desktop/b2bbaby/newbaby/frontend/src/pages/blog/index.astro",{"propagation":"none","containsHead":true}],["C:/Users/Administrator/Desktop/b2bbaby/newbaby/frontend/src/pages/contact/index.astro",{"propagation":"none","containsHead":true}],["C:/Users/Administrator/Desktop/b2bbaby/newbaby/frontend/src/pages/faq/index.astro",{"propagation":"none","containsHead":true}],["C:/Users/Administrator/Desktop/b2bbaby/newbaby/frontend/src/pages/index.astro",{"propagation":"none","containsHead":true}],["C:/Users/Administrator/Desktop/b2bbaby/newbaby/frontend/src/pages/oem-odm/index.astro",{"propagation":"none","containsHead":true}],["C:/Users/Administrator/Desktop/b2bbaby/newbaby/frontend/src/pages/products/[slug].astro",{"propagation":"none","containsHead":true}],["C:/Users/Administrator/Desktop/b2bbaby/newbaby/frontend/src/pages/products/index.astro",{"propagation":"none","containsHead":true}]],"renderers":[],"clientDirectives":[["idle","(()=>{var l=(o,t)=>{let i=async()=>{await(await o())()},e=typeof t.value==\"object\"?t.value:void 0,s={timeout:e==null?void 0:e.timeout};\"requestIdleCallback\"in window?window.requestIdleCallback(i,s):setTimeout(i,s.timeout||200)};(self.Astro||(self.Astro={})).idle=l;window.dispatchEvent(new Event(\"astro:idle\"));})();"],["load","(()=>{var e=async t=>{await(await t())()};(self.Astro||(self.Astro={})).load=e;window.dispatchEvent(new Event(\"astro:load\"));})();"],["media","(()=>{var s=(i,t)=>{let a=async()=>{await(await i())()};if(t.value){let e=matchMedia(t.value);e.matches?a():e.addEventListener(\"change\",a,{once:!0})}};(self.Astro||(self.Astro={})).media=s;window.dispatchEvent(new Event(\"astro:media\"));})();"],["only","(()=>{var e=async t=>{await(await t())()};(self.Astro||(self.Astro={})).only=e;window.dispatchEvent(new Event(\"astro:only\"));})();"],["visible","(()=>{var l=(s,i,o)=>{let r=async()=>{await(await s())()},t=typeof i.value==\"object\"?i.value:void 0,c={rootMargin:t==null?void 0:t.rootMargin},n=new IntersectionObserver(e=>{for(let a of e)if(a.isIntersecting){n.disconnect(),r();break}},c);for(let e of o.children)n.observe(e)};(self.Astro||(self.Astro={})).visible=l;window.dispatchEvent(new Event(\"astro:visible\"));})();"]],"entryModules":{"\u0000noop-middleware":"_noop-middleware.mjs","\u0000@astro-page:node_modules/astro/dist/assets/endpoint/node@_@js":"pages/_image.astro.mjs","\u0000@astro-page:src/pages/about/index@_@astro":"pages/about.astro.mjs","\u0000@astro-page:src/pages/api/build@_@ts":"pages/api/build.astro.mjs","\u0000@astro-page:src/pages/api/workflow@_@ts":"pages/api/workflow.astro.mjs","\u0000@astro-page:src/pages/blog/[slug]/index@_@astro":"pages/blog/_slug_.astro.mjs","\u0000@astro-page:src/pages/blog/index@_@astro":"pages/blog.astro.mjs","\u0000@astro-page:src/pages/contact/index@_@astro":"pages/contact.astro.mjs","\u0000@astro-page:src/pages/faq/index@_@astro":"pages/faq.astro.mjs","\u0000@astro-page:src/pages/oem-odm/index@_@astro":"pages/oem-odm.astro.mjs","\u0000@astro-page:src/pages/products/[slug]@_@astro":"pages/products/_slug_.astro.mjs","\u0000@astro-page:src/pages/products/index@_@astro":"pages/products.astro.mjs","\u0000@astro-page:src/pages/index@_@astro":"pages/index.astro.mjs","\u0000@astrojs-ssr-virtual-entry":"entry.mjs","\u0000@astro-renderers":"renderers.mjs","\u0000@astrojs-ssr-adapter":"_@astrojs-ssr-adapter.mjs","\u0000@astrojs-manifest":"manifest_C2y9qWVn.mjs","astro:scripts/before-hydration.js":""},"inlinedScripts":[],"assets":["/_astro/index.BAAmLGUF.css","/ai-guidelines.md","/llms.txt","/logo.svg","/robots.txt","/sitemap.xml","/about/index.html","/api/build","/api/workflow","/blog/index.html","/contact/index.html","/faq/index.html","/oem-odm/index.html","/products/index.html","/index.html"],"buildFormat":"directory","checkOrigin":false,"serverIslandNameMap":[],"key":"xIiUp9aias/a6ItmI50/imm6DS9t04CCEPQ5OVs3JgA=","experimentalEnvGetSecretEnabled":false});

export { manifest };
