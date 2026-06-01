import { defineMiddleware } from 'astro:middleware';

export const onRequest = defineMiddleware(async (context, next) => {
  const res = await next();
  
  res.headers.set('X-Content-Type-Options', 'nosniff');
  res.headers.set('X-Frame-Options', 'DENY');
  res.headers.set('X-XSS-Protection', '1; mode=block');
  
  const url = context.url.pathname;
  if (url.match(/\.(jpg|jpeg|png|gif|webp|svg|ico)$/)) {
    res.headers.set('Cache-Control', 'public, max-age=31536000, immutable');
    res.headers.set('Accept-Ranges', 'bytes');
  } else if (url.match(/\.(css|js)$/)) {
    res.headers.set('Cache-Control', 'public, max-age=31536000, immutable');
  } else if (url.match(/\.(woff|woff2|ttf|eot)$/)) {
    res.headers.set('Cache-Control', 'public, max-age=31536000, immutable');
  } else {
    res.headers.set('Cache-Control', 'public, max-age=86400');
  }
  
  res.headers.set('Cross-Origin-Resource-Policy', 'same-origin');
  res.headers.set('Cross-Origin-Opener-Policy', 'same-origin');
  
  return res;
});