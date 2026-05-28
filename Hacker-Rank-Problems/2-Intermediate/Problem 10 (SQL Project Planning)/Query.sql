WITH ProjectGroups AS (
    SELECT 
        Start_Date,
        End_Date,
        Start_Date - ROW_NUMBER() OVER (ORDER BY Start_Date) AS group_id
    FROM Projects
)
SELECT 
    MIN(Start_Date) AS project_start,
    MAX(End_Date) AS project_end
FROM ProjectGroups
GROUP BY group_id
ORDER BY 
    MAX(End_Date) - MIN(Start_Date),
    MIN(Start_Date);