WITH FullScoreSubmissions AS 
(
    SELECT s.hacker_id,
		   h.name,
           s.challenge_id,
           COUNT(*) OVER (PARTITION BY s.hacker_id) as full_score_count
    FROM Submissions s
    JOIN Hackers h ON s.hacker_id = h.hacker_id
    JOIN Challenges c ON s.challenge_id = c.challenge_id
    JOIN Difficulty d ON c.difficulty_level = d.difficulty_level
    WHERE s.score = d.score
)

SELECT hacker_id,
       name
FROM FullScoreSubmissions
GROUP BY hacker_id, name
HAVING COUNT(*) > 1
ORDER BY OUNT(*) DESC, hacker_id ASC;