CREATE DATABASE delivery_system_v2;
USE delivery_system_v2;


-- TABLES CREATION:


CREATE TABLE CUSTOMER_V2 (
customer_id INT PRIMARY KEY,
full_name VARCHAR(100),
email VARCHAR(100) UNIQUE,
phone VARCHAR(15),
city VARCHAR(50),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ZONE_V2 (
zone_id INT PRIMARY KEY,
zone_name VARCHAR(50),
city VARCHAR(50),
congestion_index INT
);

CREATE TABLE DRIVER_V2 (
driver_id INT PRIMARY KEY,
full_name VARCHAR(100),
phone VARCHAR(15),
status VARCHAR(20),
avg_rating DECIMAL(2,1),
is_available BOOLEAN
);

CREATE TABLE VEHICLE_V2 (
vehicle_id INT PRIMARY KEY,
plate_number VARCHAR(20),
vehicle_type VARCHAR(30),
capacity_kg DECIMAL(6,2),
status VARCHAR(20)
);

CREATE TABLE ORDER_V2 (
order_id INT PRIMARY KEY,
customer_id INT,
zone_id INT,
status VARCHAR(20),
priority VARCHAR(20),
weight_kg DECIMAL(6,2),
placed_at DATETIME,
FOREIGN KEY (customer_id) REFERENCES CUSTOMER_V2(customer_id),
FOREIGN KEY (zone_id) REFERENCES ZONE_V2(zone_id)
);

CREATE TABLE DELIVERY_V2 (
delivery_id INT PRIMARY KEY,
order_id INT UNIQUE,
driver_id INT,
vehicle_id INT,
zone_id INT,
pickup_time DATETIME,
estimated_time DATETIME,
delivered_time DATETIME,
delivery_status VARCHAR(20),
distance_km DECIMAL(6,2),
delay_reason VARCHAR(100),
FOREIGN KEY (order_id) REFERENCES ORDER_V2(order_id),
FOREIGN KEY (driver_id) REFERENCES DRIVER_V2(driver_id),
FOREIGN KEY (vehicle_id) REFERENCES VEHICLE_V2(vehicle_id),
FOREIGN KEY (zone_id) REFERENCES ZONE_V2(zone_id)
);

CREATE TABLE DELIVERY_LOG_V2 (
log_id INT PRIMARY KEY,
delivery_id INT,
status VARCHAR(20),
updated_at DATETIME,
FOREIGN KEY (delivery_id) REFERENCES DELIVERY_V2(delivery_id)
);

CREATE TABLE CUSTOMER_FEEDBACK_V2 (
feedback_id INT PRIMARY KEY,
order_id INT,
rating INT CHECK (rating BETWEEN 1 AND 5),
comments VARCHAR(255),
submitted_at DATETIME,
FOREIGN KEY (order_id) REFERENCES ORDER_V2(order_id)
);

-- DATA INSETION:

INSERT INTO CUSTOMER_V2 VALUES
(1,'Ali Khan','ali1@email.com','03000000001','Lahore',NOW()),
(2,'Sara Ahmed','sara2@email.com','03000000002','Karachi',NOW()),
(3,'Ahmed Raza','ahmed3@email.com','03000000003','Islamabad',NOW()),
(4,'Ayesha Malik','ayesha4@email.com','03000000004','Lahore',NOW()),
(5,'Usama Tariq','usama5@email.com','03000000005','Karachi',NOW()),
(6,'Noor Fatima','noor6@email.com','03000000006','Multan',NOW()),
(7,'Hamid Raza','hamid7@email.com','03000000007','Faisalabad',NOW()),
(8,'Sana Ahmed','sana8@email.com','03000000008','Lahore',NOW()),
(9,'Talha Khan','talha9@email.com','03000000009','Karachi',NOW()),
(10,'Anaya Noor','anaya10@email.com','03000000010','Islamabad',NOW()),
(11,'Rafay Ali','rafay11@email.com','03000000011','Lahore',NOW()),
(12,'Muneeb Sheikh','muneeb12@email.com','03000000012','Peshawar',NOW()),
(13,'Hira Salman','hira13@email.com','03000000013','Karachi',NOW()),
(14,'Fahad Malik','fahad14@email.com','03000000014','Lahore',NOW()),
(15,'Iqra Noor','iqra15@email.com','03000000015','Multan',NOW()),
(16,'Adeel Khan','adeel16@email.com','03000000016','Islamabad',NOW()),
(17,'Komal Tariq','komal17@email.com','03000000017','Karachi',NOW()),
(18,'Saif Ahmed','saif18@email.com','03000000018','Lahore',NOW()),
(19,'Zoya Malik','zoya19@email.com','03000000019','Faisalabad',NOW()),
(20,'Umer Farooq','umer20@email.com','03000000020','Karachi',NOW()),
(21,'Nimra Ali','nimra21@email.com','03000000021','Islamabad',NOW()),
(22,'Hashir Khan','hashir22@email.com','03000000022','Lahore',NOW()),
(23,'Maham Tariq','maham23@email.com','03000000023','Karachi',NOW()),
(24,'Basit Raza','basit24@email.com','03000000024','Multan',NOW()),
(25,'Hassan Ahmed','hassan25@email.com','03000000025','Lahore',NOW()),
(26,'Dua Noor','dua26@email.com','03000000026','Karachi',NOW()),
(27,'Jawad Ali','jawad27@email.com','03000000027','Islamabad',NOW()),
(28,'Sidra Khan','sidra28@email.com','03000000028','Peshawar',NOW()),
(29,'Sameer Malik','sameer29@email.com','03000000029','Lahore',NOW()),
(30,'Laiba Ahmed','laiba30@email.com','03000000030','Karachi',NOW()),
(31,'Arham Sheikh','arham31@email.com','03000000031','Islamabad',NOW()),
(32,'Fatima Noor','fatima32@email.com','03000000032','Lahore',NOW()),
(33,'Taha Malik','taha33@email.com','03000000033','Karachi',NOW()),
(34,'Maryam Ali','maryam34@email.com','03000000034','Multan',NOW()),
(35,'Danish Khan','danish35@email.com','03000000035','Lahore',NOW()),
(36,'Hoorain Ahmed','hoorain36@email.com','03000000036','Karachi',NOW()),
(37,'Abdullah Tariq','abdullah37@email.com','03000000037','Islamabad',NOW()),
(38,'Eshal Noor','eshal38@email.com','03000000038','Peshawar',NOW()),
(39,'Huzaifa Malik','huzaifa39@email.com','03000000039','Lahore',NOW()),
(40,'Mehwish Ali','mehwish40@email.com','03000000040','Karachi',NOW());



INSERT INTO DRIVER_V2 VALUES
(1,'Usman','03110000001','active',4.5,1),
(2,'Bilal','03110000002','active',4.2,1),
(3,'Hassan','03110000003','active',4.8,1),
(4,'Waqas','03110000004','active',4.1,1),
(5,'Asad','03110000005','active',4.3,1),
(6,'Rizwan','03110000006','active',4.7,1),
(7,'Haris','03110000007','active',4.0,1),
(8,'Junaid','03110000008','active',4.6,1),
(9,'Naeem','03110000009','active',4.4,1),
(10,'Salman','03110000010','active',4.5,1),
(11,'Khalid','03110000011','active',4.9,1),
(12,'Aamir','03110000012','active',4.2,1),
(13,'Adnan','03110000013','active',4.3,1),
(14,'Rehan','03110000014','active',4.1,1),
(15,'Yasir','03110000015','active',4.8,1);



INSERT INTO VEHICLE_V2 VALUES
(1,'ABC-101','Bike',50,'active'),
(2,'ABC-102','Van',200,'active'),
(3,'ABC-103','Car',100,'active'),
(4,'ABC-104','Bike',45,'active'),
(5,'ABC-105','Van',250,'active'),
(6,'ABC-106','Car',120,'active'),
(7,'ABC-107','Bike',55,'active'),
(8,'ABC-108','Van',230,'active'),
(9,'ABC-109','Car',110,'active'),
(10,'ABC-110','Bike',40,'active');



INSERT INTO ZONE_V2 VALUES
(1,'Zone A','Lahore',5),
(2,'Zone B','Karachi',7),
(3,'Zone C','Islamabad',8);


INSERT INTO ORDER_V2 VALUES
(1,1,1,'completed','high',10,'2026-05-08 10:00:00'),
(2,2,2,'completed','medium',8,'2026-05-08 10:30:00'),
(3,3,3,'completed','low',5,'2026-05-08 11:00:00'),
(4,4,1,'completed','high',12,'2026-05-08 11:30:00'),
(5,5,2,'completed','medium',9,'2026-05-08 12:00:00'),
(6,6,3,'completed','low',4,'2026-05-08 12:30:00'),
(7,7,1,'completed','high',15,'2026-05-08 13:00:00'),
(8,8,2,'completed','medium',7,'2026-05-08 13:30:00'),
(9,9,3,'completed','low',3,'2026-05-08 14:00:00'),
(10,10,1,'completed','high',11,'2026-05-08 14:30:00'),

(11,11,2,'completed','medium',6,'2026-05-08 15:00:00'),
(12,12,3,'completed','low',5,'2026-05-08 15:30:00'),
(13,13,1,'completed','high',14,'2026-05-08 16:00:00'),
(14,14,2,'completed','medium',8,'2026-05-08 16:30:00'),
(15,15,3,'completed','low',4,'2026-05-08 17:00:00'),
(16,16,1,'completed','high',16,'2026-05-08 17:30:00'),
(17,17,2,'completed','medium',9,'2026-05-08 18:00:00'),
(18,18,3,'completed','low',5,'2026-05-08 18:30:00'),
(19,19,1,'completed','high',13,'2026-05-08 19:00:00'),
(20,20,2,'completed','medium',7,'2026-05-08 19:30:00');
INSERT INTO ORDER_V2 VALUES
(21,21,3,'completed','high',15,'2026-05-08 20:00:00'),
(22,22,1,'completed','medium',7,'2026-05-08 20:30:00'),
(23,23,2,'completed','low',5,'2026-05-08 21:00:00'),
(24,24,3,'completed','high',13,'2026-05-08 21:30:00'),
(25,25,1,'completed','medium',9,'2026-05-08 22:00:00'),
(26,26,2,'completed','low',4,'2026-05-08 22:30:00'),
(27,27,3,'completed','high',16,'2026-05-08 23:00:00'),
(28,28,1,'completed','medium',8,'2026-05-08 23:30:00'),
(29,29,2,'completed','low',3,'2026-05-09 00:00:00'),
(30,30,3,'completed','high',12,'2026-05-09 00:30:00'),

(31,31,1,'completed','medium',7,'2026-05-09 01:00:00'),
(32,32,2,'completed','low',5,'2026-05-09 01:30:00'),
(33,33,3,'completed','high',14,'2026-05-09 02:00:00'),
(34,34,1,'completed','medium',9,'2026-05-09 02:30:00'),
(35,35,2,'completed','low',4,'2026-05-09 03:00:00'),
(36,36,3,'completed','high',17,'2026-05-09 03:30:00'),
(37,37,1,'completed','medium',8,'2026-05-09 04:00:00'),
(38,38,2,'completed','low',5,'2026-05-09 04:30:00'),
(39,39,3,'completed','high',13,'2026-05-09 05:00:00'),
(40,40,1,'completed','medium',6,'2026-05-09 05:30:00');



INSERT INTO DELIVERY_V2 VALUES
(1,1,1,1,1,'2026-05-08 10:10:00','2026-05-08 10:40:00','2026-05-08 10:55:00','delivered',5,'traffic'),
(2,2,2,2,2,'2026-05-08 10:40:00','2026-05-08 11:10:00','2026-05-08 11:05:00','delivered',4,''),
(3,3,3,3,3,'2026-05-08 11:10:00','2026-05-08 11:40:00','2026-05-08 11:55:00','delivered',6,'weather'),
(4,4,4,4,1,'2026-05-08 11:40:00','2026-05-08 12:10:00','2026-05-08 12:25:00','delivered',7,'traffic'),
(5,5,5,5,2,'2026-05-08 12:10:00','2026-05-08 12:40:00','2026-05-08 12:35:00','delivered',4,''),
(6,6,6,6,3,'2026-05-08 12:40:00','2026-05-08 13:10:00','2026-05-08 13:20:00','delivered',8,'heavy traffic'),
(7,7,7,7,1,'2026-05-08 13:10:00','2026-05-08 13:40:00','2026-05-08 13:55:00','delivered',6,'traffic'),
(8,8,8,8,2,'2026-05-08 13:40:00','2026-05-08 14:10:00','2026-05-08 14:05:00','delivered',3,''),
(9,9,9,9,3,'2026-05-08 14:10:00','2026-05-08 14:40:00','2026-05-08 14:55:00','delivered',7,'weather'),
(10,10,10,10,1,'2026-05-08 14:40:00','2026-05-08 15:10:00','2026-05-08 15:25:00','delivered',5,'traffic'),

(11,11,11,1,2,'2026-05-08 15:10:00','2026-05-08 15:40:00','2026-05-08 15:35:00','delivered',4,''),
(12,12,12,2,3,'2026-05-08 15:40:00','2026-05-08 16:10:00','2026-05-08 16:25:00','delivered',8,'heavy traffic'),
(13,13,13,3,1,'2026-05-08 16:10:00','2026-05-08 16:40:00','2026-05-08 16:55:00','delivered',6,'traffic'),
(14,14,14,4,2,'2026-05-08 16:40:00','2026-05-08 17:10:00','2026-05-08 17:05:00','delivered',3,''),
(15,15,15,5,3,'2026-05-08 17:10:00','2026-05-08 17:40:00','2026-05-08 17:55:00','delivered',7,'weather'),
(16,16,1,6,1,'2026-05-08 17:40:00','2026-05-08 18:10:00','2026-05-08 18:25:00','delivered',9,'traffic'),
(17,17,2,7,2,'2026-05-08 18:10:00','2026-05-08 18:40:00','2026-05-08 18:35:00','delivered',4,''),
(18,18,3,8,3,'2026-05-08 18:40:00','2026-05-08 19:10:00','2026-05-08 19:25:00','delivered',8,'heavy traffic'),
(19,19,4,9,1,'2026-05-08 19:10:00','2026-05-08 19:40:00','2026-05-08 19:55:00','delivered',6,'traffic'),
(20,20,5,10,2,'2026-05-08 19:40:00','2026-05-08 20:10:00','2026-05-08 20:05:00','delivered',3,''),

(21,21,6,1,3,'2026-05-08 20:10:00','2026-05-08 20:40:00','2026-05-08 20:55:00','delivered',7,'weather'),
(22,22,7,2,1,'2026-05-08 20:40:00','2026-05-08 21:10:00','2026-05-08 21:25:00','delivered',8,'traffic'),
(23,23,8,3,2,'2026-05-08 21:10:00','2026-05-08 21:40:00','2026-05-08 21:35:00','delivered',4,''),
(24,24,9,4,3,'2026-05-08 21:40:00','2026-05-08 22:10:00','2026-05-08 22:25:00','delivered',9,'heavy traffic'),
(25,25,10,5,1,'2026-05-08 22:10:00','2026-05-08 22:40:00','2026-05-08 22:55:00','delivered',6,'traffic'),
(26,26,11,6,2,'2026-05-08 22:40:00','2026-05-08 23:10:00','2026-05-08 23:05:00','delivered',3,''),
(27,27,12,7,3,'2026-05-08 23:10:00','2026-05-08 23:40:00','2026-05-08 23:55:00','delivered',7,'weather'),
(28,28,13,8,1,'2026-05-08 23:40:00','2026-05-09 00:10:00','2026-05-09 00:25:00','delivered',8,'traffic'),
(29,29,14,9,2,'2026-05-09 00:10:00','2026-05-09 00:40:00','2026-05-09 00:35:00','delivered',4,''),
(30,30,15,10,3,'2026-05-09 00:40:00','2026-05-09 01:10:00','2026-05-09 01:25:00','delivered',9,'heavy traffic'),

(31,31,1,1,1,'2026-05-09 01:10:00','2026-05-09 01:40:00','2026-05-09 01:55:00','delivered',5,'traffic'),
(32,32,2,2,2,'2026-05-09 01:40:00','2026-05-09 02:10:00','2026-05-09 02:05:00','delivered',3,''),
(33,33,3,3,3,'2026-05-09 02:10:00','2026-05-09 02:40:00','2026-05-09 02:55:00','delivered',7,'weather'),
(34,34,4,4,1,'2026-05-09 02:40:00','2026-05-09 03:10:00','2026-05-09 03:25:00','delivered',8,'traffic'),
(35,35,5,5,2,'2026-05-09 03:10:00','2026-05-09 03:40:00','2026-05-09 03:35:00','delivered',4,''),
(36,36,6,6,3,'2026-05-09 03:40:00','2026-05-09 04:10:00','2026-05-09 04:25:00','delivered',9,'heavy traffic'),
(37,37,7,7,1,'2026-05-09 04:10:00','2026-05-09 04:40:00','2026-05-09 04:55:00','delivered',6,'traffic'),
(38,38,8,8,2,'2026-05-09 04:40:00','2026-05-09 05:10:00','2026-05-09 05:05:00','delivered',3,''),
(39,39,9,9,3,'2026-05-09 05:10:00','2026-05-09 05:40:00','2026-05-09 05:55:00','delivered',7,'weather'),
(40,40,10,10,1,'2026-05-09 05:40:00','2026-05-09 06:10:00','2026-05-09 06:25:00','delivered',8,'traffic');


INSERT INTO DELIVERY_LOG_V2 VALUES
(1,1,'picked','2026-05-08 10:15:00'),
(2,1,'on the way','2026-05-08 10:30:00'),
(3,1,'delivered','2026-05-08 10:55:00'),

(4,2,'picked','2026-05-08 10:45:00'),
(5,2,'delivered','2026-05-08 11:05:00'),

(6,3,'picked','2026-05-08 11:15:00'),
(7,3,'on the way','2026-05-08 11:30:00'),
(8,3,'delivered','2026-05-08 11:55:00'),

(9,4,'picked','2026-05-08 11:45:00'),
(10,4,'delivered','2026-05-08 12:25:00'),

(11,5,'picked','2026-05-08 12:15:00'),
(12,5,'delivered','2026-05-08 12:35:00'),

(13,6,'picked','2026-05-08 12:45:00'),
(14,6,'on the way','2026-05-08 13:00:00'),
(15,6,'delivered','2026-05-08 13:20:00'),

(16,7,'picked','2026-05-08 13:15:00'),
(17,7,'delivered','2026-05-08 13:55:00'),

(18,8,'picked','2026-05-08 13:45:00'),
(19,8,'delivered','2026-05-08 14:05:00'),

(20,9,'picked','2026-05-08 14:15:00'),
(21,9,'on the way','2026-05-08 14:30:00'),
(22,9,'delivered','2026-05-08 14:55:00'),

(23,10,'picked','2026-05-08 14:45:00'),
(24,10,'delivered','2026-05-08 15:25:00');

-- FUNCTIONS:

DROP FUNCTION IF EXISTS get_driver_total_v2;
DROP FUNCTION IF EXISTS get_delay_minutes_v2;

DELIMITER $$

CREATE FUNCTION get_driver_total_v2(did INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT COUNT(*)
    INTO total
    FROM DELIVERY_V2
    WHERE driver_id = did;

    RETURN total;
END $$

CREATE FUNCTION get_delay_minutes_v2(did INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE delay_time INT;

    SELECT TIMESTAMPDIFF(MINUTE, estimated_time, delivered_time)
    INTO delay_time
    FROM DELIVERY_V2
    WHERE delivery_id = did;

    RETURN delay_time;
END $$

DELIMITER ;


SHOW FUNCTION STATUS
WHERE Db = 'delivery_system_v2';

SHOW CREATE FUNCTION get_driver_total_v2;


SELECT 
    ROUTINE_NAME,
    ROUTINE_DEFINITION,
    CREATED,
    LAST_ALTERED
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA = 'delivery_system_v2'
AND ROUTINE_TYPE = 'FUNCTION';


SELECT ROUTINE_NAME, ROUTINE_DEFINITION
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA = 'delivery_system_v2'
AND ROUTINE_TYPE = 'FUNCTION';

-- VIEWSS:


DROP VIEW IF EXISTS DelayedOrders_V2;
DROP VIEW IF EXISTS DriverPerformance_V2;
DROP VIEW IF EXISTS RiskyDeliveries_V2;

CREATE VIEW DelayedOrders_V2 AS
SELECT *
FROM DELIVERY_V2
WHERE delivered_time > estimated_time;

CREATE VIEW DriverPerformance_V2 AS
SELECT
driver_id,
COUNT(*) AS total_deliveries,
AVG(TIMESTAMPDIFF(MINUTE, pickup_time, delivered_time)) AS avg_time
FROM DELIVERY_V2
GROUP BY driver_id;

CREATE VIEW RiskyDeliveries_V2 AS
SELECT
d.delivery_id,
d.driver_id,
d.zone_id,
d.distance_km,
z.congestion_index,
dp.avg_time,
CASE
    WHEN z.congestion_index > 6
      OR dp.avg_time > 30
      OR d.distance_km > 6
    THEN 'High Risk'
    ELSE 'Normal'
END AS risk_level
FROM DELIVERY_V2 d
JOIN ZONE_V2 z ON d.zone_id = z.zone_id
JOIN DriverPerformance_V2 dp
ON d.driver_id = dp.driver_id;

-- view them: 
SHOW FULL TABLES 
WHERE Table_type = 'VIEW';

-- single??
SHOW CREATE VIEW RiskyDeliveries_V2;

-- INDEX : 
-- INDEXES
----------------------------------------------------

CREATE INDEX idx_driver_v2
ON DELIVERY_V2(driver_id);

CREATE INDEX idx_zone_v2
ON DELIVERY_V2(zone_id);

SHOW INDEX FROM DELIVERY_V2;


SHOW INDEX FROM ZONE_V2;


-- FUNCTION USAGE QUERIES



-- Purpose: calculate delay per delivery using custom function
SELECT 
    delivery_id, 
    get_delay_minutes_v2(delivery_id) AS delay_minutes
FROM DELIVERY_V2;



-- Purpose: count total deliveries handled by each driver
SELECT 
    driver_id, 
    get_driver_total_v2(driver_id) AS total_deliveries
FROM DRIVER_V2;


-- ZONE ANALYSIS


-- joiN we used: inner
-- Purpose: match each delivery with its zone
-- Logic: zone_id is foreign key in DELIVERY_V2 that refernce ZONE_V2
SELECT 
    z.zone_name, 
    COUNT(*) AS delayed_orders
FROM DELIVERY_V2 d
INNER JOIN ZONE_V2 z
    ON d.zone_id = z.zone_id
WHERE d.delivered_time > d.estimated_time
GROUP BY z.zone_name;


-- PEAK ORDERING TIME ANALYSIS??



-- Purpose: find busiest order hours of the day
SELECT 
    HOUR(placed_at) AS hour, 
    COUNT(*) AS total_orders
FROM ORDER_V2
GROUP BY HOUR(placed_at);
