#!/bin/bash

kind create cluster --config kind-config.yaml

docker network create kind-registry
docker run -d --name kind-registry --network=kind-registry -p 8081:8081 registry:2

kubectl apply -f kind-registry.yaml

docker build -t localhost:8081/custom-nginx:latest -f Dockerfile .
docker push localhost:8081/custom-nginx:latest

tilt up
