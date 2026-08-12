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
erDiagram
    DEPARTMENTS ||--o{ EMPLOYEE_MASTER : "employs"
    EMPLOYEE_MASTER ||--o| EMP_PERSONAL_INFO : "has personal profile"
    EMPLOYEE_MASTER ||--o| EMP_SALARY_SETTINGS : "has financial profile"
    EMPLOYEE_MASTER ||--o{ EMP_DOCUMENTS : "holds"

    RE_BUILDINGS ||--o{ RE_UNITS : "contains"
    RE_CLIENTS ||--o{ RE_LEASES : "signs"
    RE_LEASES ||--|{ RE_LEASE_UNITS : "includes"
    RE_UNITS ||--o{ RE_LEASE_UNITS : "rented via"

    GL_ACCOUNTS ||--o{ FINANCE_INVOICES : "categorizes revenue for"
    FINANCE_INVOICES ||--o{ FINANCE_PAYMENTS : "receives installments via"
    
    %% INTER-MODULE LINK
    RE_LEASES ||--o{ FINANCE_INVOICES : "generates billing for (Cross-Module Link)"

    DEPARTMENTS { NUMBER dept_id PK }
    EMPLOYEE_MASTER { NUMBER emp_id PK }
    RE_BUILDINGS { NUMBER building_id PK }
    RE_CLIENTS { NUMBER client_id PK }
    RE_UNITS { NUMBER unit_id PK }
    RE_LEASES { NUMBER lease_id PK }
    GL_ACCOUNTS { NUMBER account_id PK }
    FINANCE_INVOICES { NUMBER invoice_id PK }
    FINANCE_PAYMENTS { NUMBER payment_id PK }
