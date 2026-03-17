select COUNTRY.Continent ,trunc (avg(CITY.Population))
from city , country 
where city.countrycode=country.code
group by COUNTRY.Continent;