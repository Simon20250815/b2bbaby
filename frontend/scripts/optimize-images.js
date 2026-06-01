import fs from 'fs/promises';
import path from 'path';
import sharp from 'sharp';

// 使用 process.cwd() 获取当前工作目录，更可靠
const IMAGE_DIR = path.join(process.cwd(), 'public/images');
const QUALITY = 80;
const MAX_WIDTH = 1600;

async function optimizeImage(filePath) {
  try {
    const stats = await fs.stat(filePath);
    if (stats.size < 1024) return; // 跳过小于 1KB 的文件
    
    const ext = path.extname(filePath).toLowerCase();
    const baseName = path.basename(filePath, ext);
    const dirName = path.dirname(filePath);
    
    // 优化原始图片
    const inputBuffer = await fs.readFile(filePath);
    let sharpInstance = sharp(inputBuffer);
    
    // 获取原始尺寸
    const metadata = await sharpInstance.metadata();
    if (metadata.width && metadata.width > MAX_WIDTH) {
      sharpInstance = sharpInstance.resize(MAX_WIDTH);
    }
    
    // 优化并保存原始格式
    const optimizedBuffer = await sharpInstance
      .jpeg({ quality: QUALITY, progressive: true })
      .toBuffer();
    
    await fs.writeFile(filePath, optimizedBuffer);
    
    // 生成 WebP 版本
    const webpBuffer = await sharp(inputBuffer)
      .resize(MAX_WIDTH)
      .webp({ quality: QUALITY })
      .toBuffer();
    
    await fs.writeFile(path.join(dirName, `${baseName}.webp`), webpBuffer);
    
    console.log(`✓ Optimized: ${filePath}`);
  } catch (error) {
    console.error(`✗ Error optimizing ${filePath}:`, error.message);
  }
}

async function processDirectory(dir) {
  try {
    const files = await fs.readdir(dir);
    
    for (const file of files) {
      const filePath = path.join(dir, file);
      const stats = await fs.stat(filePath);
      
      if (stats.isDirectory()) {
        await processDirectory(filePath);
      } else {
        const ext = path.extname(file).toLowerCase();
        if (['.jpg', '.jpeg', '.png'].includes(ext)) {
          await optimizeImage(filePath);
        }
      }
    }
  } catch (error) {
    console.error(`✗ Error reading directory ${dir}:`, error.message);
  }
}

async function main() {
  console.log('=== Starting image optimization ===');
  console.log('Image directory:', IMAGE_DIR);
  
  try {
    await fs.access(IMAGE_DIR);
    await processDirectory(IMAGE_DIR);
    console.log('=== Image optimization complete ===');
  } catch (error) {
    console.error('✗ Image directory not found:', IMAGE_DIR);
    console.log('=== Skipping image optimization ===');
  }
}

main().catch(console.error);