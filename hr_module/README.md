
# Human Resources (HR) Sample Schema

## Schema Description
The HR module serves as the foundational Hub for the ERP. In the Real Estate firm, operational streams (like leasing agents or finance managers) must link back to authorized employees. This schema normalizes organizational data by tracking overarching business divisions and the specific employees working within them.

## Schema Details
* **DEPARTMENTS**: Tracks the overarching business divisions (e.g., Sales, Property Management, Leasing), including unique accounting codes used in general ledger rollups.
* **EMPLOYEE_MASTER**: The central repository for all staff, linking them to their current department and tracking their core contact/employment details.

## ER Diagram

```mermaid
erDiagram
    DEPARTMENTS {
        NUMBER dept_id PK
        VARCHAR2 dept_code "UK"
        VARCHAR2 dept_name
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }
    
    EMPLOYEE_MASTER {
        NUMBER emp_id PK
        VARCHAR2 first_name
        VARCHAR2 last_name
        VARCHAR2 work_email
        NUMBER current_dept_id FK
        DATE hire_date
    }

    %% Relationships
    DEPARTMENTS ||--o{ EMPLOYEE_MASTER : "employs"
