#!/bin/bash

kind create cluster --config kind-config.yaml
docker run -d -p 5000:5000 --restart=always --name registry registry:2
docker build -t localhost:5000/custom-nginx:latest -f Dockerfile .
docker push localhost:5000/custom-nginx:latest

tilt up
