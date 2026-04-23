SELECT 
  CASE WHEN Marks BETWEEN 70 AND 100 THEN Name ELSE null END AS Name
 ,Grade
 ,Marks
FROM Students S
INNER JOIN Grades G ON S.marks BETWEEN G.Min_Mark AND Max_Mark
ORDER BY Grade DESC, Name ASC, Marks ASC