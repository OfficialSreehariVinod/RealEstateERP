REM =======================================================
REM Finance Module - Master Execution Script
REM Runs Drop, Create, and Populate scripts in sequence
REM =======================================================

SET ECHO OFF
SET VERIFY OFF

PROMPT =======================================================
PROMPT Starting Finance Module Deployment...
PROMPT =======================================================

@fm_drop.sql
@fm_create.sql
@fm_populate.sql

PROMPT =======================================================
PROMPT Finance Deployment Successfully Completed!
PROMPT =======================================================
