--- 2021-2022 Premier League Sesaon Stat-Based Queries---
--- PL Misc/Defensive Stats---
--- Initial Query---
SELECT *
FROM pl_season_2022
LIMIT 5;

--- Win/Draw/Loss Record For Each Team---
SELECT team, CONCAT(COUNT(CASE WHEN result = 'W' THEN 1 END ),'-', 
					COUNT(CASE WHEN result = 'D' THEN 1 END), '-',
				   COUNT(CASE WHEN result = 'L' THEN 1 END)) win_draw_loss_record
FROM pl_season_2022
GROUP BY team
ORDER BY COUNT(CASE WHEN result = 'W' THEN 1 END ) DESC;

---- The Win Total For Each Team When They Are Home And When They Are Away ---
SELECT team, venue, COUNT(CASE WHEN result = 'W' THEN 1 END ) wins
FROM pl_season_2022
GROUP BY team, venue
ORDER BY team;

--- Point Total For Each Team---
SELECT t1.team, (t1.wins * 3 + t1.draw * 1) points
FROM(
SELECT team, COUNT(CASE WHEN result = 'W' THEN 1 END ) wins, 
COUNT(CASE WHEN result = 'D' THEN 1 END) draw
FROM pl_season_2022
GROUP BY team) t1
ORDER BY points DESC;

--- Game By Game Point Total By Team ---
WITH running_points AS (
SELECT t1.team, (t1.wins * 3 + t1.draw * 1) points
FROM(
SELECT team, (CASE WHEN result = 'W' THEN 1 ELSE 0 END) wins, (CASE WHEN result = 'D' THEN 1 ELSE 0 END) draw,
	(CASE WHEN result = 'L' THEN 1 ELSE 0 END) loss
FROM pl_season_2022) t1)

SELECT team, points, SUM(points) OVER (PARTITION BY team Rows BETWEEN UNBOUNDED PRECEDING AND current row)
FROM running_points;

--- Teams That Allowed The Most Goals In Total/Per Game ---
SELECT team, SUM(goal_allowed) total_goals_allowed
FROM pl_season_2022
GROUP BY team
ORDER BY total_goals_allowed DESC;

SELECT team, AVG(goal_allowed) goals_allowed_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY goals_allowed_per_game DESC;

--- Game By Game Breakdown Of Goals Allowed By Teach Team
SELECT team, goal_allowed, (LAG(goal_allowed, 1) OVER (PARTITION BY team)) gbg_ga
FROM pl_season_2022;

--- Averaged Expected Goals Allowed Per Game ---
SELECT team, AVG(expected_goals_allowed) expected_goals_allowed_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY expected_goals_allowed_per_game DESC;

--- Team That Had The Most Shots On Target Against In Total/Per Game ---
SELECT team, SUM(shots_on_target_against) total_shots_on_target_against
FROM pl_season_2022
GROUP BY team
ORDER BY total_shots_on_target_against DESC;

SELECT team, AVG(shots_on_target_against) shots_on_target_against_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY shots_on_target_against_per_game DESC;

--- Team That Kept The Most Clean Sheets In Total/Per Game ---
SELECT team, SUM(clean_sheets) total_clean_sheets
FROM pl_season_2022
GROUP BY team
ORDER BY total_clean_sheets DESC;

SELECT team, AVG(clean_sheets) clean_sheets_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY clean_sheets_per_game DESC;

--- Team That Had The Most Saves In Total/Per Game ----
SELECT team, SUM(saves) total_saves
FROM pl_season_2022
GROUP BY team
ORDER BY total_saves DESC;

SELECT team, AVG(saves) saves_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY saves_per_game DESC;

--- Team That Had The Highest Save Percentage--
SELECT team, ((SUM(shots_on_target_against) - SUM(goal_allowed)) *100/(SUM(shots_on_target_against))) save_percentage
FROM pl_season_2022
GROUP BY team
ORDER BY save_percentage DESC;

--- Team That Had The Highest Save Ratio---
SELECT team, (SUM(saves)/SUM(goal_allowed)) save_ratio
FROM pl_season_2022
GROUP BY team
ORDER BY save_ratio DESC;

--- Team That Had The Most Penalty Kick Saves In Total ----
SELECT team, SUM(penalty_kick_saves) total_penalty_kick_saves
FROM pl_season_2022
GROUP BY team
ORDER BY total_penalty_kick_saves DESC;

--- Teams That Had The Most Tackles In Total/Per Game ---
SELECT team, SUM(tackles) total_tackles
FROM pl_season_2022
GROUP BY team
ORDER BY total_tackles DESC;

SELECT team, AVG(tackles) tackles_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY tackles_per_game DESC;

--- Teams That Had The Most Won Tackles In Total/Per Game ---
SELECT team, SUM(tackles_won) total_tackles_won
FROM pl_season_2022
GROUP BY team
ORDER BY total_tackles_won DESC;

SELECT team, AVG(tackles_won) tackles_won_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY tackles_won_per_game DESC;

--- Teams That Had The Highest Won Tackles Percentage---
SELECT team, (SUM(tackles_won)*100/SUM(tackles)) tackles_won_percentage
FROM pl_season_2022
GROUP BY team
ORDER BY tackles_won_percentage DESC;

--- Teams That Had The Most Blocked Shot In Total/Per Game ---
SELECT team, SUM(shots_blocked) total_shots_blocked
FROM pl_season_2022
GROUP BY team
ORDER BY total_shots_blocked DESC;

SELECT team, AVG(shots_blocked) shots_blocked_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY shots_blocked_per_game DESC;

--- Teams That Commited The Most Errors Which Led To An Opponent Shot---
SELECT team, SUM(offensive_errors) total_offensive_errors
FROM pl_season_2022
GROUP BY team
ORDER BY total_offensive_errors DESC;

--- Game By Game Breakdown Of The Errors Commited By The Offensive Team Which Led To An Opponent Shot---
SELECT team, offensive_errors, SUM(offensive_errors) OVER (PARTITION BY team Rows BETWEEN UNBOUNDED PRECEDING AND current row)
FROM pl_season_2022;

--- Teams That Had The Most Yellow Cards In Total/Per Game ---
SELECT team, SUM(yellow_cards) total_yellow_cards
FROM pl_season_2022
GROUP BY team
ORDER BY total_yellow_cards DESC;

SELECT team, AVG(yellow_cards) yellow_cards_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY yellow_cards_per_game DESC;

--- Teams That Had The Most Red Cards In Total --- 
SELECT team, SUM(red_cards) total_red_cards
FROM pl_season_2022
GROUP BY team
ORDER BY total_red_cards DESC;

--- Teams That Had The Most Fouls In Total/Per Game ---
SELECT team, SUM(fouls) total_fouls
FROM pl_season_2022
GROUP BY team
ORDER BY total_fouls DESC;

SELECT team, AVG(fouls) fouls_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY fouls_per_game DESC;

--- Teams That Had The Most Offsides In Total/Per Game ---
SELECT team, SUM(offsides) total_offsides
FROM pl_season_2022
GROUP BY team
ORDER BY total_offsides DESC;

SELECT team, AVG(offsides) offsides_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY offsides_per_game DESC;

--- Teams That Had The Most Aerial Duels Won In Total/Per Game ---
SELECT team, SUM(aerial_duels_won) total_aerial_duels_won
FROM pl_season_2022
GROUP BY team
ORDER BY total_aerial_duels_won DESC;

SELECT team, AVG(aerial_duels_won) aerial_duels_won_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY aerial_duels_won_per_game DESC;

--- Teams That Had The Highest Aerial Duels Won Percentage In Total ---
SELECT team, (SUM(aerial_duels_won)*100/(SUM(aerial_duels_won) + SUM(aerial_duels_lost))) total_aerial_duels_won_percentage
FROM pl_season_2022
GROUP BY team
ORDER BY total_aerial_duels_won_percentage DESC;


--- Teams That Had The Most Aerial Duels Lost In Total/Per Game ---
SELECT team, SUM(aerial_duels_lost) total_aerial_duels_lost
FROM pl_season_2022
GROUP BY team
ORDER BY total_aerial_duels_lost DESC;

SELECT team, AVG(aerial_duels_lost) aerial_duels_lost_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY aerial_duels_lost_per_game DESC;