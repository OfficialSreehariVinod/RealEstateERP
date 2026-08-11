# Finance Subledger Sample Schema

## Schema Description
The Finance module acts as the "pool" into which all operational "streams" flow. When a Lease is signed in the Property Management module, it generates an Invoice here. It strictly enforces financial auditing rules, requiring Maker-Checker tracking (`created_by` vs `approved_by` timestamps) to prevent fraud. 

## Schema Details
* **FINANCE_INVOICES**: Tracks the amount owed by a client. Crucially, it links back to the `RE_LEASES` table in the PM module to prove *why* the money is owed.
* **FINANCE_PAYMENTS**: Tracks the actual cash receipts. Multiple payments (installments) can be applied against a single master invoice.

## ER Diagram

```mermaid
erDiagram
    FINANCE_INVOICES {
        NUMBER invoice_id PK
        NUMBER lease_id FK "Points to PM Module"
        NUMBER invoice_amount
        DATE issue_date
        DATE due_date
        VARCHAR2 status
        TIMESTAMP created_at
        VARCHAR2 created_by
        VARCHAR2 approved_by
    }
    
    FINANCE_PAYMENTS {
        NUMBER payment_id PK
        NUMBER invoice_id FK
        NUMBER amount_paid
        DATE payment_date
        VARCHAR2 receipt_reference
        VARCHAR2 payment_method
    }

    %% Relationships
    FINANCE_INVOICES ||--o{ FINANCE_PAYMENTS : "receives installments via"
