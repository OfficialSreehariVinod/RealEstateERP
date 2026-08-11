REM =======================================================
REM Finance Module - Drop Script
REM Safely removes GL, AR Subledgers, and Procedures
REM =======================================================

PROMPT Dropping Finance Procedures...
DROP PROCEDURE generate_lease_invoices;

PROMPT Dropping Finance Tables (Accounts Receivable)...
DROP TABLE finance_payments CASCADE CONSTRAINTS;
DROP TABLE finance_invoices CASCADE CONSTRAINTS;

PROMPT Dropping General Ledger Tables...
DROP TABLE gl_accounts CASCADE CONSTRAINTS;

PROMPT Finance objects dropped successfully.
