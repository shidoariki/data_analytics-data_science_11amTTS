#What is SQL 
1. Sql stands for **Structured query language **
2. Sql used fro create database | table structured 
3. Sql is a case insensitive language 
** example**
```
insert| INSERT | Insert
```
4. Sql is used to create structur of database  and table via its ** quert or command **
5. Sql is create logics and functional 
6. Sql execute query 
7. Sql create views or index to fast load data 
8. Sql create a structured data 

    **Structured data format like colum and rows **

    ** Example **


    | id | name | Age | Address | 
    |----|------|-----|---------|
    | 1  | Rushi| 19  | ADBC No | 
    | 1  | Rushi| 19  | ADBC No | 
    | 1  | Rushi| 19  | ADBC No | 
    | 1  | Rushi| 19  | ADBC No | 
    | 1  | Rushi| 19  | ADBC No | 
    | 1  | Rushi| 19  | ADBC No | 
    | 1  | Rushi| 19  | ADBC No |


 #types of SQLl query or command 


 1. **DDL {Data defination language }
 2. **DML {Data manuplation language}
 3. **DQL {Data query language }
 4. **TCL {Transcational control language }

 ```   DDL   Data defination language ````

 1. Stands for data defination language 
 2. create an structured of database and tables 
 3. rename tables 
 4. update | add | modify | drop data in  tables  or colums in tables
5. truncate data from tables 


** DDL query are **


1 Create 
2 Alter
3 rename
4 drop 
5 truncate
6 change

#how to create database and tables structred 

** syntax**

```
create database databasename 
```

** example **
```
create database data_ analytics
```




**
    EXample 

**
create  tables tablename 

create table tbl_employee(
emp id int AUTO_INCREAMENT primary key,
name varcar(255),
age int,
address text,
salary decimal(10,2),
city varchar(100),
deparment varchar(200)
);


# WHat is datatypes and size if colum in tables 


|  COlumname     |     datatype(Size)        |      description   | 
|----------------|---------------------------|--------------------|
|  id            |     int (default)         |    accept integer  |
| name           |  char , varchar (0-255)   | char accept character only and varchar accept character and number both 