USE `cognizant`;

-- =============================================
-- 1. INSERT DATA: BUSINESS UNITS
-- =============================================
INSERT INTO `business_unit` (`BU_ID`, `BU_Name`, `Head_AssociateID`) VALUES
('BU001', 'Digital Business', 'ASC1001'),
('BU002', 'Cloud Services', 'ASC1005'),
('BU003', 'Health Sciences', 'ASC1008'),
('BU004', 'Banking & Finance', 'ASC1010');

-- =============================================
-- 2. INSERT DATA: CLIENTS
-- =============================================
INSERT INTO `client` (`ClientID`, `ClientName`, `Region`, `ContractStatus`) VALUES
('CL001', 'Acme Corp', 'North America', 'Active'),
('CL002', 'Global Health', 'Europe', 'Active'),
('CL003', 'TechFlow Inc', 'APAC', 'Renewal Due'),
('CL004', 'SafeBank', 'North America', 'Active');

-- =============================================
-- 3. INSERT DATA: SKILL MASTER
-- =============================================
INSERT INTO `skill_master` (`SkillID`, `SkillName`) VALUES
('SK001', 'Java Fullstack'),
('SK002', 'AWS Cloud'),
('SK003', 'Python Data Science'),
('SK004', 'ReactJS'),
('SK005', 'Project Management');

-- =============================================
-- 4. INSERT DATA: EMPLOYEES
-- Note: Includes Business Unit Head references
-- =============================================
INSERT INTO `employee` (`AssociateID`, `FullName`, `Designation`, `BaseLocation`, `Email`, `CurrentStatus`, `BU_ID`) VALUES
('ASC1001', 'John Meyers', 'Director', 'New York', 'john.m@cog.com', 'Active', 'BU001'),
('ASC1002', 'Sarah Lee', 'Senior Developer', 'Chennai', 'sarah.l@cog.com', 'Allocated', 'BU001'),
('ASC1003', 'Rahul Verma', 'Data Analyst', 'Bangalore', 'rahul.v@cog.com', 'On Bench', 'BU001'),
('ASC1004', 'Emily Chen', 'Project Manager', 'London', 'emily.c@cog.com', 'Allocated', 'BU003'),
('ASC1005', 'Michael Scott', 'VP Cloud', 'Dallas', 'mike.s@cog.com', 'Active', 'BU002'),
('ASC1006', 'David Kim', 'Cloud Architect', 'Pune', 'david.k@cog.com', 'Allocated', 'BU002'),
('ASC1007', 'Anita Roy', 'QA Lead', 'Kolkata', 'anita.r@cog.com', 'On Bench', 'BU004'),
('ASC1008', 'Dr. Lisa Ray', 'Director Health', 'Boston', 'lisa.r@cog.com', 'Active', 'BU003'),
('ASC1009', 'Tom Hanks', 'UX Designer', 'Hyderabad', 'tom.h@cog.com', 'Allocated', 'BU001'),
('ASC1010', 'Gary Oldman', 'VP Finance', 'Chicago', 'gary.o@cog.com', 'Active', 'BU004');

-- =============================================
-- 5. INSERT DATA: ASSETS
-- Note: AssignedTo_ID must be unique
-- =============================================
INSERT INTO `asset` (`AssetTag`, `Model`, `SerialNum`, `AssignedTo_ID`) VALUES
('AST001', 'Dell XPS 15', 'SN12345678', 'ASC1001'),
('AST002', 'MacBook Pro', 'SN87654321', 'ASC1002'),
('AST003', 'Lenovo ThinkPad', 'SN11223344', 'ASC1004'),
('AST004', 'HP EliteBook', 'SN44332211', 'ASC1006'),
('AST005', 'Dell Latitude', 'SN55667788', 'ASC1009');

-- =============================================
-- 6. INSERT DATA: EMPLOYEE SKILL MAP
-- =============================================
INSERT INTO `employee_skill_map` (`MapID`, `AssociateID`, `SkillID`, `ProficiencyLevel`, `CertificationStatus`) VALUES
('MAP001', 'ASC1002', 'SK001', 'Expert', 'COMPLETED'),
('MAP002', 'ASC1002', 'SK004', 'Intermediate', 'IN_PROGRESS'),
('MAP003', 'ASC1006', 'SK002', 'Expert', 'COMPLETED'),
('MAP004', 'ASC1003', 'SK003', 'Beginner', 'NOT_STARTED'),
('MAP005', 'ASC1004', 'SK005', 'Advanced', 'COMPLETED');

-- =============================================
-- 7. INSERT DATA: PROJECTS
-- =============================================
INSERT INTO `project` (`ProjectID`, `ProjectName`, `ClientID`, `BU_ID`, `ProjectType`, `StartDate`, `EndDate`) VALUES
('PRJ001', 'E-Comm Platform', 'CL001', 'BU001', 'Development', '2024-01-01', '2024-12-31'),
('PRJ002', 'Cloud Migration', 'CL004', 'BU002', 'Infrastructure', '2024-03-15', '2025-03-15'),
('PRJ003', 'Patient Portal', 'CL002', 'BU003', 'Maintenance', '2023-06-01', '2024-06-01'),
('PRJ004', 'AI Fraud Detect', 'CL004', 'BU004', 'R&D', '2024-02-01', '2024-08-01');

-- =============================================
-- 8. INSERT DATA: PROJECT ALLOCATION
-- =============================================
INSERT INTO `project_allocation` (`AllocID`, `AssociateID`, `ProjectID`, `AllocationDate`, `ReleaseDate`, `BillingRate_Hourly`, `AllocationType`) VALUES
('ALL001', 'ASC1002', 'PRJ001', '2024-01-10', '2024-12-31', 65.00, 'Billable'),
('ALL002', 'ASC1004', 'PRJ003', '2023-06-01', '2024-06-01', 80.00, 'Billable'),
('ALL003', 'ASC1006', 'PRJ002', '2024-03-20', '2025-03-15', 90.00, 'Billable'),
('ALL004', 'ASC1009', 'PRJ001', '2024-02-01', '2024-06-30', 55.00, 'Shadow');

-- =============================================
-- 9. INSERT DATA: PAYROLL
-- =============================================
INSERT INTO `payroll` (`PaySlipID`, `AssociateID`, `PayMonth`, `Basic_Salary`, `HRA`, `Variable_Pay`, `Deductions`, `Net_Salary`) VALUES
('PAY001', 'ASC1002', 'October-2024', 50000.00, 20000.00, 5000.00, 4000.00, 71000.00),
('PAY002', 'ASC1003', 'October-2024', 35000.00, 14000.00, 2000.00, 3000.00, 48000.00),
('PAY003', 'ASC1006', 'October-2024', 80000.00, 32000.00, 10000.00, 8000.00, 114000.00),
('PAY004', 'ASC1001', 'October-2024', 120000.00, 48000.00, 25000.00, 15000.00, 178000.00);

-- =============================================
-- 10. INSERT DATA: LEAVE REQUESTS
-- =============================================
INSERT INTO `leave_request` (`LeaveID`, `AssociateID`, `StartDate`, `EndDate`, `LeaveType`, `Status`, `ApproverID`) VALUES
('LR001', 'ASC1002', '2024-11-01', '2024-11-05', 'Sick Leave', 'APPROVED', 'ASC1001'),
('LR002', 'ASC1003', '2024-12-20', '2024-12-31', 'Vacation', 'PENDING', 'ASC1001'),
('LR003', 'ASC1006', '2024-11-15', '2024-11-16', 'Personal', 'APPROVED', 'ASC1005');