/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Pikachu', 'Agumon');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT name FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg >= 10.6 AND weight_kg <= 17.3;

/*Part 2 */
/* 1 */
ALTER TABLE animals ADD COLUMN species VARCHAR ( 100 );

/* 2 */
BEGIN;
ALTER TABLE animals RENAME COLUMN species TO unspecified;
ROLLBACK;

/* 3 */
BEGIN;
UPDATE animals SET species = 'Digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = COALESCE(species, 'Pokemon');
COMMIT;

/* 4 */
BEGIN;
DELETE FROM ANIMALS;
ROLLBACK;

/* 5 */
BEGIN;
SAVEPOINT original;
DELETE FROM animals WHERE date_of_birth > ‘2022-01-01;
SAVEPOINT o1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT o1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/* 6 */
SELECT COUNT (*) FROM animals;
SELECT COUNT (*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT name, escape_attempts FROM animals WHERE escape_attempts = ( SELECT MAX(escape_attempts) FROM animals);
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;


/* Part 3 */
/* Animals belong to Melody Pond */
SELECT animals.name FROM animals INNER JOIN owners ON (animals.owner_id = owners.full_name) WHERE owners.full_name = 'Melody Pond';
/* List animals that are pokemon (their type is Pokemon). */
SELECT animals.name FROM animals INNER JOIN species ON (animals.species_id = species.name) WHERE species.name = 'Pokemon';
/* List owners & animals even those who don't have animals*/
SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON (owners.full_name = animals.owner_id);
/* Animals / species */
SELECT species.name, COUNT(*) FROM species INNER JOIN animals ON (animals.species_id = species.name) GROUP BY species.name;
/* Jennifer Orwell Digimonds */
SELECT animals.name, species.name, owners.full_name FROM animals INNER JOIN species ON (animals.species_id = species.name) INNER JOIN owners ON (animals.owner_id = owners.full_name) WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
/* Dean's animal without escape_attempts */
SELECT animals.name, animals.escape_attempts, owners.full_name FROM animals INNER JOIN owners ON (animals.owner_id = owners.full_name) WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
/* Who owns the most animals? */
SELECT owners.full_name, count (*) FROM animals INNER JOIN owners ON (animals.owner_id = owners.full_name) GROUP BY owners.full_name ORDER BY COUNT (*) DESC LIMIT 1;

