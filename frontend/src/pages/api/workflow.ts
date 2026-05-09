import type { APIRoute } from 'astro';
import { exec } from 'child_process';
import { promisify } from 'util';

const execAsync = promisify(exec);

let previewServerProcess = null;
let previewPort = 4323;

export const POST: APIRoute = async ({ request }) => {
  const { action } = await request.json();
  
  if (action === 'preview') {
    return handlePreview();
  } else if (action === 'publish') {
    return handlePublish();
  } else if (action === 'stop-preview') {
    return handleStopPreview();
  }
  
  return new Response(
    JSON.stringify({ success: false, error: 'Unknown action' }),
    { status: 400 }
  );
};

async function handlePreview() {
  if (previewServerProcess) {
    try {
      previewServerProcess.kill();
    } catch (e) {}
  }
  
  previewPort = 4323 + Math.floor(Math.random() * 100);
  
  try {
    previewServerProcess = exec(
      `npm run dev -- --port ${previewPort}`,
      { cwd: './frontend' }
    );
    
    await new Promise(resolve => setTimeout(resolve, 3000));
    
    return new Response(
      JSON.stringify({ 
        success: true, 
        previewUrl: `http://localhost:${previewPort}`,
        message: 'Preview server started'
      }),
      { headers: { 'Content-Type': 'application/json' } }
    );
  } catch (error) {
    return new Response(
      JSON.stringify({ success: false, error: error.message }),
      { status: 500 }
    );
  }
}

async function handlePublish() {
  try {
    const { stdout, stderr } = await execAsync(
      'npm run build',
      { cwd: './frontend', timeout: 180000 }
    );
    
    if (stderr) console.log('Build stderr:', stderr);
    
    return new Response(
      JSON.stringify({ 
        success: true, 
        message: 'Website published successfully!',
        buildOutput: stdout.slice(-500)
      }),
      { headers: { 'Content-Type': 'application/json' } }
    );
  } catch (error) {
    return new Response(
      JSON.stringify({ success: false, error: error.message }),
      { status: 500 }
    );
  }
}

async function handleStopPreview() {
  if (previewServerProcess) {
    try {
      previewServerProcess.kill();
      previewServerProcess = null;
      return new Response(
        JSON.stringify({ success: true, message: 'Preview server stopped' }),
        { headers: { 'Content-Type': 'application/json' } }
      );
    } catch (error) {
      return new Response(
        JSON.stringify({ success: false, error: error.message }),
        { status: 500 }
      );
    }
  }
  
  return new Response(
    JSON.stringify({ success: true, message: 'No preview server running' }),
    { headers: { 'Content-Type': 'application/json' } }
  );
}