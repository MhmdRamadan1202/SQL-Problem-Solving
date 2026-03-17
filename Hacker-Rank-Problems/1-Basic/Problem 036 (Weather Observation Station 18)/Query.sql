select  distinct round((((select max(LONG_W ) from station)-(select min(LONG_W ) from station))+
              (((select max(LAT_N ) from station)-(select min(LAT_N ) from station))                )), 4)
from station;