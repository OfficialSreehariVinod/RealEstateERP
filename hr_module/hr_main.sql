REM =======================================================
REM HR Module - Master Execution Script
REM Runs Drop, Create, and Populate scripts in sequence
REM =======================================================

SET ECHO OFF
SET VERIFY OFF

PROMPT =======================================================
PROMPT Starting HR Module Deployment...
PROMPT =======================================================

@hr_drop.sql
@hr_create.sql
@hr_populate.sql

PROMPT =======================================================
PROMPT HR Module Deployment Successfully Completed!
PROMPT =======================================================
