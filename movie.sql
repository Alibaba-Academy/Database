-- create and connect to database
\c postgres
DROP DATABASE dvd_rental;
CREATE DATABASE dvd_rental;
\c dvd_rental

-- create basic tables
CREATE TABLE public.address (
    address_id serial PRIMARY KEY,
    address varchar(255) NOT NULL,
    postal_code varchar(10),
    phone varchar(20) NOT NULL
);

CREATE TABLE public.store (
    store_id serial PRIMARY KEY,
    address_id integer NOT NULL
);

CREATE TABLE public.language (
    language_id serial PRIMARY KEY,
    name varchar(20) NOT NULL
);

CREATE TABLE public.actor (
    actor_id serial PRIMARY KEY,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL
);

CREATE TABLE public.category (
    category_id serial PRIMARY KEY,
    name varchar(255) NOT NULL
);

CREATE TABLE public.film (
    film_id serial PRIMARY KEY,
    language_id integer NOT NULL,
    title varchar(255) NOT NULL,
    rate real DEFAULT 4.99 NOT NULL,
    duration integer
);

CREATE TABLE public.film_actor (
    actor_id integer NOT NULL,
    film_id integer NOT NULL
);

CREATE TABLE public.film_category (
    film_id integer NOT NULL,
    category_id integer NOT NULL

);

CREATE TABLE public.inventory (
    inventory_id serial PRIMARY KEY,
    film_id integer NOT NULL,
    store_id integer NOT NULL
);


CREATE TABLE public.rental (
    rental_id serial PRIMARY KEY,
    rental_date timestamp NOT NULL,
    return_date timestamp,
    inventory_id integer NOT NULL,
    customer_id integer NOT NULL,
    staff_id integer NOT NULL
);

CREATE TABLE public.staff (
    staff_id serial PRIMARY KEY,
    first_name varchar(45) NOT NULL,
    last_name varchar(45) NOT NULL,
    address_id integer NOT NULL,
    email varchar(50),
    store_id integer NOT NULL
);

CREATE TABLE public.customer (
    customer_id serial PRIMARY KEY,
    first_name varchar(45) NOT NULL,
    last_name varchar(45) NOT NULL,
    email varchar(255),
    address_id integer NOT NULL
);


-- data entry
COPY public.address (address, postal_code, phone) FROM '/home/reza/Academy/Database/data/address.dat';
COPY public.store (address_id) FROM '/home/reza/Academy/Database/data/store.dat';
COPY public.language (name) FROM '/home/reza/Academy/Database/data/language.dat';
COPY public.actor (first_name, last_name) FROM '/home/reza/Academy/Database/data/actor.dat';
COPY public.category (name) FROM '/home/reza/Academy/Database/data/category.dat';
COPY public.film (language_id, title, rate, duration) FROM '/home/reza/Academy/Database/data/film.dat';
COPY public.film_actor (actor_id, film_id) FROM '/home/reza/Academy/Database/data/film_actor.dat';
COPY public.film_category (film_id, category_id) FROM '/home/reza/Academy/Database/data/film_category.dat';
COPY public.inventory (film_id, store_id) FROM '/home/reza/Academy/Database/data/inventory.dat';
COPY public.rental (rental_date, inventory_id, customer_id, return_date, staff_id) FROM '/home/reza/Academy/Database/data/rental.dat';
COPY public.staff (first_name, last_name, address_id, email, store_id) FROM '/home/reza/Academy/Database/data/staff.dat';
COPY public.customer (first_name, last_name, email, address_id) FROM '/home/reza/Academy/Database/data/customer.dat';


-- creating indexes
CREATE INDEX idx_fk_address_id ON public.customer USING btree (address_id);
CREATE INDEX idx_fk_film_id ON public.film_actor USING btree (film_id);
CREATE INDEX idx_fk_inventory_id ON public.rental USING btree (inventory_id);
CREATE INDEX idx_fk_language_id ON public.film USING btree (language_id);
CREATE INDEX idx_last_name ON public.customer USING btree (last_name);
CREATE INDEX idx_store_id_film_id ON public.inventory USING btree (store_id, film_id);
CREATE INDEX idx_title ON public.film USING btree (title);

-- adding fk constraints
ALTER TABLE public.store ADD CONSTRAINT store_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE public.film ADD CONSTRAINT film_language_id_fkey FOREIGN KEY (language_id) REFERENCES public.language(language_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE public.film_actor ADD CONSTRAINT film_actor_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES public.actor(actor_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE public.film_actor ADD CONSTRAINT film_actor_film_id_fkey FOREIGN KEY (film_id) REFERENCES public.film(film_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE public.film_category ADD CONSTRAINT film_category_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(category_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE public.film_category ADD CONSTRAINT film_category_film_id_fkey FOREIGN KEY (film_id) REFERENCES public.film(film_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE public.inventory ADD CONSTRAINT film_story_film_id_fkey FOREIGN KEY (film_id) REFERENCES public.film(film_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE public.rental ADD CONSTRAINT rental_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE public.rental ADD CONSTRAINT rental_inventory_id_fkey FOREIGN KEY (inventory_id) REFERENCES public.inventory(inventory_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE public.rental ADD CONSTRAINT rental_staff_id_key FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id);
ALTER TABLE public.staff ADD CONSTRAINT staff_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE public.staff ADD CONSTRAINT staff_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store(store_id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE public.customer ADD CONSTRAINT customer_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;

