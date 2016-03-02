textreadr
============


<img src="inst/textreadr_logo/r_textreadr.png" width="320" alt="textreadr Logo">

[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build
Status](https://travis-ci.org/trinker/textreadr.svg?branch=master)](https://travis-ci.org/trinker/textreadr)
[![Coverage
Status](https://coveralls.io/repos/trinker/textreadr/badge.svg?branch=master)](https://coveralls.io/r/trinker/textreadr?branch=master)
<a href="https://img.shields.io/badge/Version-0.1.0-orange.svg"><img src="https://img.shields.io/badge/Version-0.1.0-orange.svg" alt="Version"/></a>
</p>
**textreadr** is a small collection of convenience tools for reading
text documents into R. This is not meant to be an exhaustive collection;
for more see the
[**tm**](https://cran.r-project.org/web/packages/tm/index.html) package.

Function Usage
==============

The main functions, task category, & descriptions are summarized in the
table below:

<table>
<thead>
<tr class="header">
<th align="left">Function</th>
<th align="left">Task</th>
<th align="left">Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left"><code>read_transcript</code></td>
<td align="left">reading</td>
<td align="left">Read 2 column transcripts</td>
</tr>
<tr class="even">
<td align="left"><code>read_docx</code></td>
<td align="left">reading</td>
<td align="left">Read .docx</td>
</tr>
<tr class="odd">
<td align="left"><code>read_pdf</code></td>
<td align="left">reading</td>
<td align="left">Read .pdf</td>
</tr>
<tr class="even">
<td align="left"><code>read_dir</code></td>
<td align="left">reading</td>
<td align="left">Read and format multiple .txt files</td>
</tr>
<tr class="odd">
<td align="left"><code>download</code></td>
<td align="left">downloading</td>
<td align="left">Download documents</td>
</tr>
<tr class="even">
<td align="left"><code>peek</code></td>
<td align="left">viewing</td>
<td align="left">Truncated viewing of <code>data.frame</code>s</td>
</tr>
</tbody>
</table>


Table of Contents
============

-   [[Function Usage](#function-usage)](#[function-usage](#function-usage))
-   [[Installation](#installation)](#[installation](#installation))
-   [[Contact](#contact)](#[contact](#contact))
-   [[Demonstration](#demonstration)](#[demonstration](#demonstration))
    -   [[Load the Packages/Data](#load-the-packagesdata)](#[load-the-packagesdata](#load-the-packagesdata))
    -   [[Download](#download)](#[download](#download))
    -   [[Read .docx](#read-.docx)](#[read-.docx](#read-.docx))
    -   [[Read .pdf](#read-.pdf)](#[read-.pdf](#read-.pdf))
    -   [[Read Transcripts](#read-transcripts)](#[read-transcripts](#read-transcripts))
        -   [[docx Simple](#docx-simple)](#[docx-simple](#docx-simple))
        -   [[docx With Skip](#docx-with-skip)](#[docx-with-skip](#docx-with-skip))
        -   [[docx With Dash Separator](#docx-with-dash-separator)](#[docx-with-dash-separator](#docx-with-dash-separator))
        -   [[xls and xlsx](#xls-and-xlsx)](#[xls-and-xlsx](#xls-and-xlsx))
        -   [[Reading Text](#reading-text)](#[reading-text](#reading-text))
        -   [[Authentic Interview](#authentic-interview)](#[authentic-interview](#authentic-interview))
    -   [[Read Directory Contents](#read-directory-contents)](#[read-directory-contents](#read-directory-contents))

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

-   submit suggestions and bug-reports at:     <https://github.com/trinker/textreadr/issues>  
-   send a pull request on: <https://github.com/trinker/textreadr/>  
-   compose a friendly e-mail to: <tyler.rinker@gmail.com>

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

    ## pres.deb1.docx read into C:\Users\Tyler\AppData\Local\Temp\Rtmpie6DKv

    ## [1] "LEHRER: We'll talk about -- specifically about health care in a moment. But what -- do you support the voucher system, Governor?"                           
    ## [2] "ROMNEY: What I support is no change for current retirees and near-retirees to Medicare. And the president supports taking $716 billion out of that program."
    ## [3] "LEHRER: And what about the vouchers?"

Read .docx
----------

A .docx file is nothing but a fancy container. It can be parsed via XML.
The `read_docx` function allows the user to read in a .docx file as
plain text. Elements are essentially the p tags (explicitly `//w:p`) in
the markup.

    docx_doc %>%
        read_docx() %>%
        head(3)

    ## [1] "JRMC2202 Audio Project" ""                      
    ## [3] "Interview Transcript"

    docx_doc %>%
        read_docx(19) %>%
        head(3)

    ## [1] "Hassan:           Could you please tell me your name, your title, your age, and your place of ref,                                   umm, residence?"
    ## [2] "Abd Rabou:   My name is Ahmad Abd Rabou. I<U+0092>m assistant professor of comparative politics at"                                                         
    ## [3] "both Cairo University and The American University in Cairo. I<U+0092>m 34 years old. I"

Read .pdf
---------

Like .docx a .pdf file is simply a container. Reading PDF's is made
easier with a number of command line tools. A few methods of PDF reading
have been incorporated into R. Here I wrap the stable, reliable **tm**
port to produce `read_pdf`, a function with sensible defaults that is
designed to read PDFs into R for as many folks as possible right out of
the box.

Here I read in a PDF with `read_pdf`. Notice the result is a data frame
with meta data, including page numbers and element (row) ids.

    pdf_doc %>%
        read_pdf() 

    ## Source: local data frame [825 x 3]
    ## 
    ##    page_id element_id                                            text
    ## 1        1          1                                                
    ## 2        1          2        Interview with Mary Waters Spaulding, Au
    ## 3        1          3                                                
    ## 4        1          4 \\Gamma \\Delta \\Theta \\Lambda \\Xi  \\Pi \\D
    ## 5        1          5       flfi^ \\Lambda _ffi !i*, "i`j*aefi #ae,fi
    ## 6        1          6        is August 8, 2013, and we are in Lexingt
    ## 7        1          7        life and family, and particularly about 
    ## 8        1          8        your full name, date of birth, and place
    ## 9        1          9                                                
    ## 10       1         10        MARY WATERS SPAULDING: My name is Mary E
    ## ..     ...        ...                                      ...

[Carl Witthoft's](http://stackoverflow.com/a/9187015/1000343) word of
caution is useful for those struggling to read image text into R.

> Just a warning to others who may be hoping to extract data: PDF is a
> container, not a format. If the original document does not contain
> actual text, as opposed to bitmapped images of text or possibly even
> uglier things than I can imagine, nothing other than OCR can help you.

Users may find the following sites useful for OCR in R:

-   <http://electricarchaeology.ca/2014/07/15/doing-ocr-within-r/>  
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

    read_transcript(trans_docs[3],skip = 1)

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

### Reading Text

Like `read.table` `read_transcript` also has a `text` argument which is
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

    ## Source: local data frame [15 x 2]
    ## 
    ##       Person                                 Dialogue
    ## 1     Hassan Could you please tell me your name, your
    ## 2  Abd Rabou My name is Ahmad Abd Rabou. I'm assistan
    ## 3     Hassan Professor Abd Rabou, being a current pro
    ## 4  Abd Rabou Sure. First of all, let's look at the so
    ## 5     Hassan So from this point of the differences of
    ## 6  Abd Rabou No. I don't--It depends --Like my--This 
    ## 7     Hassan So, as political science students, does 
    ## 8  Abd Rabou Less, not mature, they are politically m
    ## 9     Hassan Since you are an active politician and w
    ## 10 Abd Rabou It does somehow. What I do is--First of 
    ## ..       ...                                      ...

Read Directory Contents
-----------------------

Often there is a need to read multiple files in from a single directory.
The `read_dir` function wraps other **textreadr** functions and `lapply`
to create a data frame with a document and text column (one row per
document). We will read the following documents from the 'pos' directory
in **textreadr**'s system file:

    ##        levelName
    ## 1  pos          
    ## 2   ¦--0_9.txt  
    ## 3   ¦--1_7.txt  
    ## 4   ¦--10_9.txt 
    ## 5   ¦--11_9.txt 
    ## 6   ¦--12_9.txt 
    ## 7   ¦--13_7.txt 
    ## 8   ¦--14_10.txt
    ## 9   ¦--15_7.txt 
    ## 10  ¦--16_7.txt 
    ## 11  ¦--17_9.txt 
    ## 12  ¦--18_7.txt 
    ## 13  ¦--19_10.txt
    ## 14  ¦--2_9.txt  
    ## 15  ¦--3_10.txt 
    ## 16  ¦--4_8.txt  
    ## 17  ¦--5_10.txt 
    ## 18  ¦--6_10.txt 
    ## 19  ¦--7_7.txt  
    ## 20  ¦--8_7.txt  
    ## 21  °--9_7.txt

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
