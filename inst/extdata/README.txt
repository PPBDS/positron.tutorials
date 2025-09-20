This file documents the sources of the files in this directory.

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
