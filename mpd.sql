-- Suppression de la BDD préexistante
DROP DATABASE IF EXISTS cours_sql;

-- Création de la BDD
CREATE DATABASE IF NOT EXISTS cours_sql CHARACTER SET utf8 COLLATE utf8_general_ci;

USE cours_sql;

-- Création de la table articles
CREATE TABLE articles (
	id INT NOT NULL AUTO_INCREMENT,
	title VARCHAR(255) NOT NULL,
	description VARCHAR(255) NOT NULL,
	content TEXT NOT NULL,
	PRIMARY KEY (id)
) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Création de la table tags
CREATE TABLE tags (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL,
	PRIMARY KEY (id)
) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Création de la table comments
CREATE TABLE comments (
	id INT NOT NULL AUTO_INCREMENT,
	content TEXT NOT NULL,
    published_at DATETIME DEFAULT NOW(),
    article_id INT NOT NULL,
	PRIMARY KEY (id),
    CONSTRAINT fk_comments_1 FOREIGN KEY(article_id) REFERENCES articles(id)
) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Création de la table de jointure entre tags et articles (many to many)
CREATE TABLE articles_tags (
    article_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY(article_id, tag_id),
    CONSTRAINT fk_articles_tags_1 FOREIGN KEY(article_id) REFERENCES articles(id),
    CONSTRAINT fk_articles_tags_2 FOREIGN KEY(tag_id) REFERENCES tags(id)
) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;