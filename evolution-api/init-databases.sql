-- Crear bases de datos necesarias para Hunabku
CREATE DATABASE IF NOT EXISTS hk_autenticacion;
CREATE DATABASE IF NOT EXISTS evolution_db;

-- Dar permisos al usuario sail
GRANT ALL PRIVILEGES ON hk_autenticacion.* TO 'sail'@'%';
GRANT ALL PRIVILEGES ON evolution_db.* TO 'sail'@'%';
FLUSH PRIVILEGES;

