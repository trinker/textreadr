#' Read in .docx Content
#'
#' Read in the content from a .docx file.
#'
#' @param file The path to the .docx file.
#' @param skip The number of lines to skip.
#' @return Returns a character vector.
#' @keywords docx
#' @export
#' @author Bryan Goodrich and Tyler Rinker <tyler.rinker@@gmail.com>.
#' @examples
#' \dontrun{
#' x <- "http://www.cybersmart.gov.au/~/media/9999BCDEA99F40DD8170AAD978C8D2F9.docx"
#' out <- download(x)
#' (txt <- read_docx(out))
#' }
read_docx <- function (file, skip = 0) {
    tmp <- tempfile()
    if (!dir.create(tmp)) stop("Temporary directory could not be established.")
    utils::unzip(file, exdir = tmp)
    xmlfile <- file.path(tmp, "word", "document.xml")
    doc <- XML::xmlTreeParse(xmlfile, useInternalNodes = TRUE)
    unlink(tmp, recursive = TRUE)
    nodeSet <- XML::getNodeSet(doc, "//w:p")
    pvalues <- sapply(nodeSet, XML::xmlValue)
    pvalues <- pvalues[pvalues != ""]
    if (skip > 0) pvalues <- pvalues[-seq(skip)]
    pvalues
}
