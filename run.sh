#!/bin/bash

# Script de démarrage rapide pour le site Astronomie

echo "🔭 Démarrage du Site Astronomie"
echo "================================"
echo ""

# Vérifier si MariaDB est en cours d'exécution
if ! pgrep -x "mysqld" > /dev/null; then
    echo "▶️  Démarrage de MariaDB..."
    sudo service mariadb start
    sleep 2
fi

# Vérifier si la base de données existe
echo "📊 Vérification de la base de données..."
mysql -u root -e "USE astronomy_db;" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✅ Base de données existante trouvée"
else
    echo "⚠️  Base de données non trouvée, création..."
    mysql -u root << EOF
CREATE DATABASE astronomy_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
EOF
    
    # Initialiser la base de données
    echo "🛠️  Initialisation du schéma..."
    flask --app app init-db
    
    # Charger les données de test
    echo "📝 Chargement des données de test..."
    flask --app app seed-db
fi

echo ""
echo "🚀 Démarrage de Flask..."
echo ""
echo "═════════════════════════════════════════════"
echo "✨ Le site est prêt !"
echo ""
echo "🌐 Accédez à : http://localhost:5000"
echo ""
echo "📝 Pour arrêter, appuyez sur Ctrl+C"
echo "═════════════════════════════════════════════"
echo ""

# Lancer Flask
python app.py
