#' Generic Function to Read in a Document
#'
#' Generic function to read in a .pdf, .txt, .html, .docx, or .doc file.
#'
#' @param file The path to the a .pdf, .txt, .html, .docx, or .doc file.
#' @param skip The number of lines to skip.
#' @param remove.empty logical.  If \code{TRUE} empty elements in the vector are
#' removed.
#' @param trim logical.  If \code{TRUE} the leading/training white space is
#' reoved.
#' @param combine logical.  If \code{TRUE} the vector is concatenated into a
#' single string via \code{\link[textshape]{combine}}.
#' @param format For .doc files only.  Logical.  If \code{TRUE} the output will
#' keep doc formatting (e.g., bold, italics, underlined).  This corresponds to
#' the \code{-f} flag in antiword.
#' @param \ldots Other arguments passed to \code{\link[textreadr]{read_pdf}},
#' \code{\link[textreadr]{read_html}}, \code{\link[textreadr]{read_docx}},
#' \code{\link[textreadr]{read_doc}}, or \code{\link[base]{readLines}}.
#' @return Returns a \code{\link[base]{list}} of string \code{\link[base]{vector}}s.
#' @export
#' @examples
#' ## .pdf
#' pdf_doc <- system.file("docs/rl10075oralhistoryst002.pdf",
#'     package = "textreadr")
#' read_document(pdf_doc)
#'
#' ## .html
#' html_doc <- system.file("docs/textreadr_creed.html", package = "textreadr")
#' read_document(html_doc)
#'
#' ## .docx
#' docx_doc <- system.file("docs/Yasmine_Interview_Transcript.docx",
#'     package = "textreadr")
#' read_document(docx_doc)
#'
#' ## .doc
#' doc_doc <- system.file("docs/Yasmine_Interview_Transcript.doc",
#'     package = "textreadr")
#' read_document(doc_doc)
#'
#' ## .txt
#' txt_doc <- system.file('docs/textreadr_creed.txt', package = "textreadr")
#' read_document(txt_doc)
#'
#' \dontrun{
#' ## URLs
#' read_document('http://www.talkstats.com/index.php')
#' }
read_document <- function(file, skip = 0, remove.empty = TRUE, trim = TRUE,
    combine = FALSE, format = FALSE, ...){

    if (grepl('^([fh]ttp)', file)){
        filetype <- 'html'
    } else {
        filetype <- tools::file_ext(file)
        filetype <- ifelse(filetype %in% c('php', 'htm'), 'html', filetype)
    }

    fun <- switch(filetype,
        pdf = {function(x, ...) {read_pdf(x, remove.empty = FALSE, trim = FALSE, ...)[["text"]]}},
        docx = {function(x, ...) {read_docx(x, remove.empty = FALSE, trim = FALSE, ...)}},
        doc = {function(x, ...) {read_doc(x, remove.empty = FALSE, trim = FALSE, format=format, ...)}},
        html = {function(x, ...) {read_html(x, remove.empty = FALSE, trim = FALSE, ...)}},
        txt = {function(x, ...) {suppressWarnings(readLines(x, ...))}},
        {function(x, ...) {suppressWarnings(readLines(x, ...))}}
    )

    out <- try(fun(file, ...), silent = TRUE)
    if (inherits(out, 'try-error')) return(NULL)

    ## formatting
    if (isTRUE(remove.empty)) out <- out[!grepl("^\\s*$", out)]
    if (skip > 0) out <- out[-seq(skip)]
    if (isTRUE(trim)) out <- trimws(out)


    if (isTRUE(combine)) out <- textshape::combine(out)
    out

}
