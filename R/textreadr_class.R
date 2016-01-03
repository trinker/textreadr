#' Prints a textreadr Object
#'
#' Prints a textreadr object
#'
#' @param x A \code{\link[base]{data.frame}} textreadr object.
#' @param width The width of the columns to be displayed.
#' @param \ldots Other arguments passed to \code{\link[textreadr]{peek}}.
#' @method print textreadr
#' @export
print.textreadr <- function(x, width = 40, ...){
    #y <- x
    #class(x) <- class(x)[!class(x) %in% "textreadr"]
    peek(x, width = width, ...)
    #invisible(y)
}
