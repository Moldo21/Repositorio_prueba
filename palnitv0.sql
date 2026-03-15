-- ========================================
-- CREACIÓN DE BASE DE DATOS
-- ========================================
CREATE DATABASE IF NOT EXISTS planit;

USE planit;

-- ========================================
-- TABLA ROLES
-- ========================================
CREATE TABLE roles (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ========================================
-- TABLA USUARIOS
-- ========================================
CREATE TABLE usuarios (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    rol_id BIGINT UNSIGNED NOT NULL,

    telefono VARCHAR(20) NULL,
    pais VARCHAR(100) NULL,
    codigo_postal VARCHAR(20) NULL,
    poblacion VARCHAR(100) NULL,
    direccion VARCHAR(255) NULL,

    fecha_nacimiento DATE NULL,
    documento_identidad VARCHAR(50) UNIQUE NULL,

    intentos_fallidos INT NOT NULL DEFAULT 0 CHECK (intentos_fallidos >= 0),
    bloqueado_hasta DATETIME NULL,

    remember_token VARCHAR(100) NULL,

    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_usuario_rol
        FOREIGN KEY (rol_id)
        REFERENCES roles(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ========================================
-- TABLA SESSIONS
-- ========================================
CREATE TABLE sessions (
    id VARCHAR(255) PRIMARY KEY,
    user_id BIGINT UNSIGNED NULL,
    ip_address VARCHAR(45) NULL,
    user_agent TEXT NULL,
    payload LONGTEXT NOT NULL,
    last_activity INT NOT NULL,

    INDEX idx_sessions_user_id (user_id),
    INDEX idx_sessions_last_activity (last_activity)
);

-- ========================================
-- TABLA PASSWORD_RESETS
-- ========================================
CREATE TABLE password_resets (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(150) NOT NULL,
    token VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_password_email (email)
);

-- ========================================
-- TABLA EMAIL_VERIFICATIONS
-- ========================================

CREATE TABLE email_verifications (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(150) NOT NULL,
    token VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_email_verifications_email (email)
);