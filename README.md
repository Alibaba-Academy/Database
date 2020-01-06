# Getting started
## installation
Install the `postgresql` package along with a `postgresql-contrib` package that adds some additional utilities and functionality:

    sudo apt update
    sudo apt install postgresql postgresql-contrib

## Swithching to postgres user
You have to work with `postgresql` with its user named `postgres`. You can either switch user and work:

    sudo -i -u postgres
## Creating Database
For creating a database use:


    createdb database_name

### Notice
For creating a database from other users directly, you can use:

    sudo -u postgres createdb database_name
	
## Entering and exiting Postgres prompt
You can access a Postgres prompt by typing:

    psql
And exit by typing and entering `\q`
### Notice
For accessing a Postgres prompt from other users directly, you can use:

    sudo -u postgres psql



