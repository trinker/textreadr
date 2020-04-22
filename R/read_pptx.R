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
#' @param include.notes logical.  If \code{TRUE} then slide notes are included.
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
#' 
#' pptx_doc <- system.file('docs/Hello_World.pptx', package = "textreadr")
#' read_pptx(pptx_doc)
#' read_pptx(pptx_doc, include.notes = TRUE)
#' }
read_pptx <- function (file, skip = 0, remove.empty = TRUE, trim = TRUE, include.notes = FALSE, ...) {

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

    slides <- extract_pptx_nodes(
        tmp,
        trim = trim,
        remove.empty = remove.empty, 
        skip = skip
    )
    
    if (include.notes){

        notes <- extract_pptx_nodes(
            tmp, 
            dir = 'notesSlides', 
            tag1 = '//p:txBody//a:p', 
            starts = lapply(slides, nrow),
            trim = trim,
            remove.empty = remove.empty,
            skip = 0
        )
     
        slides <- lapply(names(slides), function(i){  

            rbind(
                slides[[i]],
                notes[[i]],
                stringsAsFactors = FALSE
            )

        })
    }

    textshape::tidy_list(slides, 'slide_id')

}


extract_pptx_nodes <- function(loc, dir = 'slides', tag1 = '//a:p', tag2 = 'a:t', starts = NULL, remove.empty, trim, skip){

    xmlfiles <- dir(file.path(loc, "ppt", dir), pattern = '[.]xml$', full.names = TRUE)

    ## read in the unzipped docx
    docs <- lapply(xmlfiles, xml2::read_xml)

    if (is.null(starts)) starts <- as.list(rep(0, length(docs)))

    out <- Map(function(doc){

        if (dir == 'slides'){
            ## extract the content
            children <- lapply(xml2::xml_find_all(doc, tag1), xml2::xml_children)
            pvalues <- unlist(lapply(children, function(x) {
                paste(xml2::xml_text(xml2::xml_find_all(x, tag2)), collapse = ' ')
            }))
        } else {
            pvalues <- lapply(xml2::xml_find_all(doc, tag1), xml2::xml_text)
        }
 
        ## formatting
        if (isTRUE(remove.empty)) pvalues <- pvalues[!grepl("^\\s*$", pvalues)]
        if (skip > 0) pvalues <- pvalues[-seq(skip)]
        if (isTRUE(trim)) pvalues <- trimws(pvalues)
        data.frame(element_id = seq_along(pvalues), text = pvalues, stringsAsFactors = FALSE)

    }, docs)

    if (dir == 'slides'){

        names(out) <- gsub('^(notes)?[Ss]lide|\\.xml$', '', basename(xmlfiles))

    } else {

        names(out) <- unlist(lapply(out, function(x) x$text[nrow(x)]))

        lens <- unlist(starts[as.integer(names(out))])
        out[] <- Map(function(x, len) {
             x$element_id <- x$element_id + len
             x[1:(nrow(x) - 1),]
        }, out, lens)
    }

    out

}
