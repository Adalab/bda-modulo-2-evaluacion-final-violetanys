USE sakila;

/* 1.- Selecciona todos los nombres de las películas 
sin que aparezcan duplicados.*/

SELECT DISTINCT title       -- DISTINCT asegura la eliminación de duplicados. Muestra solo una instancia de cada valor 
	FROM film;

/* 2.- Muestra los nombres de todas las películas que 
tengan una clasificación de "PG-13".*/

SELECT title      -- podría haber puesto (*) pero solo pide los titulos, no lo demás. 
	FROM film
	WHERE rating = 'PG-13';  -- El (=) busca coincidencias exactas.
    
/* 3.- Encuentra el título y la descripción de todas las películas que 
contengan la palabra "amazing" en su descripciin*/

SELECT title, description
	FROM film
	WHERE description LIKE '%amazing%';  -- Se utiliza para encontrar patrones de texto. 

/* 4.- Encuentra el título de todas las películas que 
tengan una duración mayor a 120 minutos*/
SELECT title
	FROM film
	WHERE length > 120;


/* 5.- Recupera los nombres de todos los actores */
SELECT CONCAT(first_name, ' ', last_name) AS actor_name    -- Se utiliza unit las dos columnas. 
	FROM actor;

/*6.- Encuentra el nombre y apellido de los actores 
que tengan "Gibson" en su apellido*/
SELECT CONCAT(first_name, ' ', last_name) AS actor_name
	FROM actor   
	WHERE last_name LIKE '%GIBSON%';   

/* 7.- Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20 */
SELECT CONCAT(first_name, ' ', last_name) AS actor_name
	FROM actor 
	WHERE actor_id BETWEEN 10 AND 20;   -- Between para buscar valores dentro de un rango.
 -- WHERE actor_id >= 10 AND actor_id <= 20;  (Tambien podría usar los operadores de comparación, pero es una forma más "manual")
 
/* 8.- Encuentra el título de las películas en la tabla film que 
no sean ni "R" ni "PG-13" en cuanto a su clasificación*/

SELECT title
	FROM film
	WHERE rating NOT IN ('R', 'PG-13');
-- WHERE rating != 'R' AND rating != 'PG-13'; (Tambien podría usar los operadores de comparación, pero es una forma más "manual")

/* 9.- Encuentra la cantidad total de películas en cada clasificación de la tabla film 
y muestra la clasificación junto con el recuento*/

SELECT rating, COUNT(film_id)
	FROM film
	GROUP BY rating;
    
/* 10.- Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su
nombre y apellido junto con la cantidad de películas alquiladas.*/

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_alquileres
	FROM customer AS c
	JOIN rental AS r ON c.customer_id = r.customer_id
	GROUP BY c.customer_id, c.first_name, c.last_name;
    
/* 11.- Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría
junto con el recuento de alquileres */
SELECT categ.name, fc.film_id
	FROM category AS categ
	INNER JOIN film_category AS fc 
		ON categ.category_id = fc.category_id;
        
SELECT categ.name, i.inventory_id 
	FROM category AS categ
	INNER JOIN film_category AS fc 
		ON categ.category_id = fc.category_id
	INNER JOIN inventory AS i
		ON fc.film_id = i.film_id;

SELECT categ.name AS nombre_categoria, COUNT(r.rental_id) AS total_alquileres
	FROM category AS categ
	INNER JOIN film_category fc 
		ON categ.category_id = fc.category_id
	INNER JOIN inventory AS i 
		ON fc.film_id = i.film_id
	INNER JOIN rental AS r 
		ON i.inventory_id = r.inventory_id
	GROUP BY categ.name;
