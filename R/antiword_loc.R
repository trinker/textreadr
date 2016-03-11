#' Make User Specific Path/URL to Antiword
#'
#' Make a user specific path/URL to Antiword.
#'
#' @return returns a path as a string.
#' @rdname check_antiword_installed
#' @export
#' @examples
#' antiword_loc()
antiword_loc <- function(){
    file.path(strsplit(getwd(), "(/|\\\\)+")[[1]][1], 'antiword/antiword.exe')
}


#' @rdname check_antiword_installed
#' @export
antiword_url <- function(){

    os <- Sys.info()[['sysname']]

    switch(os,
        Windows= {'http://www-stud.rbi.informatik.uni-frankfurt.de/~markus/antiword/antiword-0_37-windows.zip'},
        Linux  = {os},
        Darwin = {os},
        stop(os)
    )
}

