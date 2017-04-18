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

    myPaths <- c("antiword", "~/.cabal/bin/antiword", "~/Library/Haskell/bin/antiword",
        "C:\\PROGRA~1\\antiword\\antiword.exe", "/usr/bin/antiword",
        "/Applications/antiword.app/Contents/MacOS/antiword", 
        file.path(strsplit(getwd(), "(/|\\\\)+")[[1]][1], 'antiword/antiword.exe'))
    
    antiloc <- Sys.which(myPaths)
    temp <- antiloc[antiloc != ""]

    short.path <- which.min(unlist(lapply(gregexpr("[Aa]ntiword", temp), "[[", 1)))
    temp[short.path]
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

