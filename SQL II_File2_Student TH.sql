CREATE SCHEMA IF NOT EXISTS SQL2TakeHome2;
USE SQL2TakeHome2;
SELECT * FROM Video_Games_Sales;

# 1. Display the names of the Games, platform and total sales in North America for 
#respective platforms.(4586 Rows) 
SELECT name, Platform, SUM(NA_Sales) TOT_SAL
FROM video_games_sales
group by name,Platform;
# 2. Display the name of the game, platform , Genre and total sales in North America for
# corresponding Genre as Genre_Sales,total sales for the given platform as Platformm_Sales 
# and also display the global sales as total sales .
# Also arrange the results in descending order according to the Total Sales.(4586 Rows) 
SELECT name, Platform, Genre, NA_Sales AS Genre_Sales, 
Global_Sales AS Total_Sales,
SUM(NA_Sales) OVER(PARTITION BY Platform) AS Platform_Sales
FROM video_games_sales
ORDER BY Total_Sales DESC;

# 3. Use nonaggregate window functions to produce the row number for each row 
# within its partition (Platform) ordered by release year.(4586 Rows) 
SELECT name, Platform, Genre, NA_Sales AS Genre_Sales, 
Global_Sales AS Total_Sales,
ROW_NUMBER() OVER (PARTITION BY Platform ORDER BY year_of_release) s_no
FROM video_games_sales;
# 4. Use aggregate window functions to produce the average global sales of each row
# within its partition (Year of release). Also arrange the result in the descending order
# by year of release.(4586 Rows) 
  SELECT name, Platform, Genre, NA_Sales AS Genre_Sales, 
Global_Sales AS Total_Sales,
AVG(Global_Sales) OVER (PARTITION BY year_of_release) AS Average_Global_Sales
FROM video_games_sales
ORDER BY year_of_release DESC;
# 5. Display the name of the top 5 Games with highest Critic Score For Each Publisher.(821 Rows)  
SELECT name, sum(Critic_Score)high_cri_score,publisher FROM video_games_sales
GROUP BY Publisher,name
ORDER BY high_cri_score desc;
-- ----------------------------------------------------------------------------------
# Dataset Used: website_stats.csv and web.csv
-- ----------------------------------------------------------------------------------
# 6. Write a query that displays the opening date two rows forward i.e. 
#the 1st row should display the 3rd website launch date using LEAD function.(3 Rows) 
SELECT name, launch_date,
LEAD(launch_date, 2) OVER (ORDER BY launch_date) AS opening_date
FROM web
LIMIT 3;
# 7. Write a query that displays the statistics for website_id = 1 i.e. for each row, 
#show the day, the income and the income on the first day.(3 Rows) 
SELECT day, Income,
FIRST_VALUE(Income) OVER (PARTITION BY website_id ORDER BY day) AS income_on_first_day
FROM website_stats
WHERE website_id = 1
LIMIT 3;
-----------------------------------------------------------------
# Dataset Used: play_store.csv 
-----------------------------------------------------------------
# 8. For each game, show its name, genre and date of release. 
#In the next three columns, show RANK(), DENSE_RANK() and ROW_NUMBER() 
#sorted by the date of release in ascending order.(12 Rows) 
SELECT name, genre, released,
RANK() OVER (ORDER BY released) rnk,
DENSE_RANK() OVER (ORDER BY released)  d_rank,
ROW_NUMBER() OVER (ORDER BY released) row_num
FROM play_store
ORDER BY released;

