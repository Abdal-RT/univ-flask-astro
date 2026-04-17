# 🔭 Site Web Communautaire d'Astronomie

Un site Flask pour explorer les appareils photo, télescopes et photographies astronomiques.

## 📋 Fonctionnalités

✅ **Authentification** - Inscription et connexion sécurisée avec hashage des mots de passe  
✅ **Menu Bootstrap** - Navigation responsive avec 3 catégories  
✅ **Appareils Photo** - Listage par catégories (Amateur, Amateur sérieux, Professionnel)  
✅ **Télescopes** - Listage par catégories (Pour enfants, Automatisés, Complets)  
✅ **Photographies** - Galerie de photographies astronomiques  
✅ **Base de Données** - MySQL/MariaDB avec SQLAlchemy

## 🚀 Installation

### 1. Cloner le projet
```bash
cd /workspaces/univ-flask-astro
```

### 2. Configurer MariaDB (dans votre codespace)
```bash
# Mise à jour
sudo apt update

# Installation de MariaDB
sudo apt install mariadb-server -y

# Démarrage du service
sudo service mariadb start

# Configuration sécurisée
sudo mysql_secure_installation
```

### 3. Créer la base de données
```bash
# Se connecter à MySQL
mysql -u root -p

# Créer la base de données
CREATE DATABASE astronomy_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
EXIT;
```

### 4. Installer les dépendances Python
```bash
pip install -r requirements.txt
```

### 5. Initialiser la base de données
```bash
flask --app app init-db
flask --app app seed-db
```

## ▶️ Lancer l'application
```bash
python app.py
```

L'application est accessible à l'adresse : `http://localhost:5000`

## 📝 Comptes de test

Les données de test sont automatiquement ajoutées lors de l'initialisation. Vous pouvez créer votre propre compte via l'interface.

## 📁 Structure du projet

```
univ-flask-astro/
├── app.py                    # Application principale Flask
├── config.py                 # Configuration de la base de données
├── models.py                 # Modèles SQLAlchemy
├── requirements.txt          # Dépendances Python
├── README.md                 # Ce fichier
├── templates/                # Templates Jinja2
│   ├── base.html            # Template de base avec menu
│   ├── index.html           # Page d'accueil
│   ├── login.html           # Page de connexion
│   ├── register.html        # Page d'inscription
│   ├── cameras.html         # Liste des appareils photo
│   ├── camera_detail.html   # Détails d'un appareil
│   ├── telescopes.html      # Liste des télescopes
│   ├── telescope_detail.html# Détails d'un télescope
│   ├── photos.html          # Galerie de photos
│   ├── 404.html             # Page d'erreur 404
│   └── 500.html             # Page d'erreur 500
└── static/                   # Fichiers statiques
    ├── css/                  # Feuilles de style
    ├── js/                   # Scripts JavaScript
    └── images/              # Images

```

## 🔐 Sécurité

- ✅ Les mots de passe sont hashés avec Werkzeug
- ✅ La session utilise des cookies sécurisés
- ✅ Requête Flask-Login pour les pages protégées
- ✅ Protection CSRF avec Flask-WTF

## 📊 Modèles de Données

### User
- `id` : Identifiant unique
- `username` : Nom d'utilisateur unique
- `email` : Email unique
- `password_hash` : Mot de passe hashé
- `created_at` : Date de création

### Camera
- `id` : Identifiant unique
- `brand` : Marque
- `model` : Modèle
- `release_date` : Date de sortie
- `score` : Score de 1 à 5
- `category` : Amateur, Amateur sérieux, Professionnel
- `description` : Description du produit

### Telescope
- `id` : Identifiant unique
- `brand` : Marque
- `model` : Modèle
- `release_date` : Date de sortie
- `score` : Score de 1 à 5
- `category` : Pour enfants, Automatisés, Complets
- `description` : Description du produit

### Photograph
- `id` : Identifiant unique
- `title` : Titre de la photo
- `description` : Description
- `image_path` : Chemin de l'image
- `user_id` : ID de l'utilisateur
- `created_at` : Date de création

## 🔄 Export des données

Avant de rendre votre code, exportez votre schéma et vos données :

```bash
# Exporter le schéma et les données
mysqldump -u root -p astronomy_db > astronomy_dump.sql

# Exporter seulement le schéma
mysqldump -u root -p --no-data astronomy_db > astronomy_schema.sql
```

## 🚧 Améliorations Futures

- [ ] Ajouter une colonne "Résumé" et pages de détails enrichies
- [ ] Page Actualités avec websockets
- [ ] Système de forum avec fils de discussion
- [ ] Galerie d'images améliorée
- [ ] Système de commentaires et avis
- [ ] Recherche et filtres avancés

## 👨‍💻 Auteur

Créé pour le TP d'Astronomie avec Flask, Bootstrap et MySQL.

---

**Bon codage ! 🚀**