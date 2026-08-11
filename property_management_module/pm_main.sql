REM =======================================================
REM Property Management Module - Master Execution Script
REM Runs Drop, Create, and Populate scripts in sequence
REM =======================================================

SET ECHO OFF
SET VERIFY OFF

PROMPT =======================================================
PROMPT Starting Property Management Module Deployment...
PROMPT =======================================================

@pm_drop.sql
@pm_create.sql
@pm_populate.sql

PROMPT =======================================================
PROMPT Property Management Deployment Successfully Completed!
PROMPT =======================================================
