Create database Tech_layoffs;
Use Tech_layoffs;


SET GLOBAL local_infile = 'ON';
SHOW VARIABLES LIKE 'local_infile';
SHOW VARIABLES LIKE "secure_file_priv";

-- drop table forbes_names; 

CREATE TABLE Q2_2024 (
    # INT UNIQUE,
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
    PRIMARY KEY (#),
);

Show columns from Q2_2024;

LOAD DATA Local INFILE '/tech_layoffs_Q2_2024.csv'
INTO TABLE Q2_2024
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;  -- This skips the header row if it's present in the CSV
