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
SELECT animals.name FROM animals INNER JOIN owners ON (animals.owner_id = owners.id) WHERE owners.full_name = 'Melody Pond';
/* List animals that are pokemon (their type is Pokemon). */
SELECT animals.name FROM animals INNER JOIN species ON (animals.species_id = species.id) WHERE species.name = 'Pokemon';
/* List owners & animals even those who don't have animals*/
SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON (owners.id = animals.owner_id);
/* Animals / species */
SELECT species.name, COUNT(*) FROM species INNER JOIN animals ON (animals.species_id = species.id) GROUP BY species.name;
/* Jennifer Orwell Digimonds */
SELECT animals.name, species.name, owners.full_name FROM animals INNER JOIN species ON (animals.species_id = species.id) INNER JOIN owners ON (animals.owner_id = owners.id) WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
/* Dean's animal without escape_attempts */
SELECT animals.name, animals.escape_attempts, owners.full_name FROM animals INNER JOIN owners ON (animals.owner_id = owners.id) WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
/* Who owns the most animals? */
SELECT owners.full_name, count (*) FROM animals INNER JOIN owners ON (animals.owner_id = owners.id) GROUP BY owners.full_name ORDER BY COUNT (*) DESC LIMIT 1;

/* Part 4 */
/* Last animal seen by William Tatcher */
SELECT animals.name, visits.date_of_visit FROM visits INNER JOIN vets ON (visits.vets_id = vets.id) INNER JOIN animals ON (visits.animals_id = animals.id) WHERE vets.name = 'William Tatcher' ORDER BY visits.date_of_visit DESC LIMIT 1;
/* Different animals that visited Stephanie Mendez*/
SELECT COUNT(DISTINCT (visits.animals_id)) FROM visits INNER JOIN vets ON (visits.vets_id = vets.id) WHERE vets.name = 'Stephanie Mendez';
/* List all vets specialization, even those with no specialization.*/
SELECT vets.name, vets.age, species.name FROM vets LEFT JOIN specialization ON (vets.id = specialization.vets_id) LEFT JOIN species ON (species.id = specialization.species_id);
/* Animals that visited Stephanie Mendez between April 1st and August 30th, 2020.*/
SELECT DISTINCT (animals.id), animals.name FROM visits INNER JOIN vets ON (visits.vets_id = vets.id) INNER JOIN animals ON (visits.animals_id = animals.id) WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';
/* Animal with most vets visits*/
SELECT animals.id, animals.name, COUNT(*) FROM visits INNER JOIN animals ON (visits.animals_id = animals.id) GROUP BY animals.id ORDER BY count(*) DESC LIMIT 1;
/* Maisy Smith's first visit?*/
SELECT visits.date_of_visit, animals.name FROM vets INNER JOIN visits ON (vets.id = visits.vets_id) INNER JOIN animals ON (visits.animals_id = animals.id) WHERE vets.name = 'Maisy Smith' ORDER BY visits.date_of_visit LIMIT 1;
/* Most recent visit: animal information, vet information, and date of visit.*/
SELECT animals.name, date_of_birth, escape_attempts, neutered, weight_kg, vets.name, vets.age, vets.date_of_graduation, visits.date_of_visit FROM visits INNER JOIN animals ON ( visits.animals_id = animals.id) INNER JOIN vets ON (visits.vets_id = vets.id) ORDER BY date_of_visit DESC LIMIT 1;
/* Visits with vet not specialize in animal's species*/
SELECT COUNT(*) FROM visits INNER JOIN animals ON (visits.animals_id = animals.id)INNER JOIN specialization ON (visits.vets_id = specialization.vets_id) WHERE animals.species_id <> specialization.species_id;
/* Look for Masy Smith most frequent specialty. */
SELECT species.name, COUNT(*) FROM visits INNER JOIN animals ON (visits.animals_id = animals.id) INNER JOIN vets ON (visits.vets_id = vets.id) INNER JOIN species ON (animals.species_id = species.id) WHERE vets.name = 'Maisy Smith' GROUP BY species.name ORDER BY COUNT(*) DESC LIMIT 1;

