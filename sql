CREATE TABLE vae(
    id integer PRIMARY KEY,
    time INTEGER,
    status INTEGER, 
    vae_type CHAR, 
    tot_los INTEGER, 
    icu_los INTEGER, 
    unit CHAR(5), 
   	gender CHAR(6),
	age INTEGER
);

COPY vae
FROM 'C:\Users\Public\vae_exp.csv'
WITH(FORMAT CSV, HEADER);
