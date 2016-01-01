#' Download Documents
#'
#' This function enables downloading documents.
#'
#' @param url The download url(s).
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
#'
#' m
#' }
download <- function(url, loc = tempdir()) {
    invisible(sapply(url, function(x) {
        try(single_download(x, loc = loc))
    }, USE.NAMES = FALSE))
}

single_download <- function(url, loc) {
    x <- basename(url)
    out <- file.path(loc, x)
    curl::curl_download(url, out)
    message(noquote(paste(x, "read into", loc)))
    invisible(out)
}

