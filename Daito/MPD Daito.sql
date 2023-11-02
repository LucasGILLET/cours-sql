    -- Suppression de la BDD préexistante
    DROP DATABASE IF EXISTS daito;

    -- Création de la BDD
    CREATE DATABASE IF NOT EXISTS daito CHARACTER SET utf8 COLLATE utf8_general_ci;

    USE daito;


    -- Création de la table guilds
    CREATE TABLE IF NOT EXISTS guilds (
        id INT NOT NULL AUTO_INCREMENT,
        name VARCHAR(255) NOT NULL,
        guild_level INT NOT NULL,
        total_players INT NOT NULL,
        PRIMARY KEY (id),
        CHECK (total_players <= 50)
    ) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    -- Création de la table classes
    CREATE TABLE classes (
        id INT NOT NULL AUTO_INCREMENT,
        name VARCHAR(255) NOT NULL,
        color VARCHAR(255) NOT NULL,
        PRIMARY KEY (id)
    ) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    -- Création de la table players
    CREATE TABLE players (
        id INT NOT NULL AUTO_INCREMENT,
        name VARCHAR(255) NOT NULL,
        life_points INT,
        mana_points INT,
        xp_points INT,
        guild_id INT NOT NULL,
        class_id INT NOT NULL,
        PRIMARY KEY (id),
        CONSTRAINT fk_players_1 FOREIGN KEY(guild_id) REFERENCES guilds(id),
        CONSTRAINT fk_players_2 FOREIGN KEY(class_id) REFERENCES classes(id)
    ) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    -- Création de la table confrontations
    CREATE TABLE confrontations (
        id INT NOT NULL AUTO_INCREMENT,
        player_1_id INT NOT NULL,
        player_2_id INT NOT NULL,
        is_victory BOOLEAN,
        date_confrontation DATETIME DEFAULT NOW(),
        glory_points INT NOT NULL,
        PRIMARY KEY (id),
        CONSTRAINT fk_confrontations_1 FOREIGN KEY(player_1_id) REFERENCES players(id),
        CONSTRAINT fk_confrontations_2 FOREIGN KEY(player_2_id) REFERENCES players(id)
    ) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    -- Création de la table skills
    CREATE TABLE skills (
        id INT NOT NULL AUTO_INCREMENT,
        name VARCHAR(255) NOT NULL,
        damages INT NOT NULL,
        PRIMARY KEY (id)
    ) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



    -- Création de la table de jointure entre players et skills (many to many)
    CREATE TABLE players_skills (
        player_id INT NOT NULL,
        skill_id INT NOT NULL,
        PRIMARY KEY(player_id, skill_id),
        CONSTRAINT fk_players_skills_1 FOREIGN KEY(player_id) REFERENCES players(id),
        CONSTRAINT fk_players_skills_2 FOREIGN KEY(skill_id) REFERENCES skills(id)
    ) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    -- Créer un script SQL qui va peupler la BDD grâce à une IA (parce que bon le faire soi-même hein...)

    -- Insertion de données dans la table "classes"
    INSERT INTO classes (name, color) VALUES
    ('Mage', 'bleu'),
    ('Archer', 'vert'),
    ('Guerrier', 'rouge');

    -- Insertion de données dans la table "skills"
    INSERT INTO skills (name, damages) VALUES
    ('Boule de feu', 10),
    ('Main éléctrique', 3),
    ('Pique de glace', 6);

    -- Insérer des guilds (guildes) factices
    INSERT INTO guilds (name, guild_level, total_players) VALUES
    ('Guild A', 1, 10),
    ('Guild B', 2, 8),
    ('Guild C', 3, 12);

    -- Insérer des joueurs (players) avec des guild_id et class_id existants
    INSERT INTO players (name, life_points, mana_points, xp_points, guild_id, class_id) VALUES
    ('Player 1', 100, 50, 500, 1, 1),
    ('Player 2', 120, 60, 600, 1, 2),
    ('Player 3', 90, 40, 450, 2, 2);

    -- Insérer des confrontations factices avec player_1_id et player_2_id existants
    INSERT INTO confrontations (player_1_id, player_2_id, is_victory, glory_points) VALUES
    (1, 2, true, 100),
    (1, 3, false, 50),
    (2, 3, true, 80);

    -- Insérer des liens entre des joueurs et des compétences
    INSERT INTO players_skills (player_id, skill_id) VALUES
    (1, 1),
    (1, 2),
    (2, 2),
    (3, 3);