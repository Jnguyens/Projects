SELECT *
FROM nba;

# Creating second table to work on to leave original data as is

CREATE TABLE nba2
LIKE nba;

INSERT INTO nba2
SELECT *
FROM nba;

SELECT *
FROM nba2;

# Fixing column names and dropping irrelevant columns

ALTER TABLE nba2
RENAME COLUMN team_abbreviation TO team;

ALTER TABLE nba2
RENAME COLUMN player_weight TO weight_kg;

ALTER TABLE nba2
RENAME COLUMN player_height TO height_cm;

ALTER TABLE nba2
DROP COLUMN college;

SELECT *
FROM nba2;

# Checking what year the data starts and end at

SELECT MIN(`season`), MAX(`season`)
FROM nba2;

# Taking a look to see how height and weight affect point averages

SELECT player_name, age, height_cm, weight_kg, gp, pts, ts_pct, season
FROM nba2
WHERE gp >= 55
ORDER BY pts DESC, ts_pct;

# Highest points per game average

SELECT player_name, age, gp, pts, reb, ast, season 
FROM nba2
WHERE gp >= 55
ORDER BY pts DESC, reb, ast;

# Average points per game by every player from each season

SELECT season, AVG(pts)
FROM nba2
WHERE gp >= 55
GROUP BY season
ORDER BY 2 DESC;

# Amount of players in the NBA from each season

SELECT season, COUNT(DISTINCT player_name) AS num_of_players
FROM nba2
GROUP BY season
ORDER BY 2 DESC;

# Number of players from each country

SELECT country, COUNT(country) AS num_of_players
FROM nba2
GROUP BY country
ORDER BY num_of_players DESC;

#Players on each team from 2013 to 2023

SELECT DISTINCT player_name, team, season
FROM nba2
WHERE  SUBSTRING(`season`, 1, 4) >= "2013"
ORDER BY team, season;

# Total players in the NBA since 1996

WITH Rolling_Total AS 
(
SELECT season, COUNT(DISTINCT player_name) AS total_players
FROM nba2
GROUP BY season
ORDER BY season ASC
)
SELECT season, total_players, 
SUM(total_players) OVER(ORDER BY season) as rolling_total
FROM Rolling_Total;

SELECT *
FROM nba2;


