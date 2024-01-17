#!/bin/bash

# Create a kind cluster with a local registry
kind create cluster --config kind-config.yaml

# Set up local Docker registry
docker network create kind-registry
docker run -d --name kind-registry --network=kind-registry -p 5000:5000 registry:2

# Connect the kind cluster to the local registry
kubectl apply -f kind-registry.yaml

# Build and push the custom nginx container to the local registry
docker build -t localhost:5000/custom-nginx:latest -f Dockerfile .
docker push localhost:5000/custom-nginx:latest

# Deploy the custom nginx container using tilt
tilt up
