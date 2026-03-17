select city.name 
from city ,country
where city.CountryCode =country.code 
and CONTINENT = 'Africa';