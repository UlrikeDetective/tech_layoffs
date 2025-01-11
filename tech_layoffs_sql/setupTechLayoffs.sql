select * from techLayoffs;

CREATE TABLE techLayoffs (
    Nr TEXT PRIMARY KEY,
    Company TEXT,
    Location_HQ TEXT,
    Region TEXT,
    USState TEXT,
    Country TEXT,
    Continent TEXT,
    Laid_Off INTEGER,
    Date_layoffs DATE,
    Percentage INTEGER,
    Company_Size_before_Layoffs INTEGER,
    Company_Size_after_Layoffs INTEGER,
    Industry TEXT,
    Stage TEXT,
    Money_Raised_in_mil INTEGER,
    Year INTEGER,
    latitude NUMERIC,
    longitude NUMERIC
);

Drop table techLayoffs;

COPY techLayoffs (Nr, Company, Location_HQ, Region, USState, Country, Continent, Laid_Off, Date_layoffs, Percentage, Company_Size_before_Layoffs, Company_Size_after_Layoffs, Industry, Stage, Money_Raised_in_mil, Year, latitude, longitude)
FROM '/Users/ulrike_imac_air/projects/DataScienceProjects/tech_layoffs_project/tech_layoffs_csv/tech_layoffs_til_Q4_2024.csv' DELIMITER ';' CSV HEADER;