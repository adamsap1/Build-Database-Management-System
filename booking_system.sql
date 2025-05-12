Clinic Booking System - Database Design
             Entities (Tables)
1. Patients
Stores information about patients who visit the clinic.
Primary Key: patient_id
Important Fields: Full name, phone number (unique), optional email.


2. Doctors
Stores doctors' personal and professional data.
Primary Key: doctor_id
Foreign Key: department_id (links to Departments)
Important Fields: Full name, unique email.


3. Appointments
Represents scheduled meetings between patients and doctors.
Primary Key: appointment_id
Foreign Keys: doctor_id, patient_id
Important Fields: Appointment date/time, reason for visit.


4. Departments
Organizational units within the clinic, like Cardiology or Neurology.
Primary Key: department_id
Important Field: Name (must be unique)

5. Specializations
Represents medical specialties (e.g., Pediatrics, Orthopedics).
Primary Key: specialization_id
Important Field: Name (must be unique)


6. Doctor_Specializations
A junction table to model the many-to-many relationship between doctors and specializations.
Composite Primary Key: (doctor_id, specialization_id)
Foreign Keys: doctor_id, specialization_id







-- Table: Departments
-- Stores department names in the clinic (e.g., Cardiology, Pediatrics)
CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT, -- Unique ID for each department
    name VARCHAR(100) NOT NULL UNIQUE             -- Name of the department (must be unique)
);

-- Table: Specializations
-- Represents areas of medical expertise (e.g., Dermatology, Neurology)
CREATE TABLE Specializations (
    specialization_id INT PRIMARY KEY AUTO_INCREMENT, -- Unique ID for each specialization
    name VARCHAR(100) NOT NULL UNIQUE                 -- Name of the specialization (must be unique)
);

-- Table: Doctors
-- Stores doctor information and their associated department
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,        -- Unique ID for each doctor
    full_name VARCHAR(100) NOT NULL,                 -- Doctor's full name
    email VARCHAR(100) NOT NULL UNIQUE,              -- Email address (must be unique)
    department_id INT NOT NULL,                      -- FK linking to department
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) -- Enforces dept link
);

-- Table: Patients
-- Stores patient contact and personal info
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,       -- Unique ID for each patient
    full_name VARCHAR(100) NOT NULL,                 -- Patient's full name
    phone VARCHAR(15) NOT NULL UNIQUE,               -- Phone number (must be unique)
    email VARCHAR(100)                               -- Optional email address
);

-- Table: Doctor_Specializations
-- Many-to-Many relationship between Doctors and Specializations
CREATE TABLE Doctor_Specializations (
    doctor_id INT,                                   -- FK to Doctor
    specialization_id INT,                           -- FK to Specialization
    PRIMARY KEY (doctor_id, specialization_id),      -- Composite PK to avoid duplicates
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id)
);

-- Table: Appointments
-- Records appointment details between a doctor and a patient
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,   -- Unique appointment ID
    doctor_id INT NOT NULL,                          -- FK to Doctor
    patient_id INT NOT NULL,                         -- FK to Patient
    appointment_date DATETIME NOT NULL,              -- Date and time of the appointment
    reason TEXT,                                     -- Reason for the visit
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);
