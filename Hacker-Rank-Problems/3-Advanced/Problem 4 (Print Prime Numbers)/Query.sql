with x as (
			select level lvl 
			from dual  connect by level <=1000)
			
,y as (
		select level lvl1  
		from dual  connect by level  <=1000)
		
		
select distinct LISTAGG(lvl, '&') WITHIN GROUP (ORDER BY lvl asc) 
from x
where not exists (select lvl1 
					from y 
					where mod(lvl,lvl1)= 0
						  and lvl1 < lvl                 
						  and lvl !=1
						  and lvl1!=1)
	  and lvl!=1;