#' Read a Portable Document Format into R
#'
#' A wrapper for [pdftools::pdf_text()] to read PDFs into \pkg{R}.
#'
#' @param file A path to a PDF file.
#' @param skip Integer; the number of lines of the data file to skip before
#' beginning to read data.
#' @param remove.empty logical.  If `TRUE` empty elements in the vector are
#' removed.
#' @param trim logical.  If `TRUE` the leading/training white space is
#' removed.
#' @param ocr logical.  If `TRUE` documents with a non-text pull using
#' [pdftools::pdf_text()][pdftools::pdftools] will be re-run using OCR via the
#' [tesseract::ocr()] function.  This will create temporary .png
#' files and will require a much larger compute time.
#' @param ... Other arguments passed to [pdftools::pdf_text()][pdftools::pdftools].
#' @note A word of caution from [Carl Witthoft](http://stackoverflow.com/a/9187015/1000343)"
#' "Just a warning to others who may be hoping to extract data: PDF is a
#' container, not a format. If the original document does not contain actual
#' text, as opposed to bitmapped images of text or possibly even uglier things
#' than I can imagine, nothing other than OCR can help you."  If the reader has
#' OCR needs the \pkg{tesseract} package, available on CRAN
#' (<https://CRAN.R-project.org/package=tesseract>), is an "OCR engine with
#' Unicode (UTF-8) support" and may be of use.
#' @return Returns a [base::data.frame()] with the page number
#' (`page_id`), line number (`element_id`), and the `text`.
#' @keywords pdf
#' @export
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
#'
#' \dontrun{
#' ## An image based .pdf file returns nothing.  Using the tesseract package as
#' ## a backend for OCR overcomes this problem.
#'
#' ## Non-ocr
#' read_pdf(
#'     system.file("docs/McCune2002Choi2010.pdf", package = "textreadr"),
#'     ocr = FALSE
#' )
#'
#' read_pdf(
#'     system.file("docs/McCune2002Choi2010.pdf", package = "textreadr"),
#'     ocr = TRUE
#' )
#' }
read_pdf <- function(file, skip = 0, remove.empty = TRUE, trim = TRUE, ocr = TRUE, ...) {

    ## use pdftools to read in the document
    text <- pdftools::pdf_text(file, ...)

    ## Use ocr if pdf is raster not text
    if (all(text %in% '') & isTRUE(ocr)){

        if (requireNamespace("tesseract", quietly = TRUE)){
            
            temp <- tempdir()
            fls <- file.path(
                temp,
                paste0(gsub('\\.pdf$', '', base_name(file)), '_', pad_left(seq_along(text)), '.png')
            )
   
            ## convert to png files for tesseract to interact with
            png_files <- pdftools::pdf_convert(file, dpi = 600, filenames = fls)
    
            ## OCR
            text <- tesseract::ocr(png_files)
    
            ## clean up and remove the png files
            unlink(png_files, TRUE, TRUE)
            
        } else {
            
            warning('\'tesseract\' not available.  `ocr = TRUE` ignored.\n\nPlease use `install.packages(\'tesseract\')` and then retry.', call. = FALSE)
            
        }

        split <- "\\r\\n|\\n"
        
    } else {

        split <- "\\r\\n"

    }

    ## Convert to UTF-8 encoding and split on carriage returns
    Encoding(text) <- "UTF-8"
    text <- strsplit(text, split)

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



