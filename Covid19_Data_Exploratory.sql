-- Change the data type of the column "new_deaths"
UPDATE coviddeaths
SET new_deaths = NULL
WHERE new_deaths ='';
ALTER TABLE coviddeaths
MODIFY COLUMN new_deaths INT;

-- Change the data type of the column "date"
UPDATE coviddeaths
SET date = STR_TO_DATE(date, '%m/%d/%Y');
ALTER TABLE coviddeaths
MODIFY COLUMN `date` DATE;

-- Looking at Total Cases Vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
SELECT location, Max(date) AS Last_Date, MAX(total_cases), MAX(total_deaths), 
MAX(total_deaths)/MAX(total_cases)*100 AS Death_Percentage FROM coviddeaths
GROUP BY location
ORDER  BY Death_Percentage DESC;

-- Looking at Total cases Vs Population
-- Looking at How many people in the population catching Covid 19
SELECT location, MAX(total_cases) AS TotalCases, population, 
MAX(total_cases)/population*100 AS Infection_Percentage FROM coviddeaths
GROUP BY location, population
ORDER  BY Infection_Percentage DESC;

-- The column "total_deaths" should be typed as "int" not "text"
UPDATE coviddeaths
SET total_deaths = null
WHERE total_deaths = '';
ALTER TABLE coviddeaths
MODIFY COLUMN total_deaths INT;

-- Showing the countries with the highest death rate per population
SELECT location, population, MAX(total_deaths) AS TotalDeaths, 
MAX(total_deaths)/population*100 AS Death_Percentage FROM coviddeaths
WHERE continent IS NOT NULL AND continent <> '' 
GROUP BY location, population
HAVING location IS NOT NULL AND location <> '' 
ORDER  BY Death_Percentage DESC;
-- Method2 Using New_Deaths
SELECT location, SUM(new_deaths) AS TotalDeaths,population, 
SUM(new_deaths)/population*100 AS Death_Percentage FROM coviddeaths
WHERE continent IS NOT NULL AND continent <> '' 
GROUP BY location, population
HAVING location IS NOT NULL AND location <> '' 
ORDER  BY Death_Percentage DESC;

-- Showing the continents/countries with the highest death rate per population
-- Method1 Using New_Cases
SELECT continent, location, MAX(total_deaths) AS TotalDeaths,population, 
MAX(total_deaths)/population*100 AS Death_Percentage FROM coviddeaths
GROUP BY continent, location, population
Having continent IS NOT NULL AND continent <> ''
ORDER  BY Death_Percentage DESC;
-- Method2 Using New_Deaths
SELECT continent, location, SUM(new_deaths) AS Total_Deaths,population, 
SUM(new_deaths)/population*100 AS Death_Percentage FROM coviddeaths
GROUP BY continent, location, population
Having continent IS NOT NULL AND continent <> ''
ORDER  BY Death_Percentage DESC;

-- Let's break down things into continent
SELECT continent, SUM(new_deaths) AS Total_Deaths, SUM(new_cases) AS Total_Cases, 
SUM(new_deaths)/SUM(new_cases)*100 AS Death_Percentage FROM coviddeaths
GROUP BY continent
Having continent IS NOT NULL AND continent <> ''
ORDER  BY Death_Percentage DESC;

-- The column "new_vaccinations" should be typed as "int" not "text"
UPDATE covidvaccinations
SET new_vaccinations = null
WHERE new_vaccinations = '';
ALTER TABLE covidvaccinations
MODIFY COLUMN  new_vaccinations INT;

-- Joining coviddeaths and covidvaccinations tables
-- Looking at Total population on coviddeaths vs new vaccinations on covidvaccination
SELECT DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations 
FROM coviddeaths AS DEA 
JOIN covidvaccinations AS VAC
ON DEA.location = VAC.location AND DEA.date = VAC.date
WHERE DEA.continent IS NOT NULL AND DEA.continent <> '' AND
VAC.new_vaccinations IS NOT NULL AND VAC.new_vaccinations <>''
ORDER BY 2,3;

-- Looking at Total population on coviddeaths vs accumulated no # new vaccinations on covidvaccination
-- ************************************* Method1  ***********************************************
SELECT *, ACC_NEW_VAC/population*100 FROM
(SELECT DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations,
SUM(VAC.new_vaccinations) OVER(partition by DEA.location ORDER BY DEA.date) AS ACC_NEW_VAC
FROM coviddeaths AS DEA 
JOIN covidvaccinations AS VAC
ON DEA.location = VAC.location AND DEA.date = VAC.date
WHERE DEA.continent IS NOT NULL AND DEA.continent <> '' AND
VAC.new_vaccinations IS NOT NULL AND VAC.new_vaccinations <>''
) AS JOINED_TABLES
ORDER BY 2,3;
-- *********************************** Method2: USING CTE *************************************
WITH ACCUMULATED_NEW_VAC_PER_LOCATION(continent, location, date, population, new_vaccinations,
ACC_NEW_VAC) AS 
(SELECT DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations,
SUM(VAC.new_vaccinations) OVER(partition by DEA.location ORDER BY DEA.date) AS ACC_NEW_VAC
FROM coviddeaths AS DEA 
JOIN covidvaccinations AS VAC
ON DEA.location = VAC.location AND DEA.date = VAC.date
WHERE DEA.continent IS NOT NULL AND DEA.continent <> '' AND
VAC.new_vaccinations IS NOT NULL AND VAC.new_vaccinations <>'')
SELECT *, ACC_NEW_VAC/population*100 FROM ACCUMULATED_NEW_VAC_PER_LOCATION;
-- *****************************  Method3: CREATING A TEMPORARY TABLE *******************************
Drop TABLE IF EXISTS ACCUMULATED_NEW_VAC_PER_LOCATION;
CREATE TABLE ACCUMULATED_NEW_VAC_PER_LOCATION (
continent text,
location text,
`date` text,
population int,
new_vaccination int,
ACC_NEW_VAC int
);
INSERT INTO ACCUMULATED_NEW_VAC_PER_LOCATION
SELECT DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations,
SUM(VAC.new_vaccinations) OVER(partition by DEA.location ORDER BY DEA.date) AS ACC_NEW_VAC
FROM coviddeaths AS DEA 
JOIN covidvaccinations AS VAC
ON DEA.location = VAC.location AND DEA.date = VAC.date
WHERE DEA.continent IS NOT NULL AND DEA.continent <> '' AND
VAC.new_vaccinations IS NOT NULL AND VAC.new_vaccinations <>'';
SELECT *, ACC_NEW_VAC/population*100 FROM accumulated_new_vac_per_location;
-- **************************** Method4: Creating View ********************************************
DROP VIEW IF EXISTS ACCUMULATED_NEW_VAC_PER_LOCATION_VIEW;
CREATE VIEW ACCUMULATED_NEW_VAC_PER_LOCATION_VIEW AS  
SELECT DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations,
SUM(VAC.new_vaccinations) OVER(partition by DEA.location ORDER BY DEA.date) AS ACC_NEW_VAC
FROM coviddeaths AS DEA 
JOIN covidvaccinations AS VAC
ON DEA.location = VAC.location AND DEA.date = VAC.date
WHERE DEA.continent IS NOT NULL AND DEA.continent <> '' AND
VAC.new_vaccinations IS NOT NULL AND VAC.new_vaccinations <>'';
SELECT * , ACC_NEW_VAC/population*100 FROM ACCUMULATED_NEW_VAC_PER_LOCATION_VIEW LIMIT 1000; 

-- Global Stats of Total cases and deaths 
SELECT SUM(new_cases) AS TotalCases, SUM(new_deaths) AS TotalDeaths, 
SUM(new_deaths)/SUM(new_cases)*100
AS DeathPercentage FROM coviddeaths
WHERE continent <> '' AND new_cases IS NOT NULL AND new_cases <> '' AND 
new_deaths IS NOT NULL AND new_deaths <>'';

-- Global stats per continent excluded in the above query
SELECT location, SUM(new_cases) AS TotalCases, SUM(new_deaths) AS TotalDeaths
FROM coviddeaths
WHERE continent ='' AND (location NOT IN ('World','International','European Union'))
AND new_cases IS NOT NULL AND new_cases <> '' AND
new_deaths IS NOT NULL AND new_deaths <>''
GROUP BY location
ORDER BY TotalDeaths DESC;

-- Looking at How many people in the population catching Covid 19
SELECT location, population, date, MAX(total_cases) AS TotalCases, 
MAX(total_cases)/population*100 AS Infection_Percentage FROM coviddeaths
GROUP BY location, population, date
ORDER  BY Infection_Percentage DESC;












 
