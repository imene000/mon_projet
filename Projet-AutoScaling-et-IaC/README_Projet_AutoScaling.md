
# Projet AutoScaling et Infrastructure as Code (IaC)

## Objectif
Ce projet vise à créer une infrastructure d'application scalable en utilisant Kubernetes, avec une base de données Redis en architecture master/replica, un serveur Node.js stateless et une interface frontend React. Le projet inclut également la mise en place de l'autoscaling et de l'observabilité via Prometheus et Grafana.

## Prérequis
Avant de commencer, assurez-vous d'avoir installé et configuré les outils suivants sur votre machine :
- [Docker](https://www.docker.com/get-started)
- [Minikube](https://minikube.sigs.k8s.io/docs/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Git](https://git-scm.com/)
- [Node.js](https://nodejs.org/)

## Structure du Projet

```
Projet-AutoScaling-et-IaC/
│
├── k8s/
│   ├── redis/
│   ├── redis-node/
│   ├── redis-react/
│   └── monitoring/
│       ├── prometheus/
│       └── grafana/
├── deploy.sh        # Script pour déployer l'infrastructure
└── README.md        # Documentation du projet
```

## Étapes d'Installation et Déploiement

### 1. Clonez le projet

Clonez le projet depuis le dépôt GitHub.


git clone https://github.com/arthurescriou/redis-node.git
git clone https://github.com/arthurescriou/redis-react.git

### 2. Démarrer Minikube

Démarrez le cluster Kubernetes local avec Minikube.


minikube start --driver=docker --memory=4096 --force

### 3. Déployer l'infrastructure

Exécutez le script `deploy.sh` pour déployer l'infrastructure complète sur Kubernetes.

```
chmod +x deploy.sh
./deploy.sh
```

Ce script déploie les composants suivants :
- **Redis (master et replicas)** : Base de données Redis configurée pour supporter l'auto-scaling des réplicas.
- **Backend Node.js** : Serveur stateless interagissant avec Redis.
- **Frontend React** : Interface frontend utilisant l'API du backend.
- **Prometheus et Grafana** : Outils de monitoring pour collecter et visualiser les métriques de l'infrastructure.

### 4. Accéder à l'interface frontend

Une fois le déploiement effectué, vous pouvez accéder à l'application via l'URL générée par Minikube.

```bash
minikube service redis-react --url
```

### 5. Vérification des Pods

Vérifiez l'état des pods Kubernetes pour vous assurer que tous les composants sont en cours d'exécution.

```bash
kubectl get pods
```

### 6. Test de l'autoscaling

Pour tester l'autoscaling, vous pouvez simuler une charge élevée sur le backend avec la commande suivante :

```bash
while true; do curl -s http://<MINIKUBE_IP>:30764 > /dev/null; done
```

Surveillez les ressources et l'autoscaling avec :

```bash
kubectl get hpa
kubectl top pods
```

## Détruire les Ressources Kubernetes

Une fois que vous avez terminé les tests, vous pouvez supprimer les ressources Kubernetes avec le script `destroy.sh`.

```bash
chmod +x destroy.sh
./destroy.sh
```

## Conclusion

Ce projet met en œuvre une infrastructure scalable et surveillée, avec des composants auto-scalables déployés sur Kubernetes. Prometheus et Grafana permettent une surveillance détaillée des métriques du système, tandis que l'autoscaling horizontal ajuste dynamiquement le nombre de réplicas en fonction de la charge.

## Auteurs
- Imene Assous
- Mylissa Amedjkouh
