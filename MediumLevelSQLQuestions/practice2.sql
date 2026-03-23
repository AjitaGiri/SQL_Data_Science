/*  Content Recommendation Algorithm Performance

Tables
fct_watch_history(watch_id, user_id, content_id, watch_time_minutes, watch_date)
dim_content(content_id, title, genre, release_date)
fct_recommendations(recommendation_id, user_id, content_id, recommended_date)

You are a Data Analyst on the Content Discovery Team at Netflix, tasked with evaluating the impact of the recommendation algorithm on user engagement. Your team is focused on assessing how recommendations affect total watch time and categorizing user watch sessions to identify engagement patterns. The end goal is to refine the recommendation engine to enhance user satisfaction and drive more diverse content exploration.

*/

-- what is the total watch time for content after it was recommended to users? To correctly attribute watch time to the recommendation, it is critical to only include watch time after the recommendation was made to the user. A content could get recommended to a user multiple times. If so, we want to use the first date that the content was recommended to a user.

with first_recommendation as (
    select
        user_id,
        content_id,
        min(recommended_date) as first_recommended_date
    from fct_recommendations
    group by user_id, content_id
)
select
    w.user_id,
    w.content_id,
    sum(w.watch_time_minutes) as total_watch_time
from fct_watch_history w
join first_recommendation fr
    on w.user_id = fr.user_id
   and w.content_id = fr.content_id
where w.watch_date >= fr.first_recommended_date
group by w.user_id, w.content_id;

--The team wants to know the total watch time for each genre in the first quarter of 2024, split by whether or not the content was recommended vs. non-recommended to a user.

--Watch time should be bucketed into 'Recommended' by joining on both user and content, regardless of when they watched it vs. when they received the recommendation.

SELECT
    dc.genre,
    CASE
        WHEN r.user_id IS NOT NULL THEN 'Recommended'
        ELSE 'Non-Recommended'
    END AS recommendation_status,
    SUM(w.watch_time_minutes) AS total_watch_time
FROM fct_watch_history w
LEFT JOIN dim_content dc
    ON w.content_id = dc.content_id
LEFT JOIN (
    SELECT DISTINCT user_id, content_id
    FROM fct_recommendations
) r
    ON w.user_id = r.user_id
   AND w.content_id = r.content_id
WHERE w.watch_date BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY
    dc.genre,
    CASE
        WHEN r.user_id IS NOT NULL THEN 'Recommended'
        ELSE 'Non-Recommended'
    END;

-- The team aims to categorize user watch sessions into 'Short', 'Medium', or 'Long' based on watch time for recommended content to identify engagement patterns.
--'Short' for less than 60 minutes, 'Medium' for 60 to 120 minutes, and 'Long' for more than 120 minutes. Can you classify and count the sessions in Q1 2024 accordingly?

WITH recommended_pairs AS (
    SELECT DISTINCT user_id, content_id
    FROM fct_recommendations
)
SELECT
    CASE
        WHEN w.watch_time_minutes < 60 THEN 'Short'
        WHEN w.watch_time_minutes BETWEEN 60 AND 120 THEN 'Medium'
        ELSE 'Long'
    END AS watch_session,
    COUNT(*) AS session_count
FROM fct_watch_history w
JOIN recommended_pairs r
    ON w.user_id = r.user_id
   AND w.content_id = r.content_id
WHERE w.watch_date BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY
    CASE
        WHEN w.watch_time_minutes < 60 THEN 'Short'
        WHEN w.watch_time_minutes BETWEEN 60 AND 120 THEN 'Medium'
        ELSE 'Long'
    END
ORDER BY watch_session;