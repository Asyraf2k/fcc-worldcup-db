#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"

echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo "$($PSQL "SELECT MAX(winner_goals) FROM games")"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games WHERE round='Final'")"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > opponent_goals")"
echo "$($PSQL "SELECT name FROM teams WHERE team_id=(SELECT winner_id FROM games WHERE round='Final' AND year=2018)")"
echo "$($PSQL "SELECT DISTINCT name FROM teams FULL JOIN games ON teams.team_id=games.winner_id OR teams.team_id=games.opponent_id WHERE year=2014 ORDER BY name")"
