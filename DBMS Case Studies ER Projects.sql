#Case Study 1: University Database

#1. CREATE DATABASE
CREATE DATABASE UniversityDB;
USE UniversityDB;

#2. CREATE TABLES (Based on your schema)
# DEPARTMENT
CREATE TABLE DEPARTMENT (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100),
    Location VARCHAR(100),
    ManagerEmpID INT
);

#3INSTRUCTOR
CREATE TABLE INSTRUCTOR (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Title VARCHAR(50),
    Salary DECIMAL(10,2),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES DEPARTMENT(DeptID)
);

#4INSTRUCTOR_PHONE (Multivalued)
CREATE TABLE INSTRUCTOR_PHONE (
    EmpID INT,
    PhoneNo VARCHAR(15),
    PRIMARY KEY (EmpID, PhoneNo),
    FOREIGN KEY (EmpID) REFERENCES INSTRUCTOR(EmpID)
);

#5COURSE
CREATE TABLE COURSE (
    CourseCode VARCHAR(10) PRIMARY KEY,
    Title VARCHAR(100),
    Credits INT,
    Description TEXT,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES DEPARTMENT(DeptID)
);

#6SECTION (Weak Entity)
CREATE TABLE SECTION (
    CourseCode VARCHAR(10),
    SectionNo INT,
    Semester VARCHAR(20),
    Year INT,
    Time VARCHAR(20),
    Room VARCHAR(20),
    EmpID INT,
    PRIMARY KEY (CourseCode, SectionNo),
    FOREIGN KEY (CourseCode) REFERENCES COURSE(CourseCode),
    FOREIGN KEY (EmpID) REFERENCES INSTRUCTOR(EmpID)
);

#7 STUDENT
CREATE TABLE STUDENT (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DOB DATE,
    Gender VARCHAR(10),
    GPA DECIMAL(3,2)
);
#8 STUDENT_EMAIL (Multivalued)
CREATE TABLE STUDENT_EMAIL (
    StudentID INT,
    Email VARCHAR(100),
    PRIMARY KEY (StudentID, Email),
    FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID)
);

#9 ENROLLMENT (M:N Junction)
CREATE TABLE ENROLLMENT (
    StudentID INT,
    CourseCode VARCHAR(10),
    SectionNo INT,
    Grade CHAR(2),
    PRIMARY KEY (StudentID, CourseCode, SectionNo),
    FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID),
    FOREIGN KEY (CourseCode, SectionNo)
        REFERENCES SECTION(CourseCode, SectionNo)
);

#iNSERT SAMPLE DATA (VERY IMPORTANT for running queries)
INSERT INTO DEPARTMENT VALUES
(1,'Computer Science','Block A',101),
(2,'Management','Block B',102);

INSERT INTO INSTRUCTOR VALUES
(101,'Raj','Sharma','Professor',90000,1),
(102,'Neha','Patel','Associate Prof',75000,2);

INSERT INTO COURSE VALUES
('CS101','Database Systems',4,'DBMS Course',1),
('CS102','Operating Systems',4,'OS Course',1);

INSERT INTO SECTION VALUES
('CS101',1,'Fall',2025,'10AM','R1',101),
('CS101',2,'Fall',2025,'12PM','R2',101),
('CS101',3,'Fall',2025,'2PM','R3',101),
('CS101',4,'Fall',2025,'4PM','R4',101);

INSERT INTO STUDENT VALUES
(1,'Amit','Kumar','2002-05-01','Male',8.5),
(2,'Sara','Ali','2003-07-12','Female',9.1);

INSERT INTO ENROLLMENT VALUES
(1,'CS101',1,'A'),
(2,'CS101',2,'B');

#1 Find all students enrolled in “Database Systems”
SELECT s.FirstName, s.LastName, e.Grade
FROM STUDENT s
JOIN ENROLLMENT e ON s.StudentID = e.StudentID
WHERE e.CourseCode = 'CS101';

#2 Find instructors who teach more than 3 sections
SELECT i.FirstName, i.LastName, COUNT(*) AS SectionsCount
FROM INSTRUCTOR i
JOIN SECTION sec ON i.EmpID = sec.EmpID
GROUP BY i.EmpID
HAVING COUNT(*) > 3;

 #3 Average GPA per Department
SELECT d.DeptName, AVG(s.GPA) AS AvgGPA
FROM DEPARTMENT d
JOIN COURSE c ON d.DeptID = c.DeptID
JOIN ENROLLMENT e ON c.CourseCode = e.CourseCode
JOIN STUDENT s ON e.StudentID = s.StudentID
GROUP BY d.DeptName
ORDER BY AvgGPA DESC;

# Case Study 2: Hospital Database
#1. CREATE DATABASE
CREATE DATABASE HospitalDB;
USE HospitalDB;

# 2. CREATE TABLES
#WARD
CREATE TABLE WARD (
    WardID INT PRIMARY KEY,
    WardName VARCHAR(100),
    FloorNo INT,
    Capacity INT,
    HeadNurseID INT
);

# NURSE
 CREATE TABLE Nurse (
    NurseID INT PRIMARY KEY,
    Name VARCHAR(100),
    WardID INT
);

 CREATE TABLE Nurse_Shift (
    ShiftID INT PRIMARY KEY,
    NurseID INT,
    Shift VARCHAR(50),
    FOREIGN KEY (NurseID) REFERENCES Nurse(NurseID)
);

#PATIENT
CREATE TABLE PATIENT (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100),
    DOB DATE,
    BloodType VARCHAR(5),
    Street VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50)
);

# EMERGENCY_CONTACT (Weak Entity)
CREATE TABLE EMERGENCY_CONTACT (
    PatientID INT,
    ContactName VARCHAR(100),
    Relation VARCHAR(50),
    Phone VARCHAR(15),
    PRIMARY KEY (PatientID, ContactName),
    FOREIGN KEY (PatientID) REFERENCES PATIENT(PatientID)
);

#DOCTOR
CREATE TABLE DOCTOR (
    DoctorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Specialization VARCHAR(100),
    Contact VARCHAR(15),
    Experience INT
);

# ADMISSION
CREATE TABLE ADMISSION (
    AdmissionID INT PRIMARY KEY,
    PatientID INT,
    WardID INT,
    AdmitDate DATE,
    DischargeDate DATE,
    Reason VARCHAR(200),
    FOREIGN KEY (PatientID) REFERENCES PATIENT(PatientID),
    FOREIGN KEY (WardID) REFERENCES WARD(WardID)
);

#MEDICATION
CREATE TABLE MEDICATION (
    DrugID INT PRIMARY KEY,
    Name VARCHAR(100),
    Manufacturer VARCHAR(100),
    Type VARCHAR(50)
);

#TREATMENT
CREATE TABLE TREATMENT (
    TreatmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Date DATE,
    Diagnosis VARCHAR(200),
    FOREIGN KEY (PatientID) REFERENCES PATIENT(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES DOCTOR(DoctorID)
);

# PRESCRIPTION
CREATE TABLE PRESCRIPTION (
    TreatmentID INT,
    DrugID INT,
    Dosage VARCHAR(50),
    Frequency VARCHAR(50),
    Duration VARCHAR(50),
    PRIMARY KEY (TreatmentID, DrugID),
    FOREIGN KEY (TreatmentID) REFERENCES TREATMENT(TreatmentID),
    FOREIGN KEY (DrugID) REFERENCES MEDICATION(DrugID)
);

#LAB_TEST
CREATE TABLE LAB_TEST (
    TestID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    TestName VARCHAR(100),
    Date DATE,
    Result VARCHAR(100),
    Status VARCHAR(50),
    FOREIGN KEY (PatientID) REFERENCES PATIENT(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES DOCTOR(DoctorID)
);

#INSERT SAMPLE DATA
INSERT INTO WARD VALUES
(1,'General',1,30,NULL),
(2,'ICU',2,10,NULL);

INSERT INTO NURSE VALUES
(1,'Anita',2),
(2,'Pooja',2),
(3,'Ravi',1);

INSERT INTO NURSE_SHIFT VALUES
(1,'Morning'),
(1,'Night'),
(2,'Morning'),
(3,'Evening');

INSERT INTO PATIENT VALUES
(1,'Amit','2000-05-01','A+','MG Road','Mumbai','MH'),
(2,'Sara','1999-03-02','B+','Link Road','Mumbai','MH');

INSERT INTO DOCTOR VALUES
(1,'Dr Mehta','Cardiology','999999',12),
(2,'Dr Khan','Neuro','888888',8);

INSERT INTO ADMISSION VALUES
(1,1,2,'2024-01-01',NULL,'Heart Issue'),
(2,2,1,'2024-02-01','2024-02-10','Fever');

INSERT INTO TREATMENT VALUES
(1,1,1,'2024-01-02','Cardiac Check'),
(2,1,1,'2024-01-03','ECG'),
(3,1,1,'2024-01-04','Followup');


#1 List all patients currently admitted
SELECT p.Name, w.WardName, a.AdmitDate
FROM PATIENT p
JOIN ADMISSION a ON p.PatientID = a.PatientID
JOIN WARD w ON a.WardID = w.WardID
WHERE a.DischargeDate IS NULL;

 #2 Doctors who treated more than 10 patients in 2024
SELECT d.Name,
COUNT(DISTINCT t.PatientID) AS PatientCount
FROM DOCTOR d
JOIN TREATMENT t ON d.DoctorID = t.DoctorID
WHERE YEAR(t.Date)=2024
GROUP BY d.DoctorID
HAVING COUNT(DISTINCT t.PatientID) > 10;

 #3 Nurses working Morning shift in Ward 2
SELECT n.Name
FROM NURSE n
JOIN NURSE_SHIFT ns ON n.NurseID = ns.NurseID
WHERE n.WardID = 2 AND ns.Shift='Morning';

#Case Study 3: E-Commerce Database
#1. CREATE DATABASE
CREATE DATABASE EcommerceDB;
USE EcommerceDB;

# 2. CREATE TABLES
# CATEGORY (Self Referencing)
CREATE TABLE CATEGORY(
    CatID INT PRIMARY KEY,
    CatName VARCHAR(100),
    ParentCatID INT,
    FOREIGN KEY (ParentCatID) REFERENCES CATEGORY(CatID)
);

# PRODUCT
CREATE TABLE PRODUCT(
    ProductID INT PRIMARY KEY,
    Name VARCHAR(100),
    Description TEXT,
    BasePrice DECIMAL(10,2),
    StockQty INT,
    Weight DECIMAL(6,2),
    CatID INT,
    FOREIGN KEY (CatID) REFERENCES CATEGORY(CatID)
);

# PRODUCT_IMAGE
CREATE TABLE PRODUCT_IMAGE(
    ProductID INT,
    ImageURL VARCHAR(200),
    PRIMARY KEY(ProductID, ImageURL),
    FOREIGN KEY(ProductID) REFERENCES PRODUCT(ProductID)
);

# VENDOR
CREATE TABLE VENDOR(
    VendorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Rating DECIMAL(2,1),
    Email VARCHAR(100),
    Phone VARCHAR(20)
);

# VENDOR_PRODUCT
CREATE TABLE VENDOR_PRODUCT(
    VendorID INT,
    ProductID INT,
    VendorPrice DECIMAL(10,2),
    DeliveryDays INT,
    PRIMARY KEY(VendorID, ProductID),
    FOREIGN KEY(VendorID) REFERENCES VENDOR(VendorID),
    FOREIGN KEY(ProductID) REFERENCES PRODUCT(ProductID)
);

# CUSTOMER
CREATE TABLE CUSTOMER(
    CustID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateJoined DATE,
    LoyaltyPoints INT
);

# CUSTOMER_EMAIL
CREATE TABLE CUSTOMER_EMAIL(
    CustID INT,
    Email VARCHAR(100),
    PRIMARY KEY(CustID, Email),
    FOREIGN KEY(CustID) REFERENCES CUSTOMER(CustID)
);

# ADDRESS
CREATE TABLE ADDRESS(
    CustID INT,
    AddressID INT,
    Street VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    Pincode VARCHAR(10),
    Type VARCHAR(20),
    PRIMARY KEY(CustID, AddressID),
    FOREIGN KEY(CustID) REFERENCES CUSTOMER(CustID)
);

# CART
CREATE TABLE CART(
    CartID INT PRIMARY KEY,
    CustID INT UNIQUE,
    CreatedAt DATE,
    FOREIGN KEY(CustID) REFERENCES CUSTOMER(CustID)
);

# CART_ITEM
CREATE TABLE CART_ITEM(
    CartID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY(CartID, ProductID),
    FOREIGN KEY(CartID) REFERENCES CART(CartID),
    FOREIGN KEY(ProductID) REFERENCES PRODUCT(ProductID)
);

#ORDERS
CREATE TABLE ORDERS(
    OrderID INT PRIMARY KEY,
    CustID INT,
    OrderDate DATE,
    Status VARCHAR(30),
    ShipStreet VARCHAR(100),
    ShipCity VARCHAR(50),
    ShipState VARCHAR(50),
    FOREIGN KEY(CustID) REFERENCES CUSTOMER(CustID)
);

#ORDER_ITEM
CREATE TABLE ORDER_ITEM(
    OrderID INT,
    ItemSeq INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    Discount DECIMAL(5,2),
    PRIMARY KEY(OrderID, ItemSeq),
    FOREIGN KEY(OrderID) REFERENCES ORDERS(OrderID),
    FOREIGN KEY(ProductID) REFERENCES PRODUCT(ProductID)
);

# PAYMENT
CREATE TABLE PAYMENT(
    PaymentID INT PRIMARY KEY,
    OrderID INT UNIQUE,
    Method VARCHAR(30),
    Amount DECIMAL(10,2),
    TxnID VARCHAR(100),
    Status VARCHAR(30),
    PaidAt DATE,
    FOREIGN KEY(OrderID) REFERENCES ORDERS(OrderID)
);

# REVIEW
CREATE TABLE REVIEW(
    ReviewID INT PRIMARY KEY,
    CustID INT,
    ProductID INT,
    Rating INT,
    Comment TEXT,
    ReviewDate DATE,
    UNIQUE(CustID, ProductID),
    FOREIGN KEY(CustID) REFERENCES CUSTOMER(CustID),
    FOREIGN KEY(ProductID) REFERENCES PRODUCT(ProductID)
);

#INSERT SAMPLE DATA (IMPORTANT)
INSERT INTO CATEGORY VALUES
(1,'Electronics',NULL),
(2,'Mobiles',1);

INSERT INTO PRODUCT VALUES
(101,'iPhone','Apple Phone',80000,50,0.5,2),
(102,'Samsung','Android Phone',50000,40,0.4,2);

INSERT INTO CUSTOMER VALUES
(1,'Amit','Shah','2024-01-01',100),
(2,'Sara','Khan','2024-02-01',200);

INSERT INTO ORDERS VALUES
(1001,1,'2024-03-01','DELIVERED','MG Road','Mumbai','MH'),
(1002,1,'2024-04-01','DELIVERED','MG Road','Mumbai','MH');

INSERT INTO ORDER_ITEM VALUES
(1001,1,101,2,80000,0),
(1002,1,102,1,50000,0);

INSERT INTO REVIEW VALUES
(1,1,101,5,'Great','2024-05-01'),
(2,2,102,4,'Good','2024-05-02');

#1 Top 5 Best-Selling Products by Revenue
SELECT p.Name,
SUM(oi.Quantity * oi.UnitPrice) AS Revenue
FROM PRODUCT p
JOIN ORDER_ITEM oi ON p.ProductID = oi.ProductID
JOIN ORDERS o ON oi.OrderID = o.OrderID
WHERE o.Status='DELIVERED'
GROUP BY p.ProductID
ORDER BY Revenue DESC
LIMIT 5;

 #2 Customers who never placed any order
SELECT c.FirstName, c.LastName
FROM CUSTOMER c
LEFT JOIN ORDERS o ON c.CustID = o.CustID
WHERE o.OrderID IS NULL;

#3 Average Product Rating per Category
SELECT cat.CatName,
AVG(r.Rating) AS AvgRating,
COUNT(r.ReviewID) AS TotalReviews
FROM CATEGORY cat
JOIN PRODUCT p ON cat.CatID = p.CatID
JOIN REVIEW r ON p.ProductID = r.ProductID
GROUP BY cat.CatName
ORDER BY AvgRating DESC;
