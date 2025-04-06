#!/bin/bash

# Fonction pour supprimer Redis (master + replicas)
destroy_redis() {
    echo "Destruction de Redis..."
    kubectl delete -f k8s/redis/redis-replica-hpa.yaml
    kubectl delete -f k8s/redis/redis-replica-service.yaml
    kubectl delete -f k8s/redis/redis-replica-deployment.yaml
    kubectl delete -f k8s/redis/redis-master-service.yaml
    kubectl delete -f k8s/redis/redis-master-deployment.yaml
}

# Fonction pour supprimer le backend Redis-Node
destroy_backend() {
    echo "Destruction du backend Node.js..."
    kubectl delete -f k8s/redis-node/redis-node-hpa.yaml
    kubectl delete -f k8s/redis-node/redis-node-service.yaml
    kubectl delete -f k8s/redis-node/redis-node-deployment.yaml
}

# Fonction pour supprimer le frontend React
destroy_frontend() {
    echo "Destruction du frontend React..."
    kubectl delete -f k8s/redis-react/redis-react-service.yaml
    kubectl delete -f k8s/redis-react/redis-react-deployment.yaml
}

# Fonction pour supprimer Prometheus et Grafana
destroy_monitoring() {
    echo "Destruction de Prometheus et Grafana..."
    kubectl delete -f k8s/monitoring/prometheus/
    kubectl delete -f k8s/monitoring/grafana/
}

# Fonction principale pour détruire toute l'infrastructure
destroy_all() {
    echo "Démarrage de la destruction complète..."

    # Suppression de Redis
    destroy_redis
    # Suppression du backend
    destroy_backend
    # Suppression du frontend
    destroy_frontend
    # Suppression de monitoring
    destroy_monitoring

    echo "Destruction complète terminée!"
}

# Exécution de la destruction
destroy_all
