-- QUESTION SET 1 (ONLINE BOOKSTORE)
CREATE DATABASE OnlineBookstore;

USE OnlineBookstore;

-- CREATE TABLES
CREATE TABLE Authors (
AuthorID INT PRIMARY KEY,
Name VARCHAR(100),
Country VARCHAR(50),
DOB DATE
);

-- CATEGORIES TABLES
CREATE TABLE Categories (
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(100)
);

-- BOOKS TABLE
CREATE TABLE Books (
BookID INT PRIMARY KEY,
Title VARCHAR(100),
AuthorID INT,
CategoryID INT,
Price DECIMAL(10,2),
Stock INT,
PublishedYear INT,
FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- CUSTOMERS TABLE
CREATE TABLE Customers (
CustomerID INT PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(12),
Address VARCHAR(200)
);

-- ORDERS TABLE
CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerId INT,
OrderDate DATE,
Status VARCHAR(50),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- INSERT DATA
-- AUTHORS
INSERT INTO Authors VALUES
(1,'J.K. Rowling','UK','1965-07-31'),
(2,'Dan Brown','USA','1964-06-22'),
(3,'Chetan Bhagat','India','1974-04-22'),
(4,'George Orwell','UK','1903-06-25'),
(5,'Paulo Coelho','Brazil','1947-08-24');

-- CATEGORIES
INSERT INTO Categories VALUES
(1,'Fiction'),
(2,'Mystery'),
(3,'Romance'),
(4,'Fantasy'),
(5,'Self Help');

-- BOOKS
INSERT INTO Books VALUES
(1,'Harry Potter Guide',1,4,650,15,2001),
(2,'Da Vinci Code',2,2,550,8,2003),
(3,'2 States',3,3,350,20,2009),
(4,'1984',4,1,400,12,1949),
(5,'The Alchemist Guide',5,5,700,5,1988);

-- CUSTOMERS
INSERT INTO Customers VALUES
(1,'Rahul Sharma','rahul@gmail.com','9876543210','Mumbai'),
(2,'Anita Singh','anita@gmail.com','9876543211','Delhi'),
(3,'Rohan Patel','rohan@gmail.com','9876543212','Ahmedabad'),
(4,'Neha Gupta','neha@gmail.com','9876543213','Pune'),
(5,'Aman Verma','aman@gmail.com','9876543214','Jaipur');

-- ORDERS
INSERT INTO Orders VALUES
(1,1,'2026-03-01','Completed'),
(2,2,'2026-03-10','Pending'),
(3,3,'2026-02-25','Completed'),
(4,1,'2026-03-12','Pending'),
(5,4,'2026-03-15','Completed');

SELECT * FROM Authors;
SELECT * FROM Categories;
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- QUERIES 1 - 25
SELECT * FROM Books
WHERE Price > 500;
 
SELECT * FROM Books
WHERE PublishedYear > 2015;

SELECT * FROM Customers
WHERE Address='Mumbai';

SELECT b.Title
FROM Books b
JOIN Authors a ON b.AuthorID=a.AuthorID
WHERE a.Name='Dan Brown';

SELECT * FROM Books
ORDER BY Price DESC
LIMIT 3;

SELECT CategoryID, COUNT(*) AS TotalBooks
FROM Books
GROUP BY CategoryID;

SELECT *
FROM Orders
WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;

SELECT c.Name, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID=o.CustomerID
GROUP BY c.Name;

SELECT * FROM Books
WHERE Stock < 10;

SELECT AuthorID, COUNT(BookID) AS TotalBooks
FROM Books
GROUP BY AuthorID
HAVING COUNT(BookID) > 5;

SELECT b.Title, c.CategoryName
FROM Books b
JOIN Categories c
ON b.CategoryID=c.CategoryID;

SELECT COUNT(*) AS TotalSales
FROM Orders
WHERE OrderID=1;

SELECT *
FROM Orders
WHERE Status='Pending';

SELECT *
FROM Authors
WHERE Country='India';

SELECT *
FROM Customers
WHERE CustomerID NOT IN
(SELECT CustomerID FROM Orders);

SELECT CategoryID, AVG(Price) AS AvgPrice
FROM Books
GROUP BY CategoryID;

SELECT *
FROM Books
ORDER BY PublishedYear DESC;

SELECT CustomerID, MAX(OrderDate) AS RecentOrder
FROM Orders
GROUP BY CustomerID;

SELECT c.CategoryName
FROM Categories c
LEFT JOIN Books b
ON c.CategoryID=b.CategoryID
WHERE b.BookID IS NULL;

SELECT DISTINCT Address
FROM Customers;

SELECT COUNT(*) AS TotalCustomers
FROM Customers;

SELECT c.Name, o.OrderDate
FROM Orders o
JOIN Customers c
ON o.CustomerID=c.CustomerID;

SELECT *
FROM Books
WHERE Price =
(SELECT MIN(Price) FROM Books);

SELECT DISTINCT c.Name
FROM Customers c
JOIN Orders o ON c.CustomerID=o.CustomerID
JOIN Books b ON b.AuthorID=1;

SELECT *
FROM Books
WHERE Title LIKE '%Guide%';


-- QUESTION SET 2 (HOSPITAL MANAGEMENT SYSTEM) 
CREATE DATABASE HospitalOperations;

USE HospitalOperations;

-- CREATE TABLES
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Specialization VARCHAR(100),
    Phone VARCHAR(15),
    JoiningDate DATE
);

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100),
    DOB DATE,
    Phone VARCHAR(15)
);

CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100),
    Location VARCHAR(100)
);

CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Date DATE,
    Time TIME,
    Status VARCHAR(50),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE Bills (
    BillID INT PRIMARY KEY,
    PatientID INT,
    Amount DECIMAL(10,2),
    BillDate DATE,
    PaymentStatus VARCHAR(50),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

-- INSERT DATA

INSERT INTO Doctors VALUES
(1,'Dr. Mehta','Cardiology','9876543201','2019-06-10'),
(2,'Dr. Sharma','Neurology','9876543202','2021-03-15'),
(3,'Dr. Patel','Orthopedic','9876543203','2018-01-20'),
(4,'Dr. Khan','Cardiology','9876543204','2022-11-05'),
(5,'Dr. Rao','Dermatology','9876543205','2020-08-12');

INSERT INTO Patients VALUES
(1,'Amit','1960-05-10','9000000001'),
(2,'Anita','2000-02-15','9000000002'),
(3,'Raj','1985-07-20','9000000003'),
(4,'Neha','1995-09-25','9000000004'),
(5,'Arjun','1955-12-30','9000000005');

INSERT INTO Departments VALUES
(1,'Cardiology','Block A'),
(2,'Neurology','Block B'),
(3,'Orthopedic','Block C'),
(4,'Dermatology','Block D'),
(5,'General','Block E');


INSERT INTO Appointments VALUES
(1,1,1,CURDATE(),'10:00:00','Completed'),
(2,2,2,CURDATE(),'11:00:00','Cancelled'),
(3,3,3,'2026-03-15','09:30:00','Completed'),
(4,4,1,'2026-03-18','12:00:00','Pending'),
(5,5,4,CURDATE(),'01:00:00','Completed');

INSERT INTO Bills VALUES
(1,1,6000,'2026-03-01','Paid'),
(2,2,3000,'2026-03-10','Unpaid'),
(3,3,7000,'2026-03-12','Paid'),
(4,4,2000,'2026-03-14','Unpaid'),
(5,5,9000,'2026-03-16','Paid');

-- QUERIES

SELECT * FROM Doctors
WHERE Specialization='Cardiology';

SELECT * FROM Patients
WHERE TIMESTAMPDIFF(YEAR, DOB, CURDATE()) > 60;

SELECT * FROM Appointments
WHERE Date = CURDATE();

SELECT DeptID, COUNT(*) AS TotalPatients
FROM Appointments
GROUP BY DeptID;

SELECT p.*
FROM Patients p
JOIN Appointments a ON p.PatientID=a.PatientID
WHERE a.DoctorID=1;

SELECT * FROM Bills
WHERE Amount > 5000;

SELECT * FROM Bills
WHERE PaymentStatus='Unpaid';

SELECT DoctorID, COUNT(*) AS TotalAppointments
FROM Appointments
GROUP BY DoctorID
ORDER BY TotalAppointments DESC
LIMIT 1;

SELECT * FROM Patients
WHERE PatientID NOT IN
(SELECT PatientID FROM Appointments);

SELECT * FROM Patients
ORDER BY DOB ASC
LIMIT 1;

SELECT DeptID, AVG(Amount) AS AvgBill
FROM Bills
GROUP BY DeptID;

SELECT * FROM Doctors
WHERE JoiningDate > '2020-01-01';

SELECT * FROM Patients
WHERE Name LIKE 'A%';

SELECT * FROM Appointments
WHERE Status='Cancelled';

SELECT Date, COUNT(*) AS TotalAppointments
FROM Appointments
GROUP BY Date;

SELECT PatientID, COUNT(*) AS VisitCount
FROM Appointments
GROUP BY PatientID
HAVING COUNT(*) > 3;

SELECT d.DeptName, doc.Name
FROM Departments d
JOIN Doctors doc ON d.DeptName=doc.Specialization;

SELECT * FROM Doctors
WHERE Specialization='Neurology';

SELECT PatientID, SUM(Amount) AS TotalBill
FROM Bills
GROUP BY PatientID;

SELECT PatientID, SUM(Amount) AS TotalBill
FROM Bills
GROUP BY PatientID
ORDER BY TotalBill DESC
LIMIT 5;

SELECT d.Name AS Doctor, p.Name AS Patient
FROM Appointments a
JOIN Doctors d ON a.DoctorID=d.DoctorID
JOIN Patients p ON a.PatientID=p.PatientID;

SELECT * FROM Departments
WHERE DeptID NOT IN
(SELECT DISTINCT DoctorID FROM Doctors);

SELECT * FROM Doctors
WHERE Phone LIKE '98%';

SELECT * FROM Patients
WHERE PatientID IN
(SELECT PatientID FROM Appointments
WHERE Date >= CURDATE() - INTERVAL 7 DAY);

SELECT d.Name, SUM(b.Amount) AS TotalBilling
FROM Doctors d
JOIN Appointments a ON d.DoctorID=a.DoctorID
JOIN Bills b ON a.PatientID=b.PatientID
GROUP BY d.Name;


-- QUESTION 3 (UNIVERSITY MANAGEMNET SYSTEM)
CREATE DATABASE UniversityDB;
 
USE UniversityDB;

-- CREATE TABLES
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100)
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    DOB DATE,
    Gender VARCHAR(10),
    DeptID INT,
    Email VARCHAR(100),
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    DeptID INT,
    Credits INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

CREATE TABLE Faculty (
    FacultyID INT PRIMARY KEY,
    Name VARCHAR(100),
    DeptID INT,
    Email VARCHAR(100),
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Semester VARCHAR(20),
    Grade VARCHAR(5),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

INSERT INTO Departments VALUES
(1,'Computer Science'),
(2,'Mathematics'),
(3,'Physics'),
(4,'Commerce'),
(5,'Biology');

INSERT INTO Students VALUES
(1,'Sahil','2002-05-10','Male',1,'sahil@gmail.com'),
(2,'Amit','1999-08-20','Male',2,'amit@gmail.com'),
(3,'Sneha','2003-01-15','Female',1,'sneha@gmail.com'),
(4,'Riya','2001-09-25','Female',3,'riya@gmail.com'),
(5,'Sam','2004-12-30','Male',2,'sam@gmail.com');

INSERT INTO Courses VALUES
(1,'Data Structures',1,4),
(2,'Calculus',2,3),
(3,'Quantum Physics',3,5),
(4,'Accounting',4,3),
(5,'Genetics',5,4);

INSERT INTO Faculty VALUES
(1,'Dr. Kumar',1,'kumar@gmail.com'),
(2,'Dr. Singh',2,'singh@gmail.com'),
(3,'Dr. Roy',3,'roy@gmail.com'),
(4,'Dr. Shah',4,'shah@gmail.com'),
(5,'Dr. Das',5,'das@gmail.com');

INSERT INTO Enrollments VALUES
(1,1,1,'Sem1','A'),
(2,2,2,'Sem1','B'),
(3,3,1,'Sem1','A'),
(4,4,3,'Sem1','C'),
(5,5,2,'Sem1','F');

-- QUERIES

SELECT s.*
FROM Students s
JOIN Departments d ON s.DeptID=d.DeptID
WHERE d.DeptName='Computer Science';

SELECT * FROM Courses
WHERE Credits > 3;

SELECT * FROM Students
WHERE YEAR(DOB) > 2000;

SELECT CourseID, AVG(CASE 
    WHEN Grade='A' THEN 4
    WHEN Grade='B' THEN 3
    WHEN Grade='C' THEN 2
    WHEN Grade='F' THEN 0 END) AS AvgGrade
FROM Enrollments
GROUP BY CourseID;

SELECT f.*
FROM Faculty f
JOIN Departments d ON f.DeptID=d.DeptID
WHERE d.DeptName='Physics';

SELECT DeptID, COUNT(*) AS TotalStudents
FROM Students
GROUP BY DeptID;

SELECT c.*
FROM Courses c
JOIN Faculty f ON c.DeptID=f.DeptID
WHERE f.Name='Dr. Kumar';

SELECT * FROM Students
WHERE StudentID NOT IN
(SELECT StudentID FROM Enrollments);

SELECT StudentID, COUNT(*) AS ScoreCount
FROM Enrollments
GROUP BY StudentID
ORDER BY ScoreCount DESC
LIMIT 3;

SELECT StudentID
FROM Enrollments
GROUP BY StudentID
HAVING COUNT(CourseID) > 4;

SELECT * FROM Courses
WHERE CourseID NOT IN
(SELECT CourseID FROM Enrollments);

SELECT d.DeptName, COUNT(f.FacultyID) AS TotalFaculty
FROM Departments d
LEFT JOIN Faculty f ON d.DeptID=f.DeptID
GROUP BY d.DeptName;

SELECT StudentID, CourseID
FROM Enrollments;

SELECT * FROM Students
WHERE Name LIKE 'S%';

SELECT * FROM Students
ORDER BY DOB DESC
LIMIT 1;

SELECT s.Name, AVG(CASE 
    WHEN e.Grade='A' THEN 4
    WHEN e.Grade='B' THEN 3
    WHEN e.Grade='C' THEN 2
    WHEN e.Grade='F' THEN 0 END) AS AvgGrade
FROM Students s
JOIN Enrollments e ON s.StudentID=e.StudentID
GROUP BY s.Name;

SELECT * FROM Departments
WHERE DeptID NOT IN
(SELECT DISTINCT DeptID FROM Students);

SELECT Email FROM Faculty;

SELECT s.*
FROM Students s
JOIN Enrollments e ON s.StudentID=e.StudentID
JOIN Courses c ON e.CourseID=c.CourseID
WHERE c.CourseName='Calculus';

SELECT StudentID, SUM(c.Credits) AS TotalCredits
FROM Enrollments e
JOIN Courses c ON e.CourseID=c.CourseID
GROUP BY StudentID;

SELECT * FROM Enrollments
WHERE Grade='F';

SELECT CourseID, COUNT(StudentID) AS TotalStudents
FROM Enrollments
GROUP BY CourseID
ORDER BY TotalStudents DESC;

SELECT CourseID, Grade, COUNT(*) AS Count
FROM Enrollments
GROUP BY CourseID, Grade;

SELECT s.Name, d.DeptName
FROM Students s
JOIN Departments d ON s.DeptID=d.DeptID;

SELECT * FROM Faculty
ORDER BY FacultyID ASC
LIMIT 1;


-- QUESTION SET 4 (AIRLINE RESERVATION SYSTEM)
CREATE DATABASE AirlinesDB;

USE AirlinesDB;

-- CREATE TABLES
CREATE TABLE Airlines (
    AirlineID INT PRIMARY KEY,
    AirlineName VARCHAR(100),
    Country VARCHAR(50)
);

CREATE TABLE Flights (
    FlightID INT PRIMARY KEY,
    AirlineID INT,
    Source VARCHAR(50),
    Destination VARCHAR(50),
    DepartureTime TIME,
    ArrivalTime TIME,
    Price DECIMAL(10,2),
    FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID)
);

CREATE TABLE Passengers (
    PassengerID INT PRIMARY KEY,
    Name VARCHAR(100),
    PassportNo VARCHAR(50),
    Nationality VARCHAR(50),
    DOB DATE
);

CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    FlightID INT,
    PassengerID INT,
    BookingDate DATE,
    SeatNo VARCHAR(10),
    Status VARCHAR(50),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID),
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    BookingID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    Method VARCHAR(50),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

INSERT INTO Airlines VALUES
(1,'Air India','India'),
(2,'IndiGo','India'),
(3,'Emirates','UAE'),
(4,'Delta','USA'),
(5,'Qatar Airways','Qatar');

INSERT INTO Flights VALUES
(1,1,'Delhi','Mumbai','18:30:00','20:30:00',6000),
(2,2,'Delhi','Bangalore','19:00:00','21:30:00',5500),
(3,3,'Dubai','Delhi','09:00:00','13:00:00',12000),
(4,4,'New York','Chicago','08:00:00','10:00:00',15000),
(5,5,'Doha','Mumbai','06:00:00','11:00:00',14000);

INSERT INTO Passengers VALUES
(1,'Amit','M12345','India','2001-05-10'),
(2,'Sara','X56789','USA','1995-08-20'),
(3,'Raj','M98765','India','2003-02-15'),
(4,'John','A34567','UK','1998-11-30'),
(5,'Anita','M45678','India','2002-07-25');

INSERT INTO Bookings VALUES
(1,1,1,CURDATE(),'A1','Confirmed'),
(2,2,2,CURDATE(),'B2','Pending'),
(3,1,3,'2026-03-10','A2','Confirmed'),
(4,3,4,'2026-03-15','C1','Cancelled'),
(5,5,5,CURDATE(),'D4','Confirmed');

INSERT INTO Payments VALUES
(1,1,6000,'2026-03-01','Card'),
(2,2,5500,'2026-03-05','UPI'),
(3,3,6000,'2026-03-10','Cash'),
(4,4,12000,'2026-03-15','Card'),
(5,5,14000,'2026-03-16','UPI');

-- QUERIES
SELECT * FROM Flights
WHERE Source='Delhi' AND Destination='Mumbai';

SELECT * FROM Flights
WHERE DepartureTime > '18:00:00';

SELECT * FROM Passengers
WHERE Nationality='India';

SELECT * FROM Bookings
WHERE Status='Confirmed';

SELECT b.*
FROM Bookings b
JOIN Passengers p ON b.PassengerID=p.PassengerID
WHERE p.Name='Amit';

SELECT AirlineID, COUNT(*) AS TotalFlights
FROM Flights
GROUP BY AirlineID;

SELECT PassengerID, COUNT(*) AS TotalBookings
FROM Bookings
GROUP BY PassengerID
HAVING COUNT(*) > 3;

SELECT * FROM Flights
ORDER BY Price DESC
LIMIT 1;

SELECT * FROM Airlines
WHERE Country='USA';

SELECT * FROM Bookings
WHERE BookingDate >= CURDATE() - INTERVAL 7 DAY;

SELECT AirlineID, AVG(Price) AS AvgPrice
FROM Flights
GROUP BY AirlineID;

SELECT * FROM Passengers
WHERE PassengerID NOT IN
(SELECT PassengerID FROM Bookings);

SELECT * FROM Flights
WHERE FlightID NOT IN
(SELECT FlightID FROM Bookings);

SELECT * FROM Passengers
WHERE PassportNo LIKE 'M%';

SELECT b.BookingID, p.Name, f.Source, f.Destination
FROM Bookings b
JOIN Passengers p ON b.PassengerID=p.PassengerID
JOIN Flights f ON b.FlightID=f.FlightID;

SELECT * FROM Payments
ORDER BY Amount DESC
LIMIT 5;

SELECT FlightID, COUNT(PassengerID) AS TotalPassengers
FROM Bookings
GROUP BY FlightID;

SELECT * FROM Flights
WHERE ArrivalTime < '10:00:00';

SELECT f.*, a.AirlineName
FROM Flights f
JOIN Airlines a ON f.AirlineID=a.AirlineID;

SELECT PassengerID, BookingDate, COUNT(*) AS TotalBookings
FROM Bookings
GROUP BY PassengerID, BookingDate
HAVING COUNT(*) > 1;

SELECT Method, SUM(Amount) AS TotalAmount
FROM Payments
GROUP BY Method;

SELECT DISTINCT p.*
FROM Passengers p
JOIN Bookings b ON p.PassengerID=b.PassengerID
WHERE b.BookingDate >= CURDATE() - INTERVAL 1 MONTH;

SELECT * FROM Flights
WHERE Price BETWEEN 5000 AND 10000;

SELECT * FROM Passengers
WHERE YEAR(DOB) > 2000;

SELECT * FROM Airlines
WHERE AirlineID NOT IN
(SELECT DISTINCT AirlineID FROM Flights);


-- QUESTION SET 5 (HOTEL MANAGEMENT SYSTEM)
CREATE DATABASE HotelDB;

USE HotelDB;

-- CREATE TABLES
CREATE TABLE Hotels (
    HotelID INT PRIMARY KEY,
    HotelName VARCHAR(100),
    Location VARCHAR(100),
    Rating DECIMAL(2,1)
);

CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY,
    HotelID INT,
    RoomType VARCHAR(50),
    PricePerNight DECIMAL(10,2),
    Availability VARCHAR(20),
    FOREIGN KEY (HotelID) REFERENCES Hotels(HotelID)
);

CREATE TABLE Guests (
    GuestID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Address VARCHAR(200)
);

CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY,
    RoomID INT,
    GuestID INT,
    CheckInDate DATE,
    CheckOutDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
    FOREIGN KEY (GuestID) REFERENCES Guests(GuestID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    ReservationID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    Method VARCHAR(50),
    FOREIGN KEY (ReservationID) REFERENCES Reservations(ReservationID)
);

INSERT INTO Hotels VALUES
(1,'Taj Hotel','Mumbai',4.8),
(2,'Oberoi','Delhi',4.5),
(3,'ITC Grand','Mumbai',4.6),
(4,'Leela Palace','Bangalore',4.7),
(5,'Hyatt','Delhi',4.2);

INSERT INTO Rooms VALUES
(1,1,'Suite',8000,'Available'),
(2,1,'Deluxe',4000,'Booked'),
(3,2,'Suite',7500,'Available'),
(4,3,'Standard',3000,'Available'),
(5,4,'Suite',9000,'Booked');

INSERT INTO Guests VALUES
(1,'Amit','9000000001','amit@gmail.com','Mumbai'),
(2,'Sara','9000000002','sara@gmail.com','Delhi'),
(3,'Raj','9000000003','raj@gmail.com','Pune'),
(4,'Neha','9000000004','neha@gmail.com','Mumbai'),
(5,'John','9000000005','john@gmail.com','Bangalore');

INSERT INTO Reservations VALUES
(1,1,1,'2026-03-01','2026-03-06','Checked-In'),
(2,2,2,'2026-03-10','2026-03-12','Booked'),
(3,3,3,'2026-02-15','2026-02-20','Checked-Out'),
(4,4,4,'2026-03-18','2026-03-22','Checked-In'),
(5,5,5,'2026-03-05','2026-03-07','Cancelled');

INSERT INTO Payments VALUES
(1,1,40000,'2026-03-01','Card'),
(2,2,8000,'2026-03-10','UPI'),
(3,3,30000,'2026-02-15','Cash'),
(4,4,16000,'2026-03-18','Card'),
(5,5,18000,'2026-03-05','UPI');

SELECT * FROM Hotels
WHERE Location='Mumbai';

SELECT * FROM Rooms
WHERE PricePerNight > 3000;

SELECT * FROM Rooms
WHERE Availability='Available' AND HotelID=1;

SELECT g.*
FROM Guests g
JOIN Reservations r ON g.GuestID=r.GuestID
JOIN Rooms ro ON r.RoomID=ro.RoomID
WHERE ro.HotelID=1;

SELECT * FROM Reservations
WHERE Status='Checked-In';

SELECT HotelID, RoomType, COUNT(*) AS TotalRooms
FROM Rooms
GROUP BY HotelID, RoomType;

SELECT g.*
FROM Guests g
JOIN Reservations r ON g.GuestID=r.GuestID
WHERE DATEDIFF(r.CheckOutDate, r.CheckInDate) > 5;

SELECT RoomType, PricePerNight
FROM Rooms
ORDER BY PricePerNight DESC
LIMIT 3;

SELECT * FROM Reservations
WHERE CheckInDate >= CURDATE() - INTERVAL 1 MONTH;

SELECT GuestID, COUNT(*) AS TotalReservations
FROM Reservations
GROUP BY GuestID
HAVING COUNT(*) > 2;

SELECT h.HotelName, AVG(r.PricePerNight) AS AvgPrice
FROM Hotels h
JOIN Rooms r ON h.HotelID=r.HotelID
GROUP BY h.HotelName
HAVING AVG(r.PricePerNight) > 4000;

SELECT * FROM Guests
WHERE Address='Mumbai';

SELECT * FROM Hotels
WHERE HotelID NOT IN
(SELECT DISTINCT ro.HotelID
 FROM Rooms ro
 JOIN Reservations r ON ro.RoomID=r.RoomID);

SELECT r.ReservationID, g.Name, h.HotelName, ro.RoomType
FROM Reservations r
JOIN Guests g ON r.GuestID=g.GuestID
JOIN Rooms ro ON r.RoomID=ro.RoomID
JOIN Hotels h ON ro.HotelID=h.HotelID;

SELECT h.HotelName, SUM(p.Amount) AS TotalRevenue
FROM Hotels h
JOIN Rooms r ON h.HotelID=r.HotelID
JOIN Reservations res ON r.RoomID=res.RoomID
JOIN Payments p ON res.ReservationID=p.ReservationID
GROUP BY h.HotelName;

SELECT * FROM Reservations
WHERE CheckOutDate < CheckInDate;

SELECT Method, COUNT(*) AS Total
FROM Payments
GROUP BY Method;

SELECT * FROM Guests
WHERE GuestID NOT IN
(SELECT DISTINCT r.GuestID
 FROM Reservations r
 JOIN Payments p ON r.ReservationID=p.ReservationID);

SELECT * FROM Reservations
ORDER BY CheckInDate;

SELECT * FROM Hotels
WHERE Rating > 4;

SELECT g.*
FROM Guests g
JOIN Reservations r ON g.GuestID=r.GuestID
JOIN Rooms ro ON r.RoomID=ro.RoomID
WHERE ro.RoomType='Suite';

SELECT r.*
FROM Rooms r
JOIN Hotels h ON r.HotelID=h.HotelID
WHERE r.Availability='Available' AND h.Location='Delhi';

SELECT g.GuestID, SUM(DATEDIFF(r.CheckOutDate, r.CheckInDate)) AS TotalNights
FROM Guests g
JOIN Reservations r ON g.GuestID=r.GuestID
GROUP BY g.GuestID;

SELECT r1.*
FROM Reservations r1
JOIN Reservations r2
ON r1.RoomID=r2.RoomID
AND r1.ReservationID <> r2.ReservationID
AND r1.CheckInDate < r2.CheckOutDate
AND r1.CheckOutDate > r2.CheckInDate;

SELECT DISTINCT Location
FROM Hotels;


-- QUESTION SET 6 (LIBRARY MANAGEMENT SYSTEM)
CREATE DATABASE LibraryDB;

USE LibraryDB;

-- CREATE TABLES
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Nationality VARCHAR(50)
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(200)
);

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    IssueDate DATE,
    ReturnDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

CREATE TABLE Fines (
    FineID INT PRIMARY KEY,
    LoanID INT,
    Amount DECIMAL(10,2),
    PaymentStatus VARCHAR(50),
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
);

INSERT INTO Authors VALUES
(1,'Isaac Asimov','USA'),
(2,'Chetan Bhagat','India'),
(3,'J.K. Rowling','UK'),
(4,'George Orwell','UK'),
(5,'Paulo Coelho','Brazil');

INSERT INTO Books VALUES
(1,'Foundation',1,'Science Fiction',500,10),
(2,'2 States',2,'Romance',300,4),
(3,'Harry Potter',3,'Fantasy',600,8),
(4,'1984',4,'Dystopian',400,3),
(5,'The Alchemist',5,'Fiction',450,7);

INSERT INTO Members VALUES
(1,'Amit','amit@gmail.com','9123456789','Mumbai'),
(2,'Sara','sara@gmail.com','9876543210','Delhi'),
(3,'Raj','raj@gmail.com','9988776655','Pune'),
(4,'Neha','neha@gmail.com','9765432109','Mumbai'),
(5,'John','john@gmail.com','9234567890','Bangalore');

INSERT INTO Loans VALUES
(1,1,1,'2026-03-01','2026-03-10','Returned'),
(2,2,2,'2026-03-05',NULL,'Issued'),
(3,3,3,'2026-02-10','2026-02-20','Returned'),
(4,4,4,'2026-03-12',NULL,'Issued'),
(5,1,5,'2026-03-15',NULL,'Issued');

INSERT INTO Fines VALUES
(1,1,100,'Paid'),
(2,2,200,'Unpaid'),
(3,3,150,'Paid'),
(4,4,250,'Unpaid'),
(5,5,300,'Paid');

-- QUERIES
SELECT * FROM Books
WHERE Category='Science Fiction';

SELECT * FROM Books
WHERE Stock < 5;

SELECT m.*
FROM Members m
JOIN Loans l ON m.MemberID=l.MemberID
WHERE l.ReturnDate IS NULL;

SELECT * FROM Books
ORDER BY Price DESC
LIMIT 3;

SELECT * FROM Authors
WHERE Nationality='India';

SELECT b.*
FROM Books b
JOIN Authors a ON b.AuthorID=a.AuthorID
WHERE a.Name='Isaac Asimov';

SELECT Category, COUNT(*) AS TotalBooks
FROM Books
GROUP BY Category;

SELECT MemberID, COUNT(*) AS TotalBooks
FROM Loans
GROUP BY MemberID
HAVING COUNT(*) > 3;

SELECT * FROM Loans
WHERE Status='Returned';

SELECT * FROM Members
WHERE MemberID NOT IN
(SELECT MemberID FROM Loans);

SELECT * FROM Fines
WHERE PaymentStatus='Unpaid';

SELECT l.MemberID, SUM(f.Amount) AS TotalFine
FROM Loans l
JOIN Fines f ON l.LoanID=f.LoanID
GROUP BY l.MemberID;

SELECT * FROM Loans
WHERE IssueDate >= CURDATE() - INTERVAL 1 MONTH;

SELECT DISTINCT m.*
FROM Members m
JOIN Loans l ON m.MemberID=l.MemberID
JOIN Books b ON l.BookID=b.BookID
WHERE b.Category='Science Fiction';

SELECT AuthorID, COUNT(*) AS TotalBooks
FROM Books
GROUP BY AuthorID
HAVING COUNT(*) > 3;

SELECT * FROM Books
WHERE Price BETWEEN 200 AND 500;

SELECT AVG(Amount) AS AvgFine
FROM Fines;

SELECT * FROM Members
WHERE Phone LIKE '9%';

SELECT l.LoanID, b.Title, m.Name
FROM Loans l
JOIN Books b ON l.BookID=b.BookID
JOIN Members m ON l.MemberID=m.MemberID;

SELECT * FROM Books
WHERE Title LIKE '%History%';

SELECT MemberID, COUNT(*) AS UnpaidFines
FROM Loans l
JOIN Fines f ON l.LoanID=f.LoanID
WHERE f.PaymentStatus='Unpaid'
GROUP BY MemberID
HAVING COUNT(*) > 1;

SELECT * FROM Books
WHERE BookID NOT IN
(SELECT BookID FROM Loans);

SELECT BookID, COUNT(*) AS BorrowCount
FROM Loans
GROUP BY BookID
ORDER BY BorrowCount DESC
LIMIT 1;

SELECT MemberID, COUNT(*) AS TotalBorrowings
FROM Loans
GROUP BY MemberID
ORDER BY TotalBorrowings DESC
LIMIT 5;

SELECT DISTINCT Category
FROM Books;

-- QUESTION SET 7 (INVENTORY MANAGEMNET SYSTEM)
CREATE DATABASE InventoryDB;

USE InventoryDB;

-- CREATE TABLES
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100),
    Contact VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    CategoryID INT,
    SupplierID INT,
    Price DECIMAL(10,2),
    Stock INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

CREATE TABLE Purchases (
    PurchaseID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    PurchaseDate DATE,
    SupplierID INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    CustomerName VARCHAR(100),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Suppliers VALUES
(1,'ABC Traders','9876543210','Delhi'),
(2,'XYZ Supplies','9876543211','Mumbai'),
(3,'Global Corp','9876543212','Delhi'),
(4,'Prime Goods','9876543213','Pune'),
(5,'Super Distributors','9876543214','Chennai');

INSERT INTO Categories VALUES
(1,'Electronics'),
(2,'Clothing'),
(3,'Groceries'),
(4,'Furniture'),
(5,'Stationery');

INSERT INTO Products VALUES
(1,'Laptop',1,1,60000,8),
(2,'Shirt',2,2,1500,20),
(3,'Rice',3,3,800,50),
(4,'Table',4,4,5000,5),
(5,'Notebook',5,5,100,30);

INSERT INTO Purchases VALUES
(1,1,10,'2026-03-01',1),
(2,2,20,'2026-03-05',2),
(3,3,50,'2026-03-10',3),
(4,4,5,'2026-03-15',4),
(5,5,30,'2026-03-18',5);

INSERT INTO Sales VALUES
(1,1,2,'2026-03-10','Amit'),
(2,2,5,'2026-03-12','Sara'),
(3,3,10,'2026-03-14','Raj'),
(4,1,1,'2026-03-15','Neha'),
(5,5,8,'2026-03-18','John');

SELECT * FROM Products
WHERE Stock < 10;

SELECT * FROM Products
ORDER BY Price DESC
LIMIT 5;

SELECT * FROM Suppliers
WHERE City='Delhi';

SELECT p.*
FROM Products p
JOIN Suppliers s ON p.SupplierID=s.SupplierID
WHERE s.SupplierName='ABC Traders';

SELECT CategoryID, COUNT(*) AS TotalProducts
FROM Products
GROUP BY CategoryID;

SELECT SUM(Quantity) AS TotalPurchased
FROM Purchases
WHERE ProductID=1;

SELECT * FROM Products
WHERE ProductID NOT IN
(SELECT ProductID FROM Sales);

SELECT * FROM Sales
WHERE SaleDate >= CURDATE() - INTERVAL 7 DAY;

SELECT p.*
FROM Products p
JOIN Sales s ON p.ProductID=s.ProductID
GROUP BY p.ProductID
HAVING SUM(s.Quantity) > 50;

SELECT SupplierID, COUNT(*) AS TotalProducts
FROM Products
GROUP BY SupplierID
HAVING COUNT(*) > 5;

SELECT CategoryID, AVG(Price) AS AvgPrice
FROM Products
GROUP BY CategoryID;

SELECT ProductID, SUM(Quantity) AS TotalSold
FROM Sales
GROUP BY ProductID
ORDER BY TotalSold DESC
LIMIT 1;

SELECT * FROM Categories
WHERE CategoryID NOT IN
(SELECT DISTINCT CategoryID FROM Products);

SELECT s.SaleID, p.ProductName
FROM Sales s
JOIN Products p ON s.ProductID=p.ProductID;

SELECT p.PurchaseID, s.SupplierName
FROM Purchases p
JOIN Suppliers s ON p.SupplierID=s.SupplierID;

SELECT * FROM Suppliers
WHERE SupplierID NOT IN
(SELECT SupplierID FROM Purchases);

SELECT ProductID, MAX(PurchaseDate) AS RecentPurchase
FROM Purchases
GROUP BY ProductID;

SELECT CustomerName, COUNT(*) AS TotalProducts
FROM Sales
GROUP BY CustomerName
HAVING COUNT(*) > 3;

SELECT SUM(Price * Stock) AS TotalStockValue
FROM Products;

SELECT * FROM Products
ORDER BY Stock DESC
LIMIT 1;

SELECT CustomerName, SUM(Quantity) AS TotalSales
FROM Sales
GROUP BY CustomerName;

SELECT CustomerName, SUM(Quantity) AS TotalSales
FROM Sales
GROUP BY CustomerName
ORDER BY TotalSales DESC
LIMIT 3;

SELECT DATE_FORMAT(SaleDate,'%Y-%m') AS Month, SUM(Quantity) AS TotalSales
FROM Sales
GROUP BY Month;

SELECT * FROM Products
WHERE ProductID IN (SELECT ProductID FROM Purchases)
AND ProductID NOT IN (SELECT ProductID FROM Sales);

SELECT SupplierID, COUNT(DISTINCT CategoryID) AS CategoryCount
FROM Products
GROUP BY SupplierID
HAVING COUNT(DISTINCT CategoryID) > 1;

-- QUESTION SET 8 (ONLINE FOOD DELIVERY SYSTEM)
CREATE DATABASE OnlineFoodDB;

USE OnlineFoodDB;

-- CREATE TABLES
CREATE TABLE Restaurants (
    RestaurantID INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(50),
    Rating DECIMAL(2,1)
);

CREATE TABLE MenuItems (
    MenuItemID INT PRIMARY KEY,
    RestaurantID INT,
    ItemName VARCHAR(100),
    Price DECIMAL(10,2),
    Category VARCHAR(50),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(100)
);

CREATE TABLE DeliveryAgents (
    AgentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    VehicleNo VARCHAR(20)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    RestaurantID INT,
    OrderDate DATE,
    Status VARCHAR(50),
    AgentID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID),
    FOREIGN KEY (AgentID) REFERENCES DeliveryAgents(AgentID)
);

INSERT INTO Restaurants VALUES
(1,'Dominos','Bangalore',4.5),
(2,'KFC','Mumbai',4.2),
(3,'Pizza Hut','Bangalore',4.6),
(4,'Burger King','Delhi',4.1),
(5,'Subway','Chennai',4.0);

INSERT INTO MenuItems VALUES
(1,1,'Veg Pizza',400,'Pizza'),
(2,2,'Chicken Bucket',500,'Fast Food'),
(3,3,'Cheese Pizza',450,'Pizza'),
(4,4,'Burger',250,'Fast Food'),
(5,5,'Chocolate Cake',300,'Dessert');

INSERT INTO Customers VALUES
(1,'Amit','9000000001','Mumbai'),
(2,'Sara','9000000002','Delhi'),
(3,'Raj','9000000003','Bangalore'),
(4,'Neha','9000000004','Pune'),
(5,'John','9000000005','Chennai');

INSERT INTO DeliveryAgents VALUES
(1,'Ravi','8000000001','MH01'),
(2,'Karan','8000000002','DL02'),
(3,'Aman','8000000003','KA03'),
(4,'Vijay','8000000004','TN04'),
(5,'Rahul','8000000005','GJ05');

INSERT INTO Orders VALUES
(1,1,1,CURDATE(),'Delivered',1),
(2,2,2,CURDATE(),'Cancelled',2),
(3,3,3,'2026-03-10','Delivered',3),
(4,1,3,'2026-03-12','Delivered',1),
(5,4,4,CURDATE(),'Pending',4);

-- QUERIES
SELECT * FROM Restaurants
WHERE City='Bangalore';

SELECT * FROM MenuItems
WHERE Price > 300;

SELECT * FROM Orders
WHERE OrderDate >= CURDATE() - INTERVAL 7 DAY;

SELECT * FROM Restaurants
ORDER BY Rating DESC
LIMIT 5;

SELECT * FROM Customers
WHERE Address='Mumbai';

SELECT * FROM Orders
WHERE Status='Delivered';

SELECT RestaurantID, COUNT(*) AS TotalItems
FROM MenuItems
GROUP BY RestaurantID;

SELECT CustomerID, COUNT(DISTINCT RestaurantID) AS TotalRestaurants
FROM Orders
GROUP BY CustomerID
HAVING COUNT(DISTINCT RestaurantID) > 3;

SELECT RestaurantID, MAX(Price) AS MaxPrice
FROM MenuItems
GROUP BY RestaurantID;

SELECT AgentID, COUNT(*) AS TotalOrders
FROM Orders
GROUP BY AgentID
HAVING COUNT(*) > 10;

SELECT * FROM Restaurants
WHERE RestaurantID NOT IN
(SELECT DISTINCT RestaurantID FROM Orders);

SELECT Category, AVG(Price) AS AvgPrice
FROM MenuItems
GROUP BY Category;

SELECT o.OrderID, c.Name, r.Name
FROM Orders o
JOIN Customers c ON o.CustomerID=c.CustomerID
JOIN Restaurants r ON o.RestaurantID=r.RestaurantID;

SELECT CustomerID, RestaurantID, COUNT(*) AS TotalOrders
FROM Orders
GROUP BY CustomerID, RestaurantID
HAVING COUNT(*) > 1;

SELECT AgentID, COUNT(*) AS TotalOrders
FROM Orders
GROUP BY AgentID
ORDER BY TotalOrders DESC
LIMIT 1;

SELECT * FROM Orders
WHERE Status='Cancelled';

SELECT DISTINCT r.*
FROM Restaurants r
JOIN MenuItems m ON r.RestaurantID=m.RestaurantID
WHERE m.ItemName LIKE '%Pizza%';

SELECT ItemName, COUNT(*) AS OrderCount
FROM MenuItems m
JOIN Orders o ON m.RestaurantID=o.RestaurantID
GROUP BY ItemName
ORDER BY OrderCount DESC
LIMIT 1;

SELECT CustomerID, COUNT(*) AS TotalOrders
FROM Orders
GROUP BY CustomerID
ORDER BY TotalOrders DESC
LIMIT 3;

SELECT * FROM Orders
ORDER BY OrderDate;

SELECT * FROM Customers
WHERE CustomerID NOT IN
(SELECT CustomerID FROM Orders);

SELECT * FROM MenuItems
WHERE Category='Dessert';

SELECT * FROM Orders
WHERE AgentID=1;

SELECT OrderDate, COUNT(*) AS TotalOrders
FROM Orders
GROUP BY OrderDate;

SELECT RestaurantID
FROM MenuItems
GROUP BY RestaurantID
HAVING COUNT(DISTINCT Category) > 1;

SELECT * FROM MenuItems;


-- QUESTION SET 9 (CINEMA TICKET BOOKING SYSTEM)
CREATE DATABASE MovieTicketBookingDB;

USE MovieTicketBookingDB;

-- CREATE TABLES
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(100),
    Genre VARCHAR(50),
    Language VARCHAR(50),
    Duration INT,
    ReleaseDate DATE
);

CREATE TABLE Screens (
    ScreenID INT PRIMARY KEY,
    ScreenName VARCHAR(50),
    Capacity INT
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15)
);

CREATE TABLE Showtimes (
    ShowID INT PRIMARY KEY,
    MovieID INT,
    ScreenID INT,
    ShowDate DATE,
    ShowTime TIME,
    Price DECIMAL(10,2),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (ScreenID) REFERENCES Screens(ScreenID)
);

CREATE TABLE Tickets (
    TicketID INT PRIMARY KEY,
    ShowID INT,
    CustomerID INT,
    SeatNo VARCHAR(10),
    BookingDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (ShowID) REFERENCES Showtimes(ShowID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Movies VALUES
(1,'Avengers','Action','English',180,'2019-04-26'),
(2,'Dangal','Drama','Hindi',160,'2016-12-23'),
(3,'Inception','Sci-Fi','English',150,'2010-07-16'),
(4,'Pathaan','Action','Hindi',145,'2023-01-25'),
(5,'Interstellar','Sci-Fi','English',170,'2014-11-07');

INSERT INTO Screens VALUES
(1,'Screen 1',100),
(2,'Screen 2',120),
(3,'Screen 3',80),
(4,'Screen 4',150),
(5,'Screen 5',90);

INSERT INTO Customers VALUES
(1,'Amit','amit@gmail.com','9000000001'),
(2,'Sara','sara@gmail.com','9000000002'),
(3,'Raj','raj@gmail.com','9000000003'),
(4,'Neha','neha@gmail.com','9000000004'),
(5,'John','john@gmail.com','9000000005');

INSERT INTO Showtimes VALUES
(1,1,1,CURDATE(),'10:00:00',300),
(2,2,2,CURDATE(),'13:00:00',250),
(3,3,3,'2026-03-10','16:00:00',350),
(4,4,4,'2026-03-12','19:00:00',400),
(5,5,5,CURDATE(),'21:00:00',450);

INSERT INTO Tickets VALUES
(1,1,1,'A1',CURDATE(),'Booked'),
(2,2,2,'B1',CURDATE(),'Cancelled'),
(3,1,3,'A2','2026-03-10','Booked'),
(4,3,4,'C1','2026-03-12','Booked'),
(5,5,5,'D1',CURDATE(),'Booked');

SELECT * FROM Movies
WHERE Genre='Action';

SELECT * FROM Movies
WHERE ReleaseDate > '2020-01-01';

SELECT * FROM Showtimes
WHERE ShowDate = CURDATE();

SELECT * FROM Showtimes
ORDER BY Price DESC
LIMIT 3;

SELECT ShowID, COUNT(*) AS TicketsSold
FROM Tickets
GROUP BY ShowID;

SELECT CustomerID, COUNT(*) AS TotalTickets
FROM Tickets
GROUP BY CustomerID
HAVING COUNT(*) > 5;

SELECT s.ShowID, sc.Capacity - COUNT(t.TicketID) AS AvailableSeats
FROM Showtimes s
JOIN Screens sc ON s.ScreenID=sc.ScreenID
LEFT JOIN Tickets t ON s.ShowID=t.ShowID
GROUP BY s.ShowID;

SELECT c.*
FROM Customers c
JOIN Tickets t ON c.CustomerID=t.CustomerID
JOIN Showtimes s ON t.ShowID=s.ShowID
WHERE s.MovieID=1;

SELECT * FROM Movies
WHERE MovieID NOT IN
(SELECT DISTINCT MovieID FROM Showtimes);

SELECT t.TicketID, c.Name, m.Title
FROM Tickets t
JOIN Customers c ON t.CustomerID=c.CustomerID
JOIN Showtimes s ON t.ShowID=s.ShowID
JOIN Movies m ON s.MovieID=m.MovieID;

SELECT * FROM Customers
WHERE CustomerID NOT IN
(SELECT CustomerID FROM Tickets);

SELECT ShowDate, COUNT(*) AS TotalTickets
FROM Tickets t
JOIN Showtimes s ON t.ShowID=s.ShowID
GROUP BY ShowDate;

SELECT * FROM Movies
WHERE Duration > 120;

SELECT m.Title, COUNT(t.TicketID) AS TotalTickets
FROM Movies m
JOIN Showtimes s ON m.MovieID=s.MovieID
JOIN Tickets t ON s.ShowID=t.ShowID
GROUP BY m.Title
ORDER BY TotalTickets DESC
LIMIT 1;

SELECT CustomerID, COUNT(*) AS TotalTickets
FROM Tickets
GROUP BY CustomerID
ORDER BY TotalTickets DESC
LIMIT 5;

SELECT * FROM Tickets
WHERE Status='Cancelled';

SELECT * FROM Showtimes
WHERE ScreenID=1;

SELECT Genre, AVG(Price) AS AvgPrice
FROM Movies m
JOIN Showtimes s ON m.MovieID=s.MovieID
GROUP BY Genre;

SELECT * FROM Movies
WHERE Language='Hindi';

SELECT * FROM Showtimes
WHERE ShowDate BETWEEN CURDATE() AND CURDATE() + INTERVAL 7 DAY;

SELECT CustomerID, COUNT(DISTINCT MovieID) AS MoviesCount
FROM Tickets t
JOIN Showtimes s ON t.ShowID=s.ShowID
GROUP BY CustomerID
HAVING COUNT(DISTINCT MovieID) > 1;

SELECT MovieID, MIN(ShowTime) AS EarliestShow
FROM Showtimes
GROUP BY MovieID;

SELECT MovieID
FROM Showtimes
GROUP BY MovieID
HAVING COUNT(DISTINCT ScreenID) > 1;

SELECT COUNT(*) AS TotalTickets
FROM Tickets
WHERE BookingDate = CURDATE();

SELECT m.Title, COUNT(t.TicketID) AS TotalTickets
FROM Movies m
JOIN Showtimes s ON m.MovieID=s.MovieID
JOIN Tickets t ON s.ShowID=t.ShowID
GROUP BY m.Title
HAVING COUNT(t.TicketID) > 10;


-- QUESTION SET 10 (E-LEARNING PLATFORM)
CREATE DATABASE ELearningDB;

USE ELearningDB;

-- CREATE TABLES
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    Title VARCHAR(100),
    Category VARCHAR(50),
    DurationWeeks INT,
    Price DECIMAL(10,2),
    InstructorID INT
);

CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Specialty VARCHAR(50)
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    City VARCHAR(50)
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

CREATE TABLE Assignments (
    AssignmentID INT PRIMARY KEY,
    CourseID INT,
    Title VARCHAR(100),
    DueDate DATE,
    MaxMarks INT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

INSERT INTO Instructors VALUES
(1,'Rahul','rahul@gmail.com','Python'),
(2,'Anita','anita@gmail.com','Data Science'),
(3,'Karan','karan@gmail.com','AI'),
(4,'Meena','meena@gmail.com','Web Development'),
(5,'Arjun','arjun@gmail.com','Java');

INSERT INTO Courses VALUES
(1,'Python Basics','Data Science',10,6000,1),
(2,'Machine Learning','AI',12,8000,3),
(3,'Web Dev','Development',8,4000,4),
(4,'Data Analysis','Data Science',9,5000,2),
(5,'Java Core','Programming',7,3000,5);

INSERT INTO Students VALUES
(1,'Amit','amit@gmail.com','Mumbai'),
(2,'Sara','sara@gmail.com','Delhi'),
(3,'Raj','raj@gmail.com','Mumbai'),
(4,'Neha','neha@gmail.com','Pune'),
(5,'John','john@gmail.com','Chennai');

INSERT INTO Enrollments VALUES
(1,1,1,CURDATE()),
(2,2,2,CURDATE()),
(3,3,1,'2026-03-10'),
(4,4,3,'2026-03-12'),
(5,5,4,CURDATE());

INSERT INTO Assignments VALUES
(1,1,'Assignment 1','2026-03-25',100),
(2,2,'Assignment 2','2026-03-28',100),
(3,3,'Assignment 3','2026-03-30',100),
(4,4,'Assignment 4','2026-04-02',100),
(5,5,'Assignment 5','2026-04-05',100);

-- QUERIES
SELECT * FROM Courses
WHERE Category='Data Science';

SELECT * FROM Instructors
WHERE Specialty='Python';

SELECT * FROM Students
WHERE City='Mumbai';

SELECT * FROM Enrollments
WHERE EnrollDate >= CURDATE() - INTERVAL 1 MONTH;

SELECT * FROM Courses
WHERE DurationWeeks > 8;

SELECT * FROM Courses
ORDER BY Price DESC
LIMIT 3;

SELECT s.*
FROM Students s
JOIN Enrollments e ON s.StudentID=e.StudentID
WHERE e.CourseID=1;

SELECT InstructorID, COUNT(*) AS TotalCourses
FROM Courses
GROUP BY InstructorID
HAVING COUNT(*) > 1;

SELECT * FROM Assignments
WHERE DueDate BETWEEN CURDATE() AND CURDATE() + INTERVAL 7 DAY;

SELECT s.*
FROM Students s
WHERE s.StudentID IN
(SELECT e.StudentID FROM Enrollments e
GROUP BY e.StudentID);

SELECT CourseID, AVG(MaxMarks) AS AvgMarks
FROM Assignments
GROUP BY CourseID;

SELECT * FROM Students
WHERE StudentID NOT IN
(SELECT StudentID FROM Enrollments);

SELECT CourseID, COUNT(*) AS TotalEnrollments
FROM Enrollments
GROUP BY CourseID;

SELECT * FROM Instructors
WHERE InstructorID NOT IN
(SELECT DISTINCT InstructorID FROM Courses);

SELECT StudentID, COUNT(*) AS TotalEnrollments
FROM Enrollments
GROUP BY StudentID
HAVING COUNT(*) > 3;

SELECT * FROM Courses
WHERE CourseID NOT IN
(SELECT DISTINCT CourseID FROM Enrollments);

SELECT CourseID, COUNT(*) AS TotalStudents
FROM Enrollments
GROUP BY CourseID
ORDER BY TotalStudents DESC
LIMIT 1;

SELECT CourseID, COUNT(*) AS TotalAssignments
FROM Assignments
GROUP BY CourseID;

SELECT * FROM Students;

SELECT c.Title, i.Name
FROM Courses c
JOIN Instructors i ON c.InstructorID=i.InstructorID;

SELECT * FROM Courses
WHERE Price < 5000;

SELECT * FROM Courses
WHERE Title LIKE '%AI%';

SELECT StudentID, COUNT(DISTINCT CourseID) AS CourseCount
FROM Enrollments
GROUP BY StudentID
HAVING COUNT(DISTINCT CourseID) > 1;

SELECT DATE_FORMAT(EnrollDate,'%Y-%m') AS Month, COUNT(*) AS TotalEnrollments
FROM Enrollments
GROUP BY Month;

SELECT InstructorID, COUNT(DISTINCT Category) AS CategoryCount
FROM Courses
GROUP BY InstructorID
HAVING COUNT(DISTINCT Category) > 1;
