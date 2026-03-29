select c.company_code,
        max(c.founder),
        count(distinct e.lead_manager_code) tot_lead_manager,
        count(distinct e.senior_manager_code  ) tot_senior_manager,
        count(distinct e.manager_code  ) tot_manager,
        count(distinct e.employee_code   ) tot_employee 
from company c 
join Employee e on c.company_code =e.company_code
group by c.company_code
order by c.company_code