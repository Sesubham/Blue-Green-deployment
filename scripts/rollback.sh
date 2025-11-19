#!/bin/bash

set -e

NGINX_CONF="nginx/nginx.conf"
BACKUP_CONF="nginx/nginx.conf.backup"

if [ ! -f "$BACKUP_CONF" ]; then
    echo "❌ No backup configuration found!"
    echo "Cannot rollback without a backup."
    exit 1
fi

echo "⚠️  Rolling back to previous configuration..."

# Restore backup
cp "$BACKUP_CONF" "$NGINX_CONF"

# Reload NGINX
docker exec nginx-lb nginx -s reload

echo "✅ Rollback complete!"
echo "Visit: http://localhost:8080"

# Detect which environment we rolled back to
if grep -q "blue-app" "$NGINX_CONF"; then
    echo "Current environment: BLUE"
else
    echo "Current environment: GREEN"
fi
