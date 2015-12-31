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
#' ## Mining Citation
#' url_dl("http://umlreading.weebly.com/uploads/2/5/2/5/25253346/whole_language_timeline-updated.docx")
#' 
#' (txt <- read_docx("whole_language_timeline-updated.docx"))
#' 
#' library(qdapTools); library(ggplot2); library(qdap)
#' txt <- rm_non_ascii(txt)
#' 
#' parts <- split_vector(txt, split = "References", include = TRUE, regex=TRUE)
#' 
#' parts[[1]]
#' 
#' rm_citation(unbag(parts[[1]]), extract=TRUE)[[1]]
#' 
#' ## By line
#' rm_citation(parts[[1]], extract=TRUE)
#' 
#' ## Frequency
#' left_just(cites <- list2df(sort(table(rm_citation(unbag(parts[[1]]),
#'     extract=TRUE)), T), "freq", "citation")[2:1])
#' 
#' ## Distribution of citations (find locations and then plot)
#' cite_locs <- do.call(rbind, lapply(cites[[1]], function(x){
#'     m <- gregexpr(x, unbag(parts[[1]]), fixed=TRUE)
#'     data.frame(
#'         citation=x,
#'         start = m[[1]] -5,
#'         end =  m[[1]] + 5 + attributes(m[[1]])[["match.length"]]
#'     )
#' }))
#' 
#' ggplot(cite_locs) +
#'     geom_segment(aes(x=start, xend=end, y=citation, yend=citation), size=3,
#'         color="yellow") +
#'     xlab("Duration") +
#'     scale_x_continuous(expand = c(0,0),
#'         limits = c(0, nchar(unbag(parts[[1]])) + 25)) +
#'     theme_grey() +
#'     theme(
#'         panel.grid.major=element_line(color="grey20"),
#'         panel.grid.minor=element_line(color="grey20"),
#'         plot.background = element_rect(fill="black"),
#'         panel.background = element_rect(fill="black"),
#'         panel.border = element_rect(colour = "grey50", fill=NA, size=1),
#'         axis.text=element_text(color="grey50"),    
#'         axis.title=element_text(color="grey50")  
#'     )
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