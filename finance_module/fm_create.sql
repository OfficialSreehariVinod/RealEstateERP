REM =======================================================
REM Finance Module - Create Tables, Triggers, and Procedures
REM =======================================================

PROMPT Creating GL_ACCOUNTS (Chart of Accounts)...
CREATE TABLE gl_accounts (
    account_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    account_number VARCHAR2(20) NOT NULL UNIQUE, 
    account_name VARCHAR2(100) NOT NULL, 
    account_type VARCHAR2(50) NOT NULL, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_by VARCHAR2(100), 
    approved_by VARCHAR2(100)
);

PROMPT Creating FINANCE_INVOICES (AR Subledger)...
CREATE TABLE finance_invoices (
    invoice_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    lease_id NUMBER NOT NULL, 
    account_id NUMBER NOT NULL, 
    invoice_date DATE NOT NULL, 
    due_date DATE NOT NULL, 
    amount NUMBER(10,2) NOT NULL, 
    status VARCHAR2(20) DEFAULT 'Unpaid', 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_by VARCHAR2(100), 
    approved_by VARCHAR2(100),
    CONSTRAINT fk_invoice_account FOREIGN KEY (account_id) REFERENCES gl_accounts(account_id),
    CONSTRAINT fk_invoice_lease FOREIGN KEY (lease_id) REFERENCES re_leases(lease_id)
);

PROMPT Creating FINANCE_PAYMENTS (Cash Receipts)...
CREATE TABLE finance_payments (
    payment_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    invoice_id NUMBER NOT NULL, 
    payment_date DATE NOT NULL, 
    payment_method VARCHAR2(50) NOT NULL, 
    reference_number VARCHAR2(100), 
    amount_paid NUMBER(10,2) NOT NULL, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_by VARCHAR2(100), 
    approved_by VARCHAR2(100),
    CONSTRAINT fk_payment_invoice FOREIGN KEY (invoice_id) REFERENCES finance_invoices(invoice_id)
);


PROMPT Creating Finance Audit Triggers...
CREATE OR REPLACE TRIGGER trg_gl_accounts_updated
BEFORE UPDATE ON gl_accounts FOR EACH ROW
BEGIN
    :NEW.updated_at := CURRENT_TIMESTAMP;
    :NEW.updated_by := USER;
END;
/

CREATE OR REPLACE TRIGGER trg_invoices_updated
BEFORE UPDATE ON finance_invoices FOR EACH ROW
BEGIN
    :NEW.updated_at := CURRENT_TIMESTAMP;
    :NEW.updated_by := USER;
END;
/

CREATE OR REPLACE TRIGGER trg_finance_payments_updated_at
BEFORE UPDATE ON finance_payments FOR EACH ROW
BEGIN
    :NEW.updated_at := CURRENT_TIMESTAMP;
    :NEW.updated_by := USER;
END;
/


PROMPT Creating Business Logic Automation Triggers...
CREATE OR REPLACE TRIGGER trg_auto_pay_invoice
AFTER INSERT ON finance_payments
FOR EACH ROW
BEGIN
    UPDATE finance_invoices
    SET status = 'Paid'
    WHERE invoice_id = :NEW.invoice_id;
END;
/


PROMPT Creating Stored Procedure: GENERATE_LEASE_INVOICES...
CREATE OR REPLACE PROCEDURE generate_lease_invoices (p_lease_id IN NUMBER)
IS
    v_start_date DATE;
    v_end_date DATE;
    v_monthly_rent NUMBER;
    v_account_id NUMBER;
    v_months_count NUMBER;
    v_current_due_date DATE;
BEGIN
    -- 1. Grab the lease details from PM Module
    SELECT start_date, end_date, total_rent 
    INTO v_start_date, v_end_date, v_monthly_rent
    FROM re_leases
    WHERE lease_id = p_lease_id;

    -- 2. Find the bucket for 'Residential Rental Income'
    SELECT account_id 
    INTO v_account_id
    FROM gl_accounts
    WHERE account_number = 'REV-4000';

    -- 3. Calculate the duration of the lease in months
    v_months_count := ROUND(MONTHS_BETWEEN(v_end_date, v_start_date));

    -- 4. The Loop: Generate an invoice for every month
    FOR i IN 0 .. (v_months_count - 1) LOOP
        v_current_due_date := ADD_MONTHS(v_start_date, i);

        INSERT INTO finance_invoices (
            lease_id, 
            account_id, 
            invoice_date, 
            due_date,     
            amount,
            status
        ) VALUES (
            p_lease_id,
            v_account_id,
            CURRENT_DATE, 
            v_current_due_date,
            (v_monthly_rent / v_months_count), -- Splits total rent by number of months
            'Unpaid'
        );
    END LOOP;

    COMMIT;
END;
/


