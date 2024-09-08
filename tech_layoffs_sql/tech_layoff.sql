Create database Tech_layoffs;
Use Tech_layoffs;


SET GLOBAL local_infile = 'ON';
SHOW VARIABLES LIKE 'local_infile';
SHOW VARIABLES LIKE "secure_file_priv";


CREATE Table Q2_2024 (
    ID INT UNIQUE,
    Company VARCHAR(100),
    Location_HQ VARCHAR(100),
    Region VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(100),
    Continent VARCHAR(100),
    Laid_Off FLOAT,
    Date_layoffs DATE,
    Percentage FLOAT,
    Company_Size_before_Layoffs INT,
    Company_Size_after_layoffs INT,
    Industry VARCHAR(50),
    Stage VARCHAR(50),
    Money_Raised_in__mil INT,
    Year INT,
    latitude FLOAT,
    longitude FLOAT,
    PRIMARY KEY (ID)
);

drop table Q2_2024;

Show columns from Q2_2024;

CREATE TABLE employees (
	rang int Primary Key,
    organizationName VARCHAR(100),
    industry VARCHAR(255),
    country varchar(100),
    employees int
);

CREATE TABLE companies (
	rang int Primary Key,
    organizationName VARCHAR(200),
    country varchar(100),
    revenue_USD_in_mio float,
    profits_USD_in_mio float,
    assets_USD_in_mio float,
    marketValue_USD_in_mio float
);

CREATE TABLE companies (
	rang int Primary Key,
    organizationName VARCHAR(200),
    country varchar(100),
    revenue_USD_in_mio real,
    profits_USD_in_mio real,
    assets_USD_in_mio real,
    marketValue_USD_in_mio real
);

drop table companies;

LOAD DATA LOCAL INFILE '/Forbes_companies_mio_2024.csv'
INTO TABLE companies
FIELDS TERMINATED BY ';'  -- Use comma as the delimiter
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;  -- This skips the header row if it's present in the CSV
-- (rang, organizationName, country, revenue_USD_in_mio, profits_USD_in_mio, assets_USD_in_mio, marketValue_USD_in_mio);

Select * from companies Limit 15;


LOAD DATA Local INFILE '/path_to_file/tech_layoffs_Q2_2024.csv'
INTO TABLE Q2_2024
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;  -- This skips the header row if it's present in the CSV

Select * From Q2_2024 Limit 10;

LOAD DATA Local INFILE '/forbes_employees_2024.csv'
INTO TABLE employees
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(rang, organizationName, industry, country, employees)
;
Select * from employees Limit 15;

DELETE FROM employees
ORDER BY rang ASC
LIMIT 1;

Select * from employees Limit 15;
