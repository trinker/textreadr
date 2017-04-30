#' Read in .doc Content
#'
#' Read in the content from a .doc file using \href{http://www.winfield.demon.nl}{antiword}
#' via the \pkg{antiword} package.
#'
#' @param file The path to the .doc file.
#' @param skip The number of lines to skip.
#' @param remove.empty logical.  If \code{TRUE} empty elements in the vector are
#' removed.
#' @param trim logical.  If \code{TRUE} the leading/training white space is
#' reoved.
#' @param format logical.  If \code{TRUE} the output will keep doc formatting
#' (e.g., bold, italics, underlined).  This corresponds to the \code{-f} flag in
#' antiword.
#' @param \dots ignored.
#' @return Returns a character vector.
#' @keywords doc
#' @export
#' @examples
#' \dontrun{
#' x <- system.file("docs/Yasmine_Interview_Transcript.doc",
#'     package = "textreadr")
#' read_doc(x)
#' }
read_doc <- function(file, skip = 0, remove.empty = TRUE, trim = TRUE,
    format = FALSE, ...){

    ## use antiword package to read in the text
    text <- strsplit(antiword::antiword(file, format = format, ...), '\r\n', fixed = TRUE)[[1]]

    ## formatting
    if (isTRUE(remove.empty)) text <- text[!grepl("^\\s*$", text)]
    if (skip > 0) text <- text[-seq(skip)]
    if (isTRUE(trim)) text <- trimws(text)

    text
}
