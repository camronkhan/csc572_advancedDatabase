DROP TABLE CSGroup CASCADE CONSTRAINTS;
CREATE TABLE CSGroup (
	CSGroupNum NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL,
	CSGroupName NVARCHAR2(100) NOT NULL,
	CONSTRAINT PK_CSGroup PRIMARY KEY (CSGroupNum)
);

INSERT INTO CSGroup (CSGroupName) VALUES ('Sales');
INSERT INTO CSGroup (CSGroupName) VALUES ('Marketing');
INSERT INTO CSGroup (CSGroupName) VALUES ('Engineering');
INSERT INTO CSGroup (CSGroupName) VALUES ('Quality Assurance');
INSERT INTO CSGroup (CSGroupName) VALUES ('Customer Service');
INSERT INTO CSGroup (CSGroupName) VALUES ('Product');
INSERT INTO CSGroup (CSGroupName) VALUES ('Finance');
INSERT INTO CSGroup (CSGroupName) VALUES ('Legal');

DROP TABLE CSEmployee CASCADE CONSTRAINTS;
CREATE TABLE CSEmployee (
	CSEmpNum NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL,
	CSEmpFirstName NVARCHAR2(30) NOT NULL,
	CSEmpLastName NVARCHAR2(50) NOT NULL,
	JobDescription NVARCHAR2(100) NOT NULL,
	WorkPhone NVARCHAR2(30) NOT NULL,
	OfficeNum NUMBER NOT NULL,
	CSGroupNum NUMBER NOT NULL,
	CONSTRAINT PK_CSEmployee PRIMARY KEY (CSEmpNum),
	CONSTRAINT FK_CSEmployee_CSGroup FOREIGN KEY (CSGroupNum) REFERENCES CSGroup(CSGroupNum)
);

INSERT INTO CSEmployee (CSEmpFirstName, CSEmpLastName, JobDescription, WorkPhone, OfficeNum, CSGroupNum) VALUES ('Camron', 'Khan', 'Software Developer', '15557660870', 1, 3);
INSERT INTO CSEmployee (CSEmpFirstName, CSEmpLastName, JobDescription, WorkPhone, OfficeNum, CSGroupNum) VALUES ('Frank', 'Policht', 'Marketing Strategist', '15559971969', 2, 2);
INSERT INTO CSEmployee (CSEmpFirstName, CSEmpLastName, JobDescription, WorkPhone, OfficeNum, CSGroupNum) VALUES ('Toni', 'Pestillo', 'Designer', '15556025628', 3, 6);
INSERT INTO CSEmployee (CSEmpFirstName, CSEmpLastName, JobDescription, WorkPhone, OfficeNum, CSGroupNum) VALUES ('Stephanie', 'Hutcheson', 'Sales Representative', '15557382234', 4, 1);
INSERT INTO CSEmployee (CSEmpFirstName, CSEmpLastName, JobDescription, WorkPhone, OfficeNum, CSGroupNum) VALUES ('Joe', 'Vitacco', 'Accountant', '15558785467', 5, 7);
INSERT INTO CSEmployee (CSEmpFirstName, CSEmpLastName, JobDescription, WorkPhone, OfficeNum, CSGroupNum) VALUES ('Roxanne', 'Rodica', 'Quality Specialist', '15553158788', 6, 4);
INSERT INTO CSEmployee (CSEmpFirstName, CSEmpLastName, JobDescription, WorkPhone, OfficeNum, CSGroupNum) VALUES ('Mike', 'Kravtsov', 'Attorney', '15556670912', 7, 8);
INSERT INTO CSEmployee (CSEmpFirstName, CSEmpLastName, JobDescription, WorkPhone, OfficeNum, CSGroupNum) VALUES ('Ruben', 'Gonzalez', 'Customer Service Representative', '15556990987', 8, 5);

DROP TABLE Project CASCADE CONSTRAINTS;
CREATE TABLE Project (
	ProjNum NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL,
	ProjName NVARCHAR2(100) NOT NULL,
	ClientName NVARCHAR2(100) NOT NULL,
	ClientProjContactName NVARCHAR2(100) NOT NULL,
	ProjType NVARCHAR2(20) NOT NULL,
	ProjStatus NVARCHAR2(20) NOT NULL,
	StartDate DATE DEFAULT SYSDATE NOT NULL,
	EndDate DATE DEFAULT SYSDATE NOT NULL,
	TotalHoursBudgeted NUMBER DEFAULT 0 NOT NULL,
	TotalDollarsBudgeted NUMBER DEFAULT 0 NOT NULL,
	ProjLeaderNum NUMBER NOT NULL,
	CONSTRAINT PK_Project PRIMARY KEY (ProjNum),
	CONSTRAINT FK_Project_CSEmployee FOREIGN KEY (ProjLeaderNum) REFERENCES CSEmployee(CSEmpNum),
	CONSTRAINT CHK_ProjType CHECK (ProjType IN ('maintenance', 'database', 'support', 'reports')),
	CONSTRAINT CHK_ProjStatus CHECK (ProjStatus IN ('planning', 'in progress', 'on hold', 'completed')),
	CONSTRAINT CHK_TotalHoursBudgeted CHECK (TotalHoursBudgeted >= 0),
	CONSTRAINT CHK_TotalDollarsBudgeted CHECK (TotalDollarsBudgeted >= 0)
);

INSERT INTO Project (ProjName, ClientName, ClientProjContactName, ProjType, ProjStatus, StartDate, EndDate, TotalHoursBudgeted, TotalDollarsBudgeted, ProjLeaderNum) VALUES ('Mercury', 'Benefit Express', 'Greg Myers', 'maintenance', 'planning', TO_DATE('2017/05/01', 'yyyy/mm/dd'), TO_DATE('2018/05/01', 'yyyy/mm/dd'), 2000, 10000, 6);
INSERT INTO Project (ProjName, ClientName, ClientProjContactName, ProjType, ProjStatus, StartDate, EndDate, TotalHoursBudgeted, TotalDollarsBudgeted, ProjLeaderNum) VALUES ('Venus', 'Motorola Solutions', 'Julie Nelson', 'database', 'planning', TO_DATE('2017/04/01', 'yyyy/mm/dd'), TO_DATE('2019/10/01', 'yyyy/mm/dd'), 10000, 80000, 1);
INSERT INTO Project (ProjName, ClientName, ClientProjContactName, ProjType, ProjStatus, StartDate, EndDate, TotalHoursBudgeted, TotalDollarsBudgeted, ProjLeaderNum) VALUES ('Mars', 'Motorola Solutions', 'Sean Thibeau', 'support', 'in progress', TO_DATE('2017/01/01', 'yyyy/mm/dd'), TO_DATE('2018/01/01', 'yyyy/mm/dd'), 1500, 6000, 8);
INSERT INTO Project (ProjName, ClientName, ClientProjContactName, ProjType, ProjStatus, StartDate, EndDate, TotalHoursBudgeted, TotalDollarsBudgeted, ProjLeaderNum) VALUES ('Jupiter', 'Aon', 'Shawn Khan', 'reports', 'in progress', TO_DATE('2017/03/01', 'yyyy/mm/dd'), TO_DATE('2019/03/01', 'yyyy/mm/dd'), 5000, 15000, 5);
INSERT INTO Project (ProjName, ClientName, ClientProjContactName, ProjType, ProjStatus, StartDate, EndDate, TotalHoursBudgeted, TotalDollarsBudgeted, ProjLeaderNum) VALUES ('Saturn', 'Deloitte', 'Amanda Halton', 'maintenance', 'on hold', TO_DATE('2017/09/01', 'yyyy/mm/dd'), TO_DATE('2020/09/01', 'yyyy/mm/dd'), 3000, 12000, 6);
INSERT INTO Project (ProjName, ClientName, ClientProjContactName, ProjType, ProjStatus, StartDate, EndDate, TotalHoursBudgeted, TotalDollarsBudgeted, ProjLeaderNum) VALUES ('Uranus', 'Verizon Wireless', 'Bob Garcia', 'database', 'on hold', TO_DATE('2017/07/01', 'yyyy/mm/dd'), TO_DATE('2018/07/01', 'yyyy/mm/dd'), 6000, 30000, 1);
INSERT INTO Project (ProjName, ClientName, ClientProjContactName, ProjType, ProjStatus, StartDate, EndDate, TotalHoursBudgeted, TotalDollarsBudgeted, ProjLeaderNum) VALUES ('Neptune', 'Zurich North America', 'Sarah Douglas', 'support', 'completed', TO_DATE('2017/02/01', 'yyyy/mm/dd'), TO_DATE('2017/05/01', 'yyyy/mm/dd'), 500, 2000, 8);
INSERT INTO Project (ProjName, ClientName, ClientProjContactName, ProjType, ProjStatus, StartDate, EndDate, TotalHoursBudgeted, TotalDollarsBudgeted, ProjLeaderNum) VALUES ('Pluto', 'Zurich North America', 'Thomas Kurtz', 'reports', 'completed', TO_DATE('2017/01/01', 'yyyy/mm/dd'), TO_DATE('2017/07/01', 'yyyy/mm/dd'), 1000, 5000, 5);

DROP TABLE EmpProj CASCADE CONSTRAINTS;
CREATE TABLE EmpProj (
	CSEmpNum NUMBER NOT NULL,
	ProjNum NUMBER NOT NULL,
	PctTime NUMBER DEFAULT 0 NOT NULL,
	HrsToDate NUMBER DEFAULT 0 NOT NULL,
	CONSTRAINT PK_EmpProj PRIMARY KEY (CSEmpNum, ProjNum),
	CONSTRAINT FK_EmpProj_CSEmployee FOREIGN KEY (CSEmpNum) REFERENCES CSEmployee(CSEmpNum),
	CONSTRAINT FK_EmpProj_Project FOREIGN KEY (ProjNum) REFERENCES Project(ProjNum),
	CONSTRAINT CHK_PctTime CHECK (PctTime BETWEEN 0 AND 100),
	CONSTRAINT CHK_HrsToDate CHECK (HrsToDate >= 0)
);

INSERT INTO EmpProj (CSEmpNum, ProjNum, PctTime, HrsToDate) VALUES (1, 2, 20, 100);
INSERT INTO EmpProj (CSEmpNum, ProjNum, PctTime, HrsToDate) VALUES (1, 6, 40, 500);
INSERT INTO EmpProj (CSEmpNum, ProjNum, PctTime, HrsToDate) VALUES (5, 4, 50, 1000);
INSERT INTO EmpProj (CSEmpNum, ProjNum, PctTime, HrsToDate) VALUES (5, 8, 50, 200);
INSERT INTO EmpProj (CSEmpNum, ProjNum, PctTime, HrsToDate) VALUES (6, 1, 40, 400);
INSERT INTO EmpProj (CSEmpNum, ProjNum, PctTime, HrsToDate) VALUES (6, 6, 50, 800);
INSERT INTO EmpProj (CSEmpNum, ProjNum, PctTime, HrsToDate) VALUES (8, 3, 40, 600);
INSERT INTO EmpProj (CSEmpNum, ProjNum, PctTime, HrsToDate) VALUES (8, 7, 10, 80);
INSERT INTO EmpProj (CSEmpNum, ProjNum, PctTime, HrsToDate) VALUES (2, 1, 80, 700);
INSERT INTO EmpProj (CSEmpNum, ProjNum, PctTime, HrsToDate) VALUES (3, 2, 20, 300);
INSERT INTO EmpProj (CSEmpNum, ProjNum, PctTime, HrsToDate) VALUES (4, 5, 30, 500);
INSERT INTO EmpProj (CSEmpNum, ProjNum, PctTime, HrsToDate) VALUES (7, 8, 30, 600);

DROP TABLE Client CASCADE CONSTRAINTS;
CREATE TABLE Client (
	ClientNum NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL,
	ClientName NVARCHAR2(100) NOT NULL,
	ClientStreet NVARCHAR2(100) NOT NULL,
	ClientCity NVARCHAR2(30) NOT NULL,
	ClientState NCHAR(2) NOT NULL,
	ClientZip NVARCHAR2(9) NOT NULL,
	IsNewClient NUMBER DEFAULT 1 NOT NULL,
	ClientPhone NVARCHAR2(30) NOT NULL,
	CONSTRAINT PK_Client PRIMARY KEY (ClientNum),
	CONSTRAINT CHK_IsNewClient CHECK (IsNewClient BETWEEN 0 AND 1)
);

INSERT INTO Client (ClientName, ClientStreet, ClientCity, ClientState, ClientZip, IsNewClient, ClientPhone) VALUES ('Benefit Express', '1700 E Golf Rd #1000', 'Schaumburg', 'IL', '60173', 1, '15557548484');
INSERT INTO Client (ClientName, ClientStreet, ClientCity, ClientState, ClientZip, IsNewClient, ClientPhone) VALUES ('Zurich North America', '1299 Zurich Way', 'Schaumburg', 'IL', '60173', 0, '15554442222');
INSERT INTO Client (ClientName, ClientStreet, ClientCity, ClientState, ClientZip, IsNewClient, ClientPhone) VALUES ('Motorola Solutions', '500 W Monroe Street, Ste 4400', 'Chicago', 'IL', '60661', 0, '15554958555');
INSERT INTO Client (ClientName, ClientStreet, ClientCity, ClientState, ClientZip, IsNewClient, ClientPhone) VALUES ('Aon', '200 E Randolph St', 'Chicago', 'IL', '60601', 1, '15554848888');
INSERT INTO Client (ClientName, ClientStreet, ClientCity, ClientState, ClientZip, IsNewClient, ClientPhone) VALUES ('Deloitte', '111 S Wacker Dr', 'Chicago', 'IL', '60606', 0, '15554943333');
INSERT INTO Client (ClientName, ClientStreet, ClientCity, ClientState, ClientZip, IsNewClient, ClientPhone) VALUES ('Verizon Wireless', '1095 Avenue of the Americas', 'New York', 'NY', '10036', 0, '15558489999');

ALTER TABLE Project ADD (
	ClientNum NUMBER,
	ClientProjContactPhone NVARCHAR2(30),
	TotalDollarsPaid NUMBER,
	BillPaidDate DATE,
	CONSTRAINT FK_Project_Client FOREIGN KEY (ClientNum) REFERENCES Client(ClientNum)
);

UPDATE Project p SET ClientNum = (SELECT ClientNum FROM Client c WHERE p.ClientName = c.ClientName);

UPDATE Project SET ClientProjContactPhone = '15553398888' WHERE ClientProjContactName = 'Greg Myers';
UPDATE Project SET ClientProjContactPhone = '15553765544' WHERE ClientProjContactName = 'Sarah Douglas';
UPDATE Project SET ClientProjContactPhone = '15553038448' WHERE ClientProjContactName = 'Sean Thibeau';
UPDATE Project SET ClientProjContactPhone = '15553645343' WHERE ClientProjContactName = 'Shawn Khan';
UPDATE Project SET ClientProjContactPhone = '15553944621' WHERE ClientProjContactName = 'Amanda Halton';
UPDATE Project SET ClientProjContactPhone = '15552027463' WHERE ClientProjContactName = 'Bob Garcia';
UPDATE Project SET ClientProjContactPhone = '15554746839' WHERE ClientProjContactName = 'Thomas Kurtz';
UPDATE Project SET ClientProjContactPhone = '15554744432' WHERE ClientProjContactName = 'Julie Nelson';

UPDATE Project SET TotalDollarsPaid = 20000, BillPaidDate = TO_DATE('2017/08/15', 'yyyy/mm/dd') WHERE ProjNum = 7;
UPDATE Project SET TotalDollarsPaid = 50000, BillPaidDate = TO_DATE('2017/10/13', 'yyyy/mm/dd') WHERE ProjNum = 8;

ALTER TABLE Project MODIFY (
	ClientNum NOT NULL,
	ClientProjContactPhone NOT NULL
);

ALTER TABLE Project DROP COLUMN ClientName;

DROP VIEW ProjectsInProgress;
CREATE VIEW ProjectsInProgress AS 
	SELECT
		c.ClientNum AS "ClientID",
		c.ClientName AS "ClientName",
		c.ClientStreet || ', ' || c.ClientCity || ', ' || c.ClientState || ' ' || c.ClientZip AS "ClientAddress",
		p.ClientProjContactName AS "ContactPersonName",
		p.ClientProjContactPhone AS "ContactPersonPhoneNumber",
		p.ProjNum AS "ProjectID",
		p.ProjName AS "ProjectName",
		p.StartDate AS "StartDate",
		p.ProjType AS "ProjectType",
		p.ProjStatus AS "Status",
		e.CSEmpFirstName || ' ' || e.CSEmpLastName AS "ProjectLeaderName",
		g.CSGroupName AS "CSGroupName"
	FROM Client c
	JOIN Project p ON c.ClientNum = p.ClientNum
	JOIN CSEmployee e ON p.ProjLeaderNum = e.CSEmpNum
	JOIN CSGroup g ON e.CSGroupNum = g.CSGroupNum
	WHERE p.ProjStatus = 'in progress'
	ORDER BY c.ClientNum;

DROP VIEW ClientsWithOpenProjects;
CREATE VIEW ClientsWithOpenProjects AS
	SELECT
		c.ClientNum AS "ClientID",
		c.ClientName AS "ClientName",
		c.ClientStreet || ', ' || c.ClientCity || ', ' || c.ClientState || ' ' || c.ClientZip AS "ClientAddress",
		p.ProjNum AS "ProjectNumber",
		p.StartDate AS "ProjectStartDate",
		p.ClientProjContactName AS "ProjectContactName"
	FROM Client c
	JOIN Project p ON c.ClientNum = p.ClientNum
	WHERE p.ProjStatus <> 'completed';