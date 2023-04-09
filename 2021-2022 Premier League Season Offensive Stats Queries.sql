--- 2021-2022 Premier League Season Offensive Stats---
---Initial Query---
SELECT *
FROM pl_season_2022
LIMIT 5;

--- Teams Win/Draw/Loss Record ---
SELECT team, CONCAT(COUNT(CASE WHEN result = 'W' THEN 1 END), '-',
					 COUNT(CASE WHEN result = 'D' THEN 1 END),'-',
					 COUNT(CASE WHEN result = 'L' THEN 1 END)) win_draw_loss_record
FROM pl_season_2022
GROUP BY team
ORDER BY COUNT(CASE WHEN result = 'W' THEN 1 END) DESC ;

--- Teams Point Totals---
SELECT t1.team, (t1.win * 3 + t1.draw * 1) point_total
FROM(
SELECT team, COUNT(CASE WHEN result = 'W' THEN 1 END) win, 
	COUNT(CASE WHEN result = 'D' THEN 1 END) draw
FROM pl_season_2022
GROUP BY team) t1
ORDER BY point_total DESC;

--- Teams Point Per Game---
WITH points AS (
SELECT t1.team, (t1.win * 3 + t1.draw * 1) point_total, t1.venues
FROM(
SELECT team, COUNT(CASE WHEN result = 'W' THEN 1 END) win, 
	COUNT(CASE WHEN result = 'D' THEN 1 END) draw, COUNT(venue) venues
FROM pl_season_2022
GROUP BY team) t1
ORDER BY point_total DESC)

SELECT p.team, (p.point_total::numeric/p.venues::numeric) ppg
FROM points p;

--- Teams That Scored The Most Goals In Total/Per Game ---
SELECT team, SUM(goal_scored) total_goals_scored
FROM pl_season_2022
GROUP BY team
ORDER BY total_goals_scored DESC;

SELECT team, AVG(goal_scored) goals_scored_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY goals_scored_per_game DESC;

--- Teams That Average The Most Expected Goals---
SELECT team, AVG(expected_goals) expected_goals_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY expected_goals_per_game DESC;

--- Teams That Had The Most Possession In Total/Per Game ---
SELECT team, SUM(possession) total_possession
FROM pl_season_2022
GROUP BY team
ORDER BY total_possession DESC;

SELECT team, AVG(possession) possession_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY possession_per_game DESC;

--- Teams That Had The Most Shots In Total/Per Game ---
SELECT team, SUM(shots) total_shots
FROM pl_season_2022
GROUP BY team
ORDER BY total_shots DESC;

SELECT team, AVG(shots) shots_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY shots_per_game DESC;

--- Team That Had The Highest Goal Per Shot Percentage---
SELECT team, (SUM(goal_scored)*100/SUM(shots)) goal_per_shot_percentage
FROM pl_season_2022
GROUP BY team
ORDER BY goal_per_shot_percentage DESC;

--- Teams That Had The Most Shots On Target In Total/Per Game ---
SELECT team, SUM(shots_on_target) total_shots_on_target
FROM pl_season_2022
GROUP BY team
ORDER BY total_shots_on_target DESC;

SELECT team, AVG(shots_on_target) shots_on_target_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY shots_on_target_per_game DESC;

--- Team That Had The Highest Shot On Target Percentage---
SELECT team, (SUM(shots_on_target)*100/SUM(shots)) total_shots_on_target_percentage
FROM pl_season_2022
GROUP BY team
ORDER BY total_shots_on_target_percentage DESC;

--- Teams Whose Shots Traveled The Most Distance In Total/Per Game ---
SELECT team, SUM(distance) total_distance
FROM pl_season_2022
GROUP BY team
ORDER BY total_distance DESC;

SELECT team, AVG(distance) distance_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY distance_per_game DESC;

--- Teams Who Took The Most Freekicks In Total ---
SELECT team, SUM(free_kicks) total_free_kicks
FROM pl_season_2022
GROUP BY team
ORDER BY total_free_kicks DESC;

--- Teams Who Took The Most Penalty Kicks In Total ---
SELECT team, SUM(penalty_kick_attempts) total_penalty_kick_attempts
FROM pl_season_2022
GROUP BY team
ORDER BY total_penalty_kick_attempts DESC;

--- Teams Who Made The Most Penalty Kicks In Total ---
SELECT team, SUM(penalty_kicks) total_penalty_kicks_made
FROM pl_season_2022
GROUP BY team
ORDER BY total_penalty_kicks_made DESC;

--- Team With Highest Penalty Kick Made Percentage ---
SELECT team, (SUM(penalty_kicks)/SUM(penalty_kick_attempts)) penalty_kicks_made_percentage
FROM pl_season_2022
GROUP BY team
ORDER BY penalty_kicks_made_percentage DESC;

--- Team That Completed The Most Passes In Total/ Per Game---
SELECT team, SUM(passes_completed) total_passes_completed
FROM pl_season_2022
GROUP BY team
ORDER BY total_passes_completed DESC;

SELECT team, AVG(passes_completed) passes_completed_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY passes_completed_per_game DESC;

--- Team That Attempted The Most Passes In Total/ Per Game---
SELECT team, SUM(passes_attempted) total_passes_attempted
FROM pl_season_2022
GROUP BY team
ORDER BY total_passes_attempted DESC;

SELECT team, AVG(passes_attempted) passes_attempted_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY passes_attempted_per_game DESC;

--- Team With Highest Percentage Of Passes Completed---
SELECT team, (SUM(passes_completed)*100/SUM(passes_attempted)) pass_completion_percentage
FROM pl_season_2022
GROUP BY team
ORDER BY pass_completion_percentage DESC;

--- Team That Had The Most Assists In Total/ Per Game---
SELECT team, SUM(assists) total_assists
FROM pl_season_2022
GROUP BY team
ORDER BY total_assists DESC;

SELECT team, AVG(assists) assists_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY assists_per_game DESC;

--- Team That Had The Most Expected Assists Per Game---
SELECT team, AVG(expected_assists) expected_assists_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY expected_assists_per_game DESC;

--- Team That Had The Most Passes Into The Final Third In Total/ Per Game---
SELECT team, SUM(passes_into_final_third) total_passes_into_final_third
FROM pl_season_2022
GROUP BY team
ORDER BY total_passes_into_final_third DESC;

SELECT team, AVG(passes_into_final_third) passes_into_final_third_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY passes_into_final_third_per_game DESC;

--- Team That Had The Most Passes Into The Penalty Area In Total/ Per Game---
SELECT team, SUM(passes_into_penalty_area) total_passes_into_penalty_area
FROM pl_season_2022
GROUP BY team
ORDER BY total_passes_into_penalty_area DESC;

SELECT team, AVG(passes_into_penalty_area) passes_into_penalty_area_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY passes_into_penalty_area_per_game DESC;

--- Team That Had The Most Crosses Into The Penalty Area In Total/ Per Game---
SELECT team, SUM(crosses_into_penalty_area) total_crosses_into_penalty_area
FROM pl_season_2022
GROUP BY team
ORDER BY total_passes_into_penalty_area DESC;

SELECT team, AVG(crosses_into_penalty_area) crosses_into_penalty_area_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY crosses_into_penalty_area_per_game DESC;

--- Teams That Had The Highest Percentage Of Their Passes Into The Penalty Area Be From Crosses ---
SELECT team, (SUM(crosses_into_penalty_area)*100/SUM(passes_into_penalty_area)) cpa_percentage
FROM pl_season_2022
GROUP BY team
ORDER BY cpa_percentage DESC;

--- Team That Had The Most Shot Creating Actions In Total/ Per Game---
SELECT team, SUM(sca) total_sca
FROM pl_season_2022
GROUP BY team
ORDER BY total_sca DESC;

SELECT team, AVG(sca) sca_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY sca_per_game DESC;

--- Team That Had The Most Goal Creating Actions In Total/ Per Game---
SELECT team, SUM(gca) total_gca
FROM pl_season_2022
GROUP BY team
ORDER BY total_gca DESC;

SELECT team, AVG(gca) gca_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY gca_per_game DESC;

--- Game By Game Breakdown Of Each Team's Goal Creating Actions---
SELECT team, gca, SUM(gca) OVER (PARTITION BY team Rows BETWEEN UNBOUNDED PRECEDING AND Current Row)
FROM pl_season_2022;

--- Team That Had The Most Take On Attempts In Total/ Per Game---
SELECT team, SUM(take_on_attempts) total_take_on_attempts
FROM pl_season_2022
GROUP BY team
ORDER BY total_take_on_attempts DESC;

SELECT team, AVG(take_on_attempts) take_on_attempts_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY take_on_attempts_per_game DESC;

--- Team That Had The Most Successful Take Ons In Total/ Per Game---
SELECT team, SUM(successful_take_ons) total_successful_take_ons
FROM pl_season_2022
GROUP BY team
ORDER BY total_take_on_attempts DESC;

SELECT team, AVG(successful_take_ons) successful_take_ons_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY successful_take_ons_per_game DESC;

--- Game By Game Breakdown Of Each Team's Successful Take Ons---
SELECT team, successful_take_ons, SUM(successful_take_ons) OVER (PARTITION BY team Rows BETWEEN UNBOUNDED PRECEDING AND Current Row)
FROM pl_season_2022;

--- Team That Had The Highest Successful Take Ons Percentage---
SELECT team, (SUM(successful_take_ons)*100/SUM(take_on_attempts)) successful_take_on_percentage
FROM pl_season_2022
GROUP BY team
ORDER BY successful_take_on_percentage DESC;

--- Team That Had The Most Carries Into The Penalty Area In Total/ Per Game---
SELECT team, SUM(carries_into_penalty_area) total_carries_into_penalty_area
FROM pl_season_2022
GROUP BY team
ORDER BY total_carries_into_penalty_area DESC;

SELECT team, AVG(carries_into_penalty_area) carries_into_penalty_area_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY carries_into_penalty_area_per_game DESC;

--- Game By Game Breakdown Of Each Team's Carries Into The Penalty Area---
SELECT team, carries_into_penalty_area, SUM(carries_into_penalty_area) OVER (PARTITION BY team Rows BETWEEN UNBOUNDED PRECEDING AND Current Row)
FROM pl_season_2022;

--- Team That Had The Most Carries In Total/ Per Game---
SELECT team, SUM(carries) total_carries
FROM pl_season_2022
GROUP BY team
ORDER BY total_carries DESC;

SELECT team, AVG(carries) carries_per_game
FROM pl_season_2022
GROUP BY team
ORDER BY carries_per_game DESC;

--- Team That Had The Highest Percentage Of Carries Being In The Penalty Area---
SELECT team, (SUM(carries_into_penalty_area)*1000/SUM(carries)) carries_into_penalty_area_percentage
FROM pl_season_2022
GROUP BY team
ORDER BY carries_into_penalty_area_percentage DESC;