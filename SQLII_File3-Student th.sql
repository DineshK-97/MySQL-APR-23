CREATE SCHEMA IF NOT EXISTS sql2takehome3;
USE sql2takehome3;
-- ----------------------------------------------------------------------------------
-- 1. Create a table Employee  

 -- Follow the instructions given below: 
-- -- Q1. Values in the columns Emp_id and Members_Exclusive_Offers should not be null.
-- -- Q2. Column Age should contain values greater than or equal to 18.
-- -- Q3. When inserting values in Employee table, if the value of salary column is left null,
-- --  then a value 20000 should be assigned at that position. 
-- -- Q4. Assign primary key to Emp_ID
-- -- Q5. All the email ids should not be same.
CREATE TABLE Employee (
    Emp_ID INT PRIMARY KEY,
    Members_Exclusive_Offers VARCHAR(100) NOT NULL,
    Age INT CHECK (Age >= 18),
    Salary DECIMAL(10, 2) DEFAULT 20000,
    Email VARCHAR(100) UNIQUE NOT NULL
    );

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Create a table Membership   

 -- Follow the instructions given below: 
-- -- Q6. Values in the columns Prime_Membership_Active_Status and Employee_Emp_ID should not
-- --  be null.
-- -- Q7. Assign a foreign key constraint on Employee_Emp_ID.
-- -- Q8. If any row from employee table is deleted, then the corresponding row from 
-- the Membership table should also get deleted.
CREATE TABLE Membership (
    Membership_ID INT PRIMARY KEY,
    Prime_Membership_Active_Status VARCHAR(50) NOT NULL,
    Employee_Emp_ID INT NOT NULL,
    FOREIGN KEY (Employee_Emp_ID) REFERENCES Employee (Emp_ID) ON DELETE CASCADE
);

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
