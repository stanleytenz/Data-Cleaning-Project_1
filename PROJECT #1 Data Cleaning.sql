-- Data Cleaning

-- 1. Remove Duplicate
-- 2. Standarize the Data
-- 3. Null Values or blank values
-- 4. Remove any unnecesarry columns

SELECT * FROM layoffs;

CREATE TABLE layout_staging LIKE layoffs;

SELECT  * FROM layout_staging;

INSERT layout_staging
SELECT * FROM layoffs;

SELECT 
ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) AS row_num
FROM layout_staging;

SELECT * FROM layout_staging
WHERE company = 'Zymergen';

CREATE TABLE `layout_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM layout_staging2;

INSERT INTO layout_staging2
SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) AS row_num
FROM layout_staging;

SELECT *
FROM layout_staging2
WHERE row_num > 1;


