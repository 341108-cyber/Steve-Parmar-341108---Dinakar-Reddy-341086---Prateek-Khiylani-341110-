-- ====================================================
-- SECTION A: ORGANIZATION STRUCTURE
-- ====================================================

-- 1. Business Units (The Verticals)
-- Cognizant organizes by industry (BFS, Healthcare, CMT, etc.)
CREATE TABLE Business_Unit (
    BU_ID INT PRIMARY KEY,
    BU_Name VARCHAR(50) NOT NULL, 
    Head_AssociateID INT          
);

-- 2. Clients (The Customers)
CREATE TABLE Client (
    ClientID INT PRIMARY KEY,
    ClientName VARCHAR(100) NOT NULL, 
    Region VARCHAR(20),               
    ContractStatus VARCHAR(20) DEFAULT 'Active'
);

-- 3. Projects (The Work)
CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    ClientID INT,
    BU_ID INT,
    ProjectType VARCHAR(20) CHECK (ProjectType IN ('T&M', 'Fixed Bid', 'Support')),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY (BU_ID) REFERENCES Business_Unit(BU_ID)
);

-- ====================================================
-- SECTION B: WORKFORCE MANAGEMENT
-- ====================================================

-- 4. Employee (The Associates)
CREATE TABLE Employee (
    AssociateID INT PRIMARY KEY, 
    FullName VARCHAR(100) NOT NULL,
    Designation VARCHAR(50),    
    BaseLocation VARCHAR(50),   
    Email VARCHAR(100) UNIQUE,
    CurrentStatus VARCHAR(20) DEFAULT 'On Bench' CHECK (CurrentStatus IN ('Allocated', 'On Bench', 'Notice Period')),
    BU_ID INT,                   
    FOREIGN KEY (BU_ID) REFERENCES Business_Unit(BU_ID)
);

-- 5. Asset_Inventory (Laptops/Hardware)
CREATE TABLE Asset (
    AssetTag VARCHAR(20) PRIMARY KEY, 
    Model VARCHAR(50),
    SerialNum VARCHAR(50) UNIQUE,
    AssignedTo_ID INT UNIQUE,         
    FOREIGN KEY (AssignedTo_ID) REFERENCES Employee(AssociateID)
);

-- ====================================================
-- SECTION C: OPERATIONS (Transactions)
-- ====================================================

-- 6. Project_Allocation (The Linking Table)

CREATE TABLE Project_Allocation (
    AllocID INT PRIMARY KEY,
    AssociateID INT,
    ProjectID INT,
    AllocationDate DATE,
    ReleaseDate DATE,
    BillingRate_Hourly DECIMAL(10,2), -- How much CTS charges the client
    AllocationType VARCHAR(20) CHECK (AllocationType IN ('Billable', 'Shadow', 'Buffer')),
    FOREIGN KEY (AssociateID) REFERENCES Employee(AssociateID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);

-- ====================================================
-- SECTION D: LEARNING & DEVELOPMENT (Skills)
-- ====================================================

-- 7. Skill_Master (The Catalog of Tech)
CREATE TABLE Skill_Master (
    SkillID INT PRIMARY KEY,
    SkillName VARCHAR(50) NOT NULL, -- e.g., 'Java Full Stack', 'Azure Admin'
    Category VARCHAR(30)            -- 'Programming', 'Cloud', 'Data Science'
);

-- 8. Employee_Skill_Map (Who knows what?)
-- M:N Relationship between Associate and Skill
CREATE TABLE Employee_Skill_Map (
    MapID INT PRIMARY KEY,
    AssociateID INT,
    SkillID INT,
    ProficiencyLevel VARCHAR(20) CHECK (ProficiencyLevel IN ('Beginner', 'Intermediate', 'Expert')),
    CertificationStatus VARCHAR(10) DEFAULT 'No' CHECK (CertificationStatus IN ('Yes', 'No')),
    FOREIGN KEY (AssociateID) REFERENCES Employee(AssociateID),
    FOREIGN KEY (SkillID) REFERENCES Skill_Master(SkillID)
);

-- ====================================================
-- SECTION E: HR & FINANCE
-- ====================================================

-- 9. Payroll (Monthly Salary)
CREATE TABLE Payroll (
    PaySlipID INT PRIMARY KEY,
    AssociateID INT,
    PayMonth VARCHAR(20),  -- e.g., 'November-2023'
    Basic_Salary DECIMAL(10,2),
    HRA DECIMAL(10,2),     -- House Rent Allowance
    Variable_Pay DECIMAL(10,2), -- Performance Bonus
    Deductions DECIMAL(10,2),   -- Tax/PF
    Net_Salary DECIMAL(10,2),   -- Calculated automatically via Trigger/Gen Column
    FOREIGN KEY (AssociateID) REFERENCES Employee(AssociateID)
);

-- 10. Leave_Request (Time Off)
CREATE TABLE Leave_Request (
    LeaveID INT PRIMARY KEY,
    AssociateID INT,
    StartDate DATE,
    EndDate DATE,
    LeaveType VARCHAR(20) CHECK (LeaveType IN ('Sick', 'Casual', 'Privilege')),
    Status VARCHAR(20) DEFAULT 'Pending' CHECK (Status IN ('Pending', 'Approved', 'Rejected')),
    ApproverID INT, -- The Manager who approves (Recursive link to Employee)
    FOREIGN KEY (AssociateID) REFERENCES Employee(AssociateID),
    FOREIGN KEY (ApproverID) REFERENCES Employee(AssociateID)
);