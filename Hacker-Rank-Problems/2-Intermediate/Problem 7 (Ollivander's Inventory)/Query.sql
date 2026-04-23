WITH RankedWands AS 
(
    SELECT w.id,
           wp.age,
           w.coins_needed,
           w.power,
        ROW_NUMBER() OVER(PARTITION BY w.power, wp.age ORDER BY w.coins_needed) as rnk
    FROM Wands w
    JOIN Wands_Property wp ON w.code = wp.code
    WHERE wp.is_evil = 0
)
SELECT RW.id,
       RW.age,
       RW.coins_needed,
       RW.power
FROM RankedWands RW
WHERE RW.rnk = 1
ORDER BY RW.power DESC, RW.age DESC;