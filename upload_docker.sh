#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
dockerpath="pflash30/capstone-app-pflash"


# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
# docker login --username pflash30
docker image tag capstone-app-pflash $dockerpath

# Step 3:
# Push image to a docker repository
docker push $dockerpath