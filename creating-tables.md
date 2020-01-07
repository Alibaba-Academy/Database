# PostgreSQL CREATE TABLE
To create a new table in PostgreSQL, you use the `CREATE TABLE` statement:


    CREATE TABLE table_name(
    column_name TYPE column_constraint,
    table_constraint) INHERITS exisiting_table_name;


## Types

The `TYPE` can be:

- BOOLEAN


- CHAR(n)
- VARCAHR(n)
- TEXT


- SERIAL
- SMALLINT
- INT
- FLOAT(n)
- REAL
- NUMERIC(p,s)


- DATE
- TIME
- TIMESTAMP
- TIMESTAMPTZ
- INTERVAL

**PostgreSQL column constraints**
The following are the commonly used column constraints in PostgreSQL:

- NOT NULL – the value of the column cannot be `NULL`.
- UNIQUE – the value of the column must be unique across the whole table. However, the column can have many `NULL` values because PostgreSQL treats each `NULL` value to be unique. Notice that SQL standard only allows one `NULL` value in the column that has the `UNIQUE` constraint.
- PRIMARY KEY– this constraint is the combination of `NOT NULL` and `UNIQUE` constraints. You can define one column as `PRIMARY KEY` by using column-level constraint. In case the primary key contains multiple columns, you must use the table-level constraint.
- CHECK – enables to check a condition when you insert or update data. For example, the values in the `price` column of the `product` table must be positive values.
- REFERENCES – constrains the value of the column that exists in a column in another table. You use `REFERENCES` to define the foreign key constraint.


## PostgreSQL CREATE TABLE example

We will create a new table named `Student`


    CREATE TABLE Student(
       id SERIAL PRIMARY KEY,
       username VARCHAR (50) UNIQUE NOT NULL,
       password VARCHAR (50) NOT NULL,
       email VARCHAR (355) UNIQUE NOT NULL,
       department_id INT NOT NULL,
       first_name VARCHAR(255) NOT NULL,
       last_name VARCHAR(255) NOT NULL,
       date_joined TIMESTAMPTZ NOT NULL,
       last_login TIMESTAMPTZ,
       PRIMARY KEY (id),
       CONSTRAINT department_id_fk FOREIGN KEY (department_id)
          REFERENCES Department (id) MATCH SIMPLE
          ON UPDATE NO ACTION ON DELETE NO ACTION,
    );

