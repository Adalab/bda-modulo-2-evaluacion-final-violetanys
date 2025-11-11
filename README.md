# SQL - De Cero a EXPERTO 🧨

El siguiente proyecto es la prueba técnica correspondiente al Módulo 2 de Adalab. En el que me introduzco al mundo de MySQL Workbench. 

## Explicación de la prueba:
Para este ejercicio utilizaré la bases de datos Sakila, siendo esta, una base de datos de ejemplo que simula una tienda de alquiler de películas. La evaluación consta de una serie de preguntas que evalúan la comprensión y habilidades en relación con SQL.

## Material utilizado 📗📘📕

Para esta evalución se han utilizado materiales como:
    - Apuntes de clase
    - Notebook LM
    - Explicaciones de GitBook de Adalab
    - Apoyo en ejemplos de ejercicios ya resueltos en clase

## Habilidades adquiridas  📖✍

    Consultas Básicas y Filtrado
Selección y Proyección: 
"SELECT, FROM" -- Habilidad básica para seleccionar columnas y tablas.

Filtros de Rangos:
"BETWEEN, >, AND" -- Filtrar filas basándose en un rango numérico (ejemplo; actor_id 10-20, release_year 2005-2010). [7, 16]

Filtros de Negación: 
"NOT IN, !=" -- Excluir valores específicos de una lista (ejemplo; clasificaciones que no son 'R' o 'PG-13')[8]

Búsqueda de Patrones:
"LIKE, %, OR" -- Buscar subcadenas en campos de texto (ejemplo; 'dog' o 'cat' en la descripción) [14]

Filtros Compuestos:
"AND" -- Aplicar múltiples condiciones estrictas a una fila (ejemplo; clasificación 'R' Y duración > 120 min). [19]

    Agregación y Agrupamiento
Agregación Básica:
"COUNT(), AVG()" -- Calcular métricas básicas: número total de películas por clasificación (COUNT) y promedio de duración (AVG). [12, 21]

Agrupamiento:
"GROUP BY":	Consolidar filas con valores comunes para aplicar funciones de agregación a cada grupo (ejemplo; agrupar por rating para contar). [22]

Filtrado de Grupos:
HAVING	-- La técnica avanzada para filtrar el resultado de una función agregada (ejemplo; encontrar actores con COUNT(películas) > 5, o categorías con AVG(duración) > 120). Esta es una habilidad clave. [21]

Manejo de Texto:
CONCAT() -- Combinar múltiples columnas de texto para una presentación limpia (ejemplo; first_name + last_name).[6]

    Consultas Multi-Tabla (Subconsutas)
Uniones de Múltiples Tablas:
INNER JOIN (Cadena de 3 y 4 tablas)	-- Conectar datos a través de tablas intermedias (film_actor, film_category, inventory, rental) para obtener información compleja (ejemplo; contar alquileres por categoría). [11]

Lógica de Exclusión:
LEFT JOIN + WHERE IS NULL	-- Encontrar filas en una tabla que NO tienen relación en otra (ejemplo; actores sin películas asignadas). [15]

Exclusión por Conjuntos:
NOT IN + Subconsulta: Encontrar elementos de la Tabla A que NO están en una lista generada por una subconsulta compleja (ejemplo; actores que NO están en la lista de actores de 'Horror') [23]

Anidamiento de Consultas:
Subconsultas -- Resolver un problema en pasos lógicos: Primero encontrar un ID o una lista, y luego usar ese resultado para filtrar la consulta principal (ejemplo; títulos de películas de la misma categoría que 'Family'). [17]

Manejo de Fechas:
DATEDIFF() / TIMESTAMPDIFF() -- Calcular intervalos de tiempo (ejemplo; alquileres que duraron más de 5 días).
[22]	


** Los numeros que aparecen entre corchetes [], hacen referencia al ejercicio de la prueba que estamos realizando **
