select  distinct round(sqrt(power((max(LONG_W )
				- min(LONG_W)),2)+ power((max(LAT_N )- min(LAT_N )),2)),4)                                                                                                 
from station;