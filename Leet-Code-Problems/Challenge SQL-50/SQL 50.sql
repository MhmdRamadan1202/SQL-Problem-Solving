--- 1* Recyclable and Low Fat Products
select product_id
from products
where low_fats='Y' and recyclable='Y'
order by 1;


--- 2* Find Customer Referee
select name 
from customer
where referee_id <> 2 or referee_id is null;

--- 3* Big Countries
select name  , population   , area         
from World
where (area >= 3000000) or (population >= 25000000);


--- 4* Article Views I
select distinct viewer_id as id
from views
where viewer_id = author_id
order by id;


--- 5* Invalid Tweets
select tweet_id 
from tweets
where length(content) > 15 ;

--- 6* Replace Employee ID With The Unique Identifier

select eu.unique_id 
		, e.name 
from Employees e 
left join  EmployeeUNI eu
		on  e.id = eu.id;

----------------------------------------------------------
--- 7* Product Sales Analysis I

select  p.product_name 
		, s.year  
		, s.price 
from sales s
left join product p 
               on s.product_id =p.product_id

----------------------------------------------------------
--- 8* Customer Who Visited but Did Not Make Any Transactions

select v.customer_id 
		,count(v.visit_id ) as count_no_trans 
from visits v 
left join Transactions t
						on v.visit_id =t.visit_id 
WHERE transaction_id is null
group by v.customer_id ;


----------------------------------------------------------
--- 9* Rising Temperature

select w.id
from weather w 
join weather as w1 ON DATEDIFF(w.recordDate, w1.recordDate) = 1
        AND w.Temperature > w1.Temperature 

			   
----------------------------------------------------------
--- 10* Average Time of Process per Machine		   

select machine_id
        , Round(avg(case when activity_type="start" then timestamp
                         when activity_type="end" then -timestamp
                     end) * (-2)
                ,3)as processing_time
from activity
group by machine_id;

----------------------------------------------------------
--- 11* Employee Bonus

select e.name 
		, b.bonus
from employee e 
left join Bonus b
on e.empId = b.empId 
where b.bonus < 1000 
		or b.bonus is null;

----------------------------------------------------------
--- 12* Students and Examinations

SELECT 
    s.student_id,
    s.student_name, 
    sub.subject_name, 
    COUNT(e.subject_name) AS attended_exams
FROM Students s 
CROSS JOIN Subjects sub
LEFT JOIN Examinations e ON s.student_id = e.student_id 
							AND sub.subject_name = e.subject_name
GROUP BY 
    s.student_id, 
    s.student_name, 
    sub.subject_name
ORDER BY 
    s.student_id, 
    sub.subject_name;

----------------------------------------------------------
--- 13* Managers with at Least 5 Direct Reports

select m.name
from employee as e 
join employee as m on e.managerid=m.id
group by e.managerId 
having count(e.id) >=5;


----------------------------------------------------------
--- 14* Confirmation Rate

select s.user_id
     , round(avg(if(c.action='confirmed',1,0)),2) confirmation_rate
from Signups as s 
left join Confirmations as c on s.user_id= c.user_id 
group by s.user_id;

			   
----------------------------------------------------------
--- 15* Not Boring Movies

select *
from Cinema
where  id %2 !=0
   and description not in ("boring")
order by rating desc;


--- 16* Average Selling Price

SELECT p.product_id, 
  IFNULL(ROUND(SUM(units*price)/SUM(units),2),0) average_price
FROM Prices p 
LEFT JOIN UnitsSold u ON p.product_id = u.product_id 
                      AND u.purchase_date BETWEEN start_date AND end_date
group by product_id

----------------------------------------------------------
--- 17* Project Employees I

select p.project_id 
		,round(avg(e.experience_years),2) average_years 
from Employee e
join Project p on e.employee_id =p.employee_id 
group by p.project_id  ;

----------------------------------------------------------
--- 18* Percentage of Users Attended a Contest
 
select  contest_id ,
        round(count(distinct user_id) * 100 /(select count(user_id) from Users) ,2) percentage 
from Register
group by contest_id
order by percentage desc,contest_id asc;


----------------------------------------------------------
--- 19* Queries Quality and Percentage
 
select  query_name 
		,ROUND(AVG(rating / position),2) quality
		,ROUND(AVG(CASE WHEN rating<3 THEN 1 ELSE 0 END )*100,2) poor_query_percentage  
from Queries 
group by query_name;

			   
----------------------------------------------------------
--- 20* Monthly Transactions I

SELECT
    DATE_FORMAT(trans_date, '%Y-%m')  month,
    country,
    COUNT(id) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1
            ELSE 0 END)  approved_count,
    SUM(amount)  trans_total_amount,
    SUM( CASE WHEN state = 'approved' THEN amount
              ELSE 0 END)  approved_total_amount
FROM Transactions
GROUP BY month, country;


----------------------------------------------------------
--- 21* Immediate Food Delivery II

WITH Q AS (SELECT delivery_id ,
                    customer_id ,
                    order_date ,
                    customer_pref_delivery_date ,
                    CASE WHEN order_date = customer_pref_delivery_date  
                                THEN 'immediate'
                        ELSE 'scheduled' END delivery_status,
                    RANK() OVER(PARTITION BY customer_id ORDER BY order_date ASC) RNK
            FROM Delivery)

SELECT  ROUND(
            AVG(CASE WHEN delivery_status='immediate' 
                    THEN 1 ELSE 0 END ) *100,2) immediate_percentage
FROM Q 
WHERE RNK=1;


----------------------------------------------------------
--- 22* Game Play Analysis IV

SELECT ROUND(COUNT(*)
            / (SELECT COUNT(DISTINCT(player_id)) FROM Activity)
                        , 2) AS fraction 
FROM Activity 
WHERE (player_id, DATE_SUB(event_date, INTERVAL 1 DAY)) IN 
        ( SELECT player_id, MIN(event_date) 
           FROM Activity GROUP BY player_id );

		   
----------------------------------------------------------
--- 23* Number of Unique Subjects Taught by Each Teacher

select teacher_id ,
        count(distinct subject_id) cnt 
from teacher
group by teacher_id	   


----------------------------------------------------------
--- 24* User Activity for the Past 30 Days I

select TO_CHAR(activity_date,'YYYY-MM-DD') as day        
    ,count(distinct user_id) as active_users 
from Activity 
WHERE activity_date > '2019-06-27' a
		nd activity_date < '2019-07-28'
group by activity_date


----------------------------------------------------------
--- 25* Product Sales Analysis III

SELECT product_id ,
                first_year ,
                quantity ,
                price 
FROM (SELECT product_id ,
                year  first_year,
                quantity ,
                price ,
                RANK() OVER(PARTITION BY product_id ORDER BY year) RNK
            FROM Sales) T
WHERE RNK=1;


----------------------------------------------------------
--- 26* Classes With at Least 5 Students

select class
from courses
group by class
having count(class) >=5 ;


----------------------------------------------------------
--- 27* Find Followers Count

select user_id , 
       count(follower_id) as followers_count
from Followers 
group by 1
order by 1;

----------------------------------------------------------
--- 28* Biggest Single Number

with  q as (select num , 
					count(num) num_count
			from MyNumbers
			group by num) 
select  max(num)num 
from q 
where num_count =1;


----------------------------------------------------------
--- 29* Customers Who Bought All Products

SELECT customer_id
FROM(SELECT customer_id ,
        COUNT(DISTINCT product_key ) NUM_PRO
    FROM Customer 
    GROUP BY customer_id) T
WHERE NUM_PRO=(SELECT COUNT(product_key )FROM Product);


----------------------------------------------------------
--- 30* The Number of Employees Which Report to Each

with q_rep as (select reports_to 
                     ,count(reports_to)reports_count 
                     ,round(avg(age),0)average_age 
				from Employees 
				group by reports_to)

select e.employee_id,
		e.name,
		r.reports_count,
		r.average_age 
from Employees e
join  q_rep r on r.reports_to =e.employee_id  
order by e.employee_id;


----------------------------------------------------------
--- 31* Primary Department for Each Employee

WITH DEP AS (SELECT employee_id ,
                        department_id ,
                        primary_flag ,
                        COUNT(department_id)OVER(PARTITION BY employee_id) NUM_DEP 
                    FROM Employee)
                   
SELECT employee_id ,
        department_id 
FROM DEP 
WHERE NUM_DEP=1    
UNION ALL 
SELECT employee_id ,
        department_id 
FROM DEP 
WHERE primary_flag ='Y'             
ORDER BY employee_id;


----------------------------------------------------------
--- 32* Triangle Judgement

SELECT x,y,z,
case WHEN (x+y) > z AND (x+z) > y AND (y+z) > x THEN 'Yes'
         ELSE 'No' end AS triangle
FROM Triangle ;


----------------------------------------------------------
--- 33* Consecutive Numbers

SELECT DISTINCT L1.NUM ConsecutiveNums 
FROM LOGS L1
JOIN LOGS L2 ON L1.ID=L2.ID-1 
			AND L1.NUM=L2.NUM
JOIN LOGS L3 ON L2.ID=L3.ID-1 
				AND L3.NUM=L2.NUM;



----------------------------------------------------------
--- 34* Product Price at a Given Date

WITH UniqueProducts AS (SELECT DISTINCT  product_id
                        FROM Products)

, LastChangedPrice AS 
              (SELECT DISTINCT product_id,
                     FIRST_VALUE (new_price) OVER (
                                                PARTITION BY product_id
                                                ORDER BY change_date DESC
                                                                      ) AS price
                FROM Products
                WHERE change_date <= '2019-08-16' )


SELECT product_id,
       IFNULL (price, 10) AS price
FROM UniqueProducts
LEFT JOIN LastChangedPrice USING (product_id);


----------------------------------------------------------
--- 35* 