

-- Let's take a look at the data
SELECT *
FROM HotelBookings..Sheet1$


-- Is the Revenue growing?
SELECT arrival_date_year, ROUND(SUM((stays_in_week_nights + stays_in_weekend_nights) * adr), 2) AS gross_revenue
FROM HotelBookings..Sheet1$
WHERE is_canceled = 0
GROUP BY arrival_date_year
ORDER BY gross_revenue DESC
--NOTE: 2020 data is available only till August 2020.


--Revenue breakdown by Hotel type
SELECT hotel, arrival_date_year, ROUND(SUM((stays_in_week_nights + stays_in_weekend_nights) * adr), 2) AS gross_revenue
FROM HotelBookings..Sheet1$
WHERE is_canceled = 0
GROUP BY arrival_date_year, hotel
ORDER BY gross_revenue desc


-- Revenue breakdown by month
SELECT hotel, arrival_date_month, arrival_date_year, ROUND(SUM((stays_in_week_nights + stays_in_weekend_nights) * adr), 2) AS gross_revenue
FROM HotelBookings..Sheet1$
WHERE is_canceled = 0
GROUP BY arrival_date_month, hotel, arrival_date_year
ORDER BY gross_revenue desc


-- Revenue breakdown by country
SELECT country, ROUND(SUM((stays_in_week_nights + stays_in_weekend_nights) * adr), 2) AS gross_revenue
FROM HotelBookings..Sheet1$
WHERE is_canceled = 0
GROUP BY country
ORDER BY gross_revenue desc


-- Month with highest footfalls
SELECT arrival_date_month, arrival_date_year, SUM(adults + children + babies) AS numguests
FROM HotelBookings..Sheet1$
WHERE is_canceled = 0
GROUP BY arrival_date_month, arrival_date_year
ORDER BY numguests DESC


-- month with lowest adr for Resort hotel
SELECT hotel, arrival_date_month, avg(adr) as AVGadr
FROM HotelBookings..Sheet1$
WHERE adr != 0
	AND hotel = 'Resort Hotel'
GROUP BY arrival_date_month, hotel--, arrival_date_year
ORDER BY AVGadr


-- month with lowest adr for City hotel
SELECT hotel, arrival_date_month, avg(adr) as AVGadr
FROM HotelBookings..Sheet1$
WHERE adr != 0
	AND hotel = 'City Hotel'
GROUP BY arrival_date_month, hotel--, arrival_date_year
ORDER BY AVGadr
-- October to March has the lowest adr for both hotel types


-- Total Required Parking spaces
SELECT hotel, arrival_date_year, SUM(required_car_parking_spaces) as TotalParkingRequired
FROM HotelBookings..Sheet1$
GROUP by hotel, arrival_date_year
ORDER BY arrival_date_year


-- Average meal cost
SELECT sh.hotel, sh.meal, ROUND(avg(mc.cost), 2) as costs
FROM HotelBookings..Sheet1$ AS sh
LEFT JOIN HotelBookings..meal_cost AS mc
	ON sh.meal = mc.meal
WHERE sh.meal != 'undefined'
GROUP BY hotel, sh.meal
ORDER BY costs


                                                              --CONCLUSION--