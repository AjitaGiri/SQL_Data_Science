/*
Netflix
As a member of the Netflix HR team, you are tasked with addressing employee retention challenges by analyzing employee satisfaction data....
*/

-- The HR team wants to understand the average satisfaction score of employees across different departments. Can you provide the average satizfaction score rounded down to the nearest whole number for each department?

Select department_id, FLOOR(AVG(satisfaction_score)) AS avg_satisfaction_score
from employee_satisfaction
group by department_id;

-- In addition to the previous analysis, the HR team is interested in knowing the average satisfaction score rounded up to the nearest whole number for each job category. 

Select job_category_id,
CEIL(AVG(satisfaction_score)) AS avg_satisfaction_score
from employee_satisfaction
group by job_category_id;

-- The HR team wants a consolidated report that includes both the rounded down and rounded up average satisfaction scores for each department and job category. Please rename the columns appropriately to 'Floor_Avg_Satisfaction' and 'Ceil_Avg_Satisfaction'.

Select department_id,
job_category_id,
FLOOR(AVG(satisfaction_score)) AS Floor_Avg_Satisfaction,
CEIL(AVG(satisfaction_score)) AS Ceil_Avg_Satisfaction
From employee_satisfaction
group by department_id,job_category_id;

-- Using the viewer_interactions table, how many unique viewers have interacted with any interactive content in October 2024. Can you find out the numver of distint  viewers?
Select count(distinct viewer_id) AS no_of_unique_viewers
from viewer_interactions
where interaction_date >= '2024-10-01' and interaction_date < '2024-11-01';

-- To understand viewer preferences, the team wants a list of all the unique choices made by viewers in November 2024. Can you provide this list sorted by choice description alphabetically?

Select distinct c.choice_description
from choices_made c
where choice_date >= '2024-11-01' and choice_date < '2024-12-01'
order by choice_description asc;

-- The team is interested in understanding which viewers interacted with content by pausing the video in December 2024.
select v.viewer_id
from viewer_interactions v
where v.interaction_type='pause' and
(v.interaction_date >= '2024-12-01' and v.interaction_date <= '2024-12-31');
