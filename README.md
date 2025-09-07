# Covid19_Data_Tableau

COVID-19 Data Analysis and Visualization
This project provides an in-depth exploratory analysis and visualization of global COVID-19 data. The analysis focuses on key metrics such as total cases, total deaths, and their relationship to population, offering insights into the pandemic's impact on a global and per-country basis.

💻 Tools and Technologies
MySQL: Used for comprehensive data cleaning, manipulation, and exploratory analysis. This includes data type conversions and querying to derive key insights.

Tableau: Utilized to create dynamic and interactive dashboards and visualizations from the cleaned data.

📂 Project Structure
CovidDeaths.csv: The raw dataset used for this project. It contains daily records of COVID-19 cases, deaths, and other relevant metrics.

Covid19_Data_Exploratory.sql: A MySQL script detailing the data cleaning and exploratory analysis process.

Covid19_Data_Tableau.twb: The Tableau workbook containing the visualizations.

📈 Analysis and Findings
The analysis was performed using MySQL to process the raw data and prepare it for visualization. Key areas of focus include:

Total Cases vs. Total Deaths: The analysis calculates the percentage of deaths relative to total cases, providing a measure of the likelihood of death if one contracts COVID-19 in a particular country. The query shows countries with the highest death rates.

Infection Rate: The project calculates the percentage of the population that has contracted COVID-19 by comparing total cases to the country's population.

Death Count by Country: The analysis identifies the countries with the highest overall death counts.

Global Statistics: The project provides an overview of the total number of cases and deaths worldwide, as well as per continent.

📊 Visualizations
The Tableau workbook (Covid19_Data_Tableau.twb) contains interactive dashboards and charts that visualize the findings from the MySQL analysis. These visualizations allow for an intuitive exploration of the data, highlighting geographical trends and country-specific impacts of the pandemic.
