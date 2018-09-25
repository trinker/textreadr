#' Read a Portable Document Format into R
#'
#' A wrapper for \code{\link[pdftools]{pdf_text}} to read PDFs into \pkg{R}.
#'
#' @param file A path to a PDF file.
#' @param skip Integer; the number of lines of the data file to skip before
#' beginning to read data.
#' @param remove.empty logical.  If \code{TRUE} empty elements in the vector are
#' removed.
#' @param trim logical.  If \code{TRUE} the leading/training white space is
#' removed.
#' @param \dots Other arguments passed to \code{\link[pdftools]{pdf_text}}.
#' @note A word of caution from \href{http://stackoverflow.com/a/9187015/1000343}{Carl Witthoft}"
#' "Just a warning to others who may be hoping to extract data: PDF is a
#' container, not a format. If the original document does not contain actual
#' text, as opposed to bitmapped images of text or possibly even uglier things
#' than I can imagine, nothing other than OCR can help you."  If the reader has
#' OCR needs the \pkg{tesseract} package, available on CRAN
#' (\url{https://CRAN.R-project.org/package=tesseract}), is an "OCR engine with
#' Unicode (UTF-8) support" and may be of use.
#' @return Returns a \code{\link[base]{data.frame}} with the page number
#' (\code{page_id}), line number (\code{element_id}), and the \code{text}.
#' @keywords pdf
#' @export
#' @seealso \code{\link[tm]{readPDF}}
#' @examples
#' pdf_dat <- read_pdf(
#'     system.file("docs/rl10075oralhistoryst002.pdf", package = "textreadr")
#' )
#'
#' pdf_dat_b <- read_pdf(
#'     system.file("docs/rl10075oralhistoryst002.pdf", package = "textreadr"),
#'     skip = 1
#' )
#'
#' \dontrun{
#' library(textshape)
#' system.file("docs/rl10075oralhistoryst002.pdf", package = "textreadr") %>%
#'     read_pdf(1) %>%
#'     `[[`('text') %>%
#'     head(-1) %>%
#'     textshape::combine() %>%
#'     gsub("([A-Z])( )([A-Z])", "\\1_\\3", .) %>%
#'     strsplit("(-| )(?=[A-Z_]+:)", perl=TRUE) %>%
#'     `[[`(1) %>%
#'     textshape::split_transcript()
#' }
read_pdf <- function(file, skip = 0, remove.empty = TRUE, trim = TRUE, ...) {

    ## use pdftools to read in the document
    text <- pdftools::pdf_text(file, ...)

    ## Convert to UTF-8 encoding and split on carriage returns
    Encoding(text) <- "UTF-8"
    text <- strsplit(text, "\\r\\n")

    ## formatting 1
    if (isTRUE(remove.empty)) text <- lapply(text, function(x) x[!grepl("^\\s*$", x)])

    ## coerce to a data.frame with page numbers
    out <- data.frame(page_id = rep(seq_along(text), sapply(text,
        length)), element_id = unlist(sapply(text, function(x) seq_len(length(x)))),
        text = unlist(text), stringsAsFactors = FALSE)

    ## formatting 2
    if (skip > 0) out <- utils::tail(out, -c(skip))
    if (isTRUE(trim)) out[['text']] <- trimws(out[['text']])


    class(out) <- c("textreadr", "data.frame")
    out
}


# read_pdf <- function(file, engine = "ghostscript", skip = 0, language='en', id='id1'){
#
#     out <- tm::readPDF(engine = engine, control = list(text = "-layout"))(
#         elem = list(uri=file), language = language, id = id
#     )
#
#     text <- unlist(lapply(out[["content"]], strsplit, "(\\n)+"), recursive = FALSE)
#     out <- data.frame(
#         page_id = rep(seq_along(text), sapply(text, length)),
#         element_id = unlist(sapply(text, function(x) seq_len(length(x)))),
#         text = unlist(text),
#         stringsAsFactors = FALSE
#     )
#     if (skip > 0) out <- out[(skip + 1):nrow(out), ]
#     class(out) <- c("textreadr", "data.frame")
#     out
# }



