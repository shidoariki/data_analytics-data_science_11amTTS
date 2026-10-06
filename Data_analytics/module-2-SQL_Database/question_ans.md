What is the difference between CREATE, ALTER, DROP, and TRUNCATE in SQL?


create (it creates a database or table in order to create a structure for the data to be inserted  )
alter(as its name suggests it is used to alter the data in the table and to insert the data and delete the data as well)
drop(it is used to delete the data along with the structure and the data in it we cannot rollback )
truncate(Via truncate it is possible to delete all the rows and we can also rollback in it )


How do you create a table named employees with columns employee_id, name, salary, and department_id?

create table employees (
employee_id Int Primary key Auto_increament,
name Varchar(255),
salary varchar(255),
department_id varchar(255)
);

How do you add a new column email to an existing employees table?
 we can add new colum to the existing employees table using this syntax 


```
 ALTER TABLE employees
ADD COLUMN email varchar(255);
```

How do you modify the data type of the salary column?


we can modyfy the data type using the follwing syntax
```
ALTER TABLE employees 
MODIFY COLUMN salary decimal(10,2);
```


How do you rename a column in an existing table?
```
ALTER table employees
RENAME COLUMN name TO emp_name;
```

How do you rename the employees table to staff?

```
Alter table employees
Rename TO staff;
```

How do you remove the email column from the employees table

we can remove the colum via 
```
Alter TABLE staff
DROP email;
```

How do you create a table with a primary key?

```
create table exam(
    paper_id int priamary key auto_increament,
    paperlist varchar(255)
)
```


How do you create a table with a NOT NULL constraint?

```
create table essay (
    ess_id int primary key auto_increament,
    esaaywriter varchar(255) Not null,
    essayname varchar(255) not null
);
```

How do you create a table with a UNIQUE constraint?
