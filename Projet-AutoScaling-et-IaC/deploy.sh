#!/bin/bash

# Affichage d'un message de début de déploiement
echo "Déploiement de l'infrastructure Kubernetes..."

# Déploiement de Redis (Master + Replicas)
echo "Déploiement de Redis (Master + Replicas)..."
kubectl apply -f k8s/redis/redis-master-deployment.yaml
kubectl apply -f k8s/redis/redis-master-service.yaml
kubectl apply -f k8s/redis/redis-replica-deployment.yaml
kubectl apply -f k8s/redis/redis-replica-service.yaml
kubectl apply -f k8s/redis/redis-replica-hpa.yaml

# Vérification du déploiement de Redis
echo "Vérification des pods Redis..."
kubectl get pods -l app=redis

# Déploiement du Backend (Redis-Node)
echo "Déploiement du Backend (Redis-Node)..."
kubectl apply -f k8s/redis-node/redis-node-deployment.yaml
kubectl apply -f k8s/redis-node/redis-node-service.yaml
kubectl apply -f k8s/redis-node/redis-node-hpa.yaml

# Vérification du déploiement du Backend
echo "Vérification des pods Backend..."
kubectl get pods -l app=redis-node

# Déploiement du Frontend (React)
echo "Déploiement du Frontend (React)..."
kubectl apply -f k8s/redis-react/redis-react-deployment.yaml
kubectl apply -f k8s/redis-react/redis-react-service.yaml

# Vérification du déploiement du Frontend
echo "Vérification des pods Frontend..."
kubectl get pods -l app=redis-react

# Déploiement du Monitoring avec Prometheus et Grafana
echo "Déploiement du Monitoring avec Prometheus et Grafana..."
kubectl apply -f k8s/monitoring/prometheus/prometheus-deployment.yaml
kubectl apply -f k8s/monitoring/prometheus/prometheus-service.yaml
kubectl apply -f k8s/monitoring/grafana/grafana-deployment.yaml
kubectl apply -f k8s/monitoring/grafana/grafana-service.yaml

# Vérification du déploiement de Prometheus et Grafana
echo "Vérification des pods Prometheus et Grafana..."
kubectl get pods -l app=prometheus
kubectl get pods -l app=grafana

# Affichage de l'URL d'accès aux services
echo "Récupération de l'URL pour accéder au frontend..."
minikube service redis-react --url

echo "Récupération de l'URL pour accéder au Backend..."
minikube service redis-node --url

# Fin du script
echo "Déploiement terminé !"
