DROP DATABASE FoodserviceDB
CREATE DATABASE FoodserviceDB
use FoodserviceDB
-------
SELECT r.Name, r.City, r.State, r.Country, r.Area, r.Price
FROM restaurants r
JOIN restaurant_cuisines rc ON r.Restaurant_ID = rc.Restaurant_ID
WHERE rc.Cuisine = 'Mexican' AND r.Area = 'Open' AND r.Price = 'Medium';
--------
  WITH RestaurantRatings AS (
    SELECT r.Restaurant_ID, AVG(rt.Service_Rating) AS OverallRating
    FROM restaurants r
    INNER JOIN Ratings rt ON r.Restaurant_ID = rt.Restaurant_ID
    INNER JOIN Restaurant_Cuisines rc ON r.Restaurant_ID = rc.Restaurant_ID
    WHERE rc.Cuisine IN ('Mexican', 'Italian')
    GROUP BY r.Restaurant_ID
)
SELECT
    Cuisine,
    COUNT(*) AS TotalRestaurants
FROM Restaurant_Cuisines rc
INNER JOIN RestaurantRatings rr ON rc.Restaurant_ID = rr.Restaurant_ID
WHERE OverallRating = 1
GROUP BY Cuisine;
----Calculate the average age of consumers who have given a 0 rating to the 'Service_rating' column. (NB: round off the value if it is a decimal)
SELECT ROUND(AVG(CAST(c.Age AS FLOAT)), 0) AS AvgAgeZeroServiceRating
FROM Consumers c
INNER JOIN Ratings r ON c.Consumer_ID = r.Consumer_ID
WHERE r.Service_rating = 0;
-----Write a query that returns the restaurants ranked by the youngest consumer. You should include the restaurant name and food rating that is given by that customer to the restaurant in your result. Sort the results based on food rating from high to low.
WITH YoungestConsumerRatings AS (
    SELECT
        r.Name AS Restaurant_Name,
        r.Restaurant_ID,
        rt.Food_rating,
        ROW_NUMBER() OVER (PARTITION BY r.Restaurant_ID ORDER BY c.Age ASC) AS RowNum
    FROM
        restaurants r
        INNER JOIN Ratings rt ON r.Restaurant_ID = rt.Restaurant_ID
        INNER JOIN Consumers c ON rt.Consumer_ID = c.Consumer_ID
)
SELECT
    Restaurant_Name,
    Food_rating
FROM
    YoungestConsumerRatings
WHERE
    RowNum = 1
ORDER BY
    Food_rating DESC;



-----Write a stored procedure for the query given as:Update the Service_rating of all restaurants to '2' if they have parking available, either as 'yes' or 'public'
CREATE PROCEDURE UpdateServiceRatingForRestaurantsWithParking AS BEGIN   UPDATE Ratings
    SET Service_rating = 2
    FROM Ratings r
    INNER JOIN Restaurant rt ON r.Restaurant_ID = rt.Restaurant_ID
    WHERE rt.Parking IN ('Yes', 'Public');
END;
EXEC UpdateServiceRatingForRestaurantsWithParking;


------You should also write four queries of your own and provide a brief explanation of the results which each query returns. You should make use of all of the following at least once:

---Nested queries-EXISTS
SELECT c1.City, c1.State, c1.Country
FROM consumers c1
WHERE EXISTS (
    SELECT 1
    FROM consumers c2
    WHERE c2.City = c1.City
      AND c2.State = c1.State
      AND c2.Country = c1.Country
      AND c2.Marital_Status = 'Married'
      AND c2.Children = 'Kids'
);

---------Nested queries-IN
SELECT c.Consumer_ID, c.City, c.State, c.Country
FROM consumers c
WHERE c.Consumer_ID IN (
    SELECT Consumer_ID
    FROM consumers
    WHERE Drink_Level = 'Social Drinker'
      AND Transportation_Method = 'Car'
      AND Occupation = 'Student'
);

--------system functions
SELECT 
    city, 
    COUNT(*) AS total_users, 
    AVG(age) AS average_age, 
    SUM(CASE WHEN Drink_Level = 'Abstemious' THEN 1 ELSE 0 END) AS abstemious_count, 
    SUM(CASE WHEN Drink_Level = 'Casual Drinker' THEN 1 ELSE 0 END) AS casual_drinker_count, 
    SUM(CASE WHEN Drink_Level = 'Social Drinker' THEN 1 ELSE 0 END) AS social_drinker_count, 
    SUM(CASE WHEN Transportation_Method = 'Public' THEN 1 ELSE 0 END) AS public_transportation_count, 
    SUM(CASE WHEN Transportation_Method = 'Car' THEN 1 ELSE 0 END) AS car_transportation_count, 
    SUM(CASE WHEN Transportation_Method = 'On Foot' THEN 1 ELSE 0 END) AS on_foot_transportation_count, 
    SUM(CASE WHEN marital_status = 'Single' THEN 1 ELSE 0 END) AS single_count, 
    SUM(CASE WHEN marital_status = 'Married' THEN 1 ELSE 0 END) AS married_count, 
    SUM(CASE WHEN marital_status = 'Kids' THEN 1 ELSE 0 END) AS kids_count, 
    (SUM(CASE WHEN marital_status = 'Single' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS single_percentage, 
    (SUM(CASE WHEN marital_status = 'Married' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS married_percentage, 
    (SUM(CASE WHEN marital_status = 'Kids' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS kids_percentage, 
    (SUM(CASE WHEN Drink_Level = 'Abstemious' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS abstemious_percentage, 
    (SUM(CASE WHEN Drink_Level = 'Casual Drinker' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS casual_drinker_percentage, 
    (SUM(CASE WHEN Drink_Level = 'Social Drinker' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS social_drinker_percentage, 
    (SUM(CASE WHEN Transportation_Method = 'Public' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS public_transportation_percentage, 
    (SUM(CASE WHEN Transportation_Method = 'Car' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS car_transportation_percentage, 
    (SUM(CASE WHEN Transportation_Method = 'On Foot' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS on_foot_transportation_percentage 
FROM 
    consumers 
GROUP BY 
    city 
HAVING 
    COUNT(*) > 10 
ORDER BY 
    total_users DESC, 
    average_age DESC;
	-----------Use of GROUP BY, HAVING and ORDER BY clauses--------
	SELECT 
    City, 
    COUNT(Restaurant_ID) AS TotalRestaurants  -- Counts the number of restaurants in each city
FROM 
    Restaurants
GROUP BY 
    City
HAVING 
    COUNT(Restaurant_ID) > 5  -- Filters to include only cities with more than 5 restaurants
ORDER BY 
    TotalRestaurants DESC;  -- Sorts cities by the total number of restaurants, highest first

