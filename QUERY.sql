-- =========================================================================
-- SYSTEM : Football Ticket Booking System Database Setup Template
-- =========================================================================

-- DROP TABLES IF THEY ALREADY EXIST TO PREVENT CONFLICTS
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Users;


-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================

CREATE TABLE Users (
    user_id      INT,
    full_name    VARCHAR(100) NOT NULL,
    email        VARCHAR(100) NOT NULL,
    role         VARCHAR(50)  NOT NULL,
    phone_number VARCHAR(20),

    -- Primary Key constraint on user_id
    CONSTRAINT users_pk PRIMARY KEY (user_id),

    -- Email must be unique across all users
    CONSTRAINT users_email_unique UNIQUE (email),

    -- Role is restricted to only these two allowed values
    CONSTRAINT users_role_check CHECK (role IN ('Ticket Manager', 'Football Fan'))
);


-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================

CREATE TABLE Matches (
    match_id             INT,
    fixture              VARCHAR(100) NOT NULL,
    tournament_category  VARCHAR(50),
    base_ticket_price    NUMERIC(10, 2),
    match_status         VARCHAR(20),

    -- Primary Key constraint on match_id
    CONSTRAINT matches_pk PRIMARY KEY (match_id),

    -- Ticket price cannot be negative
    CONSTRAINT matches_price_check CHECK (base_ticket_price >= 0),

    -- Match status restricted to only these four allowed values
    CONSTRAINT matches_status_check CHECK (match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);

-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================

CREATE TABLE Bookings (
    booking_id     INT,
    user_id        INT,
    match_id       INT,
    seat_number    VARCHAR(10),
    payment_status VARCHAR(20),
    total_cost     NUMERIC(10, 2),

    -- Primary Key constraint on booking_id
    CONSTRAINT bookings_pk PRIMARY KEY (booking_id),

    -- Foreign Key linking to Users table
    CONSTRAINT bookings_user_fk FOREIGN KEY (user_id) REFERENCES Users (user_id),

    -- Foreign Key linking to Matches table
    CONSTRAINT bookings_match_fk FOREIGN KEY (match_id) REFERENCES Matches (match_id),

    -- Total cost cannot be negative
    CONSTRAINT bookings_cost_check CHECK (total_cost >= 0),

    -- Payment status restricted to only these four allowed values
    CONSTRAINT bookings_status_check CHECK (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded'))
);


-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO USERS
-- =========================================================================

INSERT INTO Users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan',  '+8801711111111'),
(2, 'Asif Haque',   'asif@mail.com',   'Football Fan',  '+8801722222222'),
(3, 'Sajjad Rahman','sajjad@mail.com', 'Ticket Manager','+8801733333333'),
(4, 'Jannat Ara',   'jannat@mail.com', 'Football Fan',  NULL);


-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO MATCHES
-- =========================================================================

INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool',    'Premier League',   120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG',     'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan',  'Serie A',           90.00, 'Sold Out'),
(105, 'Juventus vs Roma',         'Serie A',           80.00, 'Available');


-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO BOOKINGS
-- =========================================================================

INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL,   NULL,        150.00),
(505, 3, 102, 'C-20', 'Pending',   120.00);


-- =========================================================================
-- PART 2: SQL QUERIES
-- =========================================================================


-- Query 1: Champions League Available Matches

SELECT match_id, fixture, base_ticket_price
FROM Matches
WHERE tournament_category = 'Champions League'
  AND match_status = 'Available';


-- Query 2: User Search by Name (ILIKE)

SELECT user_id, full_name, email
FROM Users
WHERE full_name ILIKE 'Tanvir%'
   OR full_name ILIKE '%Haque%';


   -- Query 3: NULL Payment Status Finder

SELECT
    booking_id,
    user_id,
    match_id,
    COALESCE(payment_status, 'Action Required') AS systematic_status
FROM Bookings
WHERE payment_status IS NULL;


-- Query 4: Booking Details with User & Match (INNER JOIN)

SELECT
    b.booking_id,
    u.full_name,
    m.fixture,
    b.total_cost
FROM Bookings b
INNER JOIN Users u   ON b.user_id  = u.user_id
INNER JOIN Matches m ON b.match_id = m.match_id;