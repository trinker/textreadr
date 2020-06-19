#' Data Frame Viewing
#'
#' `peek` - Convenience function to view all the columns of the head
#' of a truncated [base::data.frame()].  `peek` invisibly returns
#' `x`.  This makes its use ideal in a \pkg{dplyr}/\pkg{magrittr} pipeline.
#'
#' @param x A [base::data.frame()] object.
#' @param n Number of rows to display.
#' @param width The width of the columns to be displayed.
#' @param strings.left logical.  If `TRUE` strings will be left aligned.
#' @param ... For internal use.
#' @return Prints a truncated head but invisibly returns `x`.
#' @seealso [utils::head()]
#' @rdname peek
#' @export
#' @details By default \pkg{dplyr} does not print all columns of a ***tibble***.  
#' This makes inspection of data difficult at times, particularly with text 
#' string data.  `peek()` allows the user to see a truncated head for 
#' inspection purposes.
#' @examples
#' peek(mtcars)
#' peek(presidential_debates_2012)
peek <- function (x, n = 10, width = 20, strings.left = TRUE, ...) {
    WD <- options()[["width"]]
    options(width = 3000)
    o <- utils::head(truncdf(as.data.frame(x, stringsAsFactors = FALSE),
        width, reclass =FALSE), n = n, ...)
    header <- "Table: [%s x %s]\n\n"
    cat(
        sprintf(
            header,
            prettyNum(nrow(x), big.mark = ','),
            prettyNum(ncol(x), big.mark = ',')
        )
    )
    out <- utils::capture.output(print(o, right = !strings.left))
    start <- paste(rep(".", nchar(nrow(o))), collapse = "")
    bot <- gsub('(?<=\\.{3})(\\S+?)', ' ', gsub('[^ ]', '.', out[1]), perl = TRUE)
    substring(bot, 1, nchar(nrow(o))) <- start

    #
    # fill <- utils::tail(out, 1)
    # nth_row <- paste(c(paste(rep(".", nchar(nrow(o))), collapse = ""),
    #     sapply(1:ncol(o), function(i) {
    #         elems <- c(colnames(o)[i], as.character(o[[i]]))
    #         elems[is.na(elems)] <- "NA"
    #         lens <- max(nchar(elems), na.rm = TRUE)
    #         if (lens <= 3) return(paste(c(" ", rep(".", lens)),
    #             collapse = ""))
    #         paste(c(rep(" ", (lens + 1) - 3), "..."), collapse = "")
    #     })), collapse = "")
    cat(paste(c(out, bot), collapse = "\n"), "\n")
    options(width = WD)
    invisible(x)
}




#' Data Frame Viewing
#'
#' `unpeek` - Strips out class *textreadr* so that the entire
#' [base::data.frame()] will be printed.
#' @rdname peek
#' @export
unpeek <- function(x) {
    class(x) <- class(x)[!class(x) %in% "textreadr"]
    x
}

truncdf <- function(x, end = 10, begin = 1, reclass = TRUE) {
    x <- as.data.frame(x, stringsAsFactors = FALSE)
    DF <- data.frame(lapply(x, substr, begin, end), check.names = FALSE, stringsAsFactors = FALSE)
    names(DF) <- substring(names(DF), begin, end)
    if (isTRUE(reclass)) class(DF) <- c("trunc", class(DF))
    DF
}


