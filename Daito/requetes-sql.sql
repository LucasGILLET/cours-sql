-- 1 - Combien de joueurs sont inscrits sur le jeu Daïto ?
SELECT COUNT(players.id) AS nombre_de_joueurs FROM players;

-- 2 - Afficher le TOP 5 des joueurs ayant le plus de points d'expérience. En cas d'égalité afficher les joueurs par ordre alphabétique.
SELECT * FROM players ORDER BY xp_points DESC, name ASC LIMIT 5;

-- 3 - Afficher la liste des compétences par ordre alphabétique.
SELECT * FROM skills ORDER BY name ASC;

-- 4 - Afficher en face de chaque classe, le nombre de joueurs y appartenant.
SELECT classes.name, COUNT(players.id) AS nombre_de_joueurs 
FROM classes
LEFT JOIN players ON classes.id = players.class_id
GROUP BY classes.name;
-- -> ici j'ai utilisé un LEFT JOIN pour quand même obtenir les résultats nuls dans les classes (Guerrier = 0 par exemple)

-- 5 - Afficher le TOP 3 des meilleurs guildes (meilleur niveau). En cas d'égalité, afficher les guildes par ordre alphabétique.
SELECT * FROM guilds ORDER BY guild_level DESC, name ASC LIMIT 3;

-- 6 - Quel est le niveau moyen des guildes du jeu ?
SELECT AVG(guild_level) AS niveau_moyen FROM guilds;

-- 7 - Afficher le nombre de victoires pour chaque joueur.
SELECT
    players.name AS Joueur,
    SUM(CASE
        WHEN confrontations.player_1_id = players.id AND confrontations.is_victory = 1 THEN 1
        WHEN confrontations.player_2_id = players.id AND confrontations.is_victory = 0 THEN 1
        ELSE 0
    END) AS nombre_de_victoires
FROM players
LEFT JOIN confrontations ON players.id = confrontations.player_1_id OR players.id = confrontations.player_2_id
GROUP BY players.name;
-- -> ici je viens utiliser CASE pour différencier les cas : si c'est le joueur 1 et que is_victory = 1 alors on compte une victoire, ELSE une défaite, et inversement pour player_2
-- -> on fait la somme de tout ça et on obtient alors le résultat

-- 8 - Quel est le montant maximal de dommages causés par la meilleure compétence ?
SELECT skills.name AS Compétence, skills.damages AS Dégats FROM skills
ORDER BY skills.damages DESC LIMIT 1;

-- 9 - Combien de combats ont eu lieu en 2023 ?
SELECT COUNT(confrontations.id) AS nombre_de_combats_2023 FROM confrontations
WHERE YEAR(date_confrontation) = 2023;

-- 10 - Pour quelle classe un personnage aura-t-il un pseudo écrit en bleu ?
SELECT classes.name AS Classe_en_bleu FROM classes WHERE classes.color = "bleu";

-- 11 - Quelle guilde contient le plus de joueurs ?
SELECT guilds.name AS Guilde_plus_joueurs, COUNT(players.id) AS Nombre_de_joueurs FROM guilds
LEFT JOIN players ON guilds.id = players.guild_id
GROUP BY guilds.name
ORDER BY Nombre_de_joueurs DESC LIMIT 1;

-- 12 - Quel joueur a perdu le plus de combats ?
SELECT
    players.name AS Joueur,
    SUM(CASE
        WHEN confrontations.player_1_id = players.id AND confrontations.is_victory = 0 THEN 1
        WHEN confrontations.player_2_id = players.id AND confrontations.is_victory = 1 THEN 1
        ELSE 0
    END) AS nombre_de_defaites
FROM players
LEFT JOIN confrontations ON players.id = confrontations.player_1_id OR players.id = confrontations.player_2_id
GROUP BY players.name
ORDER BY nombre_de_defaites DESC LIMIT 1;
-- -> ici j'ai repris mon code précédent, en modifiant le nombre de victoire en nombre de défaites et en affichant uniquement le premier de la liste.

-- 13 - Dans quelle guilde les joueurs ont en moyenne le plus de points de gloire ?
SELECT guilds.name, AVG(players.glory_points) AS Moyenne FROM guilds 
INNER JOIN players ON players.guild_id = guilds.id 
GROUP BY guilds.name
ORDER BY Moyenne DESC LIMIT 1;

-- CI-dessous, je me suis amusé à faire un "vrai" scoreboard avec le nombre total de parties et le winrate
SELECT
    players.name AS Joueur,
    SUM(CASE
        WHEN confrontations.player_1_id = players.id AND confrontations.is_victory = 1 THEN 1
        WHEN confrontations.player_2_id = players.id AND confrontations.is_victory = 0 THEN 1
        ELSE 0
    END) AS nombre_de_victoires,
    SUM(CASE
        WHEN confrontations.player_1_id = players.id AND confrontations.is_victory = 0 THEN 1
        WHEN confrontations.player_2_id = players.id AND confrontations.is_victory = 1 THEN 1
        ELSE 0
    END) AS nombre_de_defaites,
    SUM(
        CASE
            WHEN confrontations.player_1_id = players.id AND confrontations.is_victory = 1 THEN 1
            WHEN confrontations.player_2_id = players.id AND confrontations.is_victory = 0 THEN 1
            WHEN confrontations.player_1_id = players.id AND confrontations.is_victory = 0 THEN 1
            WHEN confrontations.player_2_id = players.id AND confrontations.is_victory = 1 THEN 1
            ELSE 0
        END
    ) AS nombre_de_matchs,
    (CAST(SUM(CASE
        WHEN confrontations.player_1_id = players.id AND confrontations.is_victory = 1 THEN 1
        WHEN confrontations.player_2_id = players.id AND confrontations.is_victory = 0 THEN 1
        ELSE 0
    END) AS DECIMAL(10, 2)) / NULLIF(SUM(
        CASE
            WHEN confrontations.player_1_id = players.id THEN 1
            WHEN confrontations.player_2_id = players.id THEN 1
            ELSE 0
        END
    ), 0)) * 100 AS pourcentage_victoires
FROM players
LEFT JOIN confrontations ON players.id = confrontations.player_1_id OR players.id = confrontations.player_2_id
GROUP BY players.name
ORDER BY pourcentage_victoires DESC
LIMIT 10;


-- Envoyer à thibaud.arros@gmail.com
-- MCD + MLD + MPD + scripts de déchargement de données + requêtes
-- Objet du mail : "WEBTECH N3/N4 Prénom Nom"