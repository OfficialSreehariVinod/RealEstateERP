REM =======================================================
REM Finance Module - Master Execution Script
REM Runs Drop, Create, and Populate scripts in sequence
REM =======================================================

SET ECHO OFF
SET VERIFY OFF

PROMPT =======================================================
PROMPT Starting Finance Module Deployment...
PROMPT =======================================================

@fin_drop.sql
@fin_cre.sql
@fin_popul.sql

PROMPT =======================================================
PROMPT Finance Deployment Successfully Completed!
PROMPT =======================================================
