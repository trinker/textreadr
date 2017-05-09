#' Read In Multiple Transcript Files From a Directory
#'
#' Read in multiple transcript files from a directory and create a
#' \code{\link[base]{data.frame}}.
#'
#' @param path Path to the directory.
#' @param col.names  A character vector specifying the column names of the
#' transcript columns (document, person, dialogue).
#' @param pattern An optional regular expression. Only file names which match
#' the regular expression will be returned.
#' @param all.files Logical.   If \code{FALSE}, only the names of visible files
#' are returned. If \code{TRUE}, all file names will be returned.
#' @param recursive Logical. Should the listing recurse into directories?
#' @param skip Integer; the number of lines of the data file to skip before
#' beginning to read data.
#' @param merge.broke.tot logical.  If \code{TRUE} and if the file being read in
#' is .docx with broken space between a single turn of talk read_transcript
#' will attempt to merge these into a single turn of talk.
#' @param header logical.  If \code{TRUE} the file contains the names of the
#' variables as its first line.
#' @param dash A character string to replace the en and em dashes special
#' characters (default is to remove).
#' @param ellipsis A character string to replace the ellipsis special characters.
#' @param quote2bracket logical. If \code{TRUE} replaces curly quotes with curly
#' braces (default is \code{FALSE}).  If \code{FALSE} curly quotes are removed.
#' @param rm.empty.rows logical.  If \code{TRUE}
#' \code{\link[textreadr]{read_transcript}}  attempts to remove empty rows.
#' @param na A character string to be interpreted as an \code{NA} value.
#' @param sep The field separator character. Values on each line of the file are
#' separated by this character.  The default of \code{NULL} instructs
#' \code{\link[textreadr]{read_transcript}} to use a separator suitable for the file
#' type being read in.
#' @param comment.char A character vector of length one containing a single
#' character or an empty string. Use \code{""} to turn off the interpretation of
#' comments altogether.
#' @param max.person.nchar The max number of characters long names are expected
#' to be.  This information is used to warn the user if a separator appears beyond
#' this length in the text.
#' @param ignore.case logical.  If \code{TRUE} case in the \code{pattern} argument
#' will be ignored.
#' @param \ldots ignored.
#' @return Returns a dataframe of documents, dialogue, and people.
#' @export
#' @seealso read_transcript
#' @examples
#' skips <- c(0, 1, 1, 0, 0, 1)
#' path <- system.file("docs/transcripts", package = 'textreadr')
#' textreadr::peek(read_dir_transcript(path, skip = skips), Inf)
#'
#' \dontrun{
#' ## with additional  cleaning
#' library(tidyverse, textshape, textclean)
#'
#' path %>%
#'     read_dir_transcript(skip = skips) %>%
#'     textclean::filter_row("Person", "^\\[") %>%
#'     mutate(
#'         Person = stringi::stri_replace_all_regex(Person, "(^/\\s*)|(:\\s*$)", "") %>%
#'             trimws(),
#'         Dialogue = stringi::stri_replace_all_regex(Dialogue, "(^/\\s*)", "")
#'     ) %>%
#'     peek(Inf)
#' }
read_dir_transcript <- function(path, col.names = c("Document", "Person", "Dialogue"),
    pattern = NULL, all.files = FALSE,
    recursive = FALSE, skip = 0, merge.broke.tot = TRUE, header = FALSE, dash = "", ellipsis = "...",
    quote2bracket = FALSE, rm.empty.rows = TRUE, na = "", sep = NULL,
    comment.char = "", max.person.nchar = 20, ignore.case = FALSE, ...) {

    to_read_in <- list_files(path, all.files = all.files, full.names = TRUE, recursive = recursive)

    if (!is.null(pattern)) to_read_in <- grep(pattern, to_read_in, ignore.case = ignore.case, value = TRUE, perl=TRUE)

    if (identical(character(0), to_read_in)) {
        stop("The following location does not appear to contain files:\n   -", path)
    }

    if (length(skip) == 1) skip <- rep(skip, length(to_read_in))
    if (length(merge.broke.tot) == 1) merge.broke.tot <- rep(merge.broke.tot, length(to_read_in))
    if (length(header) == 1) header<- rep(header, length(to_read_in))
    if (length(dash) == 1) dash <- rep(dash, length(to_read_in))
    if (length(ellipsis) == 1) ellipsis <- rep(ellipsis, length(to_read_in))
    if (length(quote2bracket) == 1) quote2bracket <- rep(quote2bracket, length(to_read_in))
    if (length(rm.empty.rows) == 1) rm.empty.rows <- rep(rm.empty.rows, length(to_read_in))
    if (length(na) == 1) na <- rep(na, length(to_read_in))
    if (is.null(sep)) sep <- lapply(seq_along(to_read_in), function(i) NULL)
    if (length(sep) == 1) sep <- rep(sep, length(to_read_in))
    if (length(comment.char) == 1) comment.char <- rep(comment.char, length(to_read_in))
    if (length(max.person.nchar) == 1) max.person.nchar <- rep(max.person.nchar, length(to_read_in))

    arg_list <- list(skip, merge.broke.tot, header, dash, ellipsis, quote2bracket,
        rm.empty.rows, na, sep, comment.char, max.person.nchar
    )

    arg_nms <- c('skip', 'merge.broke.tot', 'header', 'dash', 'ellipsis', 'quote2bracket',
        'rm.empty.rows', 'na', 'sep', 'comment.char', 'max.person.nchar'
    )

    lapply(seq_along(arg_list), function(i){

        if(length(arg_list[[i]]) != length(to_read_in)) stop(paste0('`', arg_nms[i], '` is not of length 1 or the same length as files in `path`'))
    })

    #paste(c('skip', 'merge.broke.tot', 'header', 'dash', 'ellipsis',
    # 'quote2bracket', 'rm.empty.rows', 'na', 'sep',
    # 'comment.char', 'max.person.nchar'), collapse=", ")

    reads <- Map(function(x, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11) {
        try(read_transcript(x, col.names = col.names[-1], skip = y1,
            merge.broke.tot = y2, header = y3, dash = y4, ellipsis = y5,
            quote2bracket = y6, rm.empty.rows = y7, na = y8, sep = y9,
            comment.char = y10, max.person.nchar = y11, ...))
    }, to_read_in, skip, merge.broke.tot, header, dash, ellipsis,
       quote2bracket, rm.empty.rows, na, sep, comment.char, max.person.nchar)

    names(reads) <- tools::file_path_sans_ext(basename(to_read_in))

    goods <- !sapply(reads, inherits, 'try-error')
    if (any(!goods)) {
        warning(paste0("The following files did not read in and were removed:\n",
            paste0('  - ', to_read_in[!goods], collapse = "\n")
        ))
        reads <- reads[goods]
        to_read_in <- to_read_in[goods]
    }

    nulls <- unname(unlist(lapply(reads, is.null)))
    if (sum(nulls) > 0) {
        warning(sprintf("The following files failed to read in and were removed:\n%s",
            paste(paste0("  -", to_read_in[nulls]), collapse = "\n")))
        reads <- reads[!nulls]
    }

    textshape::tidy_list(reads, col.names[1])

}


