#' Read In Multiple Files From a Directory
#'
#' Read in multiple files from a directory and create a
#' \code{\link[base]{data.frame}}.
#'
#' @param path Path to the directory.
#' @param pattern An optional regular expression. Only file names which match
#' the regular expression will be returned.
#' @param doc.col A string naming the document columns (i.e., file names sans
#' file extension).
#' @param all.files Logical.   If \code{FALSE}, only the names of visible files
#' are returned. If \code{TRUE}, all file names will be returned.
#' @param recursive Logical. Should the listing recurse into directories?
#' @param \ldots Other arguments passed to read_document functions.
#' @return Returns a \code{\link[base]{data.frame}} with file names as a document
#' column and content as a text column.
#' @export
#' @examples
#' read_dir(system.file("docs/Maas2011/pos", package = "textreadr"))
#' read_dir(system.file("docs/Maas2011", package = "textreadr"), recursive=TRUE)
read_dir <- function(path, pattern = NULL, doc.col = "document", all.files = FALSE,
    recursive = FALSE, ...){

    to_read_in <- list_files(path, all.files = all.files, full.names = TRUE,
        recursive = recursive)

    if (identical(character(0), to_read_in)) stop("The following location does not appear to contain files:\n   -", path)

    text <- stats::setNames(lapply(to_read_in, read_document, ...), tools::file_path_sans_ext(basename(to_read_in)))

    errs <- sapply(text, inherits, "try-error")

    if (sum(errs) > 0) {
        warning(sprintf("The following files failed to read in and were removed:\n%s",
            paste(paste0("  -", to_read_in[errs]), collapse="\n")))

        text <- text[errs]
    }
    out <- textshape::tidy_list(text, doc.col)
    class(out) <- c("textreadr", "data.frame")
    out
}


# read_document <- function(x, ...){
#     try(switch(tools::file_ext(x),
#         docx = {textshape::combine(read_docx(x, ...))},
#         pdf = {textshape::combine(read_pdf(x, ...)[["text"]])},
#         txt = textshape::combine(suppressWarnings(readLines(x, ...)))
#     ))
# }

list_files <- function(path=".", pattern=NULL, all.files=FALSE, full.names=TRUE,
    ignore.case=FALSE, recursive=FALSE) {

    # use full.names=TRUE to pass to file.info
    all <- list.files(path, pattern, all.files, full.names=TRUE, recursive=recursive, ignore.case)
    fls <- all[!file.info(all)$isdir]
    ## determine whether to return full names or just dir names
    if(isTRUE(full.names)) return(fls)
    basename(fls)
}
