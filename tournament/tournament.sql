-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.
--DRop Database if exist
DROP database IF EXISTS tournament;
--Creating Database
CREATE database tournament;
--connecting to database
\c tournament;
--create table name players
create table players (
	id serial PRIMARY KEY,
 	player_name text not null
       );
--create table for matches
CREATE TABLE matches (
	match_id serial primary key,
	won integer references players(id),
	loss integer references players(id)
 	);
--create view to get players and match win
CREATE VIEW match_wins as
    SELECT
        players.id,
        players.player_name,
        COUNT(matches.won) AS wins
    FROM
        matches
    RIGHT JOIN
        players ON matches.won = players.id
    GROUP BY
        players.id
    ORDER BY
        wins DESC;
-- create view to get players and match loss
create view match_loss as
 select players.id,players.player_name,count(matches.loss) as losses from matches right join players on
 matches.loss=players.id group by players.id order by losses ASC;
---create view player_standing
create view player_standing as
select match_wins.id,match_wins.player_name,match_wins.wins,match_loss.losses+match_wins.wins as
matches,match_loss.losses from match_wins,match_loss where match_wins.id=match_loss.id order by
match_wins.wins desc;
