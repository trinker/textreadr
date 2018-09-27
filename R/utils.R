clean <-
function(text.var) {
    gsub("\\s+", " ", gsub("\\\\r|\\\\n|\\n|\\\\t", " ", text.var))
}

mgsub <- function (pattern, replacement, text.var, fixed = TRUE,
	order.pattern = fixed, ...) {

    if (fixed && order.pattern) {
        ord <- rev(order(nchar(pattern)))
        pattern <- pattern[ord]
        if (length(replacement) != 1) replacement <- replacement[ord]
    }
    if (length(replacement) == 1) replacement <- rep(replacement, length(pattern))

    for (i in seq_along(pattern)){
        text.var <- gsub(pattern[i], replacement[i], text.var, fixed = fixed, ...)
    }

    text.var
}

rm_empty_row <-
function(dataframe) {
    x <- paste2(dataframe, sep="")
    x <- gsub("\\s+", "", x)
    ind <- x != ""
    return(dataframe[ind,  ,drop = FALSE] )
}


#Helper function used in read.transcript
#' @importFrom data.table :=
combine_tot <- function(x){

    person <- NULL

    nms <- colnames(x)
    colnames(x) <- c('person', 'z')
    x <- data.table::data.table(x)

    exp <- parse(text='list(text = paste(z, collapse = " "))')[[1]]
    out <- x[, eval(exp),
        by = list(person, 'new' = data.table::rleid(person))][,
        'new' := NULL][]
    data.table::setnames(out, nms)
    out
}

pad_left <- function(x, len = 1 + max(nchar(x)), char = '0'){

    unlist(lapply(x, function(x) {
        paste0(
            paste(rep(char, len - nchar(x)), collapse = ''),
            x
        )
    }))
}

open_path <- function (x = ".") {
    if (.Platform["OS.type"] == "windows") {
        invisible(lapply(x, shell.exec))
    }
    else {
        invisible(lapply(x, function(x) {
            system(paste(Sys.getenv("R_BROWSER"), x))
        }))
    }
}


# combine_tot <-
#   function(dataframe, combine.var = 1, text.var = 2) {
#     NAMES <- colnames(dataframe)
#     lens <- rle(as.character(dataframe[, combine.var]))
#     z <- lens$lengths > 1
#     z[lens$lengths > 1] <- 1:sum(lens$lengths > 1)
#     a <- rep(z, lens$lengths)
#     dataframe[, "ID"] <- 1:nrow(dataframe)
#     b <- split(dataframe, a)
#     w <- b[names(b) != "0"]
#     v <- lapply(w, function(x) {
#       x <- data.frame(var1 = x[1, 1],
#                       text = paste(x[, text.var], collapse=" "),
#                       ID = x[1, 3], stringsAsFactors = FALSE)
#       colnames(x)[1:2] <- NAMES
#       return(x)
#     }
#     )
#     v$x <- as.data.frame(b["0"], stringsAsFactors = FALSE)
#     colnames(v$x) <- unlist(strsplit(colnames(v$x), "\\."))[c(F, T)]
#     h <- do.call(rbind, v)
#     h <- h[order(h$ID), ][, -3]
#     rownames(h) <- NULL
#     return(h)
# }

paste2 <-
function(multi.columns, sep=".", handle.na=TRUE, trim=TRUE){
    if (is.matrix(multi.columns)) {
        multi.columns <- data.frame(multi.columns, stringsAsFactors = FALSE)
    }
    if (trim) multi.columns <- lapply(multi.columns, function(x) {
            gsub("^\\s+|\\s+$", "", x)
        }
    )
    if (!is.data.frame(multi.columns) & is.list(multi.columns)) {
        multi.columns <- do.call('cbind', multi.columns)
    }
    m <- if (handle.na){
                 apply(multi.columns, 1, function(x){
                     if (any(is.na(x))){
                         NA
                     } else {
                         paste(x, collapse = sep)
                     }
                 }
             )
         } else {
             apply(multi.columns, 1, paste, collapse = sep)
    }
    names(m) <- NULL
    return(m)
}




