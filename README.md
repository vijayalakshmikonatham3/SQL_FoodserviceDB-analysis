# SQL_FoodserviceDB-analysis
This repo is for sql analysis done on FoodserviceDB
# FoodserviceDB: Database Design & SQL for Data Analysis

## Project Overview
This project involves the creation and structuring of a robust database designed specifically for a food service company. The objective is to manage and analyze data concerning restaurants, consumers, and their interactions through reviews and ratings. This initiative aims to derive insightful correlations between consumer behaviors and restaurant attributes, thereby aiding in strategic decision-making and improving customer satisfaction.

## Table of Contents
- [Introduction](#introduction)
- [Part 1: Database Design and Normalization](#part-1-database-design-and-normalization)
  - [Creating Database/Tables](#creating-databasestables)
  - [ER Diagram](#er-diagram)
  - [Database Design and Normalization](#database-design-and-normalization)
- [Part 2: SQL Queries and Procedures](#part-2-sql-queries-and-procedures)
  - [Conditional Join Query](#conditional-join-query)
  - [Nested Join Query](#nested-join-query)
  - [Aggregation Functions Query](#aggregation-functions-query)
  - [Join Query with Rank Functions](#join-query-with-rank-functions)
  - [Stored Procedure](#stored-procedure)
  - [Nested Queries - EXISTS](#nested-queries---exists)
  - [Nested Queries - IN](#nested-queries---in)
  - [System Function](#system-function)
  - [Use of GROUP BY, HAVING, and ORDER BY Clauses](#use-of-group-by-having-and-order-by-clauses)
  - [Database Management](#database-management)
    - [Data Integrity and Concurrency](#data-integrity-and-concurrency)
    - [Database Security](#database-security)
    - [Database Backup and Recovery](#database-backup-and-recovery)

## Introduction
As part of our ongoing commitment to enhancing the operational efficiencies and analytical capabilities of food service companies, this report details the creation and structuring of a robust database designed specifically for a food service company. The objective is to manage and analyze data concerning restaurants, consumers, and their interactions through reviews and ratings.

## Part 1: Database Design and Normalization

### Creating Database/Tables
- **Restaurant Table**: Contains essential details about restaurants, including identifiers, location, services, and other pertinent attributes.
- **Consumers Table**: Details the profiles of consumers, including demographic and lifestyle information.
- **Ratings Table**: Links consumers with restaurants, providing a basis for evaluating restaurant performance across various parameters.
- **Restaurant_Cuisines Table**: Lists the cuisines available at each restaurant, connecting cuisine types with restaurant identifiers.

### ER Diagram
A database diagram representing the relationships between the tables, ensuring each entity is properly normalized and linked through primary and foreign keys.

### Database Design and Normalization
- **Restaurant Table**: Contains columns such as Restaurant_id, Name, City, State, Country, Zip_code, Latitude, Longitude, Alcohol_Service, Smoking_Allowed, Price, Franchise, Area, and Parking. The primary key is Restaurant_id.
- **Consumers Table**: Contains columns such as Consumer_id, City, State, Country, Latitude, Longitude, Smoker, Drink_Level, Transportation_Method, Marital_Status, Children, Age, Occupation, and Budget. The primary key is Consumer_id.
- **Ratings Table**: Contains columns such as Consumer_id, Restaurant_id, Overall_Rating, Food_Rating, and Service_Rating. The primary key is a composite key of Consumer_id and Restaurant_id, with foreign keys referencing Consumers and Restaurants.
- **Restaurant_Cuisines Table**: Contains columns such as Restaurant_id and Cuisine. The primary key is a composite key of Restaurant_id and Cuisine, with Restaurant_id referencing the Restaurants table.

Normalization ensures the database eliminates redundancy, improves integrity, and ensures data dependencies make sense.

## Part 2: SQL Queries and Procedures

### Conditional Join Query
Lists all restaurants with a medium-range price and open area serving Mexican food. The query retrieves restaurant details by applying filters on cuisine type, area, and price.

### Nested Join Query
Calculates the average service rating for each restaurant and joins it with other tables to retrieve information about cuisine types and restaurant ratings. The query filters results to include only restaurants with a specific overall rating.

### Aggregation Functions Query
Calculates the average age of consumers who have given a service rating of 0. The query joins the Consumers and Ratings tables and applies a filter to include only the relevant records.

### Join Query with Rank Functions
Retrieves restaurant names and their corresponding food ratings, ranked by the youngest consumer. The results are sorted based on food rating and consumer age.

### Stored Procedure
Updates the Service_rating of all restaurants to '2' if they have parking available either as 'yes' or 'public.' The stored procedure modifies the Ratings table based on the parking availability criteria.

### Nested Queries - EXISTS
Uses the EXISTS keyword to filter records in the Consumers table based on specific conditions involving multiple columns.

### Nested Queries - IN
Uses the IN keyword to retrieve information from the Consumers table based on specified criteria. The query filters data to include only relevant consumer profiles.

### System Function
Extracts and summarizes significant user data, including total counts, average ages, preferences in drinking, transportation modes, and marital statuses. The query groups users by city and calculates various metrics.

### Use of GROUP BY, HAVING, and ORDER BY Clauses
Groups data by city and counts the number of restaurants, filtering results to include only cities with more than five restaurants. The results are sorted in descending order based on the count of restaurants.

### Database Management

#### Data Integrity and Concurrency
- **Normalization and Entity Design**: Ensures the database is normalized to at least 3NF, avoiding redundancy and maintaining data integrity.
- **Concurrency Handling**: Implements transaction management and locking mechanisms to manage concurrent access and maintain consistency.

#### Database Security
- **Access Control**: Implements robust authentication and role-based access control (RBAC) to limit database access based on user roles.
- **Sensitive Data Protection**: Encrypts sensitive data and uses auditing to track access and changes, complying with regulations like HIPAA.

#### Database Backup and Recovery
- **Backup Strategies**: Establishes a comprehensive backup strategy including full, differential, and transaction log backups.
- **Disaster Recovery Planning**: Develops and tests recovery plans to ensure quick restoration in case of data loss or corruption.

