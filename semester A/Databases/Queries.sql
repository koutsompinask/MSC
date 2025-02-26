--delete queries
delete from history where to_date < '01-AUG-2010';
delete from game where f_home_team_vat = '1000000' and f_away_team_vat = '1000001';
delete from person where first_name like 'Kon%' or last_name like 'Kon%';

--update queries
update person set salary = salary + 0.1*salary where salary < 1000000;
update game set result = 1 where f_home_team_vat = '1000000' and f_away_team_vat = '1000002';
update stadium set capacity = capacity + 10000 where capacity < 50000;

--select queries
select * from person;

select first_name, last_name, salary from person;

select first_name, last_name, salary from person order by salary desc;

select first_name, last_name, salary from person where salary > 1000000;

select t1.team_name, t2.team_name, g.result, g.date_of_game
from game g,
inner join team t1 on g.f_home_team_vat = t1.vat,
inner join team t2 on g.f_away_team_vat = t2.vat;

select t.team_name, max(salary) as Max_Salary, min(salary) as Min_Salary, 
sum(salary) as Sum_Salary, round(avg(salary),2) as Average_Salary
from person p
inner join team t on p.f_team_vat = t.vat
group by t.team_name
order by t.team_name;

select t.team_name, max(salary) as Max_Salary, min(salary) as Min_Salary, 
sum(salary) as Sum_Salary, round(avg(salary),2) as Average_Salary
from person p
inner join team t on p.f_team_vat = t.vat
group by t.team_name
having count(p.id) > 2
order by t.team_name;

select first_name, last_name, salary from person where is_coach = 1
union 
select first_name, last_name, salary from person where salary > 2000000;