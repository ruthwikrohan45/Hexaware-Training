-- STEP 1: CREATE DATABASE

CREATE DATABASE IF NOT EXISTS AirlineBookingDB;
USE AirlineBookingDB;

-- ============================================
-- STEP 2: CREATE TABLES
-- ============================================

DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Seat;
DROP TABLE IF EXISTS Passenger;
DROP TABLE IF EXISTS Flight;

CREATE TABLE Flight (
    flight_id VARCHAR(10) PRIMARY KEY,
    flight_name VARCHAR(50),
    source VARCHAR(50),
    destination VARCHAR(50)
) ENGINE = InnoDB;

CREATE TABLE Passenger (
    passenger_id INT PRIMARY KEY,
    passenger_name VARCHAR(50),
    email VARCHAR(100)
) ENGINE = InnoDB;

CREATE TABLE Seat (
    flight_id VARCHAR(10),
    seat_no VARCHAR(10),
    seat_status VARCHAR(20) DEFAULT 'Available',
    PRIMARY KEY (flight_id, seat_no),
    FOREIGN KEY (flight_id) REFERENCES Flight(flight_id)
) ENGINE = InnoDB;

CREATE TABLE Booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    passenger_id INT,
    flight_id VARCHAR(10),
    seat_no VARCHAR(10),
    fare DECIMAL(10,2),
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    UNIQUE (flight_id, seat_no),

    FOREIGN KEY (passenger_id)
        REFERENCES Passenger(passenger_id),

    FOREIGN KEY (flight_id, seat_no)
        REFERENCES Seat(flight_id, seat_no)
) ENGINE = InnoDB;

-- ============================================
-- STEP 3: INSERT SAMPLE DATA
-- ============================================

INSERT INTO Flight VALUES
('F101', 'Air India Express', 'Chennai', 'Delhi'),
('F102', 'IndiGo', 'Chennai', 'Mumbai'),
('F103', 'Air India', 'Bangalore', 'Delhi');

INSERT INTO Passenger VALUES
(101, 'Arun', 'arun@gmail.com'),
(102, 'Ravi', 'ravi@gmail.com'),
(103, 'Kumar', 'kumar@gmail.com'),
(104, 'Rahul', 'rahul@gmail.com'),
(105, 'Priya', 'priya@gmail.com'),
(106, 'Neha', 'neha@gmail.com');

INSERT INTO Seat VALUES
('F101', '01', 'Booked'),
('F101', '02', 'Booked'),
('F101', '03', 'Booked'),
('F101', '04', 'Booked'),
('F101', '05', 'Available'),
('F101', '06', 'Available'),

('F102', '01', 'Booked'),
('F102', '02', 'Booked'),
('F102', '03', 'Available'),
('F102', '04', 'Available'),

('F103', '01', 'Available'),
('F103', '02', 'Available'),
('F103', '03', 'Available');

INSERT INTO Booking
(passenger_id, flight_id, seat_no, fare)
VALUES
(101, 'F101', '01', 5000),
(102, 'F101', '02', 7000),
(103, 'F101', '03', 7000),
(104, 'F101', '04', 9000),
(105, 'F102', '01', 6000),
(106, 'F102', '02', 8000);

-- ============================================
-- TASK 1: BOOKING TRANSACTION
-- SELECT ... FOR UPDATE
-- ============================================

DROP PROCEDURE IF EXISTS BookSeat;

DELIMITER //

CREATE PROCEDURE BookSeat(
    IN p_passenger_id INT,
    IN p_flight_id VARCHAR(10),
    IN p_seat_no VARCHAR(10),
    IN p_fare DECIMAL(10,2)
)
BEGIN
    DECLARE v_status VARCHAR(20);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Lock the selected seat
    SELECT seat_status
    INTO v_status
    FROM Seat
    WHERE flight_id = p_flight_id
      AND seat_no = p_seat_no
    FOR UPDATE;

    -- Check seat availability
    IF v_status = 'Available' THEN

        -- Insert booking
        INSERT INTO Booking
        (passenger_id, flight_id, seat_no, fare)
        VALUES
        (p_passenger_id, p_flight_id, p_seat_no, p_fare);

        -- Update seat status
        UPDATE Seat
        SET seat_status = 'Booked'
        WHERE flight_id = p_flight_id
          AND seat_no = p_seat_no;

        COMMIT;

        SELECT 'Booking Successful' AS Booking_Status;

    ELSE

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Seat is already booked';

    END IF;

END //

DELIMITER ;

-- Execute Task 1

CALL BookSeat(106, 'F101', '05', 8000);

-- Check booking and seat status

SELECT * FROM Booking;

SELECT * FROM Seat
WHERE flight_id = 'F101';

-- ============================================
-- TASK 2: SIMULTANEOUS BOOKING
-- TWO MYSQL SESSIONS
-- ============================================



SELECT * FROM Seat
WHERE flight_id = 'F101'
AND seat_no = '06';


SELECT * FROM Booking
WHERE flight_id = 'F101'
AND seat_no = '06';

SELECT * FROM Seat
WHERE flight_id = 'F101'
AND seat_no = '06';
