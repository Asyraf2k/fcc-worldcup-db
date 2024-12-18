#!/bin/bash

DB_CONNECTION="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"


echo -e "\nTotal jumlah gol dalam semua pertandingan dari tim pemenang:"
echo "$($DB_CONNECTION "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal jumlah gol dalam semua pertandingan dari kedua tim:"
echo "$($DB_CONNECTION "SELECT SUM(winner_goals + opponent_goals) FROM games")"

echo -e "\nRata-rata jumlah gol dalam semua pertandingan dari tim pemenang:"
echo "$($DB_CONNECTION "SELECT AVG(winner_goals) FROM games")"

echo -e "\nRata-rata jumlah gol dalam semua pertandingan dari tim pemenang (dibulatkan dua desimal):"
echo "$($DB_CONNECTION "SELECT ROUND(AVG(winner_goals), 2) FROM games")"

echo -e "\nRata-rata jumlah gol dalam semua pertandingan dari kedua tim:"
echo "$($DB_CONNECTION "SELECT AVG(winner_goals + opponent_goals) FROM games")"

echo -e "\nJumlah gol terbanyak yang dicetak oleh satu tim dalam satu pertandingan:"
echo "$($DB_CONNECTION "SELECT MAX(winner_goals) FROM games")"

echo -e "\nJumlah pertandingan di mana tim pemenang mencetak lebih dari dua gol:"
echo "$($DB_CONNECTION "SELECT COUNT(*) FROM games WHERE winner_goals > 2")"

echo -e "\nPemenang turnamen 2018 (nama tim):"
echo "$($DB_CONNECTION "SELECT name FROM teams INNER JOIN games ON teams.team_id = games.winner_id WHERE year = 2018 AND round = 'Final'")"

echo -e "\nDaftar tim yang bermain di babak 'Eighth-Final' 2014:"
echo "$($DB_CONNECTION "SELECT DISTINCT(name) FROM teams INNER JOIN games ON teams.team_id = games.winner_id OR teams.team_id = games.opponent_id WHERE year = 2014 AND round = 'Eighth-Final'")"

echo -e "\nDaftar nama tim pemenang yang unik dalam seluruh data:"
echo "$($DB_CONNECTION "SELECT DISTINCT(name) FROM teams INNER JOIN games ON teams.team_id = games.winner_id ORDER BY name")"

echo -e "\nTahun dan nama tim juara di setiap turnamen:"
echo "$($DB_CONNECTION "SELECT year, name FROM teams INNER JOIN games ON teams.team_id = games.winner_id WHERE round = 'Final' ORDER BY year")"

echo -e "\nDaftar tim yang namanya dimulai dengan 'Co':"
echo "$($DB_CONNECTION "SELECT name FROM teams WHERE name LIKE 'Co%'")"
