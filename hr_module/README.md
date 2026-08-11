# Human Resources (HR) Sample Schema

## Schema Description
The HR module serves as the foundational Hub for the ERP. In the Real Estate firm, operational streams (like leasing agents or finance managers) must link back to authorized employees. This schema normalizes organizational data by tracking overarching business divisions and the specific employees working within them, utilizing a strict Hub-and-Spoke architecture for data security.

## Schema Details
* **DEPARTMENTS**: Tracks the overarching business divisions (e.g., Sales, Property Management, Leasing), including unique accounting codes used in general ledger rollups.
* **EMPLOYEE_MASTER**: The central repository for all staff, linking them to their current department and tracking their core contact/employment details.
* **EMP_PERSONAL_INFO**: A strict 1-to-1 extension table tracking sensitive home addresses and emergency contacts, completely isolated from general employee data.
* **EMP_SALARY_SETTINGS**: A highly secured 1-to-1 extension table tracking base salaries and bank account numbers for payroll processing.
* **EMP_DOCUMENTS**: A 1-to-Many compliance table tracking official records like passports, visas, and their respective expiry dates.

## ER Diagram

```mermaid
erDiagram
    %% Relationships
    DEPARTMENTS ||--o{ EMPLOYEE_MASTER : "employs"
    EMPLOYEE_MASTER ||--o| EMP_PERSONAL_INFO : "has personal profile"
    EMPLOYEE_MASTER ||--o| EMP_SALARY_SETTINGS : "has financial profile"
    EMPLOYEE_MASTER ||--o{ EMP_DOCUMENTS : "holds"

    %% Table Definitions with Full Attributes
    DEPARTMENTS {
        NUMBER dept_id PK
        VARCHAR2 dept_code "UK"
        VARCHAR2 dept_name
        TIMESTAMP created_at
        TIMESTAMP updated_at
        VARCHAR2 updated_by
        VARCHAR2 approved_by
    }
    
    EMPLOYEE_MASTER {
        NUMBER emp_id PK
        VARCHAR2 first_name
        VARCHAR2 last_name
        VARCHAR2 work_email "UK"
        NUMBER current_dept_id FK
        DATE hire_date
        VARCHAR2 status
        TIMESTAMP created_at
        TIMESTAMP updated_at
        VARCHAR2 updated_by
        VARCHAR2 approved_by
    }
    
    EMP_PERSONAL_INFO {
        NUMBER info_id PK
        NUMBER emp_id FK, UK
        VARCHAR2 home_address
        VARCHAR2 personal_phone
        VARCHAR2 emergency_contact_name
        VARCHAR2 emergency_phone
        VARCHAR2 blood_group
        TIMESTAMP created_at
        TIMESTAMP updated_at
        VARCHAR2 updated_by
        VARCHAR2 approved_by
    }
    
    EMP_SALARY_SETTINGS {
        NUMBER payroll_id PK
        NUMBER emp_id FK, UK
        NUMBER base_salary
        VARCHAR2 bank_name
        VARCHAR2 account_number
        TIMESTAMP created_at
        TIMESTAMP updated_at
        VARCHAR2 updated_by
        VARCHAR2 approved_by
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
        TIMESTAMP created_at
        VARCHAR2 created_by
    }
