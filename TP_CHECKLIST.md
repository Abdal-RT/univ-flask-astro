# 📋 Checklist TP Astronomie

## ✅ Partie Obligatoire (40 points)

### 1. Authentification (10 points)
- [x] Système d'authentification Flask avec MySQL
- [x] Page d'inscription
- [x] Page de connexion
- [x] Hashage sécurisé des mots de passe
- [x] Gestion de session utilisateur

### 2. Menu Bootstrap (10 points)
- [x] Menu responsive dans le template de base
- [x] 3 catégories : Appareils Photo, Photographies, Télescopes
- [x] Navigation fonctionnelle entre les pages
- [x] Style Bootstrap appliqué

### 3. Routes et Templates (10 points)
- [x] Page Appareils Photo avec 3 catégories
  - Amateur
  - Amateur sérieux
  - Professionnel
- [x] Page Télescopes avec 3 catégories
  - Pour enfants
  - Automatisés
  - Complets
- [x] Page Photographies avec liste
- [x] Chaque item dispose de : marque, modèle, date de sortie, score (1-5)
- [x] Templates Jinja2 avec héritage de base.html

### 4. Base de Données (10 points)
- [x] Utilisation de Flask-SQLAlchemy
- [x] Base de données MySQL
- [x] Modèle User avec authentification
- [x] Modèle Camera pour appareils photos
- [x] Modèle Telescope pour télescopes
- [x] Modèle Photograph pour photographies
- [x] Relations et contraintes appropriées

---

## 🚀 Améliorations Futures (Bonus +20 points)

### Pages Détails avec Résumé
- [ ] Ajouter colonne `description` (Résumé) pour Camera et Telescope ✅ (déjà implémenté)
- [ ] Créer routes de détails
  - ✅ `/camera/<id>` - Page de détail appareil photo
  - ✅ `/telescope/<id>` - Page de détail télescope
- [ ] Afficher les informations complètes avec description

### Page Actualités (+10 points)
- [ ] Créer modèle News
- [ ] Page listant les actualités
- [ ] Admin panel pour créer/modifier les news
- [ ] Intégrer WebSockets pour mises à jour en temps réel
- [ ] Notification automatique lors de nouvelles actualités

### Forum (+10 points)
- [ ] Créer modèles Thread et Post
- [ ] Liste des fils de discussion
- [ ] Création de nouveaux fils
- [ ] Création de réponses
- [ ] Système de votes/likes
- [ ] Modération des messages

---

## 📝 Instructions d'Export des Données

Avant de rendre le projet :

```bash
# Exporter le schéma complet
mysqldump -u root -p astronomy_db > astronomy_dump.sql

# Ou exporter seulement le schéma
mysqldump -u root -p --no-data astronomy_db > astronomy_schema.sql
```

Joignez le fichier `astronomy_dump.sql` ou `astronomy_schema.sql` à votre rendu.

---

## 🧪 Tests Suggérés

1. ✅ Inscription et connexion
2. ✅ Navigation entre les pages
3. ✅ Affichage des listes filtrées par catégorie
4. ✅ Pages de détail
5. ✅ Responsivité du menu
6. ✅ Gestion des erreurs 404 et 500

---

## 🎯 Conseils pour le développement

1. Testez chaque fonctionnalité au fur et à mesure
2. Utilisez les outils de dev du navigateur (F12)
3. Consultez les logs Flask pour les erreurs
4. Committez régulièrement votre code sur git
5. Documentez votre code avec des commentaires

---

## 📚 Ressources Utiles

- [Documentation Flask](https://flask.palletsprojects.com/)
- [Documentation SQLAlchemy](https://docs.sqlalchemy.org/)
- [Documentation Bootstrap](https://getbootstrap.com/docs/4.6/)
- [Documentation Jinja2](https://jinja.palletsprojects.com/)
- [Documentation MySQL](https://dev.mysql.com/doc/)

---

**Bon courage pour votre TP ! 🚀**
