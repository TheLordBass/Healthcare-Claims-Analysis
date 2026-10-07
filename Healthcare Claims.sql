SELECT *
FROM claims;

SELECT claim_type, 
SUM(billed_amount) AS Total_Billed,
SUM(paid_amount) AS Total_Paid , 
COUNT(claim_id) AS Total_Claims,
RANK() OVER(ORDER BY SUM(paid_amount) DESC) AS expense_rank
FROM claims
GROUP BY claim_type
ORDER BY total_paid DESC;

SELECT TOP 10 cpt_code, 
SUM(paid_amount) AS total_paid,
RANK() OVER(ORDER BY SUM(paid_amount) DESC) AS paid_rank
FROM claims
GROUP BY cpt_code
ORDER BY total_paid DESC;

SELECT TOP 10 icd_code, 
SUM(paid_amount) AS total_paid,
RANK() OVER(ORDER BY SUM(paid_amount) DESC) AS paid_rank
FROM claims
GROUP BY icd_code
ORDER BY total_paid DESC;

SELECT TOP 10 cpt_code, 
CAST(SUM(paid_amount) / COUNT(claim_id) AS DECIMAL(10,2))  AS average_paid_per_claim
FROM claims
GROUP BY cpt_code
ORDER BY average_paid_per_claim DESC

SELECT TOP 10
claim_id, member_id, claim_type, cpt_code, paid_amount,
COUNT(*) OVER (PARTITION BY cpt_code) AS claims_for_code,
CAST(AVG(paid_amount) OVER (PARTITION BY cpt_code) AS DECIMAL(10,2)) AS code_avg_paid
FROM claims
ORDER BY paid_amount DESC;
