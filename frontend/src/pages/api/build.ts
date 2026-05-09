import type { APIRoute } from 'astro';
import { exec } from 'child_process';
import { promisify } from 'util';

const execAsync = promisify(exec);

export const POST: APIRoute = async () => {
  try {
    const { stdout, stderr } = await execAsync(
      'npm run build',
      { cwd: './frontend', timeout: 180000 }
    );
    
    console.log('Build stdout:', stdout);
    if (stderr) console.log('Build stderr:', stderr);
    
    return new Response(
      JSON.stringify({ success: true, message: 'Build completed' }),
      { headers: { 'Content-Type': 'application/json' } }
    );
  } catch (error) {
    console.error('Build failed:', error);
    return new Response(
      JSON.stringify({ success: false, error: error.message }),
      { headers: { 'Content-Type': 'application/json' }, status: 500 }
    );
  }
};

export const GET: APIRoute = () => {
  return new Response(
    JSON.stringify({ message: 'Build API ready' }),
    { headers: { 'Content-Type': 'application/json' } }
  );
};