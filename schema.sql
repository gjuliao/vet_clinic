/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id integer,
    name varchar(100),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal,
    species_id integer,
    owners_id integer,
    PRIMARY KEY (id),
    CONSTRAINT species_id
        FOREIGN KEY (species_id)
            REFERENCES species (species_id),
    CONSTRAINT owners_id
        FOREIGN KEY (owners_id)
            REFERENCES owners (owners_id)
);

CREATE TABLE owners (
id BIGSERIAL,
full_name varchar(100),
age int,
PRIMARY KEY (id)
);

CREATE TABLE species (
id BIGSERIAL,
name varchar(100),
PRIMARY KEY (id)
);

CREATE TABLE vets (
id SERIAL,
name varchar(100),
age INT,
date_of_graduation DATE,
PRIMARY KEY (id)
);

CREATE TABLE specialization (
id SERIAL,
species_id INT,
vets_id INT,
CONSTRAINT species_id
    FOREIGN KEY (species_id)
        REFERENCES species (id)
CONSTRAINT vets_id
    FOREIGN KEY (vets_id)
        REFERENCES vets(id)
);

CREATE TABLE visits (
id SERIAL,
animals_id INT FOREIGN KEY (animals_id) REFERENCES vets(id),
vets_id INT,
date_of_visit DATE,
CONSTRAINT vets_id
    FOREIGN KEY (vets_id)
        REFERENCES vets(id)
);

/* Create index for animals_id on visits table*/
CREATE INDEX animals_id_desc ON visits(animals_id DESC);

/* Create index for vets_id on visits table */
CREATE INDEX vets_id_desc ON visits(vets_id DESC);

/* Create index for emails_desc on owners table */
CREATE INDEX email_desc ON owners(email DESC);
