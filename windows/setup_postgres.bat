
set PGPASSWORD=postgres

psql -Upostgres -c "CREATE USER omero PASSWORD 'omero'"
createdb -Upostgres -Oomero omero

set PGPASSWORD=


