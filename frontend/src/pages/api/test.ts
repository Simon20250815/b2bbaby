import type { APIRoute } from 'astro';

export const prerender = false;

export const GET: APIRoute = () => {
  return new Response(
    JSON.stringify({ message: 'API is working!', timestamp: new Date().toISOString() }),
    { headers: { 'Content-Type': 'application/json' } }
  );
};

export const POST: APIRoute = async ({ request }) => {
  const data = await request.json();
  return new Response(
    JSON.stringify({ message: 'POST received', data }),
    { headers: { 'Content-Type': 'application/json' } }
  );
};
