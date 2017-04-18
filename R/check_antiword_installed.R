#' Check if Antiword is Installed and In Root
#'
#' Checks that Antiword is installed and in root.  Currently this function will
#' try to install Antiword if missing from root for Windows users only.  Other
#' users must install manually.
#'
#' @param antiword.path The path to the latest version of Antiword.  Default
#' attempts to locate automatically.
#' @param verbose If \code{TRUE} messages are printed even when everything is
#' installed.
#' @keywords antiword
#' @references http://nlp.antiword.edu/software/antiword.shtml
#' @export
#' @rdname check_antiword_installed
#' @examples
#' \dontrun{
#' check_antiword_installed()
#' }
check_antiword_installed <- function(antiword.path = textreadr::antiword_loc(),
    verbose = TRUE){

    if (isTRUE(verbose)) message("\nchecking if antiword is installed...\n")

    out <- file.exists(antiword.path)

    if (isTRUE(out)) {
        
        mess <- paste0("antiword appears to be installed.\n\n",
                       "...Let the .doc extraction begin!\n\n")
        if (isTRUE(verbose)) message(mess)
        return(invisible(NULL))
        
    } else {

        os <- Sys.info()[['sysname']]
    
        switch(os,
            Windows= {install_anitword_windows()},
            Linux  = {install_anitword_linux()},
            Darwin = {install_anitword_mac()},
            stop(paste0(os, 'is not a supported operating system.'))
        )        
        
        
    }
}

install_anitword_windows <- function(){
    mess <- "Antiword does not appear to be installed in root.\nWould you like me to try to install it there?"
    message(mess)

    ans <- utils::menu(c("Yes", "No"))
    if (ans == "2") {
        stop("Please consider installing yourself...\n\nhttp://www.winfield.demon.nl")
    } else {
        message("Let me try...\nHold on.  It may take some time...\n")
    }
    
    root <- strsplit(getwd(), "(/|\\\\)+")[[1]][1]
    
    download <- textreadr::antiword_url()    
    temp <- tempdir()
    dest <- file.path(temp, basename(download))
    utils::download.file(download, dest)
    utils::unzip(dest, exdir = temp) # this may need to change for other OSes
    anti <- file.path(temp, 'antiword')
    if (!file.exists(anti)) stop(
        "I let you down :-/\nIt appears the file was not downloaded.\n",
        "Consider installing yourself via:\n\n",
        "http://nlp.antiword.edu/software/antiword.shtml\n\n"
    )
    file.copy(anti, file.path(root, "/"), , TRUE)
    if (file.exists(file.path(root, basename(anti)))) message(
        "I have done it...\nantiword appears to be installed.\n\n",
        "...Let the .doc extraction begin!\n\n"
    )
}

install_anitword_linux <- function(){
    stop('Antiword must be installed first.  Please try:\n\nsudo apt-get install antiword')
}

install_anitword_mac <- function(){
    stop('Antiword must be installed first.  Please install from:\n\nhttp://www.finkproject.org/pdb/package.php/antiword')
}
