CREATE TABLE Department (
    DNUM INT PRIMARY KEY,
    DName VARCHAR(100) NOT NULL,
    ManagerSSN CHAR(9) NOT NULL UNIQUE,
    HireDate DATE NOT NULL
);

CREATE TABLE Employee (
    SSN CHAR(9) PRIMARY KEY,
    Fname VARCHAR(50) NOT NULL,
    Lname VARCHAR(50) NOT NULL,
    BirthDate DATE NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')),
    DNUM INT NOT NULL,
    SupervisorSSN CHAR(9),
    CONSTRAINT chk_no_self_supervision CHECK (SupervisorSSN IS NULL OR SupervisorSSN <> SSN),
    CONSTRAINT fk_emp_dept FOREIGN KEY (DNUM) REFERENCES Department(DNUM),
    CONSTRAINT fk_emp_supervisor FOREIGN KEY (SupervisorSSN) REFERENCES Employee(SSN)
);

ALTER TABLE Department
ADD CONSTRAINT fk_dept_manager FOREIGN KEY (ManagerSSN) REFERENCES Employee(SSN);

CREATE TABLE DepartmentLocation (
    DNUM INT NOT NULL,
    Location VARCHAR(100) NOT NULL,
    PRIMARY KEY (DNUM, Location),
    FOREIGN KEY (DNUM) REFERENCES Department(DNUM) ON DELETE CASCADE
);

CREATE TABLE Project (
    PNumber INT PRIMARY KEY,
    PName VARCHAR(100) NOT NULL,
    Location VARCHAR(100) NOT NULL,
    City VARCHAR(100) NOT NULL,
    DNUM INT NOT NULL,
    FOREIGN KEY (DNUM) REFERENCES Department(DNUM)
);

CREATE TABLE WorksOn (
    SSN CHAR(9) NOT NULL,
    PNumber INT NOT NULL,
    WorkingHours DECIMAL(5,2) NOT NULL CHECK (WorkingHours >= 0),
    PRIMARY KEY (SSN, PNumber),
    FOREIGN KEY (SSN) REFERENCES Employee(SSN) ON DELETE CASCADE,
    FOREIGN KEY (PNumber) REFERENCES Project(PNumber) ON DELETE CASCADE
);

CREATE TABLE Dependent (
    SSN CHAR(9) NOT NULL,
    DependentName VARCHAR(100) NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')),
    BirthDate DATE NOT NULL,
    PRIMARY KEY (SSN, DependentName),
    FOREIGN KEY (SSN) REFERENCES Employee(SSN) ON DELETE CASCADE
);
