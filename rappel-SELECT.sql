-- On a des jeux vidéos(id, name, price, second_hand) associés à 0 ou plusieurs tags(id, name, color)

-- Combien de tags dans notre DB ?
SELECT COUNT(tags.id) FROM tags;

-- Liste des jeux neufs
SELECT * video_games WHERE second_hand = 0;

-- Combien de jeux d'occasion
SELECT COUNT(id) FROM video_games WHERE second_hand = 0;

-- Les 3 les plus chers
SELECT * FROM video_games ORDER BY price DESC LIMIT 3;

-- Nombre de jeux par tag
SELECT tags.name, COUNT(video_games.id) AS total FROM video_games
INNER JOIN video_games_tags ON video_games.id = video_games_tags.video_game_id
INNER JOIN video_games_tags ON tag.id = video_games_tags.tag_id
GROUP BY tags.name;

-- Prix moyen des jeux par tag
SELECT tags.name, AVG(video_games.price) AS price FROM video_games
INNER JOIN video_games_tags ON video_games.id = video_games_tags.video_game_id
INNER JOIN tags ON tags.id = video_games_tags.tag_id
GROUP BY tags.name;