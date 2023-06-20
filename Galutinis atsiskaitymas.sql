-- 1. 
/*
Naudoti: sql_invoicing.invoices;
Pateikti 'client_id', 'invoice_total', 'number' stulpelius. Surūšiuokite duomenis pagal 'client_id'
nuo mažiausios reikšmės ir pagal 'invoice_total' nuo didžiausios reikšmės (1t);
*/
USE sql_invoicing;

SELECT client_id, invoice_total, number
FROM invoices
ORDER BY client_id ASC, invoice_total DESC;

SELECT*
FROM invoices;

-- 2. 
/*
Naudoti: sql_invoicing.invoices; 
Pateikite visus unikalias 'client_id' reikšmes ir jas išrikiuokit
nuo didžiausios mažėjančia reikšme. (1t);
*/
SELECT*
FROM invoices;

SELECT distinct client_id
FROM invoices
ORDER BY client_id DESC;




-- 3.
/*
Naudoti: sql_invoicing.payments;
Parašykite SQL užklausą, kuri paskaičiuoja bendrą visų mokėjimų ('amount') sumą.
Rezultatą pateikite stulpelyje 'iš viso'. Taip pat paskaičiuokite mokėjimų vidurkį - 
pavadinkite stulpelį 'mokėjimų vidurkis'. Paskaičiuokite mažiausią ir didžiausią mokėjimą.
Šiuos stulpelius pavadinkite savo parinktais pavadinimais.
Taip pat paskaičiuokite unikalių pirkėjų ('client_id') skaičių, bei unikalių sąskaitų faktūrų kiekį ('invoice_id').
Šiuos stulpelius taip pat pavadinkite savo parinktais pavadinimais. (2t);
*/
SELECT*
FROM payments;

SELECT SUM(amount) AS is_viso
FROM payments;

SELECT SUM(amount) AS is_viso, AVG(amount) AS mokejimu_vidurkis
FROM payments;

SELECT 
	SUM(amount) AS is_viso, 
    AVG(amount) AS mokejimu_vidurkis,
    MIN(amount) AS maziausia_suma,
    MAX(amount) AS didziausia_suma
FROM payments;

SELECT 
	COUNT(distinct client_id) AS viso_klientu, 
    COUNT(distinct invoice_id) AS viso_saskaitu
FROM payments;



-- 4.
/*
Naudoti: sql_hr.employees; 
Parašykite SQL užklausą, kuri ištrauktų visus įrašus, kur stulpelio 'salary' 
reikšmė yra mažesnė už 40 000. Išrikiuokite įrašus nuo dižiausios algos ('salary') mažėjančia tvarka.
Prie šitų išfiltruotų įrašu pateikite papildomą stulpelį (užvadinkite jį 'new_salary'), kur 
alga būtų padidinta 15 procentų. (2t);
*/

USE sql_hr;

SELECT*
FROM employees;

SELECT*
FROM employees
Where salary < 40000;

SELECT*
FROM employees
Where salary < 40000
ORDER by salary DESC;

SELECT *, ROUND((salary*1.15),0) AS new_salary
FROM employees
Where salary < 40000
ORDER by salary DESC;


-- 5. 
/*
Naudoti: sql_store.products;
Ištirkite produkto pavadinimo ('name') stulpelį. Kelinta raidė yra 'e' (galima naudoti mysql position funkciją). 
Išrikiuokite rezultatą nuo toliausiai esančios 'e' raidės. (1t);
*/
USE sql_store;

SELECT*
FROM products;

SELECT name, position("e" IN `name`) AS raides_e_pozicija
FROM products;

SELECT name, position("e" IN `name`) AS raides_e_pozicija
FROM products
ORDER by raides_e_pozicija DESC;


-- 6. 
/*
Naudoti: sql_store.customers; 
Parašykite SQL užklausą, kuri ištrauktų visus įrašus, kurių miestas ('city') yra Vilnius, Klaipėda ir Alytus,
o lojalumo taškų ('points') pirkėjas yra surinkęs mažiau nei 1000.
Išrikiuoti rezultatus pagal lojalumo taškus didėjančia tvarka. (1t);
*/
USE sql_store;

SELECT*
FROM customers;

SELECT *
FROM customers
Where city = 'Vilnius' OR city = 'Kaunas' OR city = 'Alytus';

SELECT *
FROM customers
Where points < 1000 AND (city = 'Vilnius' OR city = 'Kaunas' OR city = 'Alytus');


-- 7.
/*
Naudoti: sql_hr.employees;
Parašykite SQL užklausą, kuri suskaičiuotų algų sumą darbuotojų, 
kurių 'job_title' stulpelyje yra reikšmė 'Operacijų'.
Stulpelį pavadinkite `sum_salary` (1t);
*/
USE sql_hr;

SELECT*
FROM employees;

SELECT*
FROM employees
WHERE job_title LIKE '%operaciju%';

SELECT SUM(salary) AS sum_salary
FROM employees
WHERE job_title LIKE '%operaciju%';


-- 8.
/*
Naudoti: sql_store.shippers,
         sql_store.orders,
         sql_store.order_items;
Parašykite užklausą, kuri pateiktų tiekėjų (SHIPPERS lentelė) pavadinimus, 
kiekį skirtingų prekių ('product_id') ir kiekį skirtingų užsakymų ('order_id') tiekėjas yra tiekęs.
Stulpelius pavadinkite atitinkamai 'Cnt_unique_products', 'Cnt_unique_orders'.
Išrikiuokite rezultatą pagal tiekėjo pavadinimą abacėlės tvarka. (3t);
*/
USE sql_store;

SELECT *
FROM shippers AS s
JOIN orders AS o
	ON s.shipper_id = o.shipper_id
JOIN order_items AS ot
		ON o.shipper_id = ot.order_id;

SELECT 
	name, 
    ot.product_id AS Cnt_unique_products, 
    o.order_id AS Cnt_unique_orders
FROM shippers AS s
JOIN orders AS o
	USING(shipper_id)
JOIN order_items AS ot
	ON o.shipper_id = ot.order_id
ORDER BY name ASC; 


-- 9.
/*
Naudoti: sakila.film;
Parašykite SQL užklausą, kuri pateiktų filmų pavadinimus ('title'), reitingus ('rating'), bei 
suskirstytų filmus pagal jų reitingus ('rating') į tokias kategorijas:
Jei reitingas yra 'PG' arba 'G' tada 'PG_G'
Jei reitingas yra 'NC-17' arba „PG-13“ tada „NC-17_PG-13“
Visus kitus reitingus priskirkite kategorijai 'Nesvarbu'
Kategorijas atvaizduokite stulpelyje 'Reitingo_grupė' (2t)
*/
USE sakila;

SELECT title, rating
FROM film;

SELECT title, rating,
CASE
	WHEN rating = 'PG' OR rating = 'G' THEN 'PG_G'
    WHEN rating = 'NC-17' OR rating = 'PG-13' THEN 'NC-17_PG-13'
    ELSE 'Nesvarbu'
    END AS 'Reitingo_grupe'
FROM film;


-- 10.
/*
Naudoti: sakila.film;
Parašykite SQL užklausą, kuri suskaičiuotų kiek filmų priklauso reitingo grupėms, kurios buvo sukurtos 9-ame uždavinyje.
Rezultate pateikite tik tokias reitingo grupes, kurioms priklausantis filmų kiekis yra 250 - 450 intervale. 
Išrikiuokite rezultatą nuo didžiausio filmų kiekio mažėjančia tvarka. (4t)
*/

USE sakila;

SELECT *
FROM film;

SELECT
CASE
	WHEN rating = 'PG' OR rating = 'G' THEN 'PG_G'
    WHEN rating = 'NC-17' OR rating = 'PG-13' THEN 'NC-17_PG-13'
    ELSE 'Nesvarbu'
    END AS 'Reitingo_grupe',
    COUNT(*) AS kiek_viso
FROM film
GROUP BY Reitingo_grupe
HAVING kiek_viso BETWEEN '250' AND '450';

-- 11. 
/*
Naudoti: sakila.customer, 
		 sakila.rental, 
         sakila.inventory, 
         sakila.film;
Pateikite klientų vardus ('first_name') ir pavardes ('last_name') iš CUSTOMER lentelės, kurie išsinuomavo filmą 'AGENT TRUMAN'. 
Užduotį atlikite naudodami subquery konstruktus. Išrikiuokite rezultą pagal kliento vardą (first_name) abecėlės tvarka.
Užduotis atlikta teisingai be subquery vertinama (2t). 
P.S. teisingame subquery konstrukte turi būti 4 x SELECT sakiniai. (4t);
*/
USE sakila;


SELECT*
FROM customer AS c
JOIN rental AS r
	USING (customer_id)
JOIN inventory AS i
	ON r.customer_id = i.inventory_id
JOIN film AS f
	ON i.inventory_id = f.film_id;
   
   
SELECT first_name, last_name, title
FROM customer AS c
LEFT JOIN rental AS r
	USING (customer_id)
LEFT JOIN inventory AS i
	ON r.customer_id = i.inventory_id
LEFT JOIN film AS f
	ON i.inventory_id = f.film_id;

    
SELECT first_name, last_name, title,
COUNT(*) kiek_kartu
FROM customer AS c
JOIN rental AS r
	USING (customer_id)
JOIN inventory AS i
	ON r.customer_id = i.inventory_id
JOIN film AS f
	ON i.inventory_id = f.film_id
    Where title = 'AGENT TRUMAN'
    Group by first_name, last_name
    ORDER BY first_name ASC;

SELECT first_name, last_name, title,
COUNT(*) kiek_kartu
FROM customer AS c
JOIN rental AS r
	USING (customer_id)
JOIN inventory AS i
	ON r.customer_id = i.inventory_id
JOIN film AS f
	ON i.inventory_id = f.film_id
    Where title IN (SELECT title FROM film where title = 'AGENT TRUMAN')
    Group by first_name, last_name
    ORDER BY first_name ASC;

Select *
From(
Select distinct first_name, last_name
FROM
(Select *
FROM (    
SELECT first_name, last_name, title
FROM customer AS c
JOIN rental AS r
	USING (customer_id)
JOIN inventory AS i
	ON r.customer_id = i.inventory_id
JOIN film AS f
	ON i.inventory_id = f.film_id) AS Lentele
    Where title  = 'AGENT TRUMAN') AS Lentele_vardas) AS Lentele_final
    Order by first_name ASC;
    



-- 	(SELECT title FROM film WHERE title = 'AGENT TRUMAN')

-- 12.
/*
Naudoti: sql_invoicing.clients, 
		 sql_invoicing.invoices;
Parašykite užklausą, kuri pateiktų clientų id ('client_id'), klientų pavadinimą ('name') ir kiek tie klientai 
turi neapmokėtų sąskaitų. Neapmokėtom sąskaitom ieškoti naudokite 'payment_date' stulpelį.
Išrikiuokite rezultatą pagal kliento id nuo didžiausios reikšmės mažėjančia tvarka. (3t);
*/
USE sql_invoicing;

SELECT c.client_id, c.name, i.payment_date
FROM clients AS c
JOIN invoices AS i
	USING(client_id)
ORDER BY c.client_id DESC;

SELECT c.client_id, c.name, i.payment_date
FROM clients AS c
JOIN invoices AS i
	USING(client_id)
Where payment_date is null
ORDER BY c.client_id DESC;

SELECT c.client_id, c.name,COUNT(*) AS kiek_neapmoketa
FROM clients AS c
JOIN invoices AS i
	USING(client_id)
Where payment_date is null
GROUP BY c.client_id
ORDER BY c.client_id DESC;

-- 13.
/*
Naudoti: sql_store.products;
Iš products lentelės pateikite produkto pavadinimą ('name').
Šalia pateikite ir kitą stulpelį, kuriame suformuotumėte naują produkto pavadinimo rašymo struktūrą ir pavadinkite jį 'new_name'.
Sąlyga: jei produkto pavadinimas turi tarpelį, tuomet naujoje struktūroje jį pakeiskite į tris žvaigždutes '***';
		jei produkto pavadinimas tarpelio neturi, tuomet pridėkite prieš pavadinimą trys šauktukus '!!!'. (2t);
*/
USE sql_store;

Select *
from products;

SELECT name
FROM products
WHERE name LIKE '% %';

SELECT `name`, REPLACE (`name`, ' ', '***') new_name 
FROM products
Where `name`LIKE '% %';

SELECT `name`, CONCAT('!!!', `name`) AS new_name
FROM products
Where `name` not LIKE '% %';

SELECT
	`name`,
    Case
		WHEN name LIKE  '% %' THEN REPLACE (`name`, ' ', '***')
        When `name`  NOT LIKE '% %' THEN CONCAT('!!!',`name`)
        Else 'Other'
        END AS new_name
	FROM products;
    


-- 14.
/*
Naudoti: sql_store.customers;
Pateikite įrašus iš CUSTOMERS lentelės jei pirkėjas turi daugiau lojalumo taškų ('points') už visų  
esančių pirkėjų lojalumo taškų vidurkį. Naudokite tokiai paieškai SUBQUERY konstruktą.
Išrikiuokite įrašus nuo daugiausiai lojalumo taškų turinčio pirkėjo. (2t);
*/
USE sql_store;

SELECT*
FROM customers;

SELECT AVG(points) AS points_vidurkis
FROM customers;

SELECT*
FROM customers
WHERE points > (SELECT AVG(points) AS points_vidurkis
FROM customers)
ORDER by points DESC;


-- 15.
/*
Parašykite SELECT užklausą, kuri atvaizduotų Jūsų vardą kaip reikšmę stulpelyje pavadinimu 'Vardas',
stulpelį 'VCS MySQL kursas' su reikšme 'Labai patiko :)' ir stulpelį 'Surinkau taškų' su taškų skaičiumi, kurį 
manote jog surinkote spręsdami šį testą. :)))
(1t);
*/

SELECT 'Sarune' AS vardas, '8 ir gal daugiau :), labai noriu i karjeros cenra :)' AS `VSC_MySql_kursas`;
