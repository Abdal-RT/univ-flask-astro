from flask import Flask, render_template, request, redirect, url_for, flash, session
from flask_login import LoginManager, login_user, logout_user, login_required, current_user
from datetime import datetime
import os

from config import Config
from models import db, User, Camera, Telescope, Photograph, News, ForumThread, ForumPost

app = Flask(__name__)
app.config.from_object(Config)

# Initialisation de SQLAlchemy
db.init_app(app)

# Configuration LoginManager
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'
login_manager.login_message = 'Veuillez vous connecter pour accéder à cette page.'

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


# ============= ROUTES D'AUTHENTIFICATION =============

@app.route('/register', methods=['GET', 'POST'])
def register():
    """Page d'inscription"""
    if request.method == 'POST':
        username = request.form.get('username')
        email = request.form.get('email')
        password = request.form.get('password')
        confirm_password = request.form.get('confirm_password')
        
        # Validations
        if not username or not email or not password:
            flash('Tous les champs sont requis.', 'danger')
            return redirect(url_for('register'))
        
        if password != confirm_password:
            flash('Les mots de passe ne correspondent pas.', 'danger')
            return redirect(url_for('register'))
        
        if User.query.filter_by(username=username).first():
            flash('Ce nom d\'utilisateur existe déjà.', 'danger')
            return redirect(url_for('register'))
        
        if User.query.filter_by(email=email).first():
            flash('Cet email est déjà utilisé.', 'danger')
            return redirect(url_for('register'))
        
        # Créer le nouvel utilisateur
        user = User(username=username, email=email)
        user.set_password(password)
        db.session.add(user)
        db.session.commit()
        
        flash('Inscription réussie ! Veuillez vous connecter.', 'success')
        return redirect(url_for('login'))
    
    return render_template('register.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    """Page de connexion"""
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        
        user = User.query.filter_by(username=username).first()
        
        if user and user.check_password(password):
            login_user(user)
            flash(f'Bienvenue {user.username} !', 'success')
            return redirect(url_for('index'))
        else:
            flash('Nom d\'utilisateur ou mot de passe incorrect.', 'danger')
    
    return render_template('login.html')


@app.route('/logout')
@login_required
def logout():
    """Déconnexion"""
    logout_user()
    flash('Vous avez été déconnecté.', 'success')
    return redirect(url_for('index'))


# ============= DONNÉES STATIQUES =============
# (Plus utilisées - remplacées par BD)


# ============= ROUTES PRINCIPALES =============

@app.route('/')
def index():
    """Page d'accueil"""
    return render_template('index.html')


# ============= ROUTES APPAREILS PHOTO =============

@app.route('/cameras')
def cameras():
    """Page listant tous les appareils photos"""
    cameras_list = Camera.query.all()
    
    # Grouper par catégorie
    cameras_by_category = {
        'Amateur': [c for c in cameras_list if c.category == 'Amateur'],
        'Amateur sérieux': [c for c in cameras_list if c.category == 'Amateur sérieux'],
        'Professionnel': [c for c in cameras_list if c.category == 'Professionnel']
    }
    
    return render_template('cameras.html', cameras_by_category=cameras_by_category)


@app.route('/camera/<int:camera_id>')
def camera_detail(camera_id):
    """Page de détail d'un appareil photo"""
    camera = Camera.query.get_or_404(camera_id)
    return render_template('camera_detail.html', camera=camera)


# ============= ROUTES TÉLESCOPES =============

@app.route('/telescopes')
def telescopes():
    """Page listant tous les télescopes"""
    telescopes_list = Telescope.query.all()
    
    # Grouper par catégorie
    telescopes_by_category = {
        'Pour enfants': [t for t in telescopes_list if t.category == 'Pour enfants'],
        'Automatisés': [t for t in telescopes_list if t.category == 'Automatisés'],
        'Complets': [t for t in telescopes_list if t.category == 'Complets']
    }
    
    return render_template('telescopes.html', telescopes_by_category=telescopes_by_category)


@app.route('/telescope/<int:telescope_id>')
def telescope_detail(telescope_id):
    """Page de détail d'un télescope"""
    telescope = Telescope.query.get_or_404(telescope_id)
    return render_template('telescope_detail.html', telescope=telescope)


# ============= ROUTES PHOTOGRAPHIES =============

@app.route('/photos')
def photos():
    """Page listant toutes les photographies"""
    photographs = Photograph.query.all()
    return render_template('photos.html', photographs=photographs)


# ============= ROUTES ACTUALITÉS =============

@app.route('/news')
def news_list():
    """Page listant les actualités"""
    news = News.query.filter_by(is_published=True).order_by(News.created_at.desc()).all()
    return render_template('news_list.html', news=news)


@app.route('/news/<int:news_id>')
def news_detail(news_id):
    """Page de détail d'une actualité"""
    news = News.query.get_or_404(news_id)
    if not news.is_published and (not current_user or current_user.id != news.author_id):
        return render_template('404.html'), 404
    return render_template('news_detail.html', news=news)


@app.route('/news/create', methods=['GET', 'POST'])
@login_required
def create_news():
    """Créer une nouvelle actualité (admin uniquement)"""
    if request.method == 'POST':
        title = request.form.get('title')
        content = request.form.get('content')
        is_published = request.form.get('is_published') == 'on'
        
        if not title or not content:
            flash('Le titre et le contenu sont requis.', 'danger')
            return redirect(url_for('create_news'))
        
        news = News(title=title, content=content, author_id=current_user.id, is_published=is_published)
        db.session.add(news)
        db.session.commit()
        
        flash('Actualité créée avec succès !', 'success')
        return redirect(url_for('news_detail', news_id=news.id))
    
    return render_template('create_news.html')


# ============= ROUTES FORUM =============

@app.route('/forum')
def forum_index():
    """Page principale du forum"""
    threads = ForumThread.query.order_by(ForumThread.is_pinned.desc(), ForumThread.updated_at.desc()).all()
    categories = ['Appareil photo', 'Télescope', 'Astrophotographie', 'Général']
    return render_template('forum_index.html', threads=threads, categories=categories)


@app.route('/forum/category/<category>')
def forum_category(category):
    """Voir tous les threads d'une catégorie"""
    threads = ForumThread.query.filter_by(category=category).order_by(ForumThread.is_pinned.desc(), ForumThread.updated_at.desc()).all()
    return render_template('forum_category.html', category=category, threads=threads)


@app.route('/forum/thread/<int:thread_id>')
def forum_thread_detail(thread_id):
    """Voir un fil de discussion avec tous ses messages"""
    thread = ForumThread.query.get_or_404(thread_id)
    posts = ForumPost.query.filter_by(thread_id=thread_id).order_by(ForumPost.created_at.asc()).all()
    return render_template('forum_thread.html', thread=thread, posts=posts)


@app.route('/forum/thread/create', methods=['GET', 'POST'])
@login_required
def create_forum_thread():
    """Créer un nouveau fil de discussion"""
    if request.method == 'POST':
        title = request.form.get('title')
        category = request.form.get('category')
        description = request.form.get('description')
        
        if not title or not category or not description:
            flash('Tous les champs sont requis.', 'danger')
            return redirect(url_for('create_forum_thread'))
        
        thread = ForumThread(title=title, category=category, description=description, author_id=current_user.id)
        db.session.add(thread)
        db.session.commit()
        
        flash('Fil de discussion créé avec succès !', 'success')
        return redirect(url_for('forum_thread_detail', thread_id=thread.id))
    
    categories = ['Appareil photo', 'Télescope', 'Astrophotographie', 'Général']
    return render_template('create_forum_thread.html', categories=categories)


@app.route('/forum/thread/<int:thread_id>/post', methods=['POST'])
@login_required
def create_forum_post(thread_id):
    """Ajouter un message dans un fil de discussion"""
    thread = ForumThread.query.get_or_404(thread_id)
    
    if thread.is_locked:
        flash('Ce fil est verrouillé et ne peut plus recevoir de réponses.', 'danger')
        return redirect(url_for('forum_thread_detail', thread_id=thread_id))
    
    content = request.form.get('content')
    
    if not content:
        flash('Le message ne peut pas être vide.', 'danger')
        return redirect(url_for('forum_thread_detail', thread_id=thread_id))
    
    post = ForumPost(content=content, author_id=current_user.id, thread_id=thread_id)
    db.session.add(post)
    thread.updated_at = datetime.utcnow()
    db.session.commit()
    
    flash('Message posté avec succès !', 'success')
    return redirect(url_for('forum_thread_detail', thread_id=thread_id))


# ============= GESTION DES ERREURS =============

@app.errorhandler(404)
def page_not_found(e):
    """Gérer les pages non trouvées"""
    return render_template('404.html'), 404


@app.errorhandler(500)
def internal_error(e):
    """Gérer les erreurs serveur"""
    return render_template('500.html'), 500


# ============= COMMANDES DE GESTION =============

@app.cli.command()
def init_db():
    """Initialiser la base de données"""
    db.create_all()
    print('✅ Base de données initialisée.')


@app.cli.command()
def seed_db():
    """Remplir la base de données avec des données de test"""
    # Vérifier si les données existent déjà
    if Camera.query.first():
        print('⚠️  La base de données contient déjà des données.')
        return
    
    # Ajouter des appareils photos
    cameras = [
        Camera(
            brand='Canon', 
            model='EOS Rebel T100', 
            release_date=datetime(2020, 1, 1).date(), 
            score=4, 
            category='Amateur', 
            description='Appareil photo reflex bien abordable'
        ),
        Camera(
            brand='Nikon', 
            model='D3400', 
            release_date=datetime(2021, 6, 15).date(), 
            score=4, 
            category='Amateur', 
            description='Excellent pour débuter'
        ),
        Camera(
            brand='Sony', 
            model='A6000', 
            release_date=datetime(2019, 3, 20).date(), 
            score=5, 
            category='Amateur sérieux', 
            description='Hybride très polyvalent'
        ),
        Camera(
            brand='Canon', 
            model='EOS R5', 
            release_date=datetime(2020, 7, 30).date(), 
            score=5, 
            category='Professionnel', 
            description='Appareil phare pour les professionnels'
        ),
    ]
    
    # Ajouter des télescopes
    telescopes = [
        Telescope(
            brand='Celestron', 
            model='StarPointer', 
            release_date=datetime(2019, 1, 1).date(), 
            score=4, 
            category='Pour enfants', 
            description='Télescope idéal pour débuter'
        ),
        Telescope(
            brand='Meade', 
            model='EclipseView', 
            release_date=datetime(2020, 5, 10).date(), 
            score=3, 
            category='Pour enfants', 
            description='Parfait pour les enfants'
        ),
        Telescope(
            brand='Celestron', 
            model='Nexstar 8SE', 
            release_date=datetime(2021, 2, 20).date(), 
            score=5, 
            category='Automatisés', 
            description='Télescope automatisé très précis'
        ),
        Telescope(
            brand='Meade', 
            model='LX90', 
            release_date=datetime(2018, 8, 15).date(), 
            score=5, 
            category='Complets', 
            description='Solution complète pour l\'astronomie'
        ),
    ]
    
    # Ajouter des photographies
    photographs = [
        Photograph(
            title='La Lune', 
            description='Photo de la Lune en haute résolution',
            image_path='/static/images/moon.jpg'
        ),
        Photograph(
            title='Voie Lactée', 
            description='Voie Lactée photographiée depuis les Alpes',
            image_path='/static/images/milkyway.jpg'
        ),
    ]
    
    db.session.add_all(cameras + telescopes + photographs)
    db.session.commit()
    print('✅ Base de données remplie avec les données de test.')


if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True, host='0.0.0.0', port=5000)