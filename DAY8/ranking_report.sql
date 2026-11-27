-- ============================================
-- TASK 3: PASSENGER RANKING REPORT
-- RANK() AND DENSE_RANK()
-- ============================================

SELECT
    b.flight_id,
    p.passenger_name,
    b.fare,

    RANK() OVER (
        PARTITION BY b.flight_id
        ORDER BY b.fare DESC
    ) AS fare_rank,

    DENSE_RANK() OVER (
        PARTITION BY b.flight_id
        ORDER BY b.fare DESC
    ) AS dense_fare_rank

FROM Booking b
JOIN Passenger p
ON b.passenger_id = p.passenger_id

ORDER BY b.flight_id, b.fare DESC;

-- ============================================
-- TASK 4: CTE AND RUNNING TOTAL OF REVENUE
-- ============================================

WITH FlightRevenue AS
(
    SELECT
        b.booking_id,
        b.flight_id,
        p.passenger_name,
        b.fare,

        SUM(b.fare) OVER (
            PARTITION BY b.flight_id
            ORDER BY b.fare, b.booking_id
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW
        ) AS running_total

    FROM Booking b
    JOIN Passenger p
    ON b.passenger_id = p.passenger_id
)

SELECT
    booking_id,
    flight_id,
    passenger_name,
    fare,
    running_total

FROM FlightRevenue

ORDER BY flight_id, fare, booking_id;

-- ============================================
-- TASK 5: CORRELATED SUBQUERY
-- FARE ABOVE AVERAGE OF THEIR FLIGHT
-- ============================================

SELECT
    p.passenger_id,
    p.passenger_name,
    b.flight_id,
    b.fare

FROM Booking b

JOIN Passenger p
ON b.passenger_id = p.passenger_id

WHERE b.fare >
(
    SELECT AVG(b2.fare)
    FROM Booking b2
    WHERE b2.flight_id = b.flight_id
)

ORDER BY b.flight_id, b.fare DESC;

-- ============================================
-- FINAL VERIFICATION
-- ============================================

SELECT * FROM Flight;

SELECT * FROM Passenger;

SELECT * FROM Seat;

SELECT * FROM Booking;
