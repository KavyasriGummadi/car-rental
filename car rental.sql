CREATE DATABASE car_rental_db;
USE car_rental_db;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE vehicles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_name VARCHAR(100),
    vehicle_number VARCHAR(50),
    vehicle_type VARCHAR(50),
    rental_price_per_day DOUBLE,
    image LONGBLOB,
    status VARCHAR(20)
);

CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    vehicle_id INT,
    days INT,
    total_amount DOUBLE,
    payment_pin VARCHAR(10),
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);