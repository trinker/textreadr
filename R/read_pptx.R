#' Read in .pptx Content
#'
#' Read in the content from a .pptx file.
#'
#' @param file The path to the .pptx file.
#' @param skip The number of lines to skip.
#' @param remove.empty logical.  If \code{TRUE} empty elements in the vector are
#' removed.
#' @param trim logical.  If \code{TRUE} the leading/training white space is
#' removed.
#' @param \dots ignored.
#' @return Returns a \code{\link[base]{data.frame}} with the slide number
#' (\code{slide_id}), line number (\code{element_id}), and the \code{text}.
#' @keywords pptx
#' @export
#' @examples
#' \dontrun{
#' url <- "https://www.oclc.org/content/dam/research/presentations/2019/111319-godby-NISO-What-Are-Entities-Matter.pptx"
#' file <- download(url)
#' (txt <- read_pptx(file))
#' }
read_pptx <- function (file, skip = 0, remove.empty = TRUE, trim = TRUE, ...) {

    filetype <- tools::file_ext(file)
    if (filetype %in% c('pptx') && grepl('^([fh]ttp)', file)){

        file <- download(file)

    }    

    ## create temp dir
    tmp <- tempfile()
    if (!dir.create(tmp)) stop("Temporary directory could not be established.")

    ## clean up
    on.exit(unlink(tmp, recursive=TRUE))

    ## unzip docx
    utils::unzip(file, exdir = tmp)
    xmlfiles <- dir(file.path(tmp, "ppt/slides"), pattern = '[.]xml$', full.names = TRUE)

    ## read in the unzipped docx
    docs <- lapply(xmlfiles, xml2::read_xml)

    out <- lapply(docs, function(doc){
        ## extract the content
        children <- lapply(xml2::xml_find_all(doc, '//a:p'), xml2::xml_children)
        pvalues <- unlist(lapply(children, function(x) {
            paste(xml2::xml_text(xml2::xml_find_all(x, 'a:t')), collapse = ' ')
        }))
 
        ## formatting
        if (isTRUE(remove.empty)) pvalues <- pvalues[!grepl("^\\s*$", pvalues)]
        if (skip > 0) pvalues <- pvalues[-seq(skip)]
        if (isTRUE(trim)) pvalues <- trimws(pvalues)
        data.frame(element_id = seq_along(pvalues), text = pvalues, stringsAsFactors = FALSE)

    })

    
    textshape::tidy_list(out, 'slide_id')

}
