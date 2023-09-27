# Datasets used: employee_details.csv and Department_Details.csv
# Use subqueries to answer every question

CREATE SCHEMA IF NOT EXISTS SQL2Takehome1;
USE SQL2Takehome1;
# import csv files in Employee database.
create database SQL2Takehome1;
use SQL2Takehome1;
SELECT * FROM DEPARTMENT_DETAILS;
SELECT * FROM EMPLOYEE_DETAILS;

#Q1. Retrive employee_id , first_name , last_name and salary details of those employees 
#whose salary is greater than the average salary of all the employees.(11 Rows)
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
FROM employee_details
WHERE SALARY > (SELECT AVG(SALARY) FROM employee_details);

#Q2. Display first_name , last_name and department_id of those employee where the
# location_id of their department is 1700(3 Rows)
select * from department_details;
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID
FROM employee_details
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM department_details WHERE LOCATION_ID = 1700);
#Q3. From the table employees_details, extract the employee_id, first_name, last_name,
# job_id and department_id who work in  any of the departments of Shipping,
# Executive and Finance.(9 Rows)
SELECT ed.employee_id, ed.first_name, ed.last_name, ed.job_id, ed.department_id
FROM employee_details ed
JOIN department_details dd ON ed.department_id = dd.department_id
WHERE dd.department_name IN ('Shipping', 'Executive', 'Finance');
#Q4. Extract employee_id, first_name, last_name,salary, phone_number and email of the 
#CLERKS who earn more than the salary of any IT_PROGRAMMER.(3 Rows)
select * from employee_details;
SELECT employee_id, first_name, last_name, salary, phone_number, email
FROM employee_details
WHERE job_id LIKE '%ST_CLERK'
AND salary > ANY (SELECT MAX(salary) FROM employee_details WHERE job_id LIKE '%IT_PROG'); 
#Q5. Extract employee_id, first_name, last_name,salary, phone_number, 
#email of the AC_ACCOUNTANTs who earn a salary more than all the AD_VPs.(2 Rows)
SELECT employee_id, first_name, last_name, salary, phone_number, email
FROM employee_details
WHERE job_id = 'AC_ACCOUNTANT'
AND salary > ALL (SELECT salary FROM employee_details WHERE job_id = 'AD_VP');
#Q6. Write a Query to display the employee_id, first_name, last_name,
# department_id of the employees who have been recruited in the recent half 
#timeline since the recruiting began. (10 Rows)
SELECT employee_id, first_name, last_name, department_id
FROM 
(SELECT employee_id, first_name, last_name, department_id,
ROW_NUMBER() OVER (ORDER BY STR_TO_DATE(hire_date, '%d-%m-%Y') DESC) AS rookies
  FROM employee_details
) t
WHERE rookies <= 10;
#Q7. Extract employee_id, first_name, last_name, phone_number, salary and job_id 
#of the employees belonging to the 'Contracting' department (3 Rows)
SELECT ed.employee_id, ed.first_name, ed.last_name, ed.phone_number, ed.salary, ed.job_id
FROM employee_details ed
JOIN department_details dd ON ed.department_id =dd.department_id
WHERE dd.department_name = 'Contracting';
#Q8. Extract employee_id, first_name, last_name, phone_number, salary and job_id of the
# employees who does not belong to 'Contracting' department(18 Rows)
SELECT e.employee_id, e.first_name, e.last_name, e.phone_number, e.salary, e.job_id
FROM employee_details e
LEFT JOIN department_details d ON e.department_id = d.department_id AND d.department_name = 'Contracting'
WHERE d.department_id IS NULL;
#Q9. Display the employee_id, first_name, last_name, job_id and department_id of the 
#employees who were recruited first in the department(7 Rows)
SELECT employee_id, first_name, last_name, job_id, department_id
FROM 
(SELECT employee_id, first_name, last_name, job_id, department_id, ROW_NUMBER() OVER(PARTITION BY department_id ORDER BY hire_date) AS rookies
  FROM employee_details
) t
WHERE rookies = 1;
#Q10. Display the employee_id, first_name, last_name, salary and job_id of the 
#employees who earn maximum salary for every job.( 7Rows)
SELECT employee_id, first_name, last_name, salary, job_id
FROM 
(SELECT employee_id, first_name, last_name, salary, job_id,
ROW_NUMBER() OVER (PARTITION BY job_id ORDER BY salary DESC) AS rookies
FROM employee_details
) t
WHERE rookies = 1;
