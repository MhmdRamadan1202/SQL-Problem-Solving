select rpad(' *',x,' *')
from (select level x 
		from dual connect by level<=40 
		order by level asc)
where mod(x,2)=0;