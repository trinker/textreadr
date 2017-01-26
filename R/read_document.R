#' Generic Function to Read in a Document
#'
#' Generic function to read in a .pdf, .txt, .docx, or .doc file.
#'
#' @param file The path to the a .pdf, .txt, .docx, or .doc file.
#' @param combine logical.  If \code{TRUE} the vector is concatenated into a
#' single string via \code{\link[textshape]{combine}}
#' @param \ldots Other arguments passed to \code{\link[textreadr]{read_pdf}},
#' \code{\link[textreadr]{read_docx}}, \code{\link[textreadr]{read_doc}}, or
#' \code{\link[base]{readLines}}.
#' @return Returns a \code{\link[base]{list}} of string \code{\link[base]{vector}}s.
#' @export
#' @examples
#' ## .pdf
#' pdf_doc <- system.file("docs/rl10075oralhistoryst002.pdf",
#'     package = "textreadr")
#' read_document(pdf_doc)
#'
#' ## .docx
#' docx_doc <- system.file("docs/Yasmine_Interview_Transcript.docx",
#'     package = "textreadr")
#' read_document(docx_doc)
#'
#' ## .txt
#' txt_doc <- system.file('docs/textreadr_creed.txt', package = "textreadr")
#' read_document(txt_doc)
#'
#' \dontrun{
#' doc_doc <- system.file("docs/Yasmine_Interview_Transcript.doc",
#'     package = "textreadr")
#' read_document(doc_doc)
#' }
read_document <- function(file, combine = FALSE, ...){
    fun <- switch(tools::file_ext(file),
        pdf = {function(x, ...) {read_pdf(x, ...)[["text"]]}},
        docx = read_docx,
        doc = read_doc,
        txt = {function(x, ...) {suppressWarnings(readLines(x, ...))}},
        {function(x, ...) {suppressWarnings(readLines(x, ...))}}
    )

    out <- try(fun(file, ...), silent = TRUE)
    if (inherits(out, 'try-error')) return(NULL)
    if (isTRUE(combine)) out <- textshape::combine(out, as.tibble = FALSE)
    out
}
