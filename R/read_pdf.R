#' Read a Portable Document Format into R
#'
#' A wrapper for \code{\link[tm]{readPDF}} to read PDFs into R.
#'
#' @param file A path to a PDF file.
#' @param engine A character string for the preferred PDF extraction engine (see
#' \code{\link[tm]{readPDF}}).
#' @param skip Integer; the number of lines of the data file to skip before
#' beginning to read data.
#' @param language A string giving the language (see \code{\link[tm]{readPDF}}).
#' @param id Not used (see \code{\link[tm]{readPDF}}).
#' @note A word of caution from \href{http://stackoverflow.com/a/9187015/1000343}{Carl Witthoft}"
#' "Just a warning to others who may be hoping to extract data: PDF is a
#' container, not a format. If the original document does not contain actual
#' text, as opposed to bitmapped images of text or possibly even uglier things
#' than I can imagine, nothing other than OCR can help you."
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
#'     skip = 9
#' )
read_pdf <- function(file, engine = "ghostscript", skip = 0, language='en', id='id1'){

    out <- tm::readPDF(engine = engine, control = list(text = "-layout"))(
        elem = list(uri=file), language = language, id = id
    )

    text <- unlist(lapply(out[["content"]], strsplit, "(\\n)+"), recursive = FALSE)
    out <- data.frame(
        page_id = rep(seq_along(text), sapply(text, length)),
        element_id = unlist(sapply(text, function(x) seq_len(length(x)))),
        text = unlist(text),
        stringsAsFactors = FALSE
    )
    if (skip > 0) out <- out[(skip + 1):nrow(out), ]
    class(out) <- c("textreadr", "data.frame")
    out
}



