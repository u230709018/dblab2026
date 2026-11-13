use movie_db;
# 1. Show the Quentin Tarantino films which have more than 500000 votes and produced before 2000.
select title, votes, year
from movies
where votes > 500000 and year < 2000 and
movie_id in
(select movie_id from movie_directors join directors 
on movie_directors.director_id = directors.director_id 
where director_name like 'Quentin%');

# 2. Show the films that Tom Hanks has act and have won more than 3 Oscars.
select m.title, m.oscars, s.star_name
from movies m
join movie_stars ms on m.movie_id = ms.movie_id
join stars s on ms.star_id = s.star_id
where s.star_name = 'Tom Hanks' and m.oscars > 3;



# 3. Show the history films produced in USA and whose duration is between 100-200 minutes.
 select m.title, m.duration, g.genre_name, c.country_name
 from movies m
 join genres g on m.movie_id = g.movie_id
 join producer_countries pc on m.movie_id = pc.movie_id  
 join countries c on c.country_id = pc.country_id
 where g.genre_name = 'History' and c.country_name = 'USA' 
 and m.duration between 100 and 200;
 
# 4.Compute the average budget of the films directed by Peter Jackson.
select AVG(m.budget) as avg_budget, d.director_name
from movies m
join movie_directors md on m.movie_id = md.movie_id
join directors d on d.director_id = md.director_id
where d.director_name = 'Peter Jackson';

# 5.Show the Francis Ford Coppola film that has the maximum budget.
select m.title, m.budget
from movies m
join movie_directors md on m.movie_id = md.movie_id
join directors d on d.director_id = md.director_id
where d.director_name = 'Francis Ford Coppola'
order by m.budget desc
limit 1;

# 6.Show the film that has the most vote and has been produced in USA.
select m.title, m.votes, c.country_name
from movies m
join producer_countries pc on m.movie_id = pc.movie_id
join countries c on c.country_id = pc.country_id
where c.country_name = 'USA'
order by m.votes desc
limit 1;

# 7. List all stars who have acted in more than 1 films
select s.star_name, count(ms.movie_id) as film_count
from stars s
join movie_stars ms on s.star_id = ms.star_id
group by s.star_name
having film_count > 1;


