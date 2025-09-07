# Covid19_Data_Tableau
Here's a professional README file for your COVID-19 data analysis project.

COVID-19 Data Exploration
This repository contains a data exploration project on COVID-19 data using MySQL for data cleaning and analysis, and Tableau for visualization. The goal of this project was to analyze key metrics such as total cases, total deaths, and vaccination rates across different locations.

💾 Dataset
The dataset consists of two primary tables:

coviddeaths: Contains information about COVID-19 cases, deaths, and population.

covidvaccinations: Contains data on new and total vaccinations.

🛠️ Tools
MySQL: Used for data cleaning, transformation, and querying. The SQL script Covid19_Data_Exploratory.sql details the entire process.

Tableau: Used to create interactive and insightful visualizations from the cleaned data.

📈 Analysis & Findings
The SQL script performs several key analyses:

Total Cases vs. Total Deaths: Calculates the death percentage (Case Fatality Rate) for each country, showing the likelihood of dying if you contract COVID-19.

Total Cases vs. Population: Determines the infection percentage, revealing what portion of a country's population has been infected.

Highest Death Rate: Identifies countries and continents with the highest death rates relative to their population.

Global Statistics: Summarizes total cases, deaths, and the overall death percentage on a global scale.

Vaccination Progress: Joins the coviddeaths and covidvaccinations tables to analyze the progress of vaccination campaigns, calculating the percentage of the population that has received a vaccination over time.

📁 Repository Structure
Covid19_Data_Exploratory.sql: The main SQL script for data cleaning, analysis, and data type conversions. It also includes examples of using CTE (Common Table Expressions) and Temporary Tables.

Tableau_Dashboard_Link.txt: A text file containing the public link to the Tableau dashboard.

🚀 How to Use
Clone the Repository:

Bash

git clone https://github.com/YourUsername/YourRepoName.git
Import Data to MySQL:

Load your coviddeaths and covidvaccinations datasets into a MySQL database.

Run the SQL Script:

Execute the queries in Covid19_Data_Exploratory.sql to clean and analyze the data.

Explore the Visualizations:

Open the link in Tableau_Dashboard_Link.txt to view the interactive visualizations.
