#' Download Documents
#'
#' This function enables downloading documents by wrapping [curl::curl_download()].
#'
#' @param url The download url(s).
#' @param loc Where to put the files.
#' @param file.out Option vector of names matching `url`.  If this is not
#' given [download()] will try to create a name from `url`.
#' @param ... Other arguments passed to [curl::curl_download()].
#' @return Places a copy of the downloaded document in location specified and returns
#' vector of the locations as string paths.
#' @export
#' @examples
#' \dontrun{
#' m <- download(
#' c('https://cran.r-project.org/web/packages/curl/curl.pdf',
#' "https://github.com/trinker/textreadr/raw/master/inst/docs/rl10075oralhistoryst002.pdf"),
#' )
#'
#' m
#' }
download <- function(url, loc = tempdir(), file.out = NULL, ...) {

    if (is.null(file.out)) file.out <- lapply(seq_along(url), function(i) {NULL})

    invisible(unlist(
        Map(function(x, y) {
            try(single_download(x, loc = loc, file = y, ...))
        }, url, file.out),
        use.names = FALSE
    ))
}

single_download <- function(url, loc, file = NULL, ...) {

    if (is.null(file)) file <- basename(url)

    out <- file.path(loc, file)
    curl::curl_download(url, out, ...)
    message(noquote(paste(file, "read into", loc)))
    invisible(out)
}

