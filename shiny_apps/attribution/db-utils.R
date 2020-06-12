
# con = DBI::dbConnect(
#   RPostgreSQL::PostgreSQL(),
#   host = 'politechnika.postgres.database.azure.com',
#   db = "postgres",
#   user = "filipcyprowski@politechnika",
#   password = rstudioapi::askForPassword(),
#   port = 5432
# )
# PAMIETAJ O ZAMKNIECIU POLACZENIA PO SKONCZENIU SESJI!!!
# dla pewnosci zawsze puszczaj:
# DBI::dbListConnections(RPostgreSQL::PostgreSQL()) %>%
#   lapply(DBI::dbDisconnect)

select_all_from = function(from) {
  paste("SELECT * FROM", from)
}
show_tables = function(con) {
  DBI::dbGetQuery(con, select_all_from("pg_catalog.pg_tables"))
}
show_databases = function(con) {
  DBI::dbGetQuery(con, "SELECT datname FROM pg_database")
}



