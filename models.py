from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime

db = SQLAlchemy()

class User(db.Model):
    """Modèle utilisateur pour l'authentification"""
    __tablename__ = 'users'
    
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False, index=True)
    email = db.Column(db.String(120), unique=True, nullable=False, index=True)
    password_hash = db.Column(db.String(255), nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    def set_password(self, password):
        """Hasher et stocker le mot de passe"""
        self.password_hash = generate_password_hash(password)
    
    def check_password(self, password):
        """Vérifier le mot de passe"""
        return check_password_hash(self.password_hash, password)
    
    def get_id(self):
        return str(self.id)
    
    def is_authenticated(self):
        return True
    
    def is_active(self):
        return True
    
    def is_anonymous(self):
        return False
    
    def __repr__(self):
        return f'<User {self.username}>'


class Camera(db.Model):
    """Modèle pour les appareils photos"""
    __tablename__ = 'cameras'
    
    id = db.Column(db.Integer, primary_key=True)
    brand = db.Column(db.String(120), nullable=False)
    model = db.Column(db.String(120), nullable=False)
    release_date = db.Column(db.Date, nullable=False)
    score = db.Column(db.Integer, nullable=False)  # De 1 à 5
    category = db.Column(db.String(50), nullable=False)  # Amateur, Amateur sérieux, Professionnel
    description = db.Column(db.Text)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    def __repr__(self):
        return f'<Camera {self.brand} {self.model}>'


class Telescope(db.Model):
    """Modèle pour les télescopes"""
    __tablename__ = 'telescopes'
    
    id = db.Column(db.Integer, primary_key=True)
    brand = db.Column(db.String(120), nullable=False)
    model = db.Column(db.String(120), nullable=False)
    release_date = db.Column(db.Date, nullable=False)
    score = db.Column(db.Integer, nullable=False)  # De 1 à 5
    category = db.Column(db.String(50), nullable=False)  # Pour enfants, Automatisés, Complets
    description = db.Column(db.Text)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    def __repr__(self):
        return f'<Telescope {self.brand} {self.model}>'


class Photograph(db.Model):
    """Modèle pour les photographies"""
    __tablename__ = 'photographs'
    
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200), nullable=False)
    description = db.Column(db.Text)
    image_path = db.Column(db.String(255), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    user = db.relationship('User', backref='photographs')
    
    def __repr__(self):
        return f'<Photograph {self.title}>'


class News(db.Model):
    """Modèle pour les actualités"""
    __tablename__ = 'news'
    
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200), nullable=False)
    content = db.Column(db.Text, nullable=False)
    image_path = db.Column(db.String(255), nullable=True)
    author_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    is_published = db.Column(db.Boolean, default=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    author = db.relationship('User', backref='news_articles')
    
    def __repr__(self):
        return f'<News {self.title}>'


class ForumThread(db.Model):
    """Modèle pour les fils de discussion"""
    __tablename__ = 'forum_threads'
    
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200), nullable=False)
    category = db.Column(db.String(50), nullable=False)  # Appareil photo, Télescope, Astrophotographie, Général
    description = db.Column(db.Text, nullable=False)
    author_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    is_locked = db.Column(db.Boolean, default=False)
    is_pinned = db.Column(db.Boolean, default=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    author = db.relationship('User', backref='forum_threads')
    posts = db.relationship('ForumPost', backref='thread', cascade='all, delete-orphan')
    
    def __repr__(self):
        return f'<ForumThread {self.title}>'
    
    def get_post_count(self):
        return len(self.posts)
    
    def get_last_post(self):
        if self.posts:
            return sorted(self.posts, key=lambda p: p.created_at)[-1]
        return None


class ForumPost(db.Model):
    """Modèle pour les messages du forum"""
    __tablename__ = 'forum_posts'
    
    id = db.Column(db.Integer, primary_key=True)
    content = db.Column(db.Text, nullable=False)
    author_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    thread_id = db.Column(db.Integer, db.ForeignKey('forum_threads.id'), nullable=False)
    likes_count = db.Column(db.Integer, default=0)
    is_solution = db.Column(db.Boolean, default=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    author = db.relationship('User', backref='forum_posts')
    
    def __repr__(self):
        return f'<ForumPost by {self.author.username}>'
