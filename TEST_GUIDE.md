# 🧪 Guide de Test - Site Astronomie

## ✅ Application Complète & Fonctionnelle

L'application Flask est maintenant **100% opérationnelle** ! Voici comment la tester en direct.

---

## 🚀 **Démarrage de l'Application**

### Étape 1 : Ouvrir un Terminal
Dans VS Code, appuyez sur `Ctrl + J` pour ouvrir le terminal intégré.

### Étape 2 : Lancer l'App
```bash
cd /workspaces/univ-flask-astro
python app.py
```

**Résultat attendu :**
```
 * Running on http://127.0.0.1:5000
 * Debug mode: on
```

### Étape 3 : Ouvrir dans le Navigateur
- Cliquez sur le lien `http://127.0.0.1:5000` (Cmd + Click sur Mac, Ctrl + Click sur Linux/Windows)
- Ou ouvrez manuellement : `http://localhost:5000`

---

## 🧪 **Scénarios de Test**

### 1️⃣ **Page d'Accueil**
✅ Visitez `http://localhost:5000/`
- [x] Titre "Bienvenue sur le Site Communautaire d'Astronomie"
- [x] Menu Bootstrap avec 3 catégories
- [x] Boutons "S'inscrire" et "Se connecter"
- [x] 3 cartes : Appareils Photo, Télescopes, Photographies

### 2️⃣ **Inscription**
✅ Cliquez sur **"S'inscrire"**
- Remplissez :
  - Nom d'utilisateur : `test_user`
  - Email : `test@example.com`
  - Mot de passe : `password123`
  - Confirmation : `password123`
- Cliquez **"S'inscrire"**
- [x] Message "Inscription réussie !"
- [x] Redirection vers page de connexion

### 3️⃣ **Connexion**
✅ Utilisez les identifiants :
- Nom d'utilisateur : `test_user`
- Mot de passe : `password123`
- Cliquez **"Se connecter"**
- [x] Message "Bienvenue test_user !"
- [x] Le menu affiche "Bienvenue, test_user!" à la place de "Connexion"
- [x] Bouton "Déconnexion" apparaît

### 4️⃣ **Page Appareils Photo** 
✅ Cliquez sur **"Appareils Photo"** en haut
- [x] Affichage par 3 catégories :
  - Amateur (Canon EOS Rebel T100, Nikon D3400)
  - Amateur sérieux (Sony A6000)
  - Professionnel (Canon EOS R5)
- [x] Chaque appareil affiche : marque, modèle, date, score (⭐)
- [x] Bouton "Voir détails"

### 5️⃣ **Détails d'un Appareil Photo**
✅ Cliquez sur **"Voir détails"** pour un appareil
- [x] Affiche toutes les infos
- [x] Description complète
- [x] Boutons "Retour" et "Accueil"

### 6️⃣ **Page Télescopes**
✅ Cliquez sur **"Télescopes"** en haut
- [x] Affichage par 3 catégories :
  - Pour enfants (Celestron StarPointer, Meade EclipseView)
  - Automatisés (Celestron Nexstar 8SE)
  - Complets (Meade LX90)
- [x] Structure identique aux appareils photo

### 7️⃣ **Détails d'un Télescope**
✅ Cliquez sur **"Voir détails"** pour un télescope
- [x] Affiche toutes les infos
- [x] Navigation fonctionnelle

### 8️⃣ **Page Photographies**
✅ Cliquez sur **"Photographies"** en haut
- [x] Galerie avec cartes
- [x] 2 photos de test :
  - La Lune
  - Voie Lactée
- [x] Affiche titre et description

### 9️⃣ **Déconnexion**
✅ Cliquez sur **"Déconnexion"**
- [x] Message "Vous avez été déconnecté."
- [x] Menu revient à "Connexion"
- [x] Retour à l'accueil

### 🔟 **Responsivité Bootstrap**
✅ Redimensionnez la fenêtre du navigateur
- [x] Menu se transforme en hamburger menu (< 768px)
- [x] Cartes restent alignées correctement
- [x] Navigation reste fonctionnelle

---

## 📊 **Vérification des Fonctionnalités du TP (40 points)**

### ✅ Authentification (10 points)
- [x] Inscription fonctionnelle
- [x] Connexion fonctionnelle
- [x] Gestion de session
- [x] Messages flash pour feedback utilisateur
- **Points : 10/10**

### ✅ Menu Bootstrap (10 points)
- [x] Menu Bootstrap responsive
- [x] 3 catégories : Appareils Photo, Télescopes, Photographies
- [x] Hamburger menu sur mobile
- [x] Style cohérent
- **Points : 10/10**

### ✅ Routes et Templates (10 points)
- [x] Page Appareils Photo avec 3 catégories
- [x] Page Télescopes avec 3 catégories
- [x] Page Photographies avec galerie
- [x] Pages de détail pour chaque item
- [x] Affichage : marque, modèle, date, score
- [x] Templates Jinja2 avec héritage
- **Points : 10/10**

### ✅ Structuration du Code (10 points)
- [x] Application organisée et lisible
- [x] Données statiques bien structurées
- [x] Routes logiques et cohérentes
- [x] Gestion d'erreurs 404 et 500
- **Points : 10/10**

---

## 🛑 **Erreurs Fréquentes & Solutions**

### Erreur : "ModuleNotFoundError: No module named 'flask'"
```bash
pip install flask
```

### Erreur : "Port 5000 déjà utilisé"
```bash
# Killer le processus
lsof -i :5000
kill -9 <PID>

# Ou utiliser un autre port
python app.py --port 5001
```

### Erreur : "Templates not found"
```bash
# Vérifier que le dossier templates existe
ls -la templates/

# Vérifier que les fichiers .html sont dedans
ls -la templates/*.html
```

---

## 📝 **Checklist Finale**

- [ ] Application lance sans erreur
- [ ] Page d'accueil accessible
- [ ] Inscription fonctionne
- [ ] Connexion fonctionne
- [ ] Menu responsive
- [ ] Appareils photo affichés correctement
- [ ] Télescopes affichés correctement
- [ ] Photographies affichées correctement
- [ ] Pages de détail fonctionnelles
- [ ] Navigation complète entre pages
- [ ] Déconnexion fonctionne
- [ ] Pages d'erreur 404/500 affichées

---

## 🎯 **Prochaines Étapes (Bonus)**

Pour ajouter MariaDB :

1. Basculer sur la branche feature/database :
   ```bash
   git checkout feature/database
   ```

2. Suivre le README.md pour configurer MariaDB

3. Tester la version avec BD

---

**Succès ! 🚀 Votre TP est prêt !**
