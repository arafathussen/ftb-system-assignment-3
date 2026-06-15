# ⚽ Football Ticket Booking System

A relational database project for managing football fans, matches, and ticket bookings — built with PostgreSQL.

---

## 📊 ERD Diagram

🔗 [View Live on Lucidchart](https://lucid.app/lucidchart/ecef057b-d601-49bc-bcf1-a4d0f92a2963/view)

![ERD Diagram](https://i.ibb.co.com/TxnQG9fc/Screenshot-22.jpg)

---

## 🗄️ Schema Overview

| Table | Fields | Key Constraints |
|---|---|---|
| **Users** | user_id, full_name, email, role, phone_number | PK, UNIQUE email, CHECK role |
| **Matches** | match_id, fixture, tournament_category, base_ticket_price, match_status | PK, CHECK price ≥ 0, CHECK status |
| **Bookings** | booking_id, user_id, match_id, seat_number, payment_status, total_cost | PK, FK→Users, FK→Matches, CHECK cost ≥ 0 |

---

## 📝 SQL Queries

| # | Description | Concepts |
|---|---|---|
| Q1 | Champions League Available Matches | `WHERE`, `AND` |
| Q2 | User Search by Name | `ILIKE` |
| Q3 | NULL Payment Status Finder | `IS NULL`, `COALESCE` |
| Q4 | Booking Details with User & Match | `INNER JOIN` |
| Q5 | All Users including those without Bookings | `LEFT JOIN` |
| Q6 | Above Average Cost Bookings | Subquery, `AVG()` |
| Q7 | Top 2 Matches Skipping Highest Price | `ORDER BY`, `LIMIT`, `OFFSET` |

---

> 🙏 *Thanks for checking out my work! This project was developed with strict adherence to relational database normalization principles, PostgreSQL best practices, and clean schema architecture. Every constraint, relationship, and query was carefully designed to reflect real-world booking system logic.*

<p align="center">⚽ Built with PostgreSQL · Lucidchart · Beekeeper Studio · Git</p>
