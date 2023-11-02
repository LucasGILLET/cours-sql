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

-- Créer un script SQL qui va peupler la BDD grâce à une IA (parce que bon le faire soi-même hein...)

-- Insertion de données dans la table "articles"
INSERT INTO articles (title, description, content) VALUES
('Article 1', 'Description de l article 1', 'Contenu de l article 1'),
('Article 2', 'Description de l article 2', 'Contenu de l article 2'),
('Article 3', 'Description de l article 3', 'Contenu de l article 3');

-- Insertion de données dans la table "tags"
INSERT INTO tags (name, color) VALUES
('HTML', 'Rouge'),
('CSS', 'Bleu'),
('JavaScript', 'Vert');

-- Insertion de données dans la table "comments"
INSERT INTO comments (content, article_id) VALUES
('Commentaire 1 pour l article 1', 1),
('Commentaire 2 pour l article 1', 1),
('Commentaire 1 pour l article 2', 2);

-- Insertion de données dans la table "articles_tags" (associations entre articles et tags)
INSERT INTO articles_tags (article_id, tag_id) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 3);


-- Ecrire une requete SQL qui va compter le nombre d'articles associés à un tag précis
SELECT COUNT(articles.id) FROM articles 
INNER JOIN articles_tags ON articles.id = articles_tags.article_id
INNER JOIN tags ON articles_tags.tag_id = tags.id
WHERE tags.name = "HTML";


-- Ecrire une requete SQL qui va afficher le nombre de commentaires par article
SELECT articles.title, COUNT(comments.id) AS nb_com FROM articles
INNER JOIN comments ON comments.article_id = articles.id
GROUP BY articles.id;