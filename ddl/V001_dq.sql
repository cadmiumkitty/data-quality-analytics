-- Use 0 ids for Unknown values

SET SESSION sql_mode='NO_AUTO_VALUE_ON_ZERO';

-- Create Roles hierarchy

CREATE TABLE dim_concept_role (
    id INT AUTO_INCREMENT PRIMARY KEY,
    label_l1 VARCHAR(255)
);

-- Create Parties hierarchy

CREATE TABLE dim_concept_party (
    id INT AUTO_INCREMENT PRIMARY KEY,
    label_l1 VARCHAR(255)
);

-- Create Address Purpose hierarchy

CREATE TABLE dim_concept_address_purpose (
    id INT AUTO_INCREMENT PRIMARY KEY,
    label_l1 VARCHAR(255)
);

-- Create Places hierarchy

CREATE TABLE dim_concept_place (
    id INT AUTO_INCREMENT PRIMARY KEY,
    label_l1 VARCHAR(255)
);

-- Create Systems hierarchy

CREATE TABLE dim_container_system (
    id INT AUTO_INCREMENT PRIMARY KEY,
    label_l1 VARCHAR(255)
);

-- Create Relational hierarchy

CREATE TABLE dim_container_relational (
    id INT AUTO_INCREMENT PRIMARY KEY,
    relational_instance VARCHAR(255),
    relational_schema VARCHAR(255),
    relational_table VARCHAR(255),
    relational_column VARCHAR(255)
);

-- Create XML hierarchy

CREATE TABLE dim_container_xml (
    id INT AUTO_INCREMENT PRIMARY KEY,
    xml_xpath VARCHAR(255)
);

-- Create Date dimension table to allow for date aggregation of quality snapshots

CREATE TABLE dim_date (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date_date DATE,
    date_day VARCHAR(2),
    date_month VARCHAR(9),
    date_year VARCHAR(4),
    date_financial_year VARCHAR(2),
    date_financial_year_quarter VARCHAR(2)
);

-- Create Consistency fact table

CREATE TABLE fact_measurement_consistency (
    id INT AUTO_INCREMENT PRIMARY KEY,
    measurement FLOAT,
    date_id INT REFERENCES dim_date(id),
    concept_role_id INT REFERENCES dim_concept_role(id),
    concept_party_id INT REFERENCES dim_concept_party(id),
    concept_address_purpose_id INT REFERENCES dim_concept_address_purpose(id),
    concept_place_id INT REFERENCES dim_concept_place(id),
    container_system_id INT REFERENCES dim_container_system(id),
    container_relational_id INT REFERENCES dim_container_relational(id),
    container_xml_id INT REFERENCES dim_container_xml(id)
);

-- Populate Roles hierarchy

INSERT INTO dim_concept_role (id, label_l1)
VALUES
(0, 'Unknown'),
(1, 'Customer'),
(2, 'Supplier'),
(3, 'Employee');

-- Populate Parties hierarchy

INSERT INTO dim_concept_party (id, label_l1)
VALUES
(0, 'Unknown'),
(1, 'Individual'),
(2, 'Legal Entity');

-- Populate Address Purpose hierarchy

INSERT INTO dim_concept_address_purpose (id, label_l1)
VALUES
(0, 'Unknown'),
(1, 'Residential'),
(2, 'Collateral');

-- Populate Places hierarchy

INSERT INTO dim_concept_place (id, label_l1)
VALUES
(0, 'Unknown'),
(1, 'Country'),
(2, 'State'),3
(3, 'Address'),
(4, 'Postal Code');

-- Populate Systems hierarchy

INSERT INTO dim_container_system (id, label_l1)
VALUES
(0, 'Unknown'),
(1, 'Lending'),
(2, 'Core Banking'),
(3, 'Customer Comms'),
(4, 'Data Warehouse'),
(5, 'Regulatory Reporting');

-- Populate Relational hierarchy

INSERT INTO dim_container_relational (id, relational_instance, relational_schema, relational_table, relational_column)
VALUES
(0, 'Unknown', 'Unknown', 'Unknown', 'Unknown');

INSERT INTO dim_container_xml (id, xml_xpath)
VALUES
(0, 'Unknown');

-- Populate Dates dimension

INSERT INTO dim_date (id, date_date, date_day, date_month, date_year, date_quarter, date_financial_year)
VALUES
(1, DATE('2023-02-03'), '03', 'February', '2023', '2022/2023', 'Q3'),
(2, DATE('2023-03-03'), '03', 'March', '2023', '2022/2023', 'Q3'),
(3, DATE('2023-04-03'), '03', 'April', '2023', '2022/2023', 'Q4'),
(4, DATE('2023-05-03'), '03', 'May', '2023', '2022/2023', 'Q4'),
(5, DATE('2023-06-03'), '03', 'June', '2023', '2022/2023', 'Q4'),
(6, DATE('2023-07-03'), '03', 'July', '2023', '2023/2024', 'Q1'),
(7, DATE('2023-08-03'), '03', 'August', '2023', '2023/2024', 'Q1'),
(8, DATE('2023-09-03'), '03', 'September', '2023', '2023/2024', 'Q1'),
(9, DATE('2023-10-03'), '03', 'October', '2023', '2023/2024', 'Q2'),
(10, DATE('2023-11-03'), '03', 'November', '2023', '2023/2024', 'Q2'),
(11, DATE('2023-12-03'), '03', 'December', '2023', '2023/2024', 'Q2'),
(12, DATE('2024-01-03'), '03', 'January', '2024', '2023/2024', 'Q3');