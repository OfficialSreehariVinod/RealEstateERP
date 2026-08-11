REM =======================================================
REM HR Module - Create Tables, Constraints, and Triggers
REM =======================================================

PROMPT Creating DEPARTMENTS table...
CREATE TABLE departments (
    dept_id NUMBER PRIMARY KEY, 
    dept_code VARCHAR2(20) NOT NULL UNIQUE, 
    dept_name VARCHAR2(100) NOT NULL, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_by VARCHAR2(100), 
    approved_by VARCHAR2(100)
);

PROMPT Creating EMPLOYEE_MASTER table...
CREATE TABLE employee_master (
    emp_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    first_name VARCHAR2(50) NOT NULL, 
    last_name VARCHAR2(50) NOT NULL, 
    work_email VARCHAR2(100) NOT NULL UNIQUE, 
    current_dept_id NUMBER, 
    hire_date DATE NOT NULL, 
    status VARCHAR2(20) DEFAULT 'Active', 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_by VARCHAR2(100), 
    approved_by VARCHAR2(100),
    CONSTRAINT fk_emp_department FOREIGN KEY (current_dept_id) REFERENCES departments(dept_id)
);

PROMPT Creating EMP_PERSONAL_INFO table...
CREATE TABLE emp_personal_info (
    info_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    emp_id NUMBER NOT NULL UNIQUE, 
    home_address VARCHAR2(255), 
    personal_phone VARCHAR2(20), 
    emergency_contact_name VARCHAR2(100), 
    emergency_phone VARCHAR2(20), 
    blood_group VARCHAR2(5), 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_by VARCHAR2(100), 
    approved_by VARCHAR2(100),
    CONSTRAINT fk_personal_emp FOREIGN KEY (emp_id) REFERENCES employee_master(emp_id) ON DELETE CASCADE
);

PROMPT Creating EMP_SALARY_SETTINGS table...
CREATE TABLE emp_salary_settings (
    payroll_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    emp_id NUMBER NOT NULL UNIQUE, 
    base_salary NUMBER(15,2) NOT NULL, 
    bank_name VARCHAR2(100), 
    account_number VARCHAR2(50), 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_by VARCHAR2(100), 
    approved_by VARCHAR2(100),
    CONSTRAINT fk_payroll_emp FOREIGN KEY (emp_id) REFERENCES employee_master(emp_id) ON DELETE CASCADE
);

PROMPT Creating EMP_DOCUMENTS table...
CREATE TABLE emp_documents (
    doc_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    emp_id NUMBER NOT NULL, 
    doc_type VARCHAR2(50) NOT NULL, 
    doc_no VARCHAR2(100) NOT NULL, 
    issue_date DATE NOT NULL, 
    expiry_date DATE NOT NULL, 
    status VARCHAR2(20) DEFAULT 'active', 
    remarks VARCHAR2(500), 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    created_by VARCHAR2(100),
    CONSTRAINT fk_emp_master FOREIGN KEY (emp_id) REFERENCES employee_master(emp_id)
);

PROMPT Creating HR Audit Triggers...
CREATE OR REPLACE TRIGGER trg_departments_updated_at 
BEFORE UPDATE ON departments FOR EACH ROW
BEGIN
    :NEW.updated_at := CURRENT_TIMESTAMP;
    :NEW.updated_by := USER;
END;
/

CREATE OR REPLACE TRIGGER trg_employee_master_updated_at 
BEFORE UPDATE ON employee_master FOR EACH ROW
BEGIN
    :NEW.updated_at := CURRENT_TIMESTAMP;
    :NEW.updated_by := USER;
END;
/

CREATE OR REPLACE TRIGGER trg_emp_personal_updated_at 
BEFORE UPDATE ON emp_personal_info FOR EACH ROW
BEGIN
    :NEW.updated_at := CURRENT_TIMESTAMP;
    :NEW.updated_by := USER;
END;
/

CREATE OR REPLACE TRIGGER trg_emp_salary_settings_updated 
BEFORE UPDATE ON emp_salary_settings FOR EACH ROW
BEGIN
    :NEW.updated_at := CURRENT_TIMESTAMP;
    :NEW.updated_by := USER;
END;
/

CREATE OR REPLACE TRIGGER trg_emp_docs_insert 
BEFORE INSERT ON emp_documents FOR EACH ROW
BEGIN
    :NEW.created_by := USER; 
END;
/
