-- Create database
CREATE DATABASE "online-vet-finder";

-- Use the database
\c "online-vet-finder";

-- Create User table
CREATE TABLE "User" (
    user_id SERIAL PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    user_email VARCHAR(150) UNIQUE NOT NULL,
    user_address TEXT
);

-- Create Authentication table
CREATE TABLE "Authentication" (
    account_id INT PRIMARY KEY REFERENCES "User"(user_id) ON DELETE CASCADE,
    hashed_password VARCHAR(255) NOT NULL
);

-- Create Vet table
CREATE TABLE "Vet" (
    vet_id SERIAL PRIMARY KEY,
    vet_name VARCHAR(100) NOT NULL,
    vet_location VARCHAR(255) NOT NULL,
    specialization VARCHAR(255),
    certifications TEXT
);

-- Create Pet table
CREATE TABLE "Pet" (
    pet_id SERIAL PRIMARY KEY,
    pet_name VARCHAR(100) NOT NULL,
    owner_id INT REFERENCES "User"(user_id) ON DELETE CASCADE,
    species VARCHAR(50) NOT NULL,
    breed VARCHAR(100),
    age INT,
    sex VARCHAR(10),
    vaccination_status BOOLEAN DEFAULT FALSE,
    last_vaccination_date DATE,
    health_status TEXT
);

-- Create Medical_records table
CREATE TABLE "Medical_records" (
    pet_id INT PRIMARY KEY REFERENCES "Pet"(pet_id) ON DELETE CASCADE,
    medical_history TEXT
);

-- Create Vet_records table
CREATE TABLE "Vet_records" (
    vet_id INT REFERENCES "Vet"(vet_id) ON DELETE CASCADE,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review TEXT,
    PRIMARY KEY (vet_id)
);

-- Create Services table
CREATE TABLE "Services" (
    service_id SERIAL PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    service_description TEXT,
    cost NUMERIC(10, 2)
);

-- Create Vet_services table
CREATE TABLE "Vet_services" (
    vet_id INT REFERENCES "Vet"(vet_id) ON DELETE CASCADE,
    service_id INT REFERENCES "Services"(service_id) ON DELETE CASCADE,
    price NUMERIC(10, 2) NOT NULL,
    days VARCHAR(255), -- e.g., "Monday, Wednesday, Friday"
    time TIME,
    PRIMARY KEY (vet_id, service_id)
);

-- Create Service_rating table
CREATE TABLE "Service_rating" (
    vet_id INT REFERENCES "Vet"(vet_id) ON DELETE CASCADE,
    service_id INT REFERENCES "Services"(service_id) ON DELETE CASCADE,
    service_rating INT CHECK (service_rating BETWEEN 1 AND 5),
    PRIMARY KEY (vet_id, service_id)
);

-- Create Appointment_records table
CREATE TABLE "Appointment_records" (
    pet_id INT REFERENCES "Pet"(pet_id) ON DELETE CASCADE,
    vet_id INT REFERENCES "Vet"(vet_id) ON DELETE CASCADE,
    date DATE NOT NULL,
    time TIME NOT NULL,
    cause TEXT NOT NULL,
    advise TEXT,
    next_appointment DATE,
    PRIMARY KEY (pet_id, vet_id, date, time)
);

-- Create Blogs table
CREATE TABLE "Blogs" (
    blog_id SERIAL PRIMARY KEY,
    vet_id INT REFERENCES "Vet"(vet_id) ON DELETE CASCADE,
    post TEXT NOT NULL,
    topic VARCHAR(255)
);
