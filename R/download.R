#' Download Instructional Documents
#'
#' This function enables downloading documents for future instructional training.
#'
#' @param url The download url or \href{https://www.dropbox.com/}{Dropbox} key.
#' @param loc Where to put the files.
#' @return Places a copy of the downloaded document in location specified and returns
#' vector of the locations as string paths.
#' @export
#' @examples
#' \dontrun{
#' m <- download(
#' c('https://cran.r-project.org/web/packages/curl/curl.pdf',
#' "https://github.com/trinker/textreadr/raw/master/inst/docs/rl10075oralhistoryst002.pdf")
#' )
#' }
download <- function(url, loc = tempdir()) {
    invisible(sapply(url, function(x) {
        try(single_download(x, loc = loc))
    }))
}

single_download <- function(url, loc) {
    x <- basename(url)
    out <- file.path(loc, x)
    curl::curl_download(url, out)
    message(noquote(paste(x, "read into", loc)))
    invisible(out)
}

