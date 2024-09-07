CREATE DATABASE Employeeattendence;
use Employeeattendence;
-- Create table for Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Position VARCHAR(50),
    DateOfJoining DATE
);

-- Create table for Attendance
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    Date DATE,
    CheckIn TIME,
    CheckOut TIME,
    HoursWorked DECIMAL(5, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Create table for Leaves
CREATE TABLE Leaves (
    LeaveID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    LeaveDate DATE,
    LeaveType VARCHAR(20),  -- E.g. 'Sick Leave', 'Casual Leave', 'Paid Leave'
    LeaveStatus VARCHAR(20), -- E.g. 'Approved', 'Pending', 'Rejected'
     FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Insert sample data into Employees
INSERT INTO Employees (FirstName, LastName, Department, Position, DateOfJoining)
VALUES 
('Sujay', 'Naskar', 'HR', 'Manager', '2022-01-10'),
('Rahul', 'Das', 'IT', 'Developer', '2021-05-20'),
('Subha', 'Pal', 'Finance', 'Accountant', '2020-09-15');

-- Insert sample attendance records
INSERT INTO Attendance (EmployeeID, Date, CheckIn, CheckOut, HoursWorked)
VALUES 
(1, '2024-09-05', '09:00:00', '17:00:00', 8.00),
(2, '2024-09-05', '08:30:00', '17:30:00', 9.00),
(3, '2024-09-05', '09:15:00', '18:00:00', 8.75);

-- Insert sample leave records
INSERT INTO Leaves (EmployeeID, LeaveDate, LeaveType, LeaveStatus)
VALUES 
(1, '2024-09-01', 'Sick Leave', 'Approved'),
(2, '2024-09-02', 'Casual Leave', 'Approved'),
(3, '2024-09-03', 'Paid Leave', 'Pending');

-- Retrieve All Employee Attendance Records
SELECT e.EmployeeID, e.FirstName, e.LastName, a.Date, a.CheckIn, a.CheckOut, a.HoursWorked
FROM Attendance a
JOIN Employees e ON a.EmployeeID = e.EmployeeID
ORDER BY a.Date;

-- Retrieve Total Working Hours for Each Employee
SELECT e.EmployeeID, e.FirstName, e.LastName, SUM(a.HoursWorked) AS TotalHoursWorked
FROM Attendance a
JOIN Employees e ON a.EmployeeID = e.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName;

-- Check Leave Status for Each Employee
SELECT e.EmployeeID, e.FirstName, e.LastName, l.LeaveDate, l.LeaveType, l.LeaveStatus
FROM Leaves l
JOIN Employees e ON l.EmployeeID = e.EmployeeID
ORDER BY l.LeaveDate;

-- Update Leave Status
UPDATE Leaves
SET LeaveStatus = 'Approved'
WHERE LeaveID = 3;

-- Delete an Attendance Record
DELETE FROM Attendance
WHERE AttendanceID = 1;
