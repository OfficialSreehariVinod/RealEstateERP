# Real Estate Enterprise Resource Planning (ERP) System

## 🏢 Project Overview
This repository contains the backend database architecture for a highly normalized, enterprise-grade Real Estate Property Management ERP. Built entirely from scratch using **Oracle Database 21c**, this project demonstrates the translation of real-world business rules into strict relational database mechanics.

## 🚀 Module Deployment Standards
The system is divided into three core operational streams. Each module is self-contained and follows the official Oracle Sample Schemas installation structure (`_main.sql`, `_cre.sql`, `_popul.sql`, `_drop.sql`). 

Navigate to the respective module folders for full attribute schemas and installation instructions:
1. **[Property Management Module](./property_management_module/)**: The operational stream managing buildings, multi-unit lease agreements, and tenant tracking.
2. **[Human Resources (HR) Module](./hr_module/)**: The organizational Hub managing departments, secure payroll data, and employee compliance.
3. **[Finance Module](./finance_module/)**: The accounting pool that tracks invoices, applies cash receipts, and maps revenue to the General Ledger Chart of Accounts.

---

## 🗺️ Master Enterprise Architecture
The system utilizes a "Streams and Pools" methodology. Operational data (like newly signed leases) acts as a stream that automatically flows into the Finance General Ledger pool via PL/SQL Stored Procedures.

*(Note: The diagram below highlights the core cross-module architecture. For full attribute details, click into the specific module folders above).*

```mermaid
---
config:
  theme: redux-dark
---
erDiagram
    %% ==========================================
    %% HR MODULE (The Hub)
    %% ==========================================
    DEPARTMENTS ||--o{ EMPLOYEE_MASTER : "employs"
    EMPLOYEE_MASTER ||--o| EMP_PERSONAL_INFO : "has personal profile"
    EMPLOYEE_MASTER ||--o| EMP_SALARY_SETTINGS : "has financial profile"
    EMPLOYEE_MASTER ||--o{ EMP_DOCUMENTS : "holds"

    %% ==========================================
    %% PROPERTY MANAGEMENT MODULE (The Stream)
    %% ==========================================
    RE_BUILDINGS ||--o{ RE_UNITS : "contains"
    RE_CLIENTS ||--o{ RE_LEASES : "signs"
    RE_LEASES ||--|{ RE_LEASE_UNITS : "includes"
    RE_UNITS ||--o{ RE_LEASE_UNITS : "rented via"

    %% ==========================================
    %% FINANCE MODULE (The Pool) & Cross-Module Links
    %% ==========================================
    GL_ACCOUNTS ||--o{ FINANCE_INVOICES : "categorizes revenue for"
    FINANCE_INVOICES ||--o{ FINANCE_PAYMENTS : "receives installments via"
    
    %% INTER-MODULE LINK: Property Management -> Finance
    RE_LEASES ||--o{ FINANCE_INVOICES : "generates billing for"

    %% ==========================================
    %% Table Definitions (Core Attributes Only)
    %% ==========================================
    
    DEPARTMENTS {
        NUMBER dept_id PK
        VARCHAR2 dept_code "UK"
        VARCHAR2 dept_name
    }
    
    EMPLOYEE_MASTER {
        NUMBER emp_id PK
        VARCHAR2 first_name
        VARCHAR2 last_name
        VARCHAR2 work_email "UK"
        NUMBER current_dept_id FK
        DATE hire_date
        VARCHAR2 status
    }
    
    EMP_PERSONAL_INFO {
        NUMBER info_id PK
        NUMBER emp_id FK
        VARCHAR2 home_address
        VARCHAR2 personal_phone
        VARCHAR2 emergency_contact_name
        VARCHAR2 emergency_phone
        VARCHAR2 blood_group
    }
    
    EMP_SALARY_SETTINGS {
        NUMBER payroll_id PK
        NUMBER emp_id FK
        NUMBER base_salary
        VARCHAR2 account_number
    }
    
    EMP_DOCUMENTS {
        NUMBER doc_id PK
        NUMBER emp_id FK
        VARCHAR2 doc_type
        VARCHAR2 doc_no
        DATE issue_date
        DATE expiry_date
        VARCHAR2 status
        VARCHAR2 remarks
    }

    RE_BUILDINGS {
        NUMBER building_id PK
        VARCHAR2 building_name
        VARCHAR2 address
        NUMBER total_floors
        VARCHAR2 facilities_available
    }
    
    RE_CLIENTS {
        NUMBER client_id PK
        VARCHAR2 first_name
        VARCHAR2 last_name
        VARCHAR2 email "UK"
        VARCHAR2 phone
        VARCHAR2 client_type
        VARCHAR2 status
    }
    
    RE_UNITS {
        NUMBER unit_id PK
        NUMBER building_id FK
        VARCHAR2 unit_number
        VARCHAR2 unit_type
        NUMBER square_footage
        NUMBER monthly_rent_rate
        VARCHAR2 current_status
    }
    
    RE_LEASES {
        NUMBER lease_id PK
        NUMBER client_id FK
        DATE start_date
        DATE end_date
        NUMBER total_rent
        NUMBER security_deposit
        VARCHAR2 status
    }
    
    RE_LEASE_UNITS {
        NUMBER lease_unit_id PK
        NUMBER lease_id FK
        NUMBER unit_id FK
        NUMBER allocated_rent
    }

    GL_ACCOUNTS {
        NUMBER account_id PK
        VARCHAR2 account_number "UK"
        VARCHAR2 account_name
        VARCHAR2 account_type
    }
    
    FINANCE_INVOICES {
        NUMBER invoice_id PK
        NUMBER lease_id FK "Cross-Module Link"
        NUMBER account_id FK
        DATE invoice_date
        DATE due_date
        NUMBER amount
        VARCHAR2 status
    }
    
    FINANCE_PAYMENTS {
        NUMBER payment_id PK
        NUMBER invoice_id FK
        DATE payment_date
        VARCHAR2 payment_method
        VARCHAR2 reference_number
        NUMBER amount_paid
    }date
    }
