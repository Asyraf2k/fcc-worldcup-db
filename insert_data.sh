#!/bin/bash

if [[ $1 == "test" ]]
then
  DB_CONNECTION="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  DB_CONNECTION="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi


echo $($DB_CONNECTION "TRUNCATE teams, games")

cat games.csv | while IFS="," read GAME_YEAR GAME_ROUND WINNING_TEAM OPPONENT_TEAM WINNER_SCORE OPPONENT_SCORE
do
  if [[ $GAME_YEAR != "year" ]]
  then
    WINNER_TEAM_ID=$($DB_CONNECTION "SELECT team_id FROM teams WHERE name='$WINNING_TEAM'")

    if [[ -z $WINNER_TEAM_ID ]]
    then
      ADD_WINNER_RESULT=$($DB_CONNECTION "INSERT INTO teams(name) VALUES('$WINNING_TEAM')")
      if [[ $ADD_WINNER_RESULT == "INSERT 0 1" ]]
      then
        echo "Tim pemenang ditambahkan: $WINNING_TEAM"
      fi
    fi

    OPPONENT_TEAM_ID=$($DB_CONNECTION "SELECT team_id FROM teams WHERE name='$OPPONENT_TEAM'")

    if [[ -z $OPPONENT_TEAM_ID ]]
    then
      ADD_OPPONENT_RESULT=$($DB_CONNECTION "INSERT INTO teams(name) VALUES('$OPPONENT_TEAM')")
      if [[ $ADD_OPPONENT_RESULT == "INSERT 0 1" ]]
      then
        echo "Tim lawan ditambahkan: $OPPONENT_TEAM"
      fi
    fi

    WINNER_TEAM_ID=$($DB_CONNECTION "SELECT team_id FROM teams WHERE name='$WINNING_TEAM'")
    OPPONENT_TEAM_ID=$($DB_CONNECTION "SELECT team_id FROM teams WHERE name='$OPPONENT_TEAM'")

    # Menambahkan pertandingan ke tabel games
    ADD_GAME_RESULT=$($DB_CONNECTION "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) 
                                     VALUES($GAME_YEAR, '$GAME_ROUND', $WINNER_TEAM_ID, $OPPONENT_TEAM_ID, $WINNER_SCORE, $OPPONENT_SCORE)")
    if [[ $ADD_GAME_RESULT == "INSERT 0 1" ]]
    then
      echo "Pertandingan ditambahkan: $GAME_YEAR $GAME_ROUND - $WINNING_TEAM vs $OPPONENT_TEAM"
    fi
  fi
done
