# Real Estate Enterprise Resource Planning (ERP) System

## 🏢 Project Overview
This repository contains the backend database architecture for a highly normalized, enterprise-grade Real Estate Property Management ERP. Built entirely from scratch using **Oracle Database 21c**, this project demonstrates the translation of real-world business rules into strict relational database mechanics.

## 🏗️ Architecture
The system is divided into three core operational streams (subledgers), mimicking standard ERP ecosystems:
1. **[Property Management Module](./property_management_module/)**: The core operational stream managing buildings, multi-unit lease agreements, and tenant tracking.
2. **[Human Resources (HR) Module](./hr_module/)**: The organizational hub managing departments and employee hierarchies.
3. **[Finance Module](./finance_module/)**: The accounting pool that receives data from operational streams to track invoices, payments, and general ledger compliance using Maker-Checker rules.

## 🚀 Deployment Standard
Each module is self-contained and follows the official Oracle Sample Schemas installation structure (`_main.sql`, `_cre.sql`, `_popul.sql`, `_drop.sql`). Navigate to the respective module folders for detailed installation instructions and Entity-Relationship (ER) Diagrams.
