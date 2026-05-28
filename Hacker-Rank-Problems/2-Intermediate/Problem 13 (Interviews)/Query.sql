SELECT c.contest_id, 
	   c.hacker_id, 
	   c.name, 
	   IFNULL(s.ts, 0) AS total_submissions, 
	   IFNULL(s.tas, 0) AS total_accepted_submissions, 
	   IFNULL(v.tv, 0) AS total_views, 
	   IFNULL(v.tuv, 0) AS total_unique_views 
FROM Contests c 
LEFT JOIN ( SELECT c.contest_id, 
				   SUM(ss.total_submissions) AS ts, 
				   SUM(ss.total_accepted_submissions) AS tas 
		    FROM Contests c 
			JOIN Colleges co ON co.contest_id = c.contest_id 
			JOIN Challenges ch ON ch.college_id = co.college_id 
			JOIN Submission_Stats ss ON ss.challenge_id = ch.challenge_id 
			GROUP BY c.contest_id ) s ON s.contest_id = c.contest_id 
LEFT JOIN ( SELECT c.contest_id, 
                   SUM(vs.total_views) AS tv, 
				   SUM(vs.total_unique_views) AS tuv 
		    FROM Contests c 
			JOIN Colleges co ON co.contest_id = c.contest_id 
			JOIN Challenges ch ON ch.college_id = co.college_id 
			JOIN View_Stats vs ON vs.challenge_id = ch.challenge_id 
			GROUP BY c.contest_id ) v ON v.contest_id = c.contest_id 
WHERE (IFNULL(s.ts,0) + IFNULL(s.tas,0) + IFNULL(v.tv,0) + IFNULL(v.tuv,0)) > 0 ORDER BY c.contest_id;