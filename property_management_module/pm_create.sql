REM =======================================================
REM Property Management Module - Create Tables & Triggers
REM =======================================================

PROMPT Creating RE_BUILDINGS table...
CREATE TABLE re_buildings (
    building_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    building_name VARCHAR2(100) NOT NULL, 
    address VARCHAR2(255) NOT NULL, 
    total_floors NUMBER, 
    facilities_available VARCHAR2(200), 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_by VARCHAR2(100), 
    approved_by VARCHAR2(100)
);

PROMPT Creating RE_CLIENTS table...
CREATE TABLE re_clients (
    client_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    first_name VARCHAR2(50) NOT NULL, 
    last_name VARCHAR2(50) NOT NULL, 
    email VARCHAR2(100) UNIQUE, 
    phone VARCHAR2(20), 
    client_type VARCHAR2(30) DEFAULT 'Tenant', 
    status VARCHAR2(20) DEFAULT 'Active', 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_by VARCHAR2(100), 
    approved_by VARCHAR2(100)
);

PROMPT Creating RE_UNITS table...
CREATE TABLE re_units (
    unit_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    building_id NUMBER NOT NULL, 
    unit_number VARCHAR2(20) NOT NULL, 
    unit_type VARCHAR2(50), 
    square_footage NUMBER, 
    monthly_rent_rate NUMBER(10,2), 
    current_status VARCHAR2(30) DEFAULT 'Available', 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_by VARCHAR2(100), 
    approved_by VARCHAR2(100),
    CONSTRAINT fk_unit_building FOREIGN KEY (building_id) REFERENCES re_buildings(building_id)
);

PROMPT Creating RE_LEASES (Master Header) table...
CREATE TABLE re_leases (
    lease_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    client_id NUMBER NOT NULL, 
    start_date DATE NOT NULL, 
    end_date DATE NOT NULL, 
    total_rent NUMBER(10,2) NOT NULL, 
    security_deposit NUMBER(10,2), 
    status VARCHAR2(20) DEFAULT 'Active', 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_by VARCHAR2(100),
    CONSTRAINT fk_lease_client FOREIGN KEY (client_id) REFERENCES re_clients(client_id)
);

PROMPT Creating RE_LEASE_UNITS (Detail Lines) table...
CREATE TABLE re_lease_units (
    lease_unit_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    lease_id NUMBER NOT NULL, 
    unit_id NUMBER NOT NULL, 
    allocated_rent NUMBER(10,2) NOT NULL, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_by VARCHAR2(100),
    CONSTRAINT fk_lu_lease_header FOREIGN KEY (lease_id) REFERENCES re_leases(lease_id) ON DELETE CASCADE,
    CONSTRAINT fk_lu_unit FOREIGN KEY (unit_id) REFERENCES re_units(unit_id)
);

PROMPT Creating Property Management Audit Triggers...
CREATE OR REPLACE TRIGGER trg_re_buildings_updated
BEFORE UPDATE ON re_buildings FOR EACH ROW
BEGIN
    :NEW.updated_at := CURRENT_TIMESTAMP;
    :NEW.updated_by := USER;
END;
/

CREATE OR REPLACE TRIGGER trg_re_clients_updated_at
BEFORE UPDATE ON re_clients FOR EACH ROW
BEGIN
    :NEW.updated_at := CURRENT_TIMESTAMP;
    :NEW.updated_by := USER;
END;
/

CREATE OR REPLACE TRIGGER trg_re_units_updated
BEFORE UPDATE ON re_units FOR EACH ROW
BEGIN
    :NEW.updated_at := CURRENT_TIMESTAMP;
    :NEW.updated_by := USER;
END;
/
