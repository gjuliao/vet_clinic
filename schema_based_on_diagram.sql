CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name VARCHAR(250),
  date_of_birth DATE
);

CREATE TABLE medical_histories (
  id SERIAL PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INT,
  status VARCHAR(250),
  CONSTRAINT patient_fk FOREIGN KEY (patient_id) REFERENCES patients(id),
);

CREATE INDEX patients_id_asc ON medical_histories(patient_id ASC);

CREATE TABLE treatments (
  id SERIAL PRIMARY KEY,
  type VARCHAR(250),
  name VARCHAR(250)
);

CREATE TABLE hist_treat_link (
  medical_histories_id INT,
  treatments_id INT,
  PRIMARY KEY(medical_histories_id, treatments_id),
  CONSTRAINT histories_fk FOREIGN KEY (medical_histories_id) REFERENCES medical_histories(id),
  CONSTRAINT treatments_fk FOREIGN KEY (treatments_id) REFERENCES treatments(id),
);
