
REM =======================================================
REM HR Module - Drop Script
REM Safely removes all HR tables and constraints
REM =======================================================

PROMPT Dropping HR Child Tables...
DROP TABLE emp_documents CASCADE CONSTRAINTS;
DROP TABLE emp_salary_settings CASCADE CONSTRAINTS;
DROP TABLE emp_personal_info CASCADE CONSTRAINTS;

PROMPT Dropping HR Hub Tables...
DROP TABLE employee_master CASCADE CONSTRAINTS;
DROP TABLE departments CASCADE CONSTRAINTS;

PROMPT HR objects dropped successfully.
