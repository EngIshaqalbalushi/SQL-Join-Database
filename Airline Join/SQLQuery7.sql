

---
SELECT fl.leg_no, fl.scheduled_dep_time, fl.scheduled_arr_time, at.typename AS airplane_name
FROM FlightLeg fl
JOIN LegInstance li ON fl.leg_no = li.leg_no
JOIN HasFlightLeg hfl ON fl.leg_no = hfl.leg_no
JOIN Flight f ON hfl.flight_id = f.flight_id
JOIN Airplane a ON (a.airplane_id = f.flight_id) -- This join might not be correct - needs airplane assignment
JOIN AirplaneType at ON a.typename = at.typename;


-----
-- This can't be fully answered with current schema as airport associations are missing
SELECT f.flight_id, 'Unknown' AS departure_airport, 'Unknown' AS arrival_airport
FROM Flight f;
-----
SELECT sr.*, c.name AS customer_name, c.phone
FROM SeatReservation sr
JOIN MadeReservation mr ON sr.reservation_id = mr.reservation_id
JOIN Customer c ON mr.customer_id = c.customer_id;
---
SELECT f.flight_id, a.city, a.state
FROM Flight f, Airport a
WHERE a.airport_code IN ('JFK', 'LAX');

---
SELECT * FROM Flight WHERE CAST(flight_id AS VARCHAR) LIKE '10%';

-----

SELECT c.customer_id, c.name, SUM(f.amount) AS total_payment
FROM Customer c
JOIN MadeReservation mr ON c.customer_id = mr.customer_id
JOIN SeatReservation sr ON mr.reservation_id = sr.reservation_id
JOIN Fare f ON (f.code = sr.seat_number) -- This join is hypothetical
GROUP BY c.customer_id, c.name
HAVING SUM(f.amount) BETWEEN 200 AND 600;

-------------

SELECT c.customer_id, c.name, COUNT(*) AS seats_booked
FROM Customer c
JOIN MadeReservation mr ON c.customer_id = mr.customer_id
JOIN SeatReservation sr ON mr.reservation_id = sr.reservation_id
JOIN LegInstance li ON sr.given_date = li.given_date
JOIN HasFlightLeg hfl ON li.leg_no = hfl.leg_no
WHERE hfl.flight_id = 1001
GROUP BY c.customer_id, c.name
HAVING COUNT(*) > 1;


-------
-- Can't be answered as there's no agent table in the schema
SELECT 'No agent data available' AS message;


----

SELECT c.name, f.flight_id, sr.given_date AS flight_date
FROM Customer c
JOIN MadeReservation mr ON c.customer_id = mr.customer_id
JOIN SeatReservation sr ON mr.reservation_id = sr.reservation_id
JOIN LegInstance li ON sr.given_date = li.given_date
JOIN HasFlightLeg hfl ON li.leg_no = hfl.leg_no
JOIN Flight f ON hfl.flight_id = f.flight_id
ORDER BY sr.given_date;

----
-- Can't be fully answered as departure city isn't linked to flights
SELECT f.flight_id, fl.scheduled_dep_time, at.airline
FROM Flight f
JOIN HasFlightLeg hfl ON f.flight_id = hfl.flight_id
JOIN FlightLeg fl ON hfl.leg_no = fl.leg_no
JOIN Airplane a ON (a.airplane_id = f.flight_id) -- Hypothetical join
JOIN AirplaneType at ON a.typename = at.typename
WHERE 'New York' IN (SELECT city FROM Airport WHERE airport_code = 'JFK');


-----
-- Can't be answered as there's no staff table in the schema
SELECT 'No staff data available' AS message;

-----
SELECT sr.reservation_id, sr.seat_number, c.name AS passenger_name, 
       CASE WHEN f.amount IS NULL THEN 'Unpaid' ELSE CAST(f.amount AS VARCHAR) END AS payment_status
FROM SeatReservation sr
LEFT JOIN MadeReservation mr ON sr.reservation_id = mr.reservation_id
LEFT JOIN Customer c ON mr.customer_id = c.customer_id
LEFT JOIN Fare f ON (f.code = sr.seat_number); -- Hypothetical join