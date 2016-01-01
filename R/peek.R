#' Data Frame Viewing
#'
#' Convenience function to view all the columns of the head
#' of a truncated \code{\link[base]{data.frame}}.  \code{peek} invisibly returns
#' \code{x}.  This makes its use ideal in a \pkg{dplyr}/\pkg{magrittr} pipeline.
#'
#' @param x A \code{\link[base]{data.frame}} object.
#' @param n Number of rows to display.
#' @param width The width of the columns to be displayed.
#' @param \ldots For internal use.
#' @return Prints a truncated head but invisibly returns \code{x}.
#' @seealso \code{\link[utils]{head}}
#' @export
#' @details By default \pkg{dplyr} does not print all columns of a data frame
#' (\code{tbl_df}).  This makes inspection of data difficult at times,
#' particularly with text string data.  \code{peek} allows the user to see a
#' truncated head for inspection purposes.
#' @examples
#' peek(mtcars)
#' peek(presidential_debates_2012)
peek <- function (x, n = 10, width = 20, ...) {
    WD <- options()[["width"]]
    options(width = 3000)
    o <- utils::head(truncdf(as.data.frame(x), width), n = n,
        ...)
    header <- "Source: local data frame [%s x %s]\n\n"
    cat(sprintf(header, nrow(x), ncol(x)))
    out <- utils::capture.output(o)
    fill <- utils::tail(out, 1)
    nth_row <- paste(c(paste(rep(".", nchar(nrow(o))), collapse = ""),
        sapply(1:ncol(o), function(i) {
            elems <- c(colnames(o)[i], as.character(o[[i]]))
            elems[is.na(elems)] <- "NA"
            lens <- max(nchar(elems), na.rm = TRUE)
            if (lens <= 3) return(paste(c(" ", rep(".", lens)),
                collapse = ""))
            paste(c(rep(" ", (lens + 1) - 3), "..."), collapse = "")
        })), collapse = "")
    cat(paste(c(out, nth_row), collapse = "\n"), "\n")
    options(width = WD)
    invisible(x)
}

truncdf <-
function(x, end=10, begin=1) {
    x <- as.data.frame(x)
    DF <- data.frame(lapply(x, substr, begin, end), check.names=FALSE)
    names(DF) <- substring(names(DF), begin, end)
    class(DF) <- c("trunc", class(DF))
    DF
}


