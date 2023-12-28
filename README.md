Introduction:

This repository contains the database schema and scripts developed as part of a group project for a Database Management course. The project focuses on creating a comprehensive database system for managing a hotel's operations, including room bookings, customer details, feedback, and more.

Database Schema:

Tables:
Rum (Rooms)
Minibar
Kunder (Customers)
Bokningar (Bookings)
BokadeRum (Booked Rooms)
Betalkort (Credit Cards)
Önskemål (Requests)
Rabatter (Discounts)
GästFeedback (Guest Feedback)
Personal (Staff)
Meddelanden (Messages)
VistelseNotering (Stay Notes)
Functionality:

Trigger:

UppdateraTotaltSummaMedRabatt: Updates total booking cost based on discounts.
Stored Procedures:

usp_Updaterakontaktperson: Updates the contact person for a booking.
usp_KollaUppbokning: Checks and retrieves details of all bookings.
AddCustomer: Adds a new customer.
usp_AddCustomerBookingPayment: Adds a new customer along with a booking and payment.
Sample Data:

The repository includes sample data for testing purposes, including records for rooms, customers, bookings, feedback, staff, and more.

How to Use:

Clone the repository.
Execute the SQL scripts in a SQL Server environment to create the database and tables.
Use the provided stored procedures for various operations.
Feel free to explore and customize the scripts based on your project requirements
