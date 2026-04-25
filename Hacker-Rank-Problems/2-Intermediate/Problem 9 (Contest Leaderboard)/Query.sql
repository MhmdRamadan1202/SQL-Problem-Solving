WITH MaxScores 
AS (
    SELECT 
        h.hacker_id,
        h.name,
        s.challenge_id,
        MAX(s.score) AS max_score
    FROM Hackers h
    JOIN Submissions s ON h.hacker_id = s.hacker_id
    GROUP BY h.hacker_id, h.name, s.challenge_id
   ),
TotalScores 
AS (
    SELECT 
        hacker_id,
        name,
        SUM(max_score) AS total_score
    FROM MaxScores
    GROUP BY hacker_id, name
   )
SELECT 
    hacker_id,
    name,
    total_score
FROM TotalScores
WHERE total_score > 0
ORDER BY 
    total_score DESC,
    hacker_id ASC;