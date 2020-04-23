root <- Sys.getenv("USERPROFILE")
pack <- basename(getwd())

quick <-  TRUE
# pdf <- TRUE
pdf <- FALSE

unlink(paste0(pack, ".pdf"), recursive = TRUE, force = TRUE)
devtools::document()
devtools::install(quick = quick, build_vignettes = FALSE, dependencies = TRUE)

if(pdf){
    path <- find.package(pack)
    system(paste(shQuote(file.path(R.home("bin"), "R")), "CMD", "Rd2pdf", shQuote(path)))
    file.copy(paste0(pack, '.pdf'), file.path(root,"Desktop", paste0(pack, '.pdf')))
    while (file.exists(paste0(pack, ".pdf"))) {unlink(paste0(pack, ".pdf"), recursive = TRUE, force = TRUE)}
    empts <- grep("^\\.Rd", dir(all.files = TRUE), value = TRUE)
    unlink(empts, recursive = TRUE, force = TRUE)
}

message("Done!")


#===============================================================================
## update_news()
## rmarkdown::render("README.Rmd", "all"); md_toc()

update_news <- function(repo = basename(getwd())) {

    News <- readLines("NEWS")

    News <- textclean::mgsub(News, 
        c("<", ">", "&lt;major&gt;.&lt;minor&gt;.&lt;patch&gt;", "BUG FIXES",
            "NEW FEATURES", "MINOR FEATURES", "CHANGES", "IMPROVEMENTS", " TRUE ", " FALSE ",
            " NULL ", "TRUE.", "FALSE.", "NULL.", ":m:"),
        c("&lt;", "&gt;", "**&lt;major&gt;.&lt;minor&gt;.&lt;patch&gt;**",
            "**BUG FIXES**", "**NEW FEATURES**", "**MINOR FEATURES**",
            "**CHANGES**", "**IMPROVEMENTS**", " `TRUE` ", "`FALSE`.", "`NULL`.", "`TRUE`.",
            " `FALSE` ", " `NULL` ", " : m : "),
            trim = FALSE, fixed=TRUE)

    News <- sub(pattern="issue *# *([0-9]+)",
        replacement=sprintf("<a href=\"https://github.com/trinker/%s/issues/\\1\">issue #\\1</a>",
        repo),
        x=News)

    News <- sub(pattern="pull request *# *([0-9]+)",
        replacement=sprintf("<a href=\"https://github.com/trinker/%s/issues/\\1\">pull request #\\1</a>",
        repo),
        x=News)

    News <- gsub(sprintf(" %s", repo),
        sprintf(" <a href=\"https://github.com/trinker/%s\" target=\"_blank\">%s</a>",
        repo, repo), News)

    cat(paste(News, collapse = "\n"), file = "NEWS.md")
    message("news.md updated")
}


md_toc <- function(path = "README.md", repo = basename(getwd()),
    insert.loc = "Functions"){

    x <- suppressWarnings(readLines(path))
    
    twitter <- ''
    contact <- paste(c(
        "You are welcome to:    ",
        "- submit suggestions and bug-reports at: <https://github.com/trinker/%s/issues>    ",
        "- send a pull request on: <https://github.com/trinker/%s/>    ",
        "- compose a friendly e-mail to: <tyler.rinker@gmail.com>    \n"
    ), collapse="\n")

    inds <- 1:(which(!grepl("(^\\s*-)|(\\]\\(#)", x))[1] - 1)

    temp <- gsub("(^[ -]+)(.+)", "\\1", x[inds])
    content <- gsub("^[ -]+", "", x[inds])
    bkna <- grepl("^[^[]", content)

    if (sum(bkna) > 0){
        bkn <- which(bkna)
        for (i in bkn){
            content[i - 1] <- paste(content[i - 1], content[i])
        }
        content <- content[!bkna]
        temp <- temp[!bkna]
    }

    toc <- paste(c("\nTable of Contents\n============\n",
        sprintf("%s[%s](%s)", temp, c(qdapRegex::ex_square(content)), gsub("[;/?:@&=+$,.]", "",
            gsub("\\s", "-", c(tolower(qdapRegex::ex_round(content)))))),
        sprintf("\n%s\n============\n", insert.loc)),
        collapse = "\n"
    )

    x <- x[(max(inds) + 1):length(x)]

    inst_loc <- which(grepl(sprintf("^%s$", insert.loc), x))[1]
    x[inst_loc] <- toc
    x <- x[-c(1 + inst_loc)]

    beg <- grep("^You are welcome", x)
    end <- grep("compose a friendly", x)
    
    x[beg] <- sprintf(contact, repo, repo)
    
    x <- x[!seq_along(x) %in% (1+beg:end)]

    a <- grep("<table>", x)
    if (!identical(integer(0), a)){
        b <- grep("</table>", x)
        inds <- unlist(mapply(function(a, b){ a:b}, a, b))
        x[inds] <- gsub("\\\\_", "_", x[inds])
    }

    x <- gsub("<!-- -->", "", x, fixed=TRUE)
    x <- gsub('^</p>$', '</p>\n\n', x, fixed = FALSE)
	
    cat(paste(c(sprintf("%s   %s\n============\n", repo, twitter), x), collapse = "\n"), file = path)
    message("README.md updated")
}

#==========================
# NEWS new version
#==========================

nh <- function() cat(paste(c("BUG FIXES", "NEW FEATURES", "MINOR FEATURES", "IMPROVEMENTS", "CHANGES"), collapse = "\n\n"), file="clipboard")
