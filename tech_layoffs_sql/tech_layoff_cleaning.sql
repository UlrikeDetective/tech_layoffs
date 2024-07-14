USE Tech_layoffs;

# Identify Spelling Errors
SELECT DISTINCT Industry
FROM Q2_2024;

# Duplicate Rows
SELECT *
FROM (
  SELECT Company, Location_HQ, Country, Laid_Off, Date_layoffs, Industry,
         ROW_NUMBER() OVER (PARTITION BY Company, Location_HQ, Country, Laid_Off, Date_layoffs, Industry) AS row_num
  FROM Q2_2024
) AS duplicates  
WHERE row_num > 1;

SELECT Company, Location_HQ, Country, Laid_Off,Date_layoffs, Industry
FROM Q2_2024
WHERE Company LIKE 'Criteo';

SELECT Company, Location_HQ, Country, Laid_Off,Date_layoffs, Industry
FROM Q2_2024
WHERE Company LIKE 'Etsy';

SELECT Company, Location_HQ, Country, Laid_Off,Date_layoffs, Industry
FROM Q2_2024
WHERE Company LIKE 'Tome';

# Missing values
SELECT Laid_Off, Percentage, Company_Size_before_Layoffs, Company_Size_after_layoffs
FROM Q2_2024
WHERE Laid_Off IS NULL
OR Percentage IS NULL 
OR Company_Size_before_Layoffs IS NULL 
OR Company_Size_after_layoffs IS NULL;

# Clean Dataset from missing values
SELECT *
FROM Q2_2024
WHERE Laid_Off IS NOT NULL
AND Percentage IS NOT NULL 
AND Company_Size_before_Layoffs IS NOT NULL 
AND Company_Size_after_layoffs IS NOT NULL;
# after save new dataset

#new table with no duplicates
CREATE TABLE Cleaned_Q2_2024 AS
SELECT Company, Location_HQ, Country, Laid_Off, Date_layoffs, Industry
FROM Original_Q2_2024
GROUP BY Company, Location_HQ, Country, Laid_Off, Date_layoffs, Industry;

# new table with no duplicates and no missing values
CREATE TABLE Cleaned_Q2_2024 AS
SELECT DISTINCT Company, Location_HQ, Country, Laid_Off, Date_layoffs, Industry, Company_Size_before_Layoffs, Company_Size_after_layoffs
FROM Q2_2024
WHERE Laid_Off IS NOT NULL
  AND Company_Size_before_Layoffs IS NOT NULL 
  AND Company_Size_after_layoffs IS NOT NULL
GROUP BY Company, Location_HQ, Country, Laid_Off, Date_layoffs, Industry;

-- Step 1: Create a temporary table with filtered and deduplicated data
CREATE TEMPORARY TABLE Temp_tech_layoffs AS
SELECT Company,
       Location_HQ,
       Country,
       Laid_Off,
       Date_layoffs,
       Industry,
       ANY_VALUE(Percentage) AS Percentage,
       ANY_VALUE(Company_Size_before_Layoffs) AS Company_Size_before_Layoffs,
       ANY_VALUE(Company_Size_after_layoffs) AS Company_Size_after_layoffs
FROM Q2_2024
WHERE Laid_Off IS NOT NULL
  AND Percentage IS NOT NULL
  AND Company_Size_before_Layoffs IS NOT NULL
  AND Company_Size_after_layoffs IS NOT NULL
GROUP BY Company, Location_HQ, Country, Laid_Off, Date_layoffs, Industry;


-- Step 2: Truncate the original table
TRUNCATE TABLE Q2_2024;

-- Step 3: Insert the filtered and deduplicated data back into the original table
INSERT INTO Q2_2024 (Company, Location_HQ, Country, Laid_Off, Date_layoffs, Industry, Percentage, Company_Size_before_Layoffs, Company_Size_after_layoffs)
SELECT Company,
       Location_HQ,
       Country,
       Laid_Off,
       Date_layoffs,
       Industry,
       Percentage,
       Company_Size_before_Layoffs,
       Company_Size_after_layoffs
FROM Temp_tech_layoffs;

Select * From temp_tech_layoffs Limit 10;
Select * From Q2_2024 Limit 10;

-- Step 4: Drop the temporary table
DROP TABLE Temp_tech_layoffs;
