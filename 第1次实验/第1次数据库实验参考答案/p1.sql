-- DROP SCHEMA gaussdb;

CREATE SCHEMA gaussdb AUTHORIZATION gaussdb;
-- gaussdb.book definition

-- Drop table

-- DROP TABLE gaussdb.book;

CREATE TABLE gaussdb.book (
	book_id bpchar(10) NOT NULL,
	book_name varchar(255) NULL,
	book_author varchar(255) NULL,
	book_price numeric(10, 2) NULL,
	book_count int4 NULL,
	CONSTRAINT book_pkey PRIMARY KEY (book_id)
)
WITH (
	orientation=row,
	compression=no
);


-- gaussdb.persons definition

-- Drop table

-- DROP TABLE gaussdb.persons;

CREATE TABLE gaussdb.persons (
	id_p int4 NOT NULL,
	lastname varchar(255) NOT NULL,
	firsname varchar(255) NULL,
	address varchar(255) NULL,
	city varchar(255) NULL,
	CONSTRAINT persons_pkey PRIMARY KEY (id_p)
)
WITH (
	orientation=row,
	compression=no
);


-- gaussdb.orders definition

-- Drop table

-- DROP TABLE gaussdb.orders;

CREATE TABLE gaussdb.orders (
	id_o int4 NOT NULL,
	id_p int4 NULL,
	id_b bpchar(10) NULL,
	CONSTRAINT orders_pkey PRIMARY KEY (id_o),
	CONSTRAINT orders_fk FOREIGN KEY (id_b) REFERENCES gaussdb.book(book_id),
	CONSTRAINT orders_id_p_fkey FOREIGN KEY (id_p) REFERENCES gaussdb.persons(id_p)
)
WITH (
	orientation=row,
	compression=no
);