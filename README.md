textreadr   [![Follow](https://img.shields.io/twitter/follow/tylerrinker.svg?style=social)](https://twitter.com/intent/follow?screen_name=tylerrinker)
============

![](tools/textreadr_logo/r_textreadr.png)

[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build
Status](https://travis-ci.org/trinker/textreadr.svg?branch=master)](https://travis-ci.org/trinker/textreadr)
[![Coverage
Status](https://coveralls.io/repos/trinker/textreadr/badge.svg?branch=master)](https://coveralls.io/r/trinker/textreadr?branch=master)
[![](http://cranlogs.r-pkg.org/badges/textreadr)](https://cran.r-project.org/package=textreadr)
<a href="https://img.shields.io/badge/Version-0.3.1-orange.svg"><img src="https://img.shields.io/badge/Version-0.3.1-orange.svg" alt="Version"/></a>
</p>


**textreadr** is a small collection of convenience tools for reading
text documents into R. This is not meant to be an exhaustive collection;
for more see the [**tm**](https://CRAN.R-project.org/package=tm)
package.


Table of Contents
============

-   [Functions](#functions)
-   [Installation](#installation)
-   [Contact](#contact)
-   [Demonstration](#demonstration)
    -   [Load the Packages/Data](#load-the-packagesdata)
    -   [Download](#download)
    -   [Generic Document Reading](#generic-document-reading)
    -   [Read Directory Contents](#read-directory-contents)
    -   [Read .docx](#read-docx)
    -   [Read .doc](#read-doc)
    -   [Read .pdf](#read-pdf)
    -   [Read Transcripts](#read-transcripts)
        -   [docx Simple](#docx-simple)
        -   [docx With Skip](#docx-with-skip)
        -   [docx With Dash Separator](#docx-with-dash-separator)
        -   [xls and xlsx](#xls-and-xlsx)
        -   [doc](#doc)
        -   [Reading Text](#reading-text)
        -   [Authentic Interview](#authentic-interview)
    -   [Pairing textreadr](#pairing-textreadr)

Functions
============


Most jobs in my workflow can be completed with `read_document` and
`read_dir`. The former generically reads in a .docx, .doc, .pdf, or .txt
file without specifying the extension. The latter reads in multiple
.docx, .doc, .pdf, or .txt files from a directory as a `data.frame` with
a file and text column. This workflow is effective because most text
documents I encounter are stored as a .docx, .doc, .pdf, or .txt file.
The remaining common storage formats I encounter include .csv, .xlsx,
XML, .html, and SQL. For these first 4 forms the
[**readr**](https://CRAN.R-project.org/package=readr),
[**readx**l](https://CRAN.R-project.org/package=readxl),
[**xml2**](https://CRAN.R-project.org/package=xml2), and
[**rvest**](https://CRAN.R-project.org/package=rvest). For SQL:

<table>
<thead>
<tr class="header">
<th>R Package</th>
<th>SQL</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>ROBDC</td>
<td>Microsoft SQL Server</td>
</tr>
<tr class="even">
<td>RMySQL</td>
<td>MySQL</td>
</tr>
<tr class="odd">
<td>ROracle</td>
<td>Oracle</td>
</tr>
<tr class="even">
<td>RJDBC</td>
<td>JDBC</td>
</tr>
</tbody>
</table>

These packages are already specialized to handle these very specific
data formats. **textreadr** provides the basic reading tools that work
with the four basic file formats in which text data is stored.

The main functions, task category, & descriptions are summarized in the
table below:

<table>
<thead>
<tr class="header">
<th>Function</th>
<th>Task</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>read_transcript</code></td>
<td>reading</td>
<td>Read 2 column transcripts</td>
</tr>
<tr class="even">
<td><code>read_docx</code></td>
<td>reading</td>
<td>Read .docx</td>
</tr>
<tr class="odd">
<td><code>read_doc</code></td>
<td>reading</td>
<td>Read .doc</td>
</tr>
<tr class="even">
<td><code>read_document</code></td>
<td>reading</td>
<td>Generic text reader for .doc, .docx, .txt, .pdf</td>
</tr>
<tr class="odd">
<td><code>read_pdf</code></td>
<td>reading</td>
<td>Read .pdf</td>
</tr>
<tr class="even">
<td><code>read_dir</code></td>
<td>reading</td>
<td>Read and format multiple .doc, .docx, .txt, .pdf files</td>
</tr>
<tr class="odd">
<td><code>read_dir_transcript</code></td>
<td>reading</td>
<td>Read and format multiple transcript files</td>
</tr>
<tr class="even">
<td><code>download</code></td>
<td>downloading</td>
<td>Download documents</td>
</tr>
<tr class="odd">
<td><code>peek</code></td>
<td>viewing</td>
<td>Truncated viewing of <code>data.frame</code>s</td>
</tr>
</tbody>
</table>

Installation
============

To download the development version of **textreadr**:

Download the [zip
ball](https://github.com/trinker/textreadr/zipball/master) or [tar
ball](https://github.com/trinker/textreadr/tarball/master), decompress
and run `R CMD INSTALL` on it, or use the **pacman** package to install
the development version:

    if (!require("pacman")) install.packages("pacman")
    pacman::p_load_gh("trinker/textreadr")

Contact
=======

You are welcome to:    
- submit suggestions and bug-reports at: <https://github.com/trinker/textreadr/issues>    
- send a pull request on: <https://github.com/trinker/textreadr/>    
- compose a friendly e-mail to: <tyler.rinker@gmail.com>    

Demonstration
=============

Load the Packages/Data
----------------------

    if (!require("pacman")) install.packages("pacman")
    pacman::p_load(textreadr, magrittr)
    pacman::p_load_gh("trinker/pathr")

    trans_docs <- dir(
        system.file("docs", package = "textreadr"), 
        pattern = "^trans",
        full.names = TRUE
    )

    pdf_doc <- system.file("docs/rl10075oralhistoryst002.pdf", package = "textreadr")
    docx_doc <- system.file("docs/Yasmine_Interview_Transcript.docx", package = "textreadr")
    doc_doc <- system.file("docs/Yasmine_Interview_Transcript.doc", package = "textreadr")
    txt_doc <- system.file('docs/textreadr_creed.txt', package = "textreadr")

Download
--------

`download` is simply a wrapper for `curl::curl_download` that allows
multiple documents to be download, has the `tempdir` pre-set as the
`destfile` (named `loc` in **textreadr**), and also returns the path to
the file download for easy use in a **magrittr** chain.

Here I download a .docx file of presidential debated from 2012.

    "https://dl.dropboxusercontent.com/u/61803503/pres.deb1.docx" %>%
        download() %>%
        read_docx() %>%
        head(3)

    ## pres.deb1.docx read into C:\Users\Tyler\AppData\Local\Temp\Rtmp6Fg2kD

    ## [1] "LEHRER: We'll talk about -- specifically about health care in a moment. But what -- do you support the voucher system, Governor?"                           
    ## [2] "ROMNEY: What I support is no change for current retirees and near-retirees to Medicare. And the president supports taking $716 billion out of that program."
    ## [3] "LEHRER: And what about the vouchers?"

Generic Document Reading
------------------------

The `read_document` is a generic wrapper for `read_docx`, `read_doc`,
and `read_pdf` that detects the file extension and chooses the correct
reader. For most tasks that require reading a .docx, .doc, .pdf, or .txt
file this is the go to function to get the job done. Below I demonstrate
reading each of these four file formats with `read_document`.

    docx_doc %>%
        read_document() %>%
        head(3)

    ## [1] "JRMC2202 Audio Project"      "Interview Transcript"       
    ## [3] "Interviewer: Yasmine Hassan"

    doc_doc %>%
        read_document() %>%
        head(3)

    ## [1] "*JRMC2202 Audio Project*"      "*Interview Transcript*"       
    ## [3] "*Interviewer:* Yasmine Hassan"

    pdf_doc %>%
        read_document() %>%
        head(3)

    ## [1] "Interview with Mary Waters Spaulding, August 8, 2013"                                          
    ## [2] "CRAIG BREADEN: My name is Craig Breaden. I<U+0092>m the audiovisual archivist at Duke University,"    
    ## [3] "and I<U+0092>m with Kirston Johnson, the curator of the Archive of Documentary Arts at Duke. The date"

    txt_doc %>%
        read_document() %>%
        paste(collapse = "\n") %>%
        cat()

    ## The textreadr package aims to be a lightweight
    ## tool kit that handles 80% of an analyst's text
    ## reading in needs.
    ## 
    ## The package handles .docx, .doc, .pdf, and .txt.
    ## 
    ## If you have another format there is likely already
    ## another popular R package that specializes in this
    ## read in task.  For example, got XML, use the xml2
    ## package, authored by Hadley Wickham, Jim Hester, &
    ## Jeroen Ooms.  Need to read in .html?  Use Hadley
    ## Wickham's rvest package.  Got SQL?  Oh boy there's
    ## a bunch of great ways to read it into R.
    ## 
    ## 
    ## | R Package   | SQL                    |
    ## |-------------|------------------------|
    ## | ROBDC       | Microsoft SQL Server   |
    ## | RMySQL      | MySQL                  |
    ## | ROracle     | Oracle                 |
    ## | RJDBC       | JDBC                   |

Read Directory Contents
-----------------------

Often there is a need to read multiple files in from a single directory.
The `read_dir` function wraps other **textreadr** functions and `lapply`
to create a data frame with a document and text column (one row per
document). We will read the following documents from the 'pos' directory
in **textreadr**'s system file:

    levelName
    pos          
      Â¦--0_9.txt  
      Â¦--1_7.txt  
      Â¦--10_9.txt 
      Â¦--11_9.txt 
      Â¦--12_9.txt 
      Â¦--13_7.txt 
      Â¦--14_10.txt
      Â¦--15_7.txt 
      Â¦--16_7.txt 
      Â¦--17_9.txt 
      Â¦--18_7.txt 
      Â¦--19_10.txt
      Â¦--2_9.txt  
      Â¦--3_10.txt 
      Â¦--4_8.txt  
      Â¦--5_10.txt 
      Â¦--6_10.txt 
      Â¦--7_7.txt  
      Â¦--8_7.txt  
      Â°--9_7.txt

Here we have read the files in, one row per file.

    system.file("docs/Maas2011/pos", package = "textreadr") %>%
        read_dir() %>%
        peek(Inf, 40)

    ## Source: local data frame [20 x 2]
    ## 
    ##    document                                  content
    ## 1       0_9 Bromwell High is a cartoon comedy. It ra
    ## 2       1_7 If you like adult comedy cartoons, like 
    ## 3      10_9 I'm a male, not given to women's movies,
    ## 4      11_9 Liked Stanley & Iris very much. Acting w
    ## 5      12_9 Liked Stanley & Iris very much. Acting w
    ## 6      13_7 The production quality, cast, premise, a
    ## 7     14_10 This film has a special place in my hear
    ## 8      15_7 I guess if a film has magic, I don't nee
    ## 9      16_7 I found this to be a so-so romance/drama
    ## 10     17_9 This is a complex film that explores the
    ## 11     18_7 `Stanley and Iris' is a heart warming fi
    ## 12    19_10 I just read the comments of TomReynolds2
    ## 13      2_9 Bromwell High is nothing short of brilli
    ## 14     3_10 "All the world's a stage and its people 
    ## 15      4_8 FUTZ is the only show preserved from the
    ## 16     5_10 I came in in the middle of this film so 
    ## 17     6_10 Fair drama/love story movie that focuses
    ## 18      7_7 Although I didn't like Stanley & Iris tr
    ## 19      8_7 Very good drama although it appeared to 
    ## 20      9_7 Working-class romantic drama from direct
    ## ..      ...                                      ...

Read .docx
----------

A .docx file is nothing but a fancy container. It can be parsed via XML.
The `read_docx` function allows the user to read in a .docx file as
plain text. Elements are essentially the p tags (explicitly `//w:p`) in
the markup.

    docx_doc %>%
        read_docx() %>%
        head(3)

    ## [1] "JRMC2202 Audio Project"      "Interview Transcript"       
    ## [3] "Interviewer: Yasmine Hassan"

    docx_doc %>%
        read_docx(15) %>%
        head(3)

    ## [1] "Hassan:           Could you please tell me your name, your title, your age, and your place of ref,                                   umm, residence?"
    ## [2] "Abd Rabou:   My name is Ahmad Abd Rabou. I<U+0092>m assistant professor of comparative politics at"                                                         
    ## [3] "both Cairo University and The American University in Cairo. I<U+0092>m 34 years old. I"

Read .doc
---------

A .doc file is a bit trickier to read in than .docx. The
[Antiword](http://www.winfield.demon.nl) program can be used from the
command line to extract text from a .doc file. Antiword must be
installed.

    doc_doc %>%
        read_doc() %>%
        head()

    ## [1] "*JRMC2202 Audio Project*"      "*Interview Transcript*"       
    ## [3] "*Interviewer:* Yasmine Hassan" "*Narrator:* Ahmad Abd Rabou"  
    ## [5] "*Date:* 16/10/2014"            "*Place:* Narrator's office"

    doc_doc %>%
        read_doc(15) %>%
        head(7)

    ## [1] "*Hassan:*           Could you please tell me your name, your title, your age,"
    ## [2] "and your place of ref,"                                                       
    ## [3] "umm, residence?"                                                              
    ## [4] "*Abd Rabou:*   My name is Ahmad Abd Rabou. I'm assistant professor of"        
    ## [5] "comparative politics at"                                                      
    ## [6] "both Cairo University and The American University"                            
    ## [7] "in Cairo. I'm 34 years old. I"

Read .pdf
---------

Like .docx a .pdf file is simply a container. Reading PDF's is made
easier with a number of command line tools. A few methods of PDF reading
have been incorporated into R. Here I wrap **pdftools** `pdf_text` to
produce `read_pdf`, a function with sensible defaults that is designed
to read PDFs into R for as many folks as possible right out of the box.

Here I read in a PDF with `read_pdf`. Notice the result is a data frame
with meta data, including page numbers and element (row) ids.

    pdf_doc %>%
        read_pdf() 

    ## Source: local data frame [616 x 3]
    ## 
    ##    page_id element_id                                     text
    ## 1        1          1 Interview with Mary Waters Spaulding, Au
    ## 2        1          2 CRAIG BREADEN: My name is Craig Breaden.
    ## 3        1          3 and I<U+0092>m with Kirston Johnson, the curato
    ## 4        1          4 is August 8, 2013, and we are in Lexingt
    ## 5        1          5 life and family, and particularly about 
    ## 6        1          6 your full name, date of birth, and place
    ## 7        1          7 MARY WATERS SPAULDING: My name is Mary E
    ## 8        1          8 birth was Lexington, NC, on May 14, 1942
    ## 9        1          9 BREADEN: Can you describe what Lexington
    ## 10       1         10                                  1940<U+0092>s?
    ## ..     ...        ...                                      ...

[Carl Witthoft's](http://stackoverflow.com/a/9187015/1000343) word of
caution is useful for those struggling to read image text into R.

> Just a warning to others who may be hoping to extract data: PDF is a
> container, not a format. If the original document does not contain
> actual text, as opposed to bitmapped images of text or possibly even
> uglier things than I can imagine, nothing other than OCR can help you.

Users may find the following sites useful for OCR in R:

-   <https://CRAN.R-project.org/package=tesseract>  
-   <http://electricarchaeology.ca/2014/07/15/doing-ocr-within-r>
-   <https://github.com/soodoku/abbyyR>

Read Transcripts
----------------

Many researchers store their dialogue data (including interviews and
observations) as a .docx or .xlsx file. Typically the data is a two
column format with the person in the first column and the text in the
second separated by some sort of separator (often a colon). The
`read_transcript` wraps up many of these assumptions into a reader that
will extract the data as a data frame with a person and text column. The
`skip` argument is very important for correct parsing.

Here I read in and parse the different formats `read_transcript`
handles. These are the files that will be read in:

    basename(trans_docs)

    ## [1] "trans1.docx" "trans2.docx" "trans3.docx" "trans4.xlsx" "trans5.xls" 
    ## [6] "trans6.doc"  "transcripts"

### docx Simple

    read_transcript(trans_docs[1])

    ## Source: local data frame [5 x 2]
    ## 
    ##              Person                                 Dialogue
    ## 1      Researcher 2                         October 7, 1892.
    ## 2         Teacher 4 Students it's time to learn. [Student di
    ## 3 Multiple Students        Yes teacher we're ready to learn.
    ## 4     [Cross Talk 3                                      00]
    ## 5         Teacher 4 Let's read this terrific book together. 
    ## .               ...                                      ...

### docx With Skip

`skip` is important to capture the document structure. Here not skipping
front end document matter throws an error, while `skip = 1` correctly
parses the file.

    read_transcript(trans_docs[2])

    ## Error in data.frame(X1 = trimws(speaker), X2 = trimws(pvalues), stringsAsFactors = FALSE): arguments imply differing number of rows: 7, 8

    read_transcript(trans_docs[2], skip = 1)

    ## Source: local data frame [5 x 2]
    ## 
    ##              Person                                 Dialogue
    ## 1      Researcher 2                         October 7, 1892.
    ## 2         Teacher 4 Students it's time to learn. [Student di
    ## 3 Multiple Students        Yes teacher we're ready to learn.
    ## 4     [Cross Talk 3                                      00]
    ## 5         Teacher 4 Let's read this terrific book together. 
    ## .               ...                                      ...

### docx With Dash Separator

The colon is the default separator. At times other separators may be
used to separate speaker and text. Here is an example where hypens are
used as a separator. Notice the poor parse with colon set as the default
separator the first go round.

    read_transcript(trans_docs[3], skip = 1)

    ## Source: local data frame [1 x 2]
    ## 
    ##          Person                                 Dialogue
    ## 1 [Cross Talk 3 Teacher 4-Students it's time to learn. [
    ## .           ...                                      ...

    read_transcript(trans_docs[3], sep = "-", skip = 1)

    ## Source: local data frame [3 x 2]
    ## 
    ##              Person                                 Dialogue
    ## 1         Teacher 4 Students it's time to learn. [Student di
    ## 2 Multiple Students Yes teacher we're ready to learn. [Cross
    ## 3         Teacher 4 Let's read this terrific book together. 
    ## .               ...                                      ...

### xls and xlsx

    read_transcript(trans_docs[4])

    ## Source: local data frame [4 x 2]
    ## 
    ##               Person                                 Dialogue
    ## 1      Researcher 2:                         October 7, 1892.
    ## 2         Teacher 4:             Students it's time to learn.
    ## 3 Multiple Students:        Yes teacher we're ready to learn.
    ## 4         Teacher 4: Let's read this terrific book together. 
    ## .                ...                                      ...

    read_transcript(trans_docs[5])

    ## Source: local data frame [4 x 2]
    ## 
    ##               Person                                 Dialogue
    ## 1      Researcher 2:                         October 7, 1892.
    ## 2         Teacher 4:             Students it's time to learn.
    ## 3 Multiple Students:        Yes teacher we're ready to learn.
    ## 4         Teacher 4: Let's read this terrific book together. 
    ## .                ...                                      ...

### doc

    read_transcript(trans_docs[6], skip = 1)

    ## Source: local data frame [3 x 2]
    ## 
    ##               Person                                 Dialogue
    ## 1         /Teacher 4 / Students it's time to learn. [Student 
    ## 2 /Multiple Students      / Yes teacher we're ready to learn.
    ## 3         /Teacher 4 / Let's read this terrific book together
    ## .                ...                                      ...

### Reading Text

Like `read.table`, `read_transcript` also has a `text` argument which is
useful for demoing code.

    read_transcript(
        text=

    "34    The New York Times reports a lot of words here.
    12    Greenwire reports a lot of words.
    31    Only three words.
     2    The Financial Times reports a lot of words.
     9    Greenwire short.
    13    The New York Times reports a lot of words again.",

        col.names = c("NO", "ARTICLE"), sep = "   "
    )

    ## Source: local data frame [6 x 2]
    ## 
    ##   NO                                  ARTICLE
    ## 1 34 The New York Times reports a lot of word
    ## 2 12        Greenwire reports a lot of words.
    ## 3 31                        Only three words.
    ## 4  2 The Financial Times reports a lot of wor
    ## 5  9                         Greenwire short.
    ## 6 13 The New York Times reports a lot of word
    ## . ..                                      ...

### Authentic Interview

Here I read in an authentic interview transcript:

    docx_doc %>%
        read_transcript(c("Person", "Dialogue"), skip = 19)

    ## Source: local data frame [13 x 2]
    ## 
    ##       Person                                 Dialogue
    ## 1     Hassan Professor Abd Rabou, being a current pro
    ## 2  Abd Rabou Sure. First of all, let's look at the so
    ## 3     Hassan So from this point of the differences of
    ## 4  Abd Rabou No. I don't--It depends --Like my--This 
    ## 5     Hassan So, as political science students, does 
    ## 6  Abd Rabou Less, not mature, they are politically m
    ## 7     Hassan Since you are an active politician and w
    ## 8  Abd Rabou It does somehow. What I do is--First of 
    ## 9     Hassan But you are characterized with, somehow 
    ## 10 Abd Rabou So far I didn't get--So far--Maybe it do
    ## ..       ...                                      ...

Pairing textreadr
-----------------

**textreadr** is but one package used in the text analysis (often the
first package used). It pairs nicely with a variety of other text
mundging and analysis packages. In the example below I show just a few
other package pairings that are used to extract case names (e.g., "Jones
v. State of New York") from a [Supreme Court Database Code
Book](http://scdb.wustl.edu/_brickFiles/2012_01/SCDB_2012_01_codebook.pdf).
I demonstrate pairings with
[**textshape**](https://github.com/trinker/textshape),
[**textclean**](https://github.com/trinker/textclean),
[**qdapRegex**](https://github.com/trinker/qdapRegex), and
[**dplyr**](https://github.com/hadley/dplyr).

    if (!require("pacman")) install.packages("pacman"); library(pacman)
    p_load(dplyr, qdapRegex)
    p_load_current_gh(file.path('trinker', c('textreadr', 'textshape', 'textclean')))

    ## Read in pdf, split on variables
    dat <- 'http://scdb.wustl.edu/_brickFiles/2012_01/SCDB_2012_01_codebook.pdf' %>%
        textreadr::download() %>%
        textreadr::read_pdf() %>%
        filter(page_id > 5 & page_id < 79) %>%
        mutate(
            loc = grepl('Variable Name', text, ignore.case=TRUE),
            text = textclean::replace_non_ascii(text)
        ) %>%
        textshape::split_index(which(.$loc) -1) %>%
        lapply(select, -loc)

    ## SCDB_2012_01_codebook.pdf read into C:\Users\Tyler\AppData\Local\Temp\Rtmp6Fg2kD

    ## Function to extract cases
    ex_vs <- qdapRegex::ex_(pattern = "((of|[A-Z][A-Za-z'.,-]+)\\s+)+([Vv]s?\\.\\s+)(([A-Z][A-Za-z'.,-]+\\s+)*((of|[A-Z][A-Za-z',.-]+),?($|\\s+|\\d))+)")

    ## Extract and filter cases
    dat %>%
        lapply(function(x) {
            x$text %>%
                textshape::combine() %>%
                ex_vs()  %>% 
                c() %>% 
                textclean::mgsub(c("^[ ,]+", "[ ,0-9]+$", "^(See\\s+|E\\.g\\.?,)"), "", fixed=FALSE)
        }) %>%
        setNames(seq_along(.)) %>%
        {.[sapply(., function(x) all(length(x) > 1 | !is.na(x)))]}

    ## $`24`
    ## [1] "Townsend v. Sain"         "Simpson v. Florida"      
    ## [3] "McNally v. United States" "United States v. Gray"   
    ## 
    ## $`30`
    ## [1] "Edward V. Heck"
    ## 
    ## $`36`
    ## [1] "State of Colorado v. Western Alfalfa Corporation"
    ## 
    ## $`38`
    ## [1] "Pulliam v. Allen"   "Burnett v. Grattan"
    ## 
    ## $`40`
    ##  [1] "United States v. Knox"                                            
    ##  [2] "Lassiter v. Department of Social Services"                        
    ##  [3] "Arkansas v. Tennessee"                                            
    ##  [4] "Utah v. United States"                                            
    ##  [5] "Johnson v. United States"                                         
    ##  [6] "Baldonado v. California"                                          
    ##  [7] "Conway v. California Adult Authority"                             
    ##  [8] "Wheaton v. California"                                            
    ##  [9] "Maxwell v. Bishop"                                                
    ## [10] "National Labor Relations Board v. United Insurance Co. of America"
    ## [11] "United States v. King"                                            
    ## [12] "National Labor Relations Board v. United Insurance Co. of America"
    ## [13] "United States v. King"                                            
    ## 
    ## $`44`
    ## [1] "Grisham v. Hagan"                  
    ## [2] "McElroy v. Guagliardo"             
    ## [3] "Virginia Supreme Court v. Friedman"
    ## 
    ## $`48`
    ## [1] "Baker v. Carr"                    "Gray v. Sanders"                 
    ## [3] "Patterson v. McLean Credit Union"
    ## 
    ## $`53`
    ## [1] "Bates v. Arizona State Bar"
    ## 
    ## $`57`
    ## [1] "New York Gaslight Club, Inc. v. Carey"
    ## [2] "Pruneyard Shopping Center v. Robins"  
    ## 
    ## $`58`
    ## [1] "Mobile v. Bolden"                            
    ## [2] "Williams v. Brown"                           
    ## [3] "United States v. Havens"                     
    ## [4] "Parratt v. Taylor"                           
    ## [5] "Dougherty County Board of Education v. White"
    ## [6] "Jenkins v. Anderson"
