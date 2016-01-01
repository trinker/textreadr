#' Prints a textreadr Object
#'
#' Prints a textreadr object
#'
#' @param x A \code{\link[base]{data.frame}} textreadr object.
#' @param \ldots ignored.
#' @method print textreadr
#' @export
print.textreadr <- function(x, ...){
    y <- x
    class(x) <- class(x)[!class(x) %in% "textreadr"]
    peek(x)
    invisible(y)
}
