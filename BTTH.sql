DROP VIEW IF EXISTS ER_Dashboard_View;
DROP TABLE IF EXISTS Vitals_Logs;
DROP TABLE IF EXISTS Patients;

CREATE TABLE Patients (
    Patient_ID CHAR(5) PRIMARY KEY,
    Full_Name VARCHAR(100) NOT NULL,
    Admission_Time DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Vitals_Logs (
    Log_ID INT AUTO_INCREMENT PRIMARY KEY,
    Patient_ID CHAR(5),
    Heart_Rate INT CHECK (Heart_Rate > 0),
    Blood_Pressure VARCHAR(20),
    Record_Time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID)
);

CREATE INDEX idx_patient_record ON Vitals_Logs(Patient_ID, Record_Time);

INSERT INTO Patients (Patient_ID, Full_Name) VALUES 
('BN001', 'Nguyen Van A'),
('BN002', 'Le Thi B'),
('BN003', 'Tran Van C');

INSERT INTO Vitals_Logs (Patient_ID, Heart_Rate, Blood_Pressure) VALUES 
('BN001', 75, '120/80'),
('BN001', 130, '140/90'),
('BN002', 45, '90/60');

CREATE VIEW ER_Dashboard_View AS
SELECT p.Patient_ID,p.Full_Name, COALESCE(CAST(v.Heart_Rate AS CHAR), 'Pending') AS Latest_Heart_Rate, COALESCE(v.Blood_Pressure, 'N/A') AS Blood_Pressure,
    CASE 
        WHEN v.Heart_Rate > 120 OR v.Heart_Rate < 50 THEN 'CRITICAL'
        WHEN v.Heart_Rate IS NULL THEN 'Pending'
        ELSE 'STABLE'
    END AS Urgency_Level
FROM Patients AS p
LEFT JOIN Vitals_Logs AS v 
ON p.Patient_ID = v.Patient_ID 
AND v.Record_Time = (
	SELECT MAX(Record_Time) FROM Vitals_Logs WHERE Patient_ID = p.Patient_ID
);

SELECT * FROM ER_Dashboard_View;
INSERT INTO ER_Dashboard_View (Patient_ID, Full_Name) VALUES ('BN004', 'Loi He Thong');
UPDATE ER_Dashboard_View 
SET Urgency_Level = 'STABLE' 
WHERE Patient_ID = 'BN001';