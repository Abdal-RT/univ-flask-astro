#!/bin/bash

# Script d'initialisation pour le TP Astronomie

echo "🔭 Initialisation du Site Astronomie"
echo "===================================="
echo ""

# Vérifier MariaDB
echo "1️⃣ Vérification de MariaDB..."
if command -v mysql &> /dev/null; then
    echo "✅ MariaDB trouvé"
else
    echo "❌ MariaDB non installé. Installation..."
    sudo apt update
    sudo apt install mariadb-server -y
fi

# Démarrer MariaDB
echo ""
echo "2️⃣ Démarrage de MariaDB..."
sudo service mariadb start

# Créer la base de données
echo ""
echo "3️⃣ Création de la base de données..."
mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS astronomy_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
EOF

if [ $? -eq 0 ]; then
    echo "✅ Base de données créée"
else
    echo "⚠️  La base de données pourrait déjà exister"
fi

# Installer les dépendances Python
echo ""
echo "4️⃣ Installation des dépendances Python..."
pip install -r requirements.txt -q
echo "✅ Dépendances installées"

# Initialiser la base de données
echo ""
echo "5️⃣ Initialisation de la base de données..."
flask --app app init-db
echo "✅ Schéma de base de données créé"

# Charger les données de test
echo ""
echo "6️⃣ Chargement des données de test..."
flask --app app seed-db
echo "✅ Données de test chargées"

echo ""
echo "✨ Initialisation terminée !"
echo ""
echo "📝 Pour lancer l'application, utilisez :"
echo "   python app.py"
echo ""
echo "🌐 Accédez à : http://localhost:5000"
