#!/bin/bash
set -e

ENVIRONMENT=${1:-staging}
VERSION=${2:-main}

echo "Deploying version $VERSION to $ENVIRONMENT..."

# Pull latest image
docker pull ghcr.io/fireaem/b3_virtualisation-conteneurisation_tp-2_partie-3:$VERSION

# Utiliser la bonne compose file
COMPOSE_FILE="docker-compose.${ENVIRONMENT}.yml"

# Deploy
docker compose -f "$COMPOSE_FILE" up -d

echo "Waiting for application to be healthy..."
sleep 10

echo "Checking health..."
if curl -f http://localhost/health; then
  echo "Deployment successful!"
  docker compose -f "$COMPOSE_FILE" ps
else
  echo "Deployment failed!"
  docker compose -f "$COMPOSE_FILE" logs
  exit 1
fi
