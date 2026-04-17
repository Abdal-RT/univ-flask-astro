# 🗄️ Guide Configuration MariaDB

## ✅ Étapes à Suivre

### Étape 1️⃣ : Basculer sur la Branche Feature

```bash
cd /workspaces/univ-flask-astro
git checkout feature/database
```

### Étape 2️⃣ : Installer MariaDB (Si Not Installed)

```bash
# Mise à jour
sudo apt update

# Installation
sudo apt install mariadb-server -y

# Vérifier l'installation
which mysql
```

### Étape 3️⃣ : Démarrer MariaDB

```bash
# Démarrer le service
sudo service mariadb start

# Vérifier que c'est actif
sudo service mariadb status
```

### Étape 4️⃣ : Créer la Base de Données

```bash
# Se connecter à MySQL
mysql -u root

# Dans le shell MySQL, exécuter :
CREATE DATABASE astronomy_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
EXIT;
```

### Étape 5️⃣ : Initialiser la Base de Données

```bash
# Initialiser le schéma
flask --app app init-db

# Remplir avec les données de test
flask --app app seed-db
```

**Résultat attendu** :
```
✅ Base de données initialisée.
✅ Base de données remplie avec les données de test.
```

### Étape 6️⃣ : Lancer l'Application

```bash
python app.py
```

L'app démarre sur `http://localhost:5000` ✅

---

## 🧪 Test Complet

1. **S'inscrire** : Créez un nouveau compte
2. **Se connecter** : Utilisez le compte créé
3. **Naviguer** : Testez toutes les pages
4. **Vérifier BD** : Les données persistent après rechargement

---

## 🛑 Troubleshooting

### Erreur : "Can't connect to MySQL"
```bash
# Vérifier si MariaDB est actif
sudo service mariadb status

# Redémarrer si nécessaire
sudo service mariadb restart
```

### Erreur : "Database doesn't exist"
```bash
# Créer la BD manuelle
mysql -u root
CREATE DATABASE astronomy_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
EXIT;
```

### Erreur : "ModuleNotFoundError: No module named 'flask_login'"
```bash
pip install flask-login flask-sqlalchemy
```

---

## 📊 Vérifier la BD

```bash
# Se connecter à MySQL
mysql -u root

# Utiliser la BD
USE astronomy_db;

# Voir les tables
SHOW TABLES;

# Voir le contenu des caméras
SELECT * FROM cameras;

# Voir les utilisateurs
SELECT * FROM users;
```

---

## 🎉 C'est Fait !

Votre TP Astronomie est maintenant avec **MariaDB + SQLAlchemy** ! 🚀

- ✅ 40/40 points obligatoires
- ✅ Bonus : Base de données MariaDB
- ✅ Authentification sécurisée
- ✅ Persistence des données

---

**Bon travail ! 🔭✨**
