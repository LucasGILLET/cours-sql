    -- Suppression de la BDD préexistante
    DROP DATABASE IF EXISTS blog;

    -- Création de la BDD
    CREATE DATABASE IF NOT EXISTS blog CHARACTER SET utf8 COLLATE utf8_general_ci;

    USE blog;

    -- Création de la table articles
    CREATE TABLE IF NOT EXISTS articles (
        id INT NOT NULL AUTO_INCREMENT,
        title VARCHAR(255) NOT NULL,
        content TEXT,
        PRIMARY KEY (id)
    ) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    -- Création de la table events
    CREATE TABLE IF NOT EXISTS events (
        id INT NOT NULL AUTO_INCREMENT,
        type VARCHAR(255) NOT NULL,
        color VARCHAR(255) NOT NULL,
        PRIMARY KEY (id)
    ) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    -- Création de la table de jointure entre articles et events (many to many)
    CREATE TABLE articles_events (
        article_id INT NOT NULL,
        event_id INT NOT NULL,
        date DATETIME DEFAULT NOW(),
        PRIMARY KEY(article_id, event_id, date),
        CONSTRAINT fk_articles_events_1 FOREIGN KEY(article_id) REFERENCES articles(id),
        CONSTRAINT fk_articles_events_2 FOREIGN KEY(event_id) REFERENCES events(id)
    ) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


    -- Insertion de données dans la table "events"
    INSERT INTO events (type, color) VALUES
    ('ADD', 'vert'),
    ('MODIFY', 'blue'),
    ('DELETE', 'rouge');

    -- Insertion de données dans la table "articles"
    INSERT INTO articles (title, content) VALUES
    ('La vie', 'la vie cest bien mais en fait on se promène et voila'),
    ('La mort', 'la mort cest pas beaucoup mieux mais bon faut bien parler de quelque chose dans cet article.'),
    ('Les pissenlits', 'jy connais rien mais je sais que cest des fleurs alors cest deja pas mal');

    -- Insérer des liens entre des joueurs et des compétences
    INSERT INTO articles_events (article_id, event_id, date) VALUES
    (1, 1, "2023-11-29 09:41:18"),
    (1, 2, "2023-11-29 09:41:35"),
    (2, 1, "2023-11-29 09:41:50"),
    (2, 2, "2023-11-29 09:41:58"),
    (2, 2, "2023-11-29 09:48:00"),
    (2, 3, "2023-11-29 09:50:00"),
    (3, 3, "2023-11-29 09:51:00");