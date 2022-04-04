SELECT e.first_name, e.last_name, t.name as team_name
FROM teams as t LEFT JOIN employees as e
ON t.id = e.team_id;

SELECT e.first_name, e.last_name, t.name as team_name
FROM teams as t LEFT JOIN employees as e
ON t.id = e.team_id
WHERE e.pension_enrol = TRUE;

SELECT e.first_name, e.last_name, t.name
FROM teams as t LEFT JOIN employees as e
ON t.id = e.team_id
WHERE CAST(t.charge_cost AS numeric) > 80;

SELECT e.*, p.local_account_no, p.local_sort_code
FROM employees AS e LEFT JOIN pay_details AS p
ON e.pay_detail_id = p.id;

SELECT e.*, p.local_account_no, p.local_sort_code, t.name as team_name
FROM (
	employees AS e
	LEFT JOIN pay_details AS p
	ON e.pay_detail_id = p.id)
LEFT JOIN teams AS t
ON e.team_id = t.id;

CREATE TABLE new_table
AS (SELECT e.id AS employee_id, t.name AS team_name
	FROM employees AS e LEFT JOIN teams AS t
	ON e.team_id = t.id)
	
SELECT team_name, COUNT(id) as number_employees
FROM new_table
GROUP BY team_name
ORDER BY number_employees ASC

CREATE TABLE newer_table
AS (SELECT team_name, team_id, COUNT(id) as number_employees
	FROM (
		SELECT e.id as id, t.id as team_id, t.name as team_name
		FROM employees as e LEFT JOIN teams as t
		ON e.team_id = t.id) as temp
	GROUP BY team_name, team_id)

SELECT team_name, CAST(charge_cost as numeric)*number_employees as total_day_charge
FROM newer_table LEFT JOIN teams
ON team_id = id