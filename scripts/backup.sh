#!/bin/bash

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="backups"

echo "📦 创建备份目录..."
mkdir -p $BACKUP_DIR

echo "📄 备份数据库..."
docker-compose exec -T db pg_dump -U admin directus > "$BACKUP_DIR/db_backup_$DATE.sql"

echo "📁 备份上传文件..."
tar -czf "$BACKUP_DIR/uploads_backup_$DATE.tar.gz" -C directus/uploads .

echo "📝 备份数据文件..."
tar -czf "$BACKUP_DIR/data_backup_$DATE.tar.gz" data/

echo "✅ 备份完成!"
echo "📁 备份目录: $BACKUP_DIR"