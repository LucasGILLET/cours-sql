-- Création de la BDD
CREATE DATABASE IF NOT EXISTS cours_sql CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Création de la table articles
CREATE TABLE articles (
	id INT NOT NULL AUTO_INCREMENT,
	title VARCHAR(255) NOT NULL,
	description VARCHAR(255) NOT NULL,
	content TEXT NOT NULL,
	PRIMARY KEY (id)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Création de la table tags
CREATE TABLE tags (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	PRIMARY KEY (id)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Création de la table comments
CREATE TABLE comments (
	id INT NOT NULL AUTO_INCREMENT,
	content TEXT NOT NULL,
	PRIMARY KEY (id)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;