Use Tech_layoffs;

SELECT Company, SUBSTRING(Date_layoffs, 1, 4) as layoff_year,
SUBSTRING(Date_layoffs, 6, 2) as layoff_month from Q2_2024