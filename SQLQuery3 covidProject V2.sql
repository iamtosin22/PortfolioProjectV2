--select *
--from CovidDeaths
--order by 3,4

--select *
--from CovidVaccinations
--where continent is not null
--order by 3,4

--select location, date, total_cases, new_cases, total_deaths, population 
--from CovidDeaths 
--order by 1,2


--select location, date, population, total_cases, (total_cases/population)*100 as Deathpercentage 
--from CovidDeaths 
--where location like '%africa%'
--order by 1,2

--select location, population, max(total_cases) as highestinfcount, max(total_cases/population)*100 as POPI
--from CovidDeaths
--group by location, population
--order by POPI desc 

--select continent, max(cast(total_deaths as int)) as TotaldeathCount
--from CovidDeaths
--where continent is not null
--group by continent
--order by TotaldeathCount desc

--select date, sum(new_cases) NCs, sum(cast(new_deaths as int)) NDs, sum(cast(new_deaths as int))/ sum(new_cases)*100 Dpercentage
--from CovidDeaths
--where continent is not null
--group by date
--order by 1,2

--CTE
--with PopVsVac (continent, location, date, population, new_vaccinations, rollingpipovaccinted) 
--as 
--(
--select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
--, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) Rollingpipovaccinted
--from CovidDeaths dea
--join CovidVaccinations vac
--on dea.location = vac.location
--and dea.date = vac.date 
--where dea.continent is not null
--) 
--select *, (rollingpipovaccinted/population)*100
--from PopVsVac

--TEMP TABLE

--Create table #PercentPopulationVaccinated
--(
--Continent nvarchar(255),
--Location nvarchar(255),
--Date datetime,
--Population numeric,
--New_vaccinations numeric,
--rollingpipovaccinted numeric
--)

--Insert into #PercentPopulationVaccinated
--select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
--, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) Rollingpipovaccinted
--from CovidDeaths dea
--join CovidVaccinations vac
--on dea.location = vac.location
--and dea.date = vac.date 
--where dea.continent is not null

--select *, (rollingpipovaccinted/population)*100
--from #PercentPopulationVaccinated

--Create View PercentPopulationVaccinated as
--select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
--, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) Rollingpipovaccinted
--from CovidDeaths dea
--join CovidVaccinations vac
--on dea.location = vac.location
--and dea.date = vac.date 
--where dea.continent is not null

select *
from PercentPopulationVaccinated 
