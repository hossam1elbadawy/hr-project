Are highly educated employees less affected by overtime in their performance?
Step 1: Identify Highly Educated Employees
SELECT 
    EmployeeID, 
    CASE 
        WHEN EducationLevel >= 3 THEN 'Highly Educated'
        ELSE 'Less Educated'
    END AS EducationCategory
FROM 
    Employees;
	Step 2: Calculate Average Overtime and Performance
	-- Overtime calculation
SELECT 
    e.EmployeeID,
    CASE 
        WHEN e.EducationLevel >= 3 THEN 'Highly Educated'
        ELSE 'Less Educated'
    END AS EducationCategory,
    AVG(o.OvertimeHours) AS AvgOvertime,
    AVG(p.PerformanceScore) AS AvgPerformance
FROM 
    Employees e
JOIN 
    Overtime o ON e.EmployeeID = o.EmployeeID
JOIN 
    Performance p ON e.EmployeeID = p.EmployeeID
GROUP BY 
    e.EmployeeID, EducationCategory;
	Step 3: Compare Performance Impact by Overtime and Education
	-- Grouped analysis of education level, overtime, and performance
WITH EmployeePerformance AS (
    SELECT 
        e.EmployeeID,
        CASE 
            WHEN e.EducationLevel >= 3 THEN 'Highly Educated'
            ELSE 'Less Educated'
        END AS EducationCategory,
        AVG(o.OvertimeHours) AS AvgOvertime,
        AVG(p.PerformanceScore) AS AvgPerformance
    FROM 
        Employees e
    JOIN 
        Overtime o ON e.EmployeeID = o.EmployeeID
    JOIN 
        Performance p ON e.EmployeeID = p.EmployeeID
    GROUP BY 
        e.EmployeeID, EducationCategory
)
SELECT 
    EducationCategory,
    AVG(AvgOvertime) AS OverallAvgOvertime,
    AVG(AvgPerformance) AS OverallAvgPerformance
FROM 
    EmployeePerformance
GROUP BY 
    EducationCategory;
		 	   	  
	: Are managers more or less affected by overtime compared to non-managers?
	Step 1: Categorize Employees as Managers or Non-Managers
SELECT 
    EmployeeID,
    CASE 
        WHEN JobTitle LIKE '%Manager%' OR JobTitle LIKE '%Supervisor%' THEN 'Manager'
        ELSE 'Non-Manager'
    END AS RoleCategory
FROM 
    Employees;
	Step 2: Calculate Overtime and Performance for Managers and Non-Managers
WITH EmployeeRole AS (
    SELECT 
        e.EmployeeID,
        CASE 
            WHEN e.JobTitle LIKE '%Manager%' OR e.JobTitle LIKE '%Supervisor%' THEN 'Manager'
            ELSE 'Non-Manager'
        END AS RoleCategory
    FROM 
        Employees e
)
-- Calculating the average overtime and performance for managers vs non-managers
SELECT 
    er.RoleCategory,
    AVG(o.OvertimeHours) AS AvgOvertime,
    AVG(p.PerformanceScore) AS AvgPerformance
FROM 
    EmployeeRole er
JOIN 
    Overtime o ON er.EmployeeID = o.EmployeeID
JOIN 
    Performance p ON er.EmployeeID = p.EmployeeID
GROUP BY 
    er.RoleCategory;
How does salary influence how overtime affects employee performance?
Step 1: Categorize Employees by Salary Range
WITH EmployeeSalary AS (
    SELECT 
        e.EmployeeID,
        e.Salary,
        CASE 
            WHEN e.Salary < 50000 THEN 'Low Salary'
            WHEN e.Salary BETWEEN 50000 AND 100000 THEN 'Medium Salary'
            ELSE 'High Salary'
        END AS SalaryCategory
    FROM 
        Employees e
)
Step 2: Calculate Overtime and Performance by Salary Group
WITH EmployeeSalary AS (
    SELECT 
        e.EmployeeID,
        e.Salary,
        CASE 
            WHEN e.Salary < 50000 THEN 'Low Salary'
            WHEN e.Salary BETWEEN 50000 AND 100000 THEN 'Medium Salary'
            ELSE 'High Salary'
        END AS SalaryCategory
    FROM 
        Employees e
)
-- Calculating the average overtime and performance for each salary group
SELECT 
    es.SalaryCategory,
    AVG(o.OvertimeHours) AS AvgOvertime,
    AVG(p.PerformanceScore) AS AvgPerformance
FROM 
    EmployeeSalary es
JOIN 
    Overtime o ON es.EmployeeID = o.EmployeeID
JOIN 
    Performance p ON es.EmployeeID = p.EmployeeID
GROUP BY 
    es.SalaryCategory;
Do employees with higher overtime hours also have lower job satisfaction ratings?
Step 1: Calculate the Average Overtime and Job Satisfaction
-- Grouping employees by overtime hours and calculating their average job satisfaction
SELECT 
    CASE 
        WHEN o.OvertimeHours < 10 THEN 'Low Overtime'
        WHEN o.OvertimeHours BETWEEN 10 AND 20 THEN 'Medium Overtime'
        ELSE 'High Overtime'
    END AS OvertimeCategory,
    AVG(o.OvertimeHours) AS AvgOvertimeHours,
    AVG(js.SatisfactionRating) AS AvgSatisfactionRating
FROM 
    Overtime o
JOIN 
    JobSatisfaction js ON o.EmployeeID = js.EmployeeID
GROUP BY 
    OvertimeCategory;

