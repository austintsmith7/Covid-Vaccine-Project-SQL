-- Covid Project
-- a. Datawise Likelihood of dying due to covid-Totalcases vs TotalDeath- in India

SELECT date, total_cases, total_deaths
FROM "CovidDeaths"
WHERE location LIKE '%India%';

--b. Total % of deaths out of entire population- in India

SELECT *
FROM public."CovidDeaths" 
WHERE location LIKE '%India%';

-- Need to update population as integer instead of varchar

SELECT MAX(total_deaths)/AVG(CAST(population as integer))*100 
FROM "CovidDeaths"
WHERE location LIKE '%India';

-- c. Verify b by getting into separately

SELECT total_deaths, population 
FROM "CovidDeaths" 
WHERE location LIKE '%India%';

-- d. Country with highest death as a % of population

SELECT location, MAX(total_deaths)/AVG(CAST(population as bigint)*100) as percentage
FROM "CovidDeaths"
GROUP BY location
ORDER BY percentage DESC;

-- e. Total % of covid +ve cases- in India

SELECT (MAX(total_cases)/AVG(CAST(population as bigint))*100) as percentagepositive
FROM "CovidDeaths"
WHERE location LIKE '%India';

-- f. Total % of covid +ve cases- in world

SELECT location, (MAX(total_cases)/AVG(CAST(population as bigint))*100) as percentagepositive
FROM "CovidDeaths"
GROUP BY location
ORDER BY percentagepositive DESC;

-- g. Continentwise +ve cases

SELECT location, MAX(total_cases) as total_case
FROM "CovidDeaths"
WHERE continent IS NULL
GROUP BY location
ORDER BY total_case DESC;

-- Got an error ^ but corrected the code below

SELECT location, MAX(total_cases) AS total_case
FROM "CovidDeaths"
WHERE "CovidDeaths"."continent " IS NULL
GROUP BY location
ORDER BY total_case DESC;

-- h. Continentwise deaths

SELECT location, MAX(total_deaths) AS total_death
FROM "CovidDeaths"
WHERE "CovidDeaths"."continent " IS NULL
GROUP BY location
ORDER BY total_death DESC;

-- i. Daily newcases vs hospitalizations vs icu_patients- India

SELECT date, new_cases, hosp_patients, icu_patients
FROM "CovidDeaths"
WHERE location LIKE '%India%'

-- j. countrywise age 65>

SELECT "CovidDeaths".date, "CovidDeaths".location, "CovidVaccinations".aged_65_older
FROM "CovidDeaths"
JOIN "CovidVaccinations" ON "CovidDeaths".iso_code = "CovidVaccinations".iso_code
AND "CovidDeaths".date = "CovidVaccinations".date;

-- k. Countrywise total vaccinated persons

SELECT "CovidDeaths".location as country, (MAX("CovidVaccinations".people_fully_vaccinated)) as Fully_vaccinated
FROM "CovidDeaths"
JOIN "CovidVaccinations" ON "CovidDeaths".iso_code = "CovidVaccinations".iso_code
AND "CovidDeaths".date = "CovidVaccinations".date
WHERE "CovidDeaths"."continent " IS NOT NULL
GROUP BY country
ORDER BY Fully_vaccinated;


