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