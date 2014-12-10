options("repos" = c(CRAN = "http://cran.rstudio.com/"))

## Create a new invisible environment for all the functions to go in so it doesn't clutter your workspace.
.env <- new.env()

## Returns a logical vector TRUE for elements of X not in Y
.env$"%nin%" <- function(x, y) !(x %in% y) 

## Returns names(df) in single column, numbered matrix format.
.env$n <- function(df) matrix(names(df)) 

## Single character shortcuts for summary() and head().
.env$s <- base::summary
.env$h <- utils::head

## ht==headtail, i.e., show the first and last 10 items of an object
.env$ht <- function(d) rbind(head(d,10),tail(d,10))

## List all functions in a package (also from @_inundata)
.env$lsp <-function(package, all.names = FALSE, pattern) {
    package <- deparse(substitute(package))
    ls(
        pos = paste("package", package, sep = ":"),
        all.names = all.names,
        pattern = pattern
    )
}

## Attach all the variables above
attach(.env)
