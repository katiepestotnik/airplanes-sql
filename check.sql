-- step 1
select * from airports as origin where city = 'New York';
-- step 2
select * from airports as destination where city = 'Paris';
-- step 3
select count(city) from airports as origin join routes on origin.id = origin_id where city = 'New York';
-- step 4
select count(city) from airports as destination join routes on destination.id = dest_id where city = 'Paris';
-- step 5
select count(city) from airports as origin
-- Try to decide which statements are necessary and find how to combine them to find out how many routes originate from New York and land in Paris!
-- select count(city) from airports as destination, airports as origin join routes on destination.id = dest_id and origin.id = origin_id where city = 'New York' and city = 'Paris';
select count(city) from airports as origin, airports as dest_id join routes on origin.id = dest_id where city = 'New York' union select count(city) from airports as destination join routes on destination.id = dest_id where city = 'Paris';

airports table (id, city)
routes table (id, origin_id, dest_id)

(select                                                        airports.id, airports.city as origin, airports.city as destination                        from airports                           left join routes as origin on airports.id=origin.origin_id                          where airports.city = 'New York')                                                      union                                                                                   (select                                                            airports.id, airports.city as origin, airports.city as destination                        from airports                                                          left join routes as destination on airports.id=destination.dest_id                            where airports.city = 'Paris');



select                             routes.dest_id, routes.origin_id                
from
routes
join airports as origin on routes.origin_id=origin.id          
where origin.city = 'New York';
left join routes as destination on airports.id = destination.dest_id
where city='Paris'

select airports as origin where origin.city = 'New York'
from airports join routes
union
select airports as destination where destination.city = 'Paris'
from airports join routes
on airports.id = routes.origin_id where origin.city = 'New York' and destination.city = 'Paris';





select origin.city, destination.city from airports as origin, airports as destination join routes on routes.origin_id = id and routes.dest_id = id where origin.city = 'New York' and destination.city = 'Paris';


--left off here

select origin.city, destination.city, destination.id, origin.id
from airports as origin, airports as destination join routes
on destination.id = dest_id and origin.id = origin_id where origin.city = 'New York' and destination.city = 'Paris'

select count(city) from airports as destination join routes on destination.id = dest_id where city = 'Paris';

select origin.city, destination.city, origin.id, destination.id
from airports as origin, airports as destination left join routes
on destination.id = dest_id and origin.id = routes.origin_id where origin.city = 'New York' and destination.city = 'Paris';



-- arugment of and must be boolean
select * from airports left join routes
    ((select count(city) from airports as origin join routes on origin.id = origin_id where city = 'New York') and
    (select count(city) from airports as destination join routes on destination.id = dest_id where city = 'Paris'))
    on origin_id = origin.id and dest_id = destination.id;

select * from
    airports join routes
    using(dest_id)
    where airports.id = dest_id and airports.city = 'Paris'






-- OMG!!! 130 flights from new york to paris is the answer!!!!!
select count(origin.city), count(destination.city) from
    airports as origin, airports as destination
    left join routes
    on id = origin_id and id = dest_id
    where origin.city = 'New York' and destination.city = 'Paris'
