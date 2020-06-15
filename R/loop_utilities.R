#' Utilities for Looping to Read In Documents
#' 
#' `loop_counter` - A simple loop counter for tracking the progress of reading in 
#' a batch of files.
#' 
#' @param i Iteration of the loop.
#' @param total Total number of iterations.
#' @param file The file name of that iteration to print out.
#' @param \ldots ignored
#' @return `loop_counter` - Prints loop information.
#' @export
#' @rdname loop_utilities
#' @examples
#' \dontrun{
#' files <- dir(
#'     system.file("docs", package = "textreadr"),
#'     full.names = TRUE, 
#'     recursive = TRUE, 
#'     pattern = '\\.(R?md|Rd?$|txt|sql|html|pdf|doc|ppt|tex)'
#' )
#' 
#' max_wait <- 30
#' total <- length(files)
#' content <- vector(mode = "list", total)
#' 
#' for (i in seq_along(files)){
#' 
#'     loop_counter(i, total, file_name(files[i]))
#' 
#'     content[[i]] <- try_limit(
#'         textreadr::read_document(files[i]), 
#'         max.time = max_wait, 
#'         zero.length.return = NA
#'     )
#' }
#' 
#' 
#' sapply(content, is.null)
#' sapply(content, function(x) length(x) == 1 && is.na(x))
#' content
#' }
loop_counter <- function(i, total, file, ...){

    percent <- round(100*i/total, 0)
    pcnt <- paste0(strrep(' ', 3 - nchar(percent)),  '(', percent, '%)')

    cat(sprintf(
        '%s of %s %s  \'%s\'\n', 
        sprintf(paste0("%0", nchar(total), "d"), i), 
        total, 
        pcnt,
        file
    ))

    utils::flush.console()

}

#' Utilities for Looping to Read In Documents
#' 
#' `file_name` - Like `base::basename` but doesn't choke on long paths.
#' 
#' @param path A character vector, containing path names.
#' @export
#' @rdname loop_utilities
file_name <- function(path) gsub('^.+/', '', path)

#' Utilities for Looping to Read In Documents
#' 
#' `try_limit` - Limits the amount of try that an expression can run for.  This
#' works to limit how long an attempted read-in of a document may take.  Most 
#' useful in a loop with a few very long running document read-ins (e.g., .pdf 
#' files that require tesseract package).  Note that `max.time` can not stop a 
#' `system` call (as many read-in functions are essentially utilizing, but it
#' can limit how many `system` calls are made.  This means a .pdf with multiple 
#' tesseract pages will only allow the first page to read-in before returning an 
#' error result.  Note that this approach does not distinguish between errors
#' running the `expr` and time-out errors.
#' 
#' @param expr An expression to run.
#' @param max.time Max allotted elapsed run time in seconds.
#' @param timeout.return Value to return for timeouts.
#' @param zero.length.return Value to return for length zero expression evaluations. 
#' @param silent logical.  If `TRUE` report of error messages.
#' @export
#' @rdname loop_utilities
try_limit <- function(expr, max.time = Inf, timeout.return = NULL, 
    zero.length.return = timeout.return, silent = TRUE, ...){

    setTimeLimit(cpu = max.time, elapsed = max.time, transient=TRUE)
    on.exit(setTimeLimit(cpu = Inf, elapsed = Inf, transient = FALSE))

    out <- try(expr, silent = silent) 

    if (is.null(out) | inherits(out, "try-error")) return(timeout.return) 
    if (length(out) == 0) zero.length.return else out 

}
