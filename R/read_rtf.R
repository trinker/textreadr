### Read a Rich Text Format into R
###
### A wrapper for \code{\link[striprtf]{read_rtf}} to read PDFs into \pkg{R}.
###
### @param file A path to a PDF file.
### @param skip Integer; the number of lines of the data file to skip before
### beginning to read data.
### @param remove.empty logical.  If \code{TRUE} empty elements in the vector are
### removed.
### @param trim logical.  If \code{TRUE} the leading/training white space is
### reoved.
### @param \dots Other arguments passed to \code{\link[striprtf]{read_rtf}}.
### @return Returns a \code{\link[base]{data.frame}} with the line number
### (\code{element_id}), and the \code{text}.
### @keywords rtf
### @export
### @seealso \code{\link[striprtf]{read_rtf}}
### @examples
### rtf_dat <- read_rtf(
###     system.file("docs/trans7.rtf", package = "textreadr")
### )
# read_rtf <- function(file, skip = 0, remove.empty = TRUE, trim = TRUE, ...) {
#

  ## Currently results in an error on the sample document in the example

#     ## use striprtf to read in the document
#     text <- striprtf::read_rtf(file, ...)
#
#     ## Convert to UTF-8 encoding and split on carriage returns
#     Encoding(text) <- "UTF-8"
#     text <- strsplit(text, "\\r\\n")
#
#     ## formatting 1
#     if (isTRUE(remove.empty)) text <- lapply(text, function(x) x[!grepl("^\\s*$", x)])
#
#     ## coerce to a data.frame with page numbers
#     out <- data.frame(page_id = rep(seq_along(text), sapply(text,
#         length)), element_id = unlist(sapply(text, function(x) seq_len(length(x)))),
#         text = unlist(text), stringsAsFactors = FALSE)
#
#     ## formatting 2
#     if (skip > 0) out <- utils::tail(out, -c(skip))
#     if (isTRUE(trim)) out[['text']] <- trimws(out[['text']])
#
#
#     class(out) <- c("textreadr", "data.frame")
#     out
# }


