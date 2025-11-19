#!/bin/bash

set -e

ENVIRONMENT=$1
NGINX_CONF="nginx/nginx.conf"

if [ -z "$ENVIRONMENT" ]; then
    echo "Usage: ./switch.sh [blue|green]"
    exit 1
fi

if [ "$ENVIRONMENT" != "blue" ] && [ "$ENVIRONMENT" != "green" ]; then
    echo "Error: Environment must be 'blue' or 'green'"
    exit 1
fi

echo "🔄 Switching to $ENVIRONMENT environment..."

# Update nginx config
sed -i.bak "s/server .*-app:80;/server $ENVIRONMENT-app:80;/" "$NGINX_CONF"

# Reload NGINX
docker exec nginx-lb nginx -s reload

echo "✅ Switched to $ENVIRONMENT environment"
echo "Visit: http://localhost:8080"

