REM =======================================================
REM Property Management Module - Drop Script
REM Safely removes all RE (Real Estate) tables and constraints
REM =======================================================

PROMPT Dropping Real Estate Detail Tables...
DROP TABLE re_lease_units CASCADE CONSTRAINTS;
DROP TABLE re_leases CASCADE CONSTRAINTS;
DROP TABLE re_units CASCADE CONSTRAINTS;

PROMPT Dropping Real Estate Master Tables...
DROP TABLE re_clients CASCADE CONSTRAINTS;
DROP TABLE re_buildings CASCADE CONSTRAINTS;

PROMPT Property Management objects dropped successfully.
