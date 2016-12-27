#' Check if Antiword is Installed and In Root
#'
#' Checks that Antiword is installed and in root.  Currently this function will
#' try to install Antiword if missing from root for Windows users only.  Other
#' users must install manually.
#'
#' @param antiword.path The version of antiword's antiword.
#' @param download The download url for antiword's antiword.
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
    download = textreadr::antiword_url(), verbose = TRUE){

    if (isTRUE(verbose)) message("\nchecking if antiword is installed...\n")

    root <- strsplit(getwd(), "(/|\\\\)+")[[1]][1]
    out <- file.exists(antiword.path)

    if (isTRUE(out)) {
        mess <- paste0("antiword appears to be installed.\n\n",
                       "...Let the .doc extraction begin!\n\n")
        if (isTRUE(verbose)) message(mess)
        return(invisible(NULL))
    } else {
        mess <- "antiword does not appear to be installed in root.\nWould you like me to try to install it there?"
        message(mess)

        ans <- utils::menu(c("Yes", "No"))
        if (ans == "2") {
            stop("Please consider installing yourself...\n\nhttp://www.winfield.demon.nl")
        } else {
            message("Let me try...\nHold on.  It may take some time...\n")
        }

        if (!isTRUE(check_availability())) {
            stop(sprintf(
                "Currently only %s installs are handled.\nPlease consider installing yourself...\n\nhttp://www.winfield.demon.nl",
                paste(names(available)[available], collapse=", ")
            ))
        }
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
}

