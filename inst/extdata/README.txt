This file documents the sources of the data files that are kept in the data/ directories of the respective tutorials. Maybe move these over to those directories . . .

Making babynames into a duckdb:

> usethis::use_directory("inst/extdata")
✔ Setting active project to
  "/Users/spgn/Desktop/ai.tutorials".
> con <- DBI::dbConnect(
+   duckdb::duckdb(),
+   dbdir = "inst/extdata/babynames.duckdb"
+ )
> DBI::dbWriteTable(con, "babynames", babynames::babynames, overwrite = TRUE)
+ DBI::dbDisconnect(con, shutdown = TRUE)
                     
> list.files("inst/extdata")
[1] "babynames.duckdb" "README.txt"      


Making flights into a duckdb:

> usethis::use_directory("inst/extdata")
✔ Setting active project to
  "/Users/spgn/Desktop/ai.tutorials".
 con <- DBI::dbConnect(
  duckdb::duckdb(),
  dbdir = "inst/extdata/flights.duckdb"
 )
> DBI::dbWriteTable(con, "flights", nycflights13::flights, overwrite = TRUE)
+ DBI::dbDisconnect(con, shutdown = TRUE)
                     
> list.files("inst/extdata")
[1] "babynames.duckdb" "flights.duckdb"   "README.txt"      
