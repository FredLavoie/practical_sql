## Practical SQL

This repo contains the code for the exercises in the book [Practical SQL](https://nostarch.com/practical-sql-2nd-edition/)

#### Setup instructions

The easiest way to work with a database locally is to use Docker. Here are the steps to setting up a Docker container to work on the exercises in the book:

-   add a `.env` file and write a database name, username and password that match the variable names of the `docker-compose` file
-   in a terminal window, run `docker-compose up -d` which will create the image if you don't have it locally already, and will start the postgres database container.
-   run `docker ps` to confirm that the container is running, and copy the container id
-   run `docker exec -ti <container_id> bash` to get into the container
-   run `psql -h localhost -U <username> <database_name>` to access the CLI for your database to run the queries

#### Resources

-   [code for first edition](https://github.com/anthonydb/practical-sql)
-   [code for second edition](https://github.com/anthonydb/practical-sql-2)
