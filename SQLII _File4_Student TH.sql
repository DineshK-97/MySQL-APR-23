##################################################################################
create database SQL2TakeHome4;
use SQL2TakeHome4;
set autocommit = 0;
# Datset Used: admission_predict.csv
-- ----------------------------------------------------
# Q.1 A university is looking for candidates with GRE score between 330 and 340. 
# Also they should be proficient in english i.e. their Total score should not be less than 115. Create a view for this university.
#Solution:	
create view  university as
select * from admission_predict
where `GRE Score`  between 330 and 340
and `TOEFL Score` >= 115;
select * from university;
# Q.2 Create a view of the candidates with the CGPA greater than the average CGPA.
#Solution:	
create view candidates as
select * from admission_predict
where CGPA > (select avg(CGPA)
from admission_predict);

select * from candidates;
 # Datsets Used: world_cup_2015.csv and world_cup_2016.csv 
-- -------------------------------------------------------------------------------------
# Q.3 Create a view "team_1516" of the players who played in world cup 2015 as well as in world cup 2016.
#Solution:	
create view team_1516 as
select w2015.player_name
from world_cup_2015 w2015
inner join world_cup_2016 w2016 on w2015.player_name = w2016.player_name;

select * from team_1516;
# Q.4 Create a view "All_From_15" that contains all the players who played in world cup 2015 but not in the year 2016Along with those players who played in both the world cup matches.
#Solution:	
create view All_From_15 as
select w2015.player_name
from world_cup_2015 w2015
left join world_cup_2016 w2016 on w2015.player_name = w2016.player_name
where w2016.player_name is null
union
select w2015_2016.player_name
from world_cup_2015 w2015_2016
inner join world_cup_2016 w2016_2015 on w2015_2016.player_name = w2016_2015.player_name;


# Q.5 Create a view "All_From_16" that contains all the players who played in world cup 2016 but not in the year 2015 Along with those players who played in both the world cup matches.
#Solution:
create view All_From_16 as
select w2016.player_name
from world_cup_2016 w2016
left join world_cup_2015 w2015 on w2016.player_name = w2015.player_name
where w2015.player_name is null
union
select w2016_2015.player_name
from world_cup_2016 w2016_2015
inner join world_cup_2015 w2015_2016 on w2016_2015.player_name = w2015_2016.player_name;

select * from All_From_16;
# Q.6 Drop multiple views "all_from_16", "all_from_15", "players_ranked"
#Solution:

drop view all_From_16,all_From_15;

