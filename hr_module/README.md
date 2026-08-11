## Schema Details
* **DEPARTMENTS**: Tracks the overarching business divisions (e.g., Sales, Property Management, Leasing), including unique accounting codes used in general ledger rollups.
* **EMPLOYEE_MASTER**: The central Hub for all staff, linking them to their current department.
* **EMP_PERSONAL_INFO**: A 1-to-1 extension table tracking sensitive home addresses and emergency contacts.
* **EMP_SALARY_SETTINGS**: A highly secured 1-to-1 extension table tracking base salaries and bank account numbers.
* **EMP_DOCUMENTS**: A 1-to-Many compliance table tracking passports, visas, and their expiry dates.

## ER Diagram

```mermaid
erDiagram
    DEPARTMENTS ||--o{ EMPLOYEE_MASTER : "employs"
    EMPLOYEE_MASTER ||--o| EMP_PERSONAL_INFO : "has personal profile"
    EMPLOYEE_MASTER ||--o| EMP_SALARY_SETTINGS : "has financial profile"
    EMPLOYEE_MASTER ||--o{ EMP_DOCUMENTS : "holds"

    DEPARTMENTS {
        NUMBER dept_id PK
        VARCHAR2 dept_code "UK"
        VARCHAR2 dept_name
    }
    EMPLOYEE_MASTER {
        NUMBER emp_id PK
        VARCHAR2 first_name
        NUMBER current_dept_id FK
    }
    EMP_PERSONAL_INFO {
        NUMBER info_id PK
        NUMBER emp_id FK, UK
        VARCHAR2 emergency_contact_name
    }
    EMP_SALARY_SETTINGS {
        NUMBER payroll_id PK
        NUMBER emp_id FK, UK
        NUMBER base_salary
    }
    EMP_DOCUMENTS {
        NUMBER doc_id PK
        NUMBER emp_id FK
        VARCHAR2 doc_type
        DATE expiry_date
    }
