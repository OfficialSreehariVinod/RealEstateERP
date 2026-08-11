# Finance Subledger Sample Schema

## Schema Description
The Finance module acts as the central "pool" into which all operational "streams" flow. It integrates a foundational General Ledger (GL) Chart of Accounts with an Accounts Receivable (AR) subledger. 

When a Lease is signed in the Property Management module, a stored procedure automatically generates future invoices here. This schema strictly enforces financial auditing rules, utilizing `updated_by` and `approved_by` audit columns to establish Maker-Checker tracking and prevent fraud.

## Schema Details
* **GL_ACCOUNTS**: The General Ledger Chart of Accounts. This defines the standard accounting buckets (e.g., `REV-4000 Residential Rental Income`) that all subledger revenue flows into.
* **FINANCE_INVOICES**: The Accounts Receivable (AR) subledger. Tracks amounts owed by clients. Crucially, it links back to the `RE_LEASES` table in the PM module to prove *why* the money is owed, and maps to `GL_ACCOUNTS` to categorize the revenue.
* **FINANCE_PAYMENTS**: Tracks the actual cash receipts. Multiple payments (installments) can be applied against a single master invoice. A PL/SQL trigger automatically flips the invoice status to "Paid" when receipts match the total.

## Install / Uninstall Instructions

**⚠️ Important Dependency Note:** *Because the Finance module links to historical leases, the **Property Management (PM) Module** MUST be installed prior to running this Finance installation.*

1. Open Oracle SQL Developer or SQL*Plus and connect to your schema owner account.
2. **To Install:** Run the master script to generate tables, GL accounts, audit triggers, and the invoice-generation stored procedure:
   `@fin_main.sql`
3. **To Uninstall/Clean:** Run the drop script to safely remove all procedures, constraints, and tables:
   `@fin_drop.sql`

## ER Diagram

```mermaid
erDiagram
    %% Relationships
    GL_ACCOUNTS ||--o{ FINANCE_INVOICES : "categorizes revenue for"
    FINANCE_INVOICES ||--o{ FINANCE_PAYMENTS : "receives installments via"

    %% Table Definitions with Full Attributes
    GL_ACCOUNTS {
        NUMBER account_id PK
        VARCHAR2 account_number "UK"
        VARCHAR2 account_name
        VARCHAR2 account_type
        TIMESTAMP created_at
        TIMESTAMP updated_at
        VARCHAR2 updated_by
        VARCHAR2 approved_by
    }
    
    FINANCE_INVOICES {
        NUMBER invoice_id PK
        NUMBER lease_id FK "Points to PM Module"
        NUMBER account_id FK "Points to GL"
        DATE invoice_date
        DATE due_date
        NUMBER amount
        VARCHAR2 status
        TIMESTAMP created_at
        TIMESTAMP updated_at
        VARCHAR2 updated_by
        VARCHAR2 approved_by
    }
    
    FINANCE_PAYMENTS {
        NUMBER payment_id PK
        NUMBER invoice_id FK
        DATE payment_date
        VARCHAR2 payment_method
        VARCHAR2 reference_number
        NUMBER amount_paid
        TIMESTAMP created_at
        TIMESTAMP updated_at
        VARCHAR2 updated_by
        VARCHAR2 approved_by
    }
