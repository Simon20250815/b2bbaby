import type { APIRoute } from 'astro';
import { exec } from 'child_process';
import { promisify } from 'util';

const execAsync = promisify(exec);

const previewServers = new Map<number, any>();

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
  for (const [port, process] of previewServers.entries()) {
    try {
      process.kill();
      previewServers.delete(port);
    } catch (e) {
      console.error(`Failed to kill preview server on port ${port}:`, e);
    }
  }
  
  const previewPort = 4323 + Math.floor(Math.random() * 100);
  
  try {
    const previewServerProcess = exec(
      `npm run dev -- --port ${previewPort}`,
      { cwd: './frontend' }
    );
    
    previewServers.set(previewPort, previewServerProcess);
    
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
  const stoppedServers = [];
  
  for (const [port, process] of previewServers.entries()) {
    try {
      process.kill();
      previewServers.delete(port);
      stoppedServers.push(port);
    } catch (error) {
      console.error(`Failed to stop preview server on port ${port}:`, error);
    }
  }
  
  if (stoppedServers.length > 0) {
    return new Response(
      JSON.stringify({ 
        success: true, 
        message: `Preview servers stopped on ports: ${stoppedServers.join(', ')}` 
      }),
      { headers: { 'Content-Type': 'application/json' } }
    );
  }
  
  return new Response(
    JSON.stringify({ success: true, message: 'No preview servers running' }),
    { headers: { 'Content-Type': 'application/json' } }
  );
}