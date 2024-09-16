Select * 
FROM [COVID-19 EDA Project]..coviddeaths
ORDER BY 3,4


Select * 
FROM [COVID-19 EDA Project]..covidvaccinations
ORDER BY 3,4

--Average new cases per day for a specific country

SELECT location, ROUND(AVG(new_cases),0) AS avg_new_cases
FROM [COVID-19 EDA Project]..coviddeaths
WHERE location = 'India'
GROUP BY location

--Top 5 countries with the highest case growth rate

SELECT 
    TOP 5
    location, 
    CASE 
        WHEN SUM(total_cases) > 0 THEN (SUM(new_cases) / SUM(total_cases))* 100
        ELSE 0
    END AS growth_rate_percentage
FROM [COVID-19 EDA Project]..coviddeaths
GROUP BY location
ORDER BY growth_rate_percentage DESC;

`
Select location,date,total_cases,new_cases,total_deaths, population
FROM [COVID-19 EDA Project]..coviddeaths
ORDER BY 1,2

--Total cases vs Total Deaths

Select
	location,
	date,
	total_cases,
	total_deaths,
	CASE 
        WHEN total_cases > 0 THEN (total_deaths / total_cases) * 100
        ELSE 0 
    END AS DeathPercentage
FROM [COVID-19 EDA Project]..coviddeaths
WHERE location like '%state%'
ORDER BY 1,2


--Total cases vs population
Select
	location,
	date,
	population
	total_cases,
	CASE 
        WHEN total_cases > 0 THEN (total_cases / population) * 100
        ELSE 0 
    END AS PopulationPercentage
FROM [COVID-19 EDA Project]..coviddeaths
ORDER BY 1,2

--country with highest infection rate compared to population

Select
	location,
	population,
	max(total_cases) as HighestInfectionCount,
	Max((total_cases/population)) * 100 AS PopulationPercentageInfected
FROM [COVID-19 EDA Project]..coviddeaths
Group By location,population
ORDER BY PopulationPercentageInfected desc

--Countries with highest death count per population

Select
	location,
	max(total_deaths) as TotalDeathCount
FROM [COVID-19 EDA Project]..coviddeaths
Group By location
ORDER BY TotalDeathCount desc

--continent with highest death count per population

Select
	continent,
	max(total_deaths) as TotalDeathCount
FROM [COVID-19 EDA Project]..coviddeaths
WHERE continent IS NOT NULL
Group By continent
ORDER BY TotalDeathCount desc

--Total Population vs Vaccinations

SELECT dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations
FROM [COVID-19 EDA Project]..coviddeaths AS dea
JOIN [COVID-19 EDA Project]..covidvaccinations AS VAC
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 1,2,3


-- Using CTE

WITH populationVSvaccination (continent,location,date,population,new_vaccinations)
as
(
SELECT dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations
FROM [COVID-19 EDA Project]..coviddeaths AS dea
JOIN [COVID-19 EDA Project]..covidvaccinations AS VAC
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
)
Select * 
From populationVSvaccination