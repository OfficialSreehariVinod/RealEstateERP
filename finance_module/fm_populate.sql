REM =======================================================
REM Finance Module - Populate Data
REM Sets up the GL and executes automatic billing procedures
REM =======================================================

PROMPT Populating Chart of Accounts (GL)...
INSERT INTO gl_accounts (account_number, account_name, account_type) 
VALUES ('REV-4000', 'Residential Rental Income', 'Revenue');

PROMPT Executing Lease Invoice Generator for Sarah Connor (Lease ID: 1)...
-- This procedure call will automatically generate 12 unpaid invoices 
-- linked to Sarah's lease from the Property Management module!
EXECUTE generate_lease_invoices(1);

PROMPT Simulating a Tenant Payment...
-- Sarah pays her very first invoice via Bank Transfer. 
-- Watch the TRG_AUTO_PAY_INVOICE trigger automatically flip the invoice to 'Paid'!
INSERT INTO finance_payments (invoice_id, payment_date, payment_method, reference_number, amount_paid)
VALUES (1, CURRENT_DATE, 'Bank Transfer', 'TRX-987654321', 8000.00);

COMMIT;
PROMPT Finance Data Population Complete.
