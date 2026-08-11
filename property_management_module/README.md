
# Property Management (PM) Sample Schema

## Schema Description
The Property Management (`PM`) module is the operational core of the Real Estate ERP. It tracks physical assets (Buildings and Units) and manages the legal agreements associated with them. 

Crucially, it utilizes a Master-Detail (Header-Lines) architecture for Leases. Because corporate clients often rent multiple apartments under a single contract, the `RE_LEASES` table acts as the master contract, while the `RE_LEASE_UNITS` bridge table maps the individual physical units to that specific historical lease.

## Schema Details
* **RE_CLIENTS**: Stores tenant/client personal or corporate information.
* **RE_BUILDINGS**: Defines the overarching physical properties managed by the firm.
* **RE_UNITS**: The specific rentable spaces within a building (e.g., apartments, retail spaces).
* **RE_LEASES**: The master contract header containing start dates, end dates, and total lease value.
* **RE_LEASE_UNITS**: The line-item details bridging one lease to multiple physical units.

## Install / Uninstall Instructions
1. Open Oracle SQL Developer or SQL*Plus and connect to your schema owner account.
2. **To Install:** Run the master script to generate the tables, constraints, and triggers, and populate the sample data:
   `@pm_main.sql`
3. **To Uninstall/Clean:** Run the drop script to safely remove all constraints and tables before a fresh installation:
   `@pm_drop.sql`

## ER Diagram

```mermaid
erDiagram
    RE_CLIENTS {
        NUMBER client_id PK
        VARCHAR2 client_name
    }
    RE_BUILDINGS {
        NUMBER building_id PK
        VARCHAR2 building_name
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
        NUMBER total_amount
    }
    RE_LEASE_UNITS {
        NUMBER lease_unit_id PK
        NUMBER lease_id FK
        NUMBER unit_id FK
        NUMBER allocated_rent
    }

    %% Relationships
    RE_CLIENTS ||--o{ RE_LEASES : "signs"
    RE_BUILDINGS ||--o{ RE_UNITS : "contains"
    RE_LEASES ||--|{ RE_LEASE_UNITS : "includes"
    RE_UNITS ||--o{ RE_LEASE_UNITS : "rented via"
