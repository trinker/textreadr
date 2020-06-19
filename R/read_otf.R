#' Read in .docx Content
#'
#' Read in the content from a .docx file.
#'
#' @param file The path to the .docx file.
#' @param skip The number of lines to skip.
#' @param remove.empty logical.  If `TRUE` empty elements in the vector are
#' removed.
#' @param trim logical.  If `TRUE` the leading/training white space is
#' removed.
#' @param ... ignored.
#' @return Returns a character vector.
#' @keywords docx
#' @export
#' @author Bryan Goodrich and Tyler Rinker <tyler.rinker@@gmail.com>.
#' @examples
#' \dontrun{
#' url <- "https://github.com/trinker/textreadr/raw/master/inst/docs/Yasmine_Interview_Transcript.docx"
#' file <- download(url)
#' (txt <- read_odt(file))
#' }
read_odt <- function (file, skip = 0, remove.empty = TRUE, trim = TRUE, ...) {

    filetype <- tools::file_ext(file)
    if (filetype %in% c('odt') && grepl('^([fh]ttp)', file)){

        file <- download(file)

    }   

    ## create temp dir
    tmp <- tempfile()
    if (!dir.create(tmp)) stop("Temporary directory could not be established.")

    ## clean up
    on.exit(unlink(tmp, recursive=TRUE))

    ## unzip docx
    xmlfile <- file.path(tmp, "content.xml")
    utils::unzip(file, exdir = tmp)

    ## read in the unzipped docx
    doc <- xml2::read_xml(xmlfile)

    ## extract the content
    rm_na <- function(x) x[!is.na(x)]

    pvalues <- xml2::xml_text(xml2::xml_find_all(doc, "//text:p"))

    ## formatting
    if (isTRUE(remove.empty)) pvalues <- pvalues[!grepl("^\\s*$", pvalues)]
    if (skip > 0) pvalues <- pvalues[-seq(skip)]
    if (isTRUE(trim)) pvalues <- trimws(pvalues)
    if (length(pvalues) == 0) pvalues <- ''
    
    pvalues

}



read_odt("C:/Users/trinker/Desktop/Hello World.odt")
