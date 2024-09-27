SELECT *
FROM prescription;
SELECT *
FROM prescriber;
SELECT *
FROM drug;

-- #1 a) 1881634483 w/ 99707 claims b) Bruce Pendley, Family Practice, 99707
SELECT npi, SUM(total_claim_count) AS total_claims
FROM prescription
GROUP BY npi
ORDER BY total_claims DESC
LIMIT 1;

SELECT nppes_provider_first_name, nppes_provider_last_org_name, specialty_description, SUM(total_claim_count) AS total_claims
FROM prescriber
INNER JOIN prescription
USING(npi)
GROUP BY  nppes_provider_first_name, nppes_provider_last_org_name, specialty_description
ORDER BY total_claims DESC
LIMIT 1;

-- #2 a)Family Practice  b)Nurse Practitioner c) d)
SELECT specialty_description, SUM(total_claim_count) AS total_claims
FROM prescriber
INNER JOIN prescription
USING(npi)
GROUP BY specialty_description
ORDER BY total_claims DESC;

SELECT specialty_description, SUM(total_claim_count) AS total_claims
FROM prescriber
INNER JOIN prescription
USING(npi)
INNER JOIN drug
USING(drug_name)
WHERE opioid_drug_flag = 'Y'
GROUP BY specialty_description
ORDER BY total_claims DESC;

-- #3 a)Insulin Glargine, HUM.REC.ANLOG b)C1 Inhibitor
SELECT generic_name, SUM(total_drug_cost) AS total_drug_sum
FROM prescription
INNER JOIN drug
USING(drug_name)
GROUP BY generic_name 
ORDER BY total_drug_sum DESC;

SELECT generic_name, ROUND(SUM(total_drug_cost)/SUM(total_day_supply), 2) AS total_day_cost_round
FROM prescription
INNER JOIN drug
USING(drug_name)
GROUP BY generic_name
ORDER BY total_day_cost_round DESC
LIMIT 1;

-- #4 a)  b)
SELECT drug_name,
	CASE WHEN opioid_drug_flag = 'Y' THEN 'opioid'
		 WHEN antibiotic_drug_flag = 'Y' THEN 'antibiotic'
		 ELSE 'neither' END AS drug_type
FROM drug
ORDER BY drug_type;

SELECT
FROM ;

-- #5 a)  b)  c)
SELECT cbsa, COUNT(cbsaname) AS cbsa_count
FROM cbsa
WHERE cbsaname = 'TN'
GROUP BY cbsa
ORDER BY cbsa_count;


-- #6 a)  b)  c)

-- #7 a)  b)  c)
