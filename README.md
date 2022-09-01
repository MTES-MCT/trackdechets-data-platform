# Modèle de déploiement pour la Plateforme Données de Trackdéchets

Ce repository contient les fichiers `Docker Compose` permettant un déploiement de Airflow et Meltano.
Le déploiement en production utilise `nginx` comme proxy inversé permettant d'activer le HTTPS viaz un certificat auto-généré via `certbot`.


Les fichiers présents ici permettent aussi de lancer l'instance Airflow en local. Dans ce cas il n'est pas nécessaire de lancer `nginx`.

## Prérequis

Docker est nécessaire pour lancer les différents containers.


## Containers Airflow 

Pour lancer Airflow, il suffit d'utiliser la commande suivante:
```bash
docker compose up
```
Néanmoins il est nécessaire de configurer des variables d’environnement avant le lancement.
Pour cela il faut créer un fichier `.env` contenant les variables suivantes :
- **AIRFLOW_UID** : UID de l'utilisateur airflow, 0 sur un environnemnet linux ou 50000 sur MacOS
- **POSTGRES_USERNAME** : nom d'utilisateur à créer pour la base de données Postgres dont va se servir Airflow, le choix est libre.
- **POSTGRES_PASSWORD**: mot de passe associé au nom d'utilisateur précédent.
- **_AIRFLOW_WWW_USER_USERNAME** : nom d'utilisateur pour le compte administrateur d'Airflow, à utiliser pour se connecter à l’interface web.
- **_AIRFLOW_WWW_USER_PASSWORD** : mot de passe associé au compte précédent, à garder en lieu sûr.
- **AIRFLOW_WORKSPACE** : dossier sur la machine hôte contenant les dossiers  `dags`, `plugins` et `logs` qui sera monté dans le container Airflow. Pour Trackdéchets, c'est le chemin vers le repository `trackdechets-airflow-workspace`.
- **FERNET_KEY** : Clé Fernet à générer et qui sera utilisé pour chiffrer les variables et connexions Airflow.
- **KEYS_FOLDER** : Dossier sur la machine hôte où seront placés les clés SSH, clés API... nécessaires au DAG, le dossier est monté dans `/opt/keys` dans le container.
- **WEBSERVER_PORT** : Port sur lequel sera exposé l'interface web d'Airflow, 8080 par défaut.


## Configuration nginx pour la production

*Cette section est en cours d'amélioration.*

Avant tout, il est nécessaire de se placer dans le dossier `nginx`.

La première étape consiste à venir modifier les valeurs indiquées par les commentaires dans le script `init-letsencrypt.sh` puis de le lancer pour lancer la création des certificats SSL.

Une fois les certificats créés il va falloir changer la configuration nginx dans le fichier `nginx.conf` en changeant les variables indiquées par les commentaires et en décommettant les parties liées au HTTPS indiquées également par les commentaires.

A ce stade la configuration devrait être prête, il faut relancer les containers nginx avec un :
```
docker compose up
```
et s'assurer que les containers Airflow sont bien lancés également.