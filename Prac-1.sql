use hr;

# 1. Write a Query to replace the null values in the column commission_pct to 0.
update employees set commission_pct = 0 where commission_pct is null;
select * from employees;

# 2. Write a Query to print the name and  email of the employee if the email is mentioned 
# else display a message 'email not disclosed'.
select first_name,last_name,email from employees;

# 3. Write a Query to print the name and  a message 'Well Paid' or 'Underpaid' if the salary 
# is above or below 6500$ respectively.
select first_name,last_name, case when salary>6500 then 'well paid' else 'underpaid' end message
from employees;

# 4. Write a Query to print the word 'GREAT LEARNING' in small alphabet letters.
select LOWER('GREAT LEARNING');

# 5. Write a Query to print the word 'great learning' in Capital Letters.
select upper('great learning');

# 6. Write a Query to print the words 'Great'  and  'Learning' together with a space in between them.
select ('Great Learning');

# 7. Write a Query to find the length of the word 'Great Learning'.
select length('Great Learning');

# 8. Write a Query to remove all the leading and trailing exclamation marks from the string '!!!!!Great Learning!!!!!!'.
select trim(Both '!' from 'Great Learning');

# 9. Write a Query to subtract 6 months from the date 01-01-2020.
select subdate(2020-01-01, interval 6 month);

# 10. Write a Query to display the date '01-01-2020' in the form of  ' January 01, 2020'.
select date_format('2020-01-01','%M %d, %Y');

# 11. Write a Query to convert the date given in a the format of '01,01,2020' to date format.
select date_format('2020-01-01','%D %M %Y');

# 12. Write a Query to divide the number 100 by 3 and print the remainder after division.
select (100%3)remainder;

# 13. Write a Query to divide the number 100 by 3 and print the result upto 2 decimal values.
select round(100/3);

# 14. Write a query to fetch the first name ,last name, name of the department and the
#  location of work of all the employees.
select e.first_name,e.last_name,d.department_name,l.city
from employees e join departments d on e.department_id = d.department_id
join locations l on l.location_id = d.location_id
group by first_name,last_name,department_name,city;

# 15. Write a query to fetch the first name ,last name of all the employees who are Sales Representative.
select * from employees;
select first_name, last_name from employees 
where job_id like 'SA_REP';

# 16. Write a Query to fetch all the departments and the names of the person managing them in America Region.
select e.first_name, e.last_name, department_name from employees e join departments d on e.department_id = d.department_id
join Regions r 
where r.region_name like 'Americas';

# 17. Write a query to fetch the names of the departments that are unstaffed.
select * from department_na;




