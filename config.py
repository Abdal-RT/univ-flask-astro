import os

class Config:
    """Configuration de base pour l'application Flask"""
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'dev-secret-key-change-in-production'
    
    # Configuration MySQL via socket Unix (Pour Debian/Ubuntu)
    SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://root@/astronomy_db?unix_socket=/run/mysqld/mysqld.sock'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    
    # Configuration de session
    PERMANENT_SESSION_LIFETIME = 86400  # 24 heures
    SESSION_COOKIE_SECURE = False
    SESSION_COOKIE_HTTPONLY = True
    SESSION_COOKIE_SAMESITE = 'Lax'
