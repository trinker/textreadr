#' Unzip/Unzip Files
#' 
#' Unzip/untar files and return the location of exit directory.  This is a convenience 
#' function (wrapper for [utils::unzip()]) to make the function more 
#' pipe-able.  Additionally, the location of the unzip defaults to the directory 
#' containing the zip file.
#' 
#' @param file Path to the zip file.
#' @param loc The output directory location.
#' @param ... Other arguments passed to [utils::unzip()].
#' @return Returns the path to where the zip file was unzipped to.
#' @keywords unzip
#' @export
#' @rdname un_zip
#' @seealso [utils::unzip()]
#' @examples
#' \dontrun{
#' if (!require("pacman")) install.packages("pacman")
#' pacman::p_load(tidyverse)
#' 
#' dl_loc <- 'http://www.cs.uic.edu/~liub/FBS/CustomerReviewData.zip'  %>%
#'     download() %>%
#'     un_zip()
#' 
#' 
#' dir(dl_loc, pattern = '[Cc]ustomer')
#' dir(dl_loc, pattern = 'customer', full.names = TRUE)[1] %>%
#'     dir()
#' 
#' dir(dl_loc, pattern = 'customer', full.names = TRUE)[1] %>%
#'     dir(pattern = '\\.txt$', full.names = TRUE) 
#' 
#' dir(dl_loc, pattern = 'customer', full.names = TRUE)[1] %>%
#'     read_dir()
#' 
#' 
#' dir(dl_loc, pattern = 'customer', full.names = TRUE)[1] %>%
#'     dir(pattern = '\\.txt$', full.names = TRUE) %>%
#'     `[`(1) %>%
#'     read_document()
#' }
un_zip <- function(file, loc = dirname(file), ...){
    
    utils::unzip(file, exdir = loc, ...)
    
    loc
}


#' @export
#' @rdname un_zip
un_tar <- function(file, loc = dirname(file), ...){
    
    utils::untar(file, exdir = loc, ...)
    
    loc
}