-- Example remediation pattern for four source tables.
-- The COALESCE rules prevent missing entity attributes from propagating downstream.
WITH unified AS (
    SELECT
        c.customer_id,
        COALESCE(c.legal_name, k.legal_name, w.legal_name, cd.legal_name) AS legal_name,
        COALESCE(c.country, k.country, w.country, cd.country) AS country,
        COALESCE(c.kyc_status, k.kyc_status) AS kyc_status,
        COALESCE(k.kyb_status, c.kyb_status) AS kyb_status
    FROM customers c
    LEFT JOIN kyc k ON c.customer_id = k.customer_id
    LEFT JOIN wire_customers w ON c.customer_id = w.customer_id
    LEFT JOIN card_customers cd ON c.customer_id = cd.customer_id
)
SELECT * FROM unified;
