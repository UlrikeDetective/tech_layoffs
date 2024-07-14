USE Tech_layoffs;

# Identify Spelling Errors
SELECT DISTINCT Industry
FROM tech_layoffs;

# Duplicate Rows
SELECT *
FROM (
  SELECT Company, Location_HQ, Country, Laid_Off, Date_layoffs, Industry,
         ROW_NUMBER() OVER (PARTITION BY Company, Location_HQ, Country, Laid_Off, Date_layoffs, Industry) AS row_num
  FROM tech_layoffs
) AS duplicates  
WHERE row_num > 1;

SELECT Company, Location_HQ, Country, Laid_Off,Date_layoffs, Industry
FROM tech_layoffs
WHERE Company LIKE 'Criteo';

SELECT Company, Location_HQ, Country, Laid_Off,Date_layoffs, Industry
FROM tech_layoffs
WHERE Company LIKE 'Etsy';

SELECT Company, Location_HQ, Country, Laid_Off,Date_layoffs, Industry
FROM tech_layoffs
WHERE Company LIKE 'Tome';

# Missing values
SELECT Laid_Off, Percentage, Company_Size_before_Layoffs, Company_Size_after_layoffs
FROM tech_layoffs
WHERE Laid_Off IS NULL
OR Percentage IS NULL 
OR Company_Size_before_Layoffs IS NULL 
OR Company_Size_after_layoffs IS NULL;

# Clean Dataset from missing values
SELECT *
FROM tech_layoffs
WHERE Laid_Off IS NOT NULL
AND Percentage IS NOT NULL 
AND Company_Size_before_Layoffs IS NOT NULL 
AND Company_Size_after_layoffs IS NOT NULL;
# after save new dataset

#new table with no duplicates
CREATE TABLE Cleaned_tech_layoffs AS
SELECT Company, Location_HQ, Country, Laid_Off, Date_layoffs, Industry
FROM Original_tech_layoffs
GROUP BY Company, Location_HQ, Country, Laid_Off, Date_layoffs, Industry;

# new table with no duplicates and no missing values
CREATE TABLE Cleaned_tech_layoffs AS
SELECT DISTINCT Company, Location_HQ, Country, Laid_Off, Date_layoffs, Industry, Percentage, Company_Size_before_Layoffs, Company_Size_after_layoffs
FROM tech_layoffs
WHERE Laid_Off IS NOT NULL
  AND Percentage IS NOT NULL 
  AND Company_Size_before_Layoffs IS NOT NULL 
  AND Company_Size_after_layoffs IS NOT NULL
GROUP BY Company, Location_HQ, Country, Laid_Off, Date_layoffs, Industry;

# temporary table with no duplicates and no missing values
CREATE TEMPORARY TABLE Temp_tech_layoffs AS
SELECT DISTINCT Company, Location_HQ, Country, Laid_Off, Date_layoffs, Industry, Percentage, Company_Size_before_Layoffs, Company_Size_after_layoffs
FROM tech_layoffs
WHERE Laid_Off IS NOT NULL
  AND Percentage IS NOT NULL 
  AND Company_Size_before_Layoffs IS NOT NULL 
  AND Company_Size_after_layoffs IS NOT NULL
GROUP BY Company, Location_HQ, Country, Laid_Off, Date_layoffs, Industry;

-- Ensure the original table is empty before inserting filtered and deduplicated data
TRUNCATE TABLE tech_layoffs;

INSERT INTO tech_layoffs (Company, Location_HQ, Country, Laid_Off, Date_layoffs, Industry, Percentage, Company_Size_before_Layoffs, Company_Size_after_layoffs)
SELECT Company, Location_HQ, Country, Laid_Off, Date_layoffs, Industry, Percentage, Company_Size_before_Layoffs, Company_Size_after_layoffs
FROM Temp_tech_layoffs;

-- Drop the temporary table
DROP TABLE Temp_tech_layoffs;


