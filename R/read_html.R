#' Read in .html Content
#'
#' Read in the content from a .html file.  This is generalized, reading in all
#' body text.  For finer control the user should utilize the \pkg{xml2} and
#' \pkg{rvest} packages.
#'
#' @param file The path to the .html file.
#' @param skip The number of lines to skip.
#' @param remove.empty logical.  If \code{TRUE} empty elements in the vector are
#' removed.
#' @param trim logical.  If \code{TRUE} the leading/training white space is
#' reoved.
#' @param \dots Other arguments passed to \code{\link[xml2]{read_html}}.
#' @return Returns a character vector.
#' @keywords html
#' @export
#' @references The xpath is taken from Tony Breyal's response on StackOverflow:
#' \url{http://stackoverflow.com/questions/3195522/is-there-a-simple-way-in-r-to-extract-only-the-text-elements-of-an-html-page/3195926#3195926}
#' @examples
#' html_dat <- read_html(
#'     system.file("docs/textreadr_creed.html", package = "textreadr")
#' )
#'
#' \dontrun{
#' url <- "http://www.talkstats.com/index.php"
#' file <- download(url)
#' (txt <- read_html(url))
#' (txt <- read_html(file))
#' }
read_html <- function (file, skip = 0, remove.empty = TRUE, trim = TRUE, ...) {

    ## read in the html
    doc <- xml2::read_html(file, ...)

    ## extract the body content
    pvalues <- rvest::html_text(
        rvest::html_nodes(
            doc,
            xpath = "//body//text()[not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)]"
        )
    )

    ## formatting
    if (isTRUE(remove.empty)) pvalues <- pvalues[!grepl("^\\s*$", pvalues)]
    if (skip > 0) pvalues <- pvalues[-seq(skip)]
    if (isTRUE(trim)) pvalues <- trimws(pvalues)

    pvalues

}
