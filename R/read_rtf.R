#' Read a Rich Text Format Content
#'
#' A wrapper for [striprtf::read_rtf()] to read RTFs
#'
#' @param file A path to a RTF file.
#' @param skip The number of lines to skip.
#' @param remove.empty logical.  If `TRUE` empty elements in the vector are
#' removed.
#' @param trim logical.  If `TRUE` the leading/training white space is
#' removed.
#' @param ... Other arguments passed to [striprtf::read_rtf()].
#' @return Returns a character vector.
#' @keywords rtf
#' @export
#' @seealso [striprtf::read_rtf()]
#' @examples
#' \dontrun{
#' rtf_dat <- read_rtf(
#'     'https://raw.githubusercontent.com/trinker/textreadr/master/inst/docs/trans7.rtf'
#' )
#' }
read_rtf <- function(file, skip = 0, remove.empty = TRUE, trim = TRUE, ...) {


    ## use striprtf to read in the document
    text <- striprtf::read_rtf(file, ...)

    ## formatting
    if (isTRUE(remove.empty)) text <- text[!grepl("^\\s*$", text)]
    if (skip > 0) text <- text[-seq(skip)]
    if (isTRUE(trim)) text <- trimws(text)
    if (length(text) == 0) text <- ''
    
    text
}


