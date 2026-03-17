select max(salary*months), count(salary*months) 
from employee 
where salary*months in (select max(salary*months) from employee);