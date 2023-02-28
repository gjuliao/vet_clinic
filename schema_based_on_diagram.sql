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

CREATE TABLE invoices (
  id SERIAL PRIMARY KEY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT,
  CONSTRAINT medical_history_id_fk FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id);
);

CREATE INDEX medical_history_id_ASC ON invoices (medical_history_id ASC);

CREATE TABLE invoice_items (
  id SERIAL PRIMARY KEY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT,
  treatment_id INT,
  CONSTRAINT invoice_id_fk FOREIGN KEY (invoice_id) REFERENCES invoices(id);
  CONSTRAINT treatment_id_fk FOREIGN KEY (treatment_id) REFERENCES treatments(id); 
);

CREATE INDEX invoice_id_ASC ON invoice_items(invoice_id ASC);
CREATE INDEX treatment_id_ASC ON invoice_items(treatment_id ASC);

CREATE TABLE hist_treat_link (
  medical_histories_id INT,
  treatments_id INT,
  PRIMARY KEY(medical_histories_id, treatments_id),
  CONSTRAINT histories_fk FOREIGN KEY (medical_histories_id) REFERENCES medical_histories(id),
  CONSTRAINT treatments_fk FOREIGN KEY (treatments_id) REFERENCES treatments(id),
);

CREATE INDEX medical_hist_asc ON hist_treat_link(medical_histories_id ASC);
CREATE INDEX treatment_id_asc ON hist_treat_link(treatments_id ASC);
