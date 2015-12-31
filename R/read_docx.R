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
#' download("http://umlreading.weebly.com/uploads/2/5/2/5/25253346/whole_language_timeline-updated.docx")
#' (txt <- read_docx("whole_language_timeline-updated.docx"))
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
