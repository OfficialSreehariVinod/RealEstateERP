REM =======================================================
REM Property Management Module - Populate Data
REM Inserts Sample Buildings, Units, Clients, and Leases
REM =======================================================

PROMPT Populating RE_BUILDINGS...
INSERT INTO re_buildings (building_name, address, total_floors, facilities_available)
VALUES ('Oasis Residential Tower', 'Dubai Silicon Oasis, UAE', 20, 'Gym, Pool, 24/7 Security');

PROMPT Populating RE_CLIENTS...
INSERT INTO re_clients (first_name, last_name, email, phone, client_type) 
VALUES ('Sarah', 'Connor', 'sarah.connor@example.com', '050-123-4567', 'Tenant');

PROMPT Populating RE_UNITS...
-- Inserting two units into the Oasis Residential Tower (building_id = 1)
INSERT INTO re_units (building_id, unit_number, unit_type, square_footage, monthly_rent_rate, current_status)
VALUES (1, '101A', '2 BHK', 1200, 8000.00, 'Rented');

INSERT INTO re_units (building_id, unit_number, unit_type, square_footage, monthly_rent_rate, current_status)
VALUES (1, '102B', '1 BHK', 850, 5500.00, 'Available');

PROMPT Populating RE_LEASES and RE_LEASE_UNITS...
-- Sarah Connor (client_id = 1) signs a lease for 96,000 AED total
INSERT INTO re_leases (client_id, start_date, end_date, total_rent, security_deposit)
VALUES (1, TO_DATE('01-SEP-2026', 'DD-MON-YYYY'), TO_DATE('31-AUG-2027', 'DD-MON-YYYY'), 96000.00, 8000.00);

-- Bridge table linking Sarah's Lease (lease_id = 1) to Unit 101A (unit_id = 1)
INSERT INTO re_lease_units (lease_id, unit_id, allocated_rent)
VALUES (1, 1, 8000.00);

COMMIT;
PROMPT Property Management Data Population Complete.
