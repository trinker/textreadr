#' Read in .doc Content
#'
#' Read in the content from a .doc file using \href{http://www.winfield.demon.nl}{antiword}.
#'
#' @param file The path to the .doc file.
#' @param skip The number of lines to skip.
#' @param antiword.path Path to \href{http://www.winfield.demon.nl}{antiword}.
#' @return Returns a character vector.
#' @keywords doc
#' @export
#' @examples
#' \dontrun{
#' x <- system.file("docs/Yasmine_Interview_Transcript.doc",
#'     package = "textreadr")
#' read_doc(x)
#' }
read_doc <- function(file, skip = 0, antiword.path = textreadr::antiword_loc()){

    # add an antiword check here based on check and install functions from stansent
    if (!file.exists(antiword.path)) {
        check_antiword_installed(antiword.path, verbose = FALSE)
    }

    cmd <- sprintf("%s -f %s", shQuote(antiword.path), shQuote(file))
    results <- system(cmd, intern = TRUE, ignore.stderr = TRUE)

    results <- results[!grepl("^\\s*$", results)]

    if (skip > 0) results <- results[-seq(skip)]
    trimws(results)
}



