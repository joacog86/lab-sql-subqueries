USE sakila;

/*Write SQL queries to perform the following tasks using the Sakila database:

Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
List all films whose length is longer than the average length of all the films in the Sakila database.
Use a subquery to display all actors who appear in the film "Alone Trip".*/


/*
1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.*/


SELECT COUNT(INVENTORY_ID) FROM (
SELECT I.INVENTORY_ID, F.FILM_ID FROM INVENTORY AS I
LEFT JOIN FILM AS F ON I.FILM_ID = F.FILM_ID
WHERE F.TITLE = "Hunchback Impossible") AS SUB1;


/*
2. List all films whose length is longer than the average length of all the films in the Sakila database.*/

SELECT F.TITLE, F.LENGTH FROM FILM F
WHERE F.LENGTH > (SELECT AVG(LENGTH) FROM FILM );


/*
3. Use a subquery to display all actors who appear in the film "Alone Trip.*/

SELECT SUB1.FILM_ID, A.ACTOR_ID, A.FIRST_NAME, A.LAST_NAME FROM (
	SELECT FA.ACTOR_ID, FA.FILM_ID FROM FILM_ACTOR AS FA
    LEFT JOIN FILM AS F ON FA.FILM_ID = F.FILM_ID
	WHERE FA.FILM_ID IN ( 
		SELECT FILM_ID FROM FILM F
		WHERE F.TITLE = "Alone Trip")) AS SUB1
LEFT JOIN ACTOR AS A ON SUB1.ACTOR_ID = A.ACTOR_ID;


-- MAS FACIL SIN SUBQUERY --
SELECT F.FILM_ID, A.ACTOR_ID, A.FIRST_NAME, A.LAST_NAME FROM FILM F
LEFT JOIN FILM_ACTOR AS FA ON F.FILM_ID = FA.FILM_ID
LEFT JOIN ACTOR AS A ON FA.ACTOR_ID = A.ACTOR_ID 
WHERE F.TITLE = "Alone Trip";
