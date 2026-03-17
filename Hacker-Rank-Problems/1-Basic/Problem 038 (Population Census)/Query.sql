select sum(CITY.population)
from city , country
where city.countrycode=country.code
and CONTINENT ='Asia';