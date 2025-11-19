#!/bin/bash

set -e

ENVIRONMENT=$1
NGINX_CONF="nginx/nginx.conf"
BACKUP_CONF="nginx/nginx.conf.backup"

if [ -z "$ENVIRONMENT" ]; then
    echo "Usage: ./deploy.sh [blue|green]"
    exit 1
fi

if [ "$ENVIRONMENT" != "blue" ] && [ "$ENVIRONMENT" != "green" ]; then
    echo "Error: Environment must be 'blue' or 'green'"
    exit 1
fi

echo "================================"
echo "Blue-Green Deployment Tool"
echo "================================"
echo ""
echo "Target Environment: $ENVIRONMENT"
echo ""

# Step 1: Backup current nginx config
echo "📦 Backing up current configuration..."
cp "$NGINX_CONF" "$BACKUP_CONF"

# Step 2: Update nginx config to point to new environment
echo "🔧 Updating NGINX configuration..."
sed -i.bak "s/server .*-app:80;/server $ENVIRONMENT-app:80;/" "$NGINX_CONF"

# Step 3: Reload NGINX
echo "🔄 Reloading NGINX..."
docker exec nginx-lb nginx -s reload

# Wait a moment for reload
sleep 2

# Step 4: Test the new configuration
echo "🧪 Testing new configuration..."
if curl -f http://localhost:8080 > /dev/null 2>&1; then
    echo "✅ Deployment successful!"
    echo ""
    echo "Current active environment: $ENVIRONMENT"
    echo "Access your application at: http://localhost:8080"
    echo ""
    echo "To rollback, run: ./scripts/rollback.sh"
else
    echo "❌ Deployment failed! Rolling back..."
    cp "$BACKUP_CONF" "$NGINX_CONF"
    docker exec nginx-lb nginx -s reload
    exit 1
fi

echo ""
echo "================================"
echo "Deployment Complete!"
echo "================================"
