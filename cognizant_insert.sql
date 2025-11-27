-- 1. Insert Business Units (Verticals)
INSERT INTO Business_Unit (BU_ID, BU_Name) VALUES 
(1, 'Banking & Financial Services (BFS)'),
(2, 'Healthcare & Life Sciences (HLS)'),
(3, 'Comms, Media & Tech (CMT)'),
(4, 'Cloud Infrastructure Services (CIS)');

-- 2. Insert Clients
INSERT INTO Client (ClientID, ClientName, Region, ContractStatus) VALUES 
(101, 'JP Morgan Chase', 'North America', 'Active'),
(102, 'MetLife Insurance', 'APAC', 'Active'),
(103, 'Verizon', 'North America', 'Active'),
(104, 'Barclays', 'EMEA', 'On Hold');

-- 3. Insert Skill Catalog (The Menu of Tech)
INSERT INTO Skill_Master (SkillID, SkillName, Category) VALUES 
(801, 'Java Spring Boot', 'Backend'),
(802, 'ReactJS', 'Frontend'),
(803, 'AWS Solution Architect', 'Cloud'),
(804, 'Selenium Automation', 'Testing'),
(805, 'Python Data Science', 'Data/AI');

-- 4. Insert Projects (Work Orders)
INSERT INTO Project (ProjectID, ProjectName, ClientID, BU_ID, ProjectType, StartDate, EndDate) VALUES 
(5001, 'Global Payment Gateway', 101, 1, 'Fixed Bid', '2023-01-15', '2024-12-31'),
(5002, 'Claims Processing AI', 102, 2, 'T&M', '2023-06-01', NULL),
(5003, '5G Network Rollout', 103, 3, 'Support', '2022-01-01', '2025-01-01');

-- 5. Insert Employees (Associates)
-- Note: Manager (210002) is inserted so others can report to him later if needed
INSERT INTO Employee (AssociateID, FullName, Designation, BaseLocation, Email, CurrentStatus, BU_ID) VALUES 
(210001, 'Rohan Mehta', 'Programmer Analyst', 'Pune', 'rohan.m@cts.com', 'On Bench', 1),
(210002, 'Sarah Jenkins', 'Senior Manager', 'London', 'sarah.j@cts.com', 'Allocated', 1),
(210003, 'Amitabh Roy', 'Associate', 'Chennai', 'amit.r@cts.com', 'Allocated', 2),
(210004, 'David Smith', 'Architect', 'New York', 'david.s@cts.com', 'Allocated', 3);

-- 6. Assign Assets (Laptops)
INSERT INTO Asset (AssetTag, Model, SerialNum, AssignedTo_ID) VALUES 
('LPT-IN-9001', 'Dell Latitude 7420', 'CN-112233', 210001),
('LPT-UK-8002', 'MacBook Pro M2', 'AP-998877', 210002),
('LPT-IN-9003', 'Lenovo ThinkPad', 'LN-556644', 210003);

-- 7. Map Skills (Who knows what?)
INSERT INTO Employee_Skill_Map (MapID, AssociateID, SkillID, ProficiencyLevel, CertificationStatus) VALUES 
(1, 210001, 801, 'Intermediate', 'Yes'), -- Rohan knows Java
(2, 210001, 802, 'Beginner', 'No'),     -- Rohan learning React
(3, 210002, 803, 'Expert', 'Yes'),      -- Sarah is AWS Expert
(4, 210003, 805, 'Intermediate', 'No'); -- Amitabh knows Python

-- 8. Project Allocation (The "Billable" Link)
-- Sarah manages the Banking Project
INSERT INTO Project_Allocation (AllocID, AssociateID, ProjectID, AllocationDate, BillingRate_Hourly, AllocationType) 
VALUES (9001, 210002, 5001, '2023-01-20', 85.00, 'Billable');

-- Amitabh works on Insurance AI
INSERT INTO Project_Allocation (AllocID, AssociateID, ProjectID, AllocationDate, BillingRate_Hourly, AllocationType) 
VALUES (9002, 210003, 5002, '2023-06-15', 45.00, 'Billable');

-- NOTE: If you have the "Update_Status_On_Allocation" Trigger active, 
-- Sarah and Amitabh will automatically flip from 'On Bench' to 'Allocated'.

-- 9. Process Payroll (For November 2023)
-- Net Salary will auto-calculate if you used the Trigger. 
-- Otherwise, Net = (Basic + HRA + Variable) - Deductions.
INSERT INTO Payroll (PaySlipID, AssociateID, PayMonth, Basic_Salary, HRA, Variable_Pay, Deductions) VALUES 
(7001, 210001, 'Nov-2023', 30000.00, 15000.00, 0.00, 3000.00),     -- Rohan (Junior)
(7002, 210002, 'Nov-2023', 120000.00, 60000.00, 20000.00, 15000.00), -- Sarah (Manager)
(7003, 210003, 'Nov-2023', 50000.00, 25000.00, 5000.00, 5000.00);    -- Amitabh

-- 10. Leave Requests
-- Scenario: Rohan asks for Sick Leave, approved by Sarah (his Manager)
INSERT INTO Leave_Request (LeaveID, AssociateID, StartDate, EndDate, LeaveType, Status, ApproverID) VALUES 
(8001, 210001, '2023-12-01', '2023-12-03', 'Sick', 'Approved', 210002);

-- Scenario: Amitabh asks for Vacation, still pending
INSERT INTO Leave_Request (LeaveID, AssociateID, StartDate, EndDate, LeaveType, Status, ApproverID) VALUES 
(8002, 210003, '2023-12-25', '2023-12-31', 'Privilege', 'Pending', 210002);