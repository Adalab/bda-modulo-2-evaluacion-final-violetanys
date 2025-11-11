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
SELECT CONCAT(first_name, " ", last_name) AS nombre_actor  -- Se utiliza unit las dos columnas. 
	FROM actor;

/*6.- Encuentra el nombre y apellido de los actores 
que tengan "Gibson" en su apellido*/
SELECT CONCAT(first_name, " ", last_name) AS nombre_actor
	FROM actor   
	WHERE last_name LIKE '%GIBSON%';   

/* 7.- Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20 */
SELECT CONCAT(first_name, ' ', last_name) AS nombre_actor
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

SELECT film_id, rating 
	FROM film; 
-- FINAL
SELECT rating, COUNT(film_id)
	FROM film
	GROUP BY rating;
    
/* 10.- Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su
nombre y apellido junto con la cantidad de películas alquiladas.*/

SELECT *
	FROM customer AS c
	INNER JOIN rental AS r 
		ON c.customer_id = r.customer_id;
-- FINAL
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_alquileres
	FROM customer AS c
	INNER JOIN rental AS r 
		ON c.customer_id = r.customer_id
	GROUP BY c.customer_id, c.first_name, c.last_name;
    
/* 11.- Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría
junto con el recuento de alquileres */
SELECT *
	FROM category AS categ
	INNER JOIN film_category AS fc 
		ON categ.category_id = fc.category_id;
        
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
-- final
SELECT categ.name AS nombre_categoria, COUNT(r.rental_id) AS total_alquileres
	FROM category AS categ
	INNER JOIN film_category fc 
		ON categ.category_id = fc.category_id
	INNER JOIN inventory AS i 
		ON fc.film_id = i.film_id
	INNER JOIN rental AS r 
		ON i.inventory_id = r.inventory_id
	GROUP BY categ.name;
    
    
/* 12.- Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y
muestra la clasificación junto con el promedio de duración.*/
SELECT rating, AVG(length) AS duracion_promedio
	FROM film
    GROUP BY rating; 
   
/* 13.- Encuentra el nombre y apellido de los actores que
 aparecen en la película con title "Indian Love". */
 SELECT film_id
	FROM film
    WHERE title = "INDIAN LOVE";
    
SELECT *
	FROM actor AS a
    INNER JOIN film_actor as fa
		ON a.actor_id = fa.actor_id;
    
SELECT CONCAT(a.first_name, " ", a.last_name) AS nombre_actor
	FROM actor AS a 
    INNER JOIN film_actor as fa 
		ON a.actor_id = fa.actor_id  -- conecta todos los actores en las peliculas en las que ha estado
    INNER JOIN film as f 
		ON fa.film_id = f.film_id  -- se conecta con la anterior para ver el titulo 
    WHERE f.title = "INDIAN LOVE"; 
    
 
  
    
/*14 .- Muestra el título de todas las películas que contengan 
la palabra "dog" o "cat" en su descripción.*/
    SELECT title  
		FROM film 
        WHERE description LIKE "%dog%" OR description LIKE "%cat%";
        
/* 15.- ¿Hay algún actor o actriz que NO
 aparezca en ninguna película en la tabla film_actor? */ -- NO, APARECEN TODOS 
 
 SELECT *
	FROM film_actor;
    
 SELECT a.actor_id, fa.film_id
	FROM actor AS a
    LEFT JOIN film_actor AS fa 
		ON a.actor_id = fa.actor_id;
        
 SELECT a.actor_id, CONCAT(a.first_name, " ", a.last_name) AS nombre_actor
		FROM actor AS a
		LEFT JOIN film_actor AS fa 
			ON a.actor_id = fa.actor_id
		WHERE fa.film_id IS NULL;
        
/* 16-. Encuentra el título de todas las películas 
que fueron lanzadas entre el año 2005 y 2010.*/
; 

SELECT title
	FROM film
	WHERE release_year BETWEEN 2005 AND 2010;  -- todas del 2006. 
    
/* 17-. Encuentra el título de todas las películas 
que son de la misma categoría que "Family".*/ -- category + film + titulo
SELECT *
From category;

SELECT category_id    -- subconsulta 
        FROM category
        WHERE name = "Family";
        
SELECT f.title AS titulo_pelicula  -- uniones 
	FROM film AS f
	INNER JOIN film_category AS fc 
		ON f.film_id = fc.film_id;
        
  -- final       
SELECT f.title AS titulo_pelicula
	FROM film AS f
	INNER JOIN film_category AS fc 
		ON f.film_id = fc.film_id
	WHERE fc.category_id = (SELECT category_id       -- el "filtro"
								FROM category
								WHERE name = "Family");
                                
                                
                                
/* 18.- Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.*/ -- ACTOR TITLE Y 

 SELECT a.actor_id, CONCAT(a.first_name, " ", a.last_name) AS nombre_actor
	FROM actor AS a
    INNER JOIN film_actor as fa
		ON a.actor_id = fa.actor_id;
	
 SELECT a.actor_id, CONCAT(a.first_name, " ", a.last_name) AS nombre_actor, COUNT(fa.film_id) AS total_peliculas
	FROM actor AS a
    INNER JOIN film_actor as fa
		ON a.actor_id = fa.actor_id
	GROUP BY a.actor_id, a.first_name, a.last_name;
    
    -- FINAL (LA CONDICIÓN: HAVING)
SELECT a.actor_id, CONCAT(a.first_name, " ", a.last_name) AS nombre_actor, COUNT(fa.film_id) AS total_peliculas
	FROM actor AS a
    INNER JOIN film_actor as fa
		ON a.actor_id = fa.actor_id
	GROUP BY a.actor_id, a.first_name, a.last_name
    HAVING COUNT(fa.film_id) > 10;
 -- * LOS 200 ACTORES HAN APARECIDO EN MÁS DE 10 PELICULAS
 
/*19 .- Encuentra el título de todas las películas que son "R" y 
tienen una duración mayor a 2 horas en la tabla film.*/

SELECT title
	FROM film
	WHERE rating = 'R' AND length > 120;
    
/* 20.-  Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y
muestra el nombre de la categoría junto con el promedio de duración.*/ -- category + film_category + film (length)
SELECT *
	FROM category AS c
    INNER JOIN film_category AS fc 
		ON c.category_id = fc.category_id;
        
SELECT c.name AS nombre_categoria, AVG(f.length) AS promedio_duración   -- SE PODRÍA INCLUIR UN ROUND () PARA QUE LUEGO NOS REDONDEE LOS DECIM; EJEMP: ROUND(AVG(f.length), 2) AS promedio_duracion
	FROM category AS c
    INNER JOIN film_category AS fc 
		ON c.category_id = fc.category_id
	INNER JOIN film AS f 
		ON fc.film_id = f.film_id
	GROUP BY c.name
    HAVING AVG(f.length) > 120;
/*21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto
con la cantidad de películas en las que han actuado.*/ -- FILM ACTOR + ACTOR

SELECT  CONCAT(a.first_name, " ", a.last_name) AS nombre_actor
	FROM actor AS a
    INNER JOIN film_actor AS fa ON a.actor_id = fa.film_id;
    
    -- FINAL
    SELECT  CONCAT(a.first_name, " ", a.last_name) AS nombre_actor, COUNT(fa.film_id) AS total_peliculas
	FROM actor AS a
    INNER JOIN film_actor AS fa ON a.actor_id = fa.film_id
    GROUP BY a.actor_id, a.first_name, a.last_name
    HAVING COUNT(fa.film_id) >= 5 ; --  el filtro para cumlir 
    
/* 22.- Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una
subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las
películas correspondientes.*/ -- RNTAL

SELECT rental.inventory_id  -- subconsulta 
	FROM rental 
	WHERE DATEDIFF(rental.return_date, rental.rental_date) > 5;
    
SELECT *
	FROM film AS f
    left join inventory AS i
		ON f.film_id = i.film_id;
    
      -- FINAL
SELECT f.title, COUNT(i.inventory_id) AS total_peliculas
	FROM film AS f
    LEFT JOIN inventory AS i
		ON f.film_id = i.film_id
        WHERE i.inventory_id IN (SELECT rental.inventory_id 
								FROM rental 
								WHERE DATEDIFF(rental.return_date, rental.rental_date) > 5)
	GROUP BY f.title;
    
    /* 23.- Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría
"Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
categoría "Horror" y luego exclúyelos de la lista de actores.*/

SELECT fc.film_id   -- obtencion de las peliculas Horror 
	FROM film_category AS fc
    INNER JOIN category AS c 
		ON fc.category_id = c.category_id
    WHERE c.name = "Horror";
    
SELECT fa.actor_id     -- Actores que han actuado en peliculas horror
    WHERE fa.film_id IN (SELECT fc.film_id
							FROM film_category AS fc
							INNER JOIN category AS c 
								ON fc.category_id = c.category_id
							WHERE c.name = "Horror");
                            
        -- FINAL
        
  SELECT  CONCAT(a.first_name, " ", a.last_name) AS nombre_actor
	FROM actor AS a
    WHERE a.actor_id NOT IN (SELECT fa.actor_id
								FROM film_actor AS fa
									WHERE fa.film_id IN (SELECT fc.film_id
															FROM film_category AS fc
															INNER JOIN category AS c 
															ON fc.category_id = c.category_id
															WHERE c.name = "Horror"));
/*24.- Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en
la tabla film.*/  -- film + film_category + category

SELECT *
	FROM film AS f
    INNER JOIN film_category AS fc
		ON f.film_id = fc.film_id;
	
SELECT f.title, c.name AS nombre_categ, f.length 
	FROM film AS f
    INNER JOIN film_category AS fc
		ON f.film_id = fc.film_id 
    INNER JOIN category AS c
		ON c.category_id = fc.category_id  -- union con el anterior
	WHERE C.name = "COMEDY" AND f.length  > 100;