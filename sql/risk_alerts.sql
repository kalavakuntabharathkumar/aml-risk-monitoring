-- AML risk alert extraction
SELECT transaction_id, customer_id, amount, country_risk_score,
       velocity_24h, kyc_complete, kyb_complete, rule_alert,
       model_probability, risk_tier
FROM transactions
WHERE rule_alert = 1 OR model_probability >= 0.65
ORDER BY model_probability DESC;
