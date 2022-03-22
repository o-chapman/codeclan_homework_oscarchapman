SELECT *
FROM employees
WHERE department = 'Human Resources';

SELECT first_name, last_name, country
FROM employees 
WHERE department = 'Legal';

SELECT
	COUNT(*) AS number_employees
FROm employees
WHERE country = 'Portugal';

SELECT
	COUNT(*) AS number_employees
FROm employees
WHERE country IN ('Portugal', 'Spain');

SELECT
	COUNT(*) AS null_records
FROM pay_details
WHERE local_account_no IS NULL;

SELECT
	COUNT(*) AS null_records
FROM pay_details
WHERE local_account_no IS NULL AND iban IS NULL;

SELECT first_name, last_name
FROM employees
ORDER BY last_name NULLS LAST;

SELECT first_name, last_name, country
FROM employees
ORDER BY 
	country NULLS LAST,
	last_name NULLS LAST;
	
SELECT *
FROM employees
ORDER BY salary DESC NULLS LAST
LIMIT 10;

SELECT first_name, last_name, salary
FROM employees
WHERE country = 'Hungary'
ORDER BY salary DESC NULLS LAST
LIMIT 1;

SELECT
	COUNT(*) AS number_f
FROM employees
WHERE first_name LIKE 'F%';

SELECT *
FROM employees
WHERE email LIKE '%@yahoo%';

SELECT *
FROM employees
WHERE country NOT IN ('Germany', 'France') AND pension_enrol = TRUE;

SELECT
	MAX(salary) AS max_salary
FROM employees
WHERE department = 'Engineering';
