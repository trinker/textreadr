#' Read Transcripts Into R
#'
#' Read .docx, .csv, .xlsx, .xlsx, or .txt transcript style files into R.
#'
#' @param file The name of the file which the data are to be read from. Each row
#' of the table appears as one line of the file. If it does not contain an
#' absolute path, the file name is relative to the current working directory,
#' \code{getwd()}.
#' @param col.names  A character vector specifying the column names of the
#' transcript columns.
#' @param text.var A character string specifying the name of the text variable
#' will ensure that variable is classed as character.  If \code{NULL}
#' \code{\link[textreadr]{read_transcript}} attempts to guess the text.variable
#' (dialogue).
#' @param merge.broke.tot logical.  If \code{TRUE} and if the file being read in
#' is .docx with broken space between a single turn of talk read_transcript
#' will attempt to merge these into a single turn of talk.
#' @param header logical.  If \code{TRUE} the file contains the names of the
#' variables as its first line.
#' @param dash A character string to replace the en and em dashes special
#' characters (default is to remove).
#' @param ellipsis A character string to replace the ellipsis special characters.
#' @param quote2bracket logical. If \code{TRUE} replaces curly quotes with curly
#' braces (default is \code{FALSE}).  If \code{FALSE} curly quotes are removed.
#' @param rm.empty.rows logical.  If \code{TRUE}
#' \code{\link[textreadr]{read_transcript}}  attempts to remove empty rows.
#' @param na A character string to be interpreted as an \code{NA} value.
#' @param sep The field separator character. Values on each line of the file are
#' separated by this character.  The default of \code{NULL} instructs
#' \code{\link[textreadr]{read_transcript}} to use a separator suitable for the file
#' type being read in.
#' @param skip Integer; the number of lines of the data file to skip before
#' beginning to read data.
#' @param text Character string: if file is not supplied and this is, then data
#' are read from the value of text. Notice that a literal string can be used to
#' include (small) data sets within R code.
#' @param comment.char A character vector of length one containing a single
#' character or an empty string. Use \code{""} to turn off the interpretation of
#' comments altogether.
#' @param max.person.nchar The max number of characters long names are expected
#' to be.  This information is used to warn the user if a separator appears beyond
#' this length in the text.
#' @param \ldots Further arguments to be passed to \code{\link[utils]{read.table}},
#' \code{\link[readxl]{read_excel}}, or \code{\link[textreadr]{read_doc}}.
#' @return Returns a dataframe of dialogue and people.
#' @note If a transcript is a .docx file read_transcript expects two columns
#' (generally person and dialogue) with some sort of separator (default is colon
#' separator).  .doc files must be converted to .docx before reading in.
#' @section Warning: \code{\link[textreadr]{read_transcript}} may contain errors if the
#' file being read in is .docx.  The researcher should carefully investigate
#' each transcript for errors before further parsing the data.
#' @author Bryan Goodrich and Tyler Rinker <tyler.rinker@@gmail.com>.
#' @references \url{https://github.com/trinker/qdap/wiki/Reading-.docx-\%5BMS-Word\%5D-Transcripts-into-R}
#' @keywords transcript
#' @export
#' @examples
#' (doc1 <- system.file("docs/trans1.docx", package = "textreadr"))
#' (doc2 <- system.file("docs/trans2.docx", package = "textreadr"))
#' (doc3 <- system.file("docs/trans3.docx", package = "textreadr"))
#' (doc4 <- system.file("docs/trans4.xlsx", package = "textreadr"))
#' (doc5 <- system.file("docs/trans5.xls", package = "textreadr"))
#' (doc6 <- system.file("docs/trans6.doc", package = "textreadr"))
#'
#' dat1 <- read_transcript(doc1)
#' dat2 <- read_transcript(doc1, col.names = c("person", "dialogue"))
#'
#' ## read_transcript(doc2) #throws an error (need skip)
#' dat3 <- read_transcript(doc2, skip = 1)
#'
#' ## read_transcript(doc3, skip = 1) #incorrect read; wrong sep
#' dat4 <- read_transcript(doc3, sep = "-", skip = 1)
#'
#' ## xlsx/xls format
#' dat5 <- read_transcript(doc4)
#' dat6 <- read_transcript(doc5)
#'
#' ## MS doc format
#' \dontrun{
#' dat7 <- read_transcript(doc6) ## need to skip Researcher
#' dat8 <- read_transcript(doc6, skip = 1)
#' }
#'
#' ## text string input
#' trans <- "sam: Computer is fun. Not too fun.
#' greg: No it's not, it's dumb.
#' teacher: What should we do?
#' sam: You liar, it stinks!"
#'
#' read_transcript(text=trans)
#'
#' ## Read in text specify spaces as sep
#' ## EXAMPLE 1
#' read_transcript(text="34    The New York Times reports a lot of words here.
#' 12    Greenwire reports a lot of words.
#' 31    Only three words.
#'  2    The Financial Times reports a lot of words.
#'  9    Greenwire short.
#' 13    The New York Times reports a lot of words again.",
#'     col.names = c("NO", "ARTICLE"), sep = "   ")
#'
#' ## EXAMPLE 2
#' read_transcript(text="34..    The New York Times reports a lot of words here.
#' 12..    Greenwire reports a lot of words.
#' 31..    Only three words.
#'  2..    The Financial Times reports a lot of words.
#'  9..    Greenwire short.
#' 13..    The New York Times reports a lot of words again.",
#'     col.names = c("NO", "ARTICLE"), sep = "\\.\\.")
#'
#' ## Real Example
#' real_dat <- read_transcript(
#'     system.file("docs/Yasmine_Interview_Transcript.docx", package = "textreadr"),
#'     skip = 19
#' )
read_transcript <-
function(file, col.names = c("Person", "Dialogue"), text.var = NULL, merge.broke.tot = TRUE,
    header = FALSE, dash = "", ellipsis = "...", quote2bracket = FALSE,
    rm.empty.rows = TRUE, na = "", sep = NULL, skip = 0, text, comment.char = "",
    max.person.nchar = 20, ...) {

    if (missing(file) && !missing(text)) {
        file <- textConnection(text)
        on.exit(close(file))
        y <- "text"
    } else {
        y <- tools::file_ext(file)
    }

    ## Handling for text= && multi-char sep
    revert <- FALSE
    if (!is.null(sep) && !missing(text) && nchar(sep) > 1) {

        text <- gsub(sep, "TEXTREADR_SEP_HOLDER", text)
        text <- gsub(":", "TEXTREADR_PLACE_HOLDER", text)
        text <- gsub("TEXTREADR_SEP_HOLDER", ":", text)
        sep <- ":"
        revert <- TRUE

    }

    if (is.null(sep)) {
        if (y %in% c("docx", "doc", "txt", "text", 'pdf')) {
            sep <- ":"
        } else {
            sep <- ","
        }
    }

    switch(y,
        xlsx = {
            x <- readxl::read_excel(file, col_names = header,
                na = na, skip = skip, ...)
            },
        xls = {
            x <- readxl::read_excel(file, col_names = header,
                na = na, skip = skip, ...)
            },
        docx = {
            x <- read.docx(file, skip = skip, sep = sep, max.person.nchar = max.person.nchar)
            sep_hits <- grepl(sep, x[, 2])
            if(any(sep_hits)) {
                warning(sprintf("The following text contains the \"%s\" separator and may not have split correctly:\n", sep),
                    paste(which(sep_hits), collapse=", "))
                }
            },
        doc = {
            x <- read.doc(file, skip = skip, sep = sep, max.person.nchar = max.person.nchar, ...)
            sep_hits <- grepl(sep, x[, 2])
            if(any(sep_hits)) {
                warning(sprintf("The following text contains the \"%s\" separator and may not have split correctly:\n", sep),
                        paste(which(sep_hits), collapse=", "))
            }
        },
        csv = {
            x <- utils::read.csv(file,  header = header,
                sep = sep, as.is=FALSE, na.strings= na,
                strip.white = TRUE, stringsAsFactors = FALSE,
                blank.lines.skip = rm.empty.rows, comment.char = comment.char, ...)
            },
        txt = {
            x <- utils::read.table(file=file, header = header, sep = sep, skip=skip)
        },
        text = {
            x <- utils::read.table(text=text, header = header, sep = sep, skip=skip)
            if(revert) {
                x[, 2] <- gsub("TEXTREADR_PLACE_HOLDER", ":", x[, 2])
                x[, 1] <- gsub("TEXTREADR_PLACE_HOLDER", ":", x[, 1])
            }
        },
        stop("invalid file extension:\n \bfile must be a .docx .csv .xls or .xlsx" )
    )

    if (!is.null(text.var) & !is.numeric(text.var)) {
        text.var <- which(colnames(x) == text.var)
    } else {
        text.col <- function(dataframe) {
            dial <- function(x) {
                if(is.factor(x) | is.character(x)) {
                    n <- max(nchar(as.character(x)), na.rm = TRUE)
                } else {
                    n <- NA
                }
            }
            which.max(unlist(lapply(dataframe, dial)))
        }
        text.var <- text.col(x)
    }

    x[[text.var]] <- trimws(iconv(as.character(x[[text.var]]), "", "ASCII", "byte"))
    if (is.logical(quote2bracket)) {
        if (quote2bracket) {
            rbrac <- "}"
            lbrac <- "{"
        } else {
            lbrac <- rbrac <- ""
        }
    } else {
            rbrac <- quote2bracket[2]
            lbrac <- quote2bracket[1]
    }

    ser <- c("<e2><80><9c>", "<e2><80><9d>", "<e2><80><98>", "<e2><80><99>",
    	"<e2><80><9b>", "<ef><bc><87>", "<e2><80><a6>", "<e2><80><93>",
    	"<e2><80><94>", "<c3><a1>", "<c3><a9>", "<c2><bd>")

    reps <- c(lbrac, rbrac, "'", "'", "'", "'", ellipsis, dash, dash, "a", "e", "half")

    Encoding(x[[text.var]]) <-"latin1"
    x[[text.var]] <- clean(mgsub(ser, reps, x[[text.var]]))
    if(rm.empty.rows) {
        x <- rm_empty_row(x)
    }
    if (!is.null(col.names)) {
        colnames(x) <- col.names
    }

    x <- as.data.frame(x, stringsAsFactors = FALSE)
    if (merge.broke.tot) {
        x <- combine_tot(x)
    }
    x <- rm_na_row(x, rm.empty.rows)
    class(x) <- c("textreadr", "data.frame")
    x
}


rm_na_row <- function(x, remove = TRUE) {
    if (!remove) return(x)
    x[rowSums(is.na(x)) != ncol(x), ]
}

read.docx <-
function(file, skip = 0, sep = ":", max.person.nchar = 20) {

    ## create temp dir
    tmp <- tempfile()
    if (!dir.create(tmp)) stop("Temporary directory could not be established.")

    ## clean up
    on.exit(unlink(tmp, recursive=TRUE))

    ## unzip docx
    xmlfile <- file.path(tmp, "word", "document.xml")
    utils::unzip(file, exdir = tmp)

    ## Import XML
    doc <- xml2::read_xml(xmlfile)

    ## extract the content
    nodeSet <- xml2::xml_find_all(doc, "//w:p")
    pvalues <- xml2::xml_text(nodeSet)

    pvalues <- pvalues[!grepl("^\\s*$", pvalues)]  # Remove empty lines
    if (skip > 0) pvalues <- pvalues[-seq(skip)]   # Ignore these many lines
    if (any(grepl(paste0("^.{", max.person.nchar, ",}", sep), pvalues))) {
        warning(sprintf(paste0(
            "I've detected the separator beyond %s characters from the line start.  Parsing may be incorrect...\n",
            "  Consider manually searching the .docx for use of the separator in-text rather than to separate person/text."
        ), max.person.nchar))
    }
    keys    <- sapply(gregexpr(paste0("^.*?", sep), pvalues), function(x) x > 0)
    speaker <- regmatches(pvalues, gregexpr(paste0("^.*?", sep), pvalues))
    pvalues <- gsub(paste0("^.*?", sep), "", pvalues)  # Remove speaker from lines
    speaker <- rep(speaker[which(keys)], diff(c(which(keys), length(speaker)+1)))
    speaker <- unlist(speaker)  # Make sure it's a vector
    speaker <- substr(speaker, 1, nchar(speaker)-nchar(sep)) # Remove ending colon
    transcript <- data.frame(X1 = trimws(speaker), X2 = trimws(pvalues), stringsAsFactors = FALSE)
    return(transcript)
}




read.doc <- function(file, skip = 0, sep = ":", max.person.nchar = 20, ...) {


        text.var <- read_doc(file = file, skip = skip, ...)

        text.var <- textshape::combine(textshape::split_match(
            text.var,
            sprintf('^.{0,%s}[%s]', max.person.nchar - 1, sep),
            include = TRUE, regex = TRUE
        ))

        if (any(grepl(paste0("^.{", max.person.nchar, ",}", sep), text.var))) {
            warning(sprintf(paste0(
                "I've detected the separator beyond %s characters from the line start.  Parsing may be incorrect...\n",
                "  Consider manually searching the .doc for use of the separator in-text rather than to separate person/text."
            ), max.person.nchar))
        }
        transcript <- textshape::split_transcript(text.var)

        return(transcript)
}


