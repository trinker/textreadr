textreadr   
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
    -   [Download & Browse](#download-browse)
        -   [Download](#download)
        -   [Browse](#browse)
    -   [Generic Document Reading](#generic-document-reading)
    -   [Read Directory Contents](#read-directory-contents)
    -   [Read .docx](#read-docx)
    -   [Read .doc](#read-doc)
    -   [Read .rtf](#read-rtf)
    -   [Read .pdf](#read-pdf)
        -   [Image Based pdf: OCR](#image-based-pdf-ocr)
    -   [Read .pptx](#read-pptx)
    -   [Read .html](#read-html)
    -   [Read Transcripts](#read-transcripts)
        -   [docx Simple](#docx-simple)
        -   [docx With Skip](#docx-with-skip)
        -   [docx With Dash Separator](#docx-with-dash-separator)
        -   [xls and xlsx](#xls-and-xlsx)
        -   [doc](#doc)
        -   [rtf](#rtf)
        -   [Reading Text](#reading-text)
        -   [Authentic Interview](#authentic-interview)
    -   [Pairing textreadr](#pairing-textreadr)

Functions
============


Most jobs in my workflow can be completed with `read_document` and
`read_dir`. The former generically reads in a .docx, .doc, .pdf, .html,
or .txt file without specifying the extension. The latter reads in
multiple .docx, .doc, .rtf, .pdf, .html, or .txt files from a directory
as a `data.frame` with a file and text column. This workflow is
effective because most text documents I encounter are stored as a .docx,
.doc, .rtf, .pdf, .html, or .txt file. The remaining common storage
formats I encounter include .csv, .xlsx, XML, structured .html, and SQL.
For these first 4 forms the
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
with the five basic file formats in which text data is stored.

The main functions, task category, & descriptions are summarized in the
table below:

<table>
<colgroup>
<col style="width: 34%" />
<col style="width: 16%" />
<col style="width: 49%" />
</colgroup>
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
<td><code>read_rtf</code></td>
<td>reading</td>
<td>Read .rtf</td>
</tr>
<tr class="odd">
<td><code>read_document</code></td>
<td>reading</td>
<td>Generic text reader for .doc, .docx, .rtf, .txt, .pdf</td>
</tr>
<tr class="even">
<td><code>read_html</code></td>
<td>reading</td>
<td>Read .html</td>
</tr>
<tr class="odd">
<td><code>read_pdf</code></td>
<td>reading</td>
<td>Read .pdf</td>
</tr>
<tr class="even">
<td><code>read_dir</code></td>
<td>reading</td>
<td>Read and format multiple .doc, .docx, .rtf, .txt, .pdf files</td>
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

    docx_doc <- system.file("docs/Yasmine_Interview_Transcript.docx", package = "textreadr")
    doc_doc <- system.file("docs/Yasmine_Interview_Transcript.doc", package = "textreadr")
    pdf_doc <- system.file("docs/rl10075oralhistoryst002.pdf", package = "textreadr")
    html_doc <- system.file('docs/textreadr_creed.html', package = "textreadr")
    txt_doc <- system.file('docs/textreadr_creed.txt', package = "textreadr")
    pptx_doc <- system.file('docs/Hello_World.pptx', package = "textreadr")

    rtf_doc <- download(
        'https://raw.githubusercontent.com/trinker/textreadr/master/inst/docs/trans7.rtf'
    )

    pdf_doc_img <- system.file("docs/McCune2002Choi2010.pdf", package = "textreadr")

Download & Browse
-----------------

The `download` and `browse` functions are utilities for downloading and
opening files and directories.

### Download

`download` is simply a wrapper for `curl::curl_download` that allows
multiple documents to be download, has the `tempdir` pre-set as the
`destfile` (named `loc` in **textreadr**), and also returns the path to
the file download for easy use in a **magrittr** chain.

Here I download a .docx file of presidential debated from 2012.

    'https://github.com/trinker/textreadr/raw/master/inst/docs/pres.deb1.docx' %>%
        download() %>%
        read_docx() %>%
        head(3)

    ## pres.deb1.docx read into C:\Users\trinker\AppData\Local\Temp\RtmpsRIhsW

    ## [1] "LEHRER: We'll talk about -- specifically about health care in a moment. But what -- do you support the voucher system, Governor?"                           
    ## [2] "ROMNEY: What I support is no change for current retirees and near-retirees to Medicare. And the president supports taking $716 billion out of that program."
    ## [3] "LEHRER: And what about the vouchers?"

### Browse

`browse` is a system dependent tool for opening files and directories.
In the example below we open the directory that contains the example
documents used in this README.

    system.file("docs", package = "textreadr") %>%
        browse()

We can open files as well:

    html_doc %>%
        browse()

Generic Document Reading
------------------------

The `read_document` is a generic wrapper for `read_docx`, `read_doc`,
`read_html`, and `read_pdf` that detects the file extension and chooses
the correct reader. For most tasks that require reading a .docx, .doc,
.html, .pdf, or .txt file this is the go-to function to get the job
done. Below I demonstrate reading each of these five file formats with
`read_document`.

    docx_doc %>%
        read_document() %>%
        head(3)

    ## [1] "JRMC2202 Audio  Project"      "Interview Transcript"         "Interviewer:  Yasmine Hassan"

    doc_doc %>%
        read_document() %>%
        head(3)

    ## [1] "JRMC2202 Audio Project"      "Interview Transcript"        "Interviewer: Yasmine Hassan"

    rtf_doc %>%
        read_document() %>%
        head(3)

    ## [1] "Researcher 2:\tOctober 7, 1892."           "Teacher 4:\tStudents it’s time to learn."  "[Student discussion; unintelligible]"

    pdf_doc %>%
        read_document() %>%
        head(3)

    ## [1] "Interview with Mary Waters Spaulding, August 8, 2013"                                          
    ## [2] "CRAIG BREADEN: My name is Craig Breaden. I’m the audiovisual archivist at Duke University,"    
    ## [3] "and I’m with Kirston Johnson, the curator of the Archive of Documentary Arts at Duke. The date"

    html_doc %>%
        read_document() %>%
        head(3)

    ## [1] "textreadr Creed"                                                                                                
    ## [2] "The textreadr package aims to be a lightweight tool kit that handles 80% of an analyst’s text reading in needs."
    ## [3] "The package handles .docx, .doc, .pdf, .html, and .txt."

    txt_doc %>%
        read_document() %>%
        paste(collapse = "\n") %>%
        cat()

    ## The textreadr package aims to be a lightweight
    ## tool kit that handles 80% of an analyst's text
    ## reading in needs.
    ## The package handles .docx, .doc, .pdf, .html, and .txt.
    ## If you have another format there is likely already
    ## another popular R package that specializes in this
    ## read in task.  For example, got XML, use the xml2
    ## package, authored by Hadley Wickham, Jim Hester, &
    ## Jeroen Ooms.  Need special handling for .html?  Use
    ## Hadley Wickham's rvest package.  Got SQL?  Oh boy
    ## there's a bunch of great ways to read it into R.
    ## | R Package   | SQL                    |
    ## |-------------|------------------------|
    ## | ROBDC       | Microsoft SQL Server   |
    ## | RMySQL      | MySQL                  |
    ## | ROracle     | Oracle                 |
    ## | RJDBC       | JDBC                   |

    pptx_doc %>%
        read_document() %>%
        head(3)

    ## [1] "Hello World"  "Tyler Rinker" "Slide 1"

Read Directory Contents
-----------------------

Often there is a need to read multiple files in from a single directory.
The `read_dir` function wraps other **textreadr** functions and `lapply`
to create a data frame with a document and text column (one row per
document). We will read the following documents from the ‘pos’ directory
in **textreadr**’s system file:

    levelName
    pos          
      |--0_9.txt  
      |--1_7.txt  
      |--10_9.txt 
      |--11_9.txt 
      |--12_9.txt 
      |--13_7.txt 
      |--14_10.txt
      |--15_7.txt 
      |--16_7.txt 
      |--17_9.txt 
      |--18_7.txt 
      |--19_10.txt
      |--2_9.txt  
      |--3_10.txt 
      |--4_8.txt  
      |--5_10.txt 
      |--6_10.txt 
      |--7_7.txt  
      |--8_7.txt  
      \--9_7.txt

Here we have read the files in, one row per file.

    system.file("docs/Maas2011/pos", package = "textreadr") %>%
        read_dir() %>%
        peek(Inf, 40)

    ## Table: [20 x 2]
    ## 
    ##    document content                                 
    ## 1  0_9      Bromwell High is a cartoon comedy. It ra
    ## 2  1_7      If you like adult comedy cartoons, like 
    ## 3  10_9     I'm a male, not given to women's movies,
    ## 4  11_9     Liked Stanley & Iris very much. Acting w
    ## 5  12_9     Liked Stanley & Iris very much. Acting w
    ## 6  13_7     The production quality, cast, premise, a
    ## 7  14_10    This film has a special place in my hear
    ## 8  15_7     I guess if a film has magic, I don't nee
    ## 9  16_7     I found this to be a so-so romance/drama
    ## 10 17_9     This is a complex film that explores the
    ## 11 18_7     `Stanley and Iris' is a heart warming fi
    ## 12 19_10    I just read the comments of TomReynolds2
    ## 13 2_9      Bromwell High is nothing short of brilli
    ## 14 3_10     "All the world's a stage and its people 
    ## 15 4_8      FUTZ is the only show preserved from the
    ## 16 5_10     I came in in the middle of this film so 
    ## 17 6_10     Fair drama/love story movie that focuses
    ## 18 7_7      Although I didn't like Stanley & Iris tr
    ## 19 8_7      Very good drama although it appeared to 
    ## 20 9_7      Working-class romantic drama from direct
    ## .. ...      ...

Read .docx
----------

A .docx file is nothing but a fancy container. It can be parsed via XML.
The `read_docx` function allows the user to read in a .docx file as
plain text. Elements are essentially the p tags (explicitly `//w:t` tags
collapsed with `//w:p` tags) in the markup.

    docx_doc %>%
        read_docx() %>%
        head(3)

    ## [1] "JRMC2202 Audio  Project"      "Interview Transcript"         "Interviewer:  Yasmine Hassan"

    docx_doc %>%
        read_docx(15) %>%
        head(3)

    ## [1] "Hassan:             Could you please tell me your name, your title, your age, and your place  of ref ,                                      umm, residence?"
    ## [2] "Abd Rabou:     My name is Ahmad Abd Rabou. I’m assistant professor of comparative politics at"                                                              
    ## [3] "both Cairo University and The American University in Cairo. I’m 34 years old. I"

Read .doc
---------

A .doc file is a bit trickier to read in than .docx but is made easy by
the **antiword** package which wraps the
[Antiword](http://www.winfield.demon.nl) program in an OS independent
way.

    doc_doc %>%
        read_doc() %>%
        head()

    ## [1] "JRMC2202 Audio Project"      "Interview Transcript"        "Interviewer: Yasmine Hassan" "Narrator: Ahmad Abd Rabou"  
    ## [5] "Date: 16/10/2014"            "Place: Narrator's office"

    doc_doc %>%
        read_doc(15) %>%
        head(7)

    ## [1] "Hassan:           Could you please tell me your name, your title, your age,"
    ## [2] "and your place of ref,"                                                     
    ## [3] "umm, residence?"                                                            
    ## [4] "Abd Rabou:   My name is Ahmad Abd Rabou. I'm assistant professor of"        
    ## [5] "comparative politics at"                                                    
    ## [6] "both Cairo University and The American University"                          
    ## [7] "in Cairo. I'm 34 years old. I"

Read .rtf
---------

Rich text format (.rtf) is a plain text document with markup similar to
latex. The **striprtf** package provides the backend for `read_rtf`.

    rtf_doc %>%
        read_rtf() 

    ## [1] "Researcher 2:\tOctober 7, 1892."                                                                                                                                                                                                                                                                                                                              
    ## [2] "Teacher 4:\tStudents it’s time to learn."                                                                                                                                                                                                                                                                                                                     
    ## [3] "[Student discussion; unintelligible]"                                                                                                                                                                                                                                                                                                                        
    ## [4] "Multiple Students:\tYes teacher we‘re ready to learn."                                                                                                                                                                                                                                                                                                        
    ## [5] "Teacher 4:\tLet's read this terrific book together.  It's called Moo Baa La La La and – what was I going to …  Oh yes — The story is by Sandra Boynton."                                                                                                                                                                                                      
    ## [6] "“A cow says Moo. A Sheep says Baa. Three singing pigs say LA LA LA! \"No, no!\" you say, that isn't right. The pigs say oink all day and night. Rhinoceroses snort and snuff. And little dogs go ruff ruff ruff! Some other dogs go bow wow wow! And cats and kittens say Meow! Quack! Says the duck. A horse says neigh. It's quiet now. What do you say? ”"

Read .pdf
---------

Like .docx a .pdf file is simply a container. Reading PDF’s is made
easier with a number of command line tools. A few methods of PDF reading
have been incorporated into R. Here I wrap **pdftools** `pdf_text` to
produce `read_pdf`, a function with sensible defaults that is designed
to read PDFs into R for as many folks as possible right out of the box.

Here I read in a PDF with `read_pdf`. Notice the result is a data frame
with meta data, including page numbers and element (row) ids.

    pdf_doc %>%
        read_pdf() 

    ## Table: [616 x 3]
    ## 
    ##    page_id element_id text                                    
    ## 1  1       1          Interview with Mary Waters Spaulding, Au
    ## 2  1       2          CRAIG BREADEN: My name is Craig Breaden.
    ## 3  1       3          and I’m with Kirston Johnson, the curato
    ## 4  1       4          is August 8, 2013, and we are in Lexingt
    ## 5  1       5          life and family, and particularly about 
    ## 6  1       6          your full name, date of birth, and place
    ## 7  1       7          MARY WATERS SPAULDING: My name is Mary E
    ## 8  1       8          birth was Lexington, NC, on May 14, 1942
    ## 9  1       9          BREADEN: Can you describe what Lexington
    ## 10 1       10         1940’s?                                 
    ## .. ...     ...        ...

### Image Based pdf: OCR

Image based .pdfs require optical character recognition (OCR) in order
for the images to be converted to text. The `ocr` argument of `read_pdf`
allows the user to read in image based .pdf files and allow the
[**tesseract**](https://CRAN.R-project.org/package=tesseract) package do
the heavy lifting in the backend. You can look at the .pdf we’ll be
using by running:

    browse(pdf_doc_img)

First let’s try the task without using OCR.

    pdf_doc_img %>%
        read_pdf(ocr = FALSE)

    ## Table: [0 x 3]
    ## 
    ## [1] page_id    element_id text      
    ## <0 rows> (or 0-length row.names)
    ## ... ...        ...        ...

And now using OCR via **tesseract**. Note that `ocr = TRUE` is the
default behavior of `read_pdf`.

    pdf_doc_img %>%
        read_pdf(ocr = TRUE)

    ## Converting page 1 to C:\Users\AppData\Local\Temp\RtmpKeJAnL/McCune2002Choi2010_01.png... done!
    ## Converting page 2 to C:\Users\AppData\Local\Temp\RtmpKeJAnL/McCune2002Choi2010_02.png... done!

    ## Table: [104 x 3]
    ##
    ##    page_id element_id text                                           
    ## 1  1       1          A Survey of Binary Similarity and Distan       
    ## 2  1       2          Seung-Seok Choi, Sung-Hyuk Cha, Charles        
    ## 3  1       3          Department of Computer Science, Pace Uni       
    ## 4  1       4          New York, US                                   
    ## 5  1       5          ABSTRACT ecological 25 <U+FB01>sh species [2|].
    ## 6  1       6          conventional similarity measures to solv       
    ## 7  1       7          The binary feature vector is one of the        
    ## 8  1       8          representations of patterns and measurin       
    ## 9  1       9          distance measures play a critical role i       
    ## 10 1       10         such as clustering, classi<U+FB01>cation, etc. 
    ## .. ...     ...        ... 

Read .pptx
----------

Like the .docx, a .pptx file is also nothing but a fancy container.
Likewise, it can be parsed via XML. The `read_pptx` function allows the
user to read in a .pptx file as a data.frame with plain text that tracks
slide id numbers.

    pptx_doc %>%
        read_pptx()

    ##     slide_id element_id                      text
    ##  1:        1          1               Hello World
    ##  2:        1          2              Tyler Rinker
    ##  3:        2          1                   Slide 1
    ##  4:        2          2              Really nifty
    ##  5:        2          3             Kinda  shifty
    ##  6:        2          4           Not worth fifty
    ##  7:        3          1                 Wowzers !
    ##  8:        3          2 There’s a cat sniffing me
    ##  9:        3          3       I think he likes me
    ## 10:        3          4                      Ouch
    ## 11:        3          5                 He bit me
    ## 12:        3          6       I think he hates me
    ## 13:        4          1                 Two Lists
    ## 14:        4          2                       One
    ## 15:        4          3                       Two
    ## 16:        4          4                     Three
    ## 17:        4          5                      Blue
    ## 18:        4          6                     Green
    ## 19:        4          7                    Orange

Read .html
----------

Often a researcher only wishes to grab the text from the body of .html
files. The `read_html` function does exactly this task. For finer
control over .html scraping the user may investigate the **xml2** &
**rvest** packages for parsing .html and .xml files. Here I read in HTML
with `read_html`.

    html_doc %>%
        read_html() 

    ##  [1] "textreadr Creed"                                                                                                                                                                                                                                                                                                                                             
    ##  [2] "The textreadr package aims to be a lightweight tool kit that handles 80% of an analyst’s text reading in needs."                                                                                                                                                                                                                                             
    ##  [3] "The package handles .docx, .doc, .pdf, .html, and .txt."                                                                                                                                                                                                                                                                                                     
    ##  [4] "If you have another format there is likely already another popular R package that specializes in this read in task. For example, got XML, use the xml2 package, authored by Hadley Wickham, Jim Hester, & Jeroen Ooms. Need special handling for .html? Use Hadley Wickham’s rvest package. Got SQL? Oh boy there’s a bunch of great ways to read it into R."
    ##  [5] "R Package"                                                                                                                                                                                                                                                                                                                                                   
    ##  [6] "SQL"                                                                                                                                                                                                                                                                                                                                                         
    ##  [7] "ROBDC"                                                                                                                                                                                                                                                                                                                                                       
    ##  [8] "Microsoft SQL Server"                                                                                                                                                                                                                                                                                                                                        
    ##  [9] "RMySQL"                                                                                                                                                                                                                                                                                                                                                      
    ## [10] "MySQL"                                                                                                                                                                                                                                                                                                                                                       
    ## [11] "ROracle"                                                                                                                                                                                                                                                                                                                                                     
    ## [12] "Oracle"                                                                                                                                                                                                                                                                                                                                                      
    ## [13] "RJDBC"                                                                                                                                                                                                                                                                                                                                                       
    ## [14] "JDBC"

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

    ## [1] "trans1.docx" "trans2.docx" "trans3.docx" "trans4.xlsx" "trans5.xls"  "trans6.doc"  "trans7.rtf"  "transcripts"

### docx Simple

    read_transcript(trans_docs[1])

    ## Table: [5 x 2]
    ## 
    ##   Person            Dialogue                                
    ## 1 Researcher 2      October 7, 1892.                        
    ## 2 Teacher 4         Students it's time to learn. [Student di
    ## 3 Multiple Students Yes teacher we're ready to learn.       
    ## 4 [Cross Talk 3     00]                                     
    ## 5 Teacher 4         Let's read this terrific book together. 
    ## . ...               ...

### docx With Skip

`skip` is important to capture the document structure. Here not skipping
front end document matter throws an error, while `skip = 1` correctly
parses the file.

    read_transcript(trans_docs[2])

    ## Error in data.frame(X1 = trimws(speaker), X2 = trimws(pvalues), stringsAsFactors = FALSE): arguments imply differing number of rows: 7, 8

    read_transcript(trans_docs[2], skip = 1)

    ## Table: [5 x 2]
    ## 
    ##   Person            Dialogue                                
    ## 1 Researcher 2      October 7, 1892.                        
    ## 2 Teacher 4         Students it's time to learn. [Student di
    ## 3 Multiple Students Yes teacher we're ready to learn.       
    ## 4 [Cross Talk 3     00]                                     
    ## 5 Teacher 4         Let's read this terrific book together. 
    ## . ...               ...

### docx With Dash Separator

The colon is the default separator. At times other separators may be
used to separate speaker and text. Here is an example where hypens are
used as a separator. Notice the poor parse with colon set as the default
separator the first go round.

    read_transcript(trans_docs[3], skip = 1)

    ## Table: [1 x 2]
    ## 
    ##   Person        Dialogue                                
    ## 1 [Cross Talk 3 Teacher 4-Students it's time to learn. [
    ## . ...           ...

    read_transcript(trans_docs[3], sep = "-", skip = 1)

    ## Table: [3 x 2]
    ## 
    ##   Person            Dialogue                                
    ## 1 Teacher 4         Students it's time to learn. [Student di
    ## 2 Multiple Students Yes teacher we're ready to learn. [Cross
    ## 3 Teacher 4         Let's read this terrific book together. 
    ## . ...               ...

### xls and xlsx

    read_transcript(trans_docs[4])

    ## New names:
    ## * `` -> ...1
    ## * `` -> ...2

    ## Table: [7 x 2]
    ## 
    ##   Person             Dialogue                                
    ## 1 Researcher 2:      October 7, 1892.                        
    ## 2 <NA>               NA                                      
    ## 3 Teacher 4:         Students it's time to learn.            
    ## 4 <NA>               NA NA NA                                
    ## 5 Multiple Students: Yes teacher we're ready to learn.       
    ## 6 <NA>               NA NA NA                                
    ## 7 Teacher 4:         Let's read this terrific book together. 
    ## . ...                ...

    read_transcript(trans_docs[5])

    ## New names:
    ## * `` -> ...1
    ## * `` -> ...2

    ## Table: [7 x 2]
    ## 
    ##   Person             Dialogue                                
    ## 1 Researcher 2:      October 7, 1892.                        
    ## 2 <NA>               NA                                      
    ## 3 Teacher 4:         Students it's time to learn.            
    ## 4 <NA>               NA NA NA                                
    ## 5 Multiple Students: Yes teacher we're ready to learn.       
    ## 6 <NA>               NA NA NA                                
    ## 7 Teacher 4:         Let's read this terrific book together. 
    ## . ...                ...

### doc

    read_transcript(trans_docs[6], skip = 1)

    ## Table: [3 x 2]
    ## 
    ##   Person            Dialogue                                
    ## 1 Teacher 4         Students it's time to learn. [Student di
    ## 2 Multiple Students Yes teacher we're ready to learn.       
    ## 3 Teacher 4         Let's read this terrific book together. 
    ## . ...               ...

### rtf

    read_transcript(rtf_doc, skip = 1)

    ## Table: [4 x 2]
    ## 
    ##   Person            Dialogue                                
    ## 1 Researcher 2      October 7, 1892.                        
    ## 2 Teacher 4         Students it's time to learn. [Student di
    ## 3 Multiple Students Yes teacher we're ready to learn.       
    ## 4 Teacher 4         Let's read this terrific book together. 
    ## . ...               ...

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

    ## Table: [6 x 2]
    ## 
    ##   NO ARTICLE                                 
    ## 1 34 The New York Times reports a lot of word
    ## 2 12 Greenwire reports a lot of words.       
    ## 3 31 Only three words.                       
    ## 4 2  The Financial Times reports a lot of wor
    ## 5 9  Greenwire short.                        
    ## 6 13 The New York Times reports a lot of word
    ## . .. ...

### Authentic Interview

Here I read in an authentic interview transcript:

    docx_doc %>%
        read_transcript(c("Person", "Dialogue"), skip = 19)

    ## Table: [13 x 2]
    ## 
    ##    Person    Dialogue                                
    ## 1  Hassan    Professor Abd Rabou, being a current pro
    ## 2  Abd Rabou Sure. First of all, let's look at the so
    ## 3  Hassan    So from this point of the differences of
    ## 4  Abd Rabou No. I don't--It depends --Like my--This 
    ## 5  Hassan    So, as political science students, does 
    ## 6  Abd Rabou Less, not mature, they are politically m
    ## 7  Hassan    Since you are an active politician and w
    ## 8  Abd Rabou It does somehow. What I do is--First of 
    ## 9  Hassan    But you are characterized with, somehow 
    ## 10 Abd Rabou So far I didn't get--So far--Maybe it do
    ## .. ...       ...

Pairing textreadr
-----------------

**textreadr** is but one package used in the text analysis (often the
first package used). It pairs nicely with a variety of other text
munging and analysis packages. In the example below I show just a few
other package pairings that are used to extract case names (e.g., “Jones
v. State of New York”) from a [Supreme Court Database Code
Book](http://scdb.wustl.edu/_brickFiles/2012_01/SCDB_2012_01_codebook.pdf).
I demonstrate pairings with
[**textshape**](https://github.com/trinker/textshape),
[**textclean**](https://github.com/trinker/textclean),
[**qdapRegex**](https://github.com/trinker/qdapRegex), and
[**dplyr**](https://github.com/hadley/dplyr).

    if (!require("pacman")) install.packages("pacman"); library(pacman)
    p_load(dplyr, qdapRegex)
    p_load_current_gh(file.path('trinker', c('textreadr', 'textshape', 'textclean')))

    ## 
    ##          checking for file 'C:\Users\trinker\AppData\Local\Temp\RtmpsRIhsW\remotes1bec16a84326\trinker-textreadr-b006057/DESCRIPTION' ...  v  checking for file 'C:\Users\trinker\AppData\Local\Temp\RtmpsRIhsW\remotes1bec16a84326\trinker-textreadr-b006057/DESCRIPTION'
    ##       -  preparing 'textreadr': (416ms)
    ##    checking DESCRIPTION meta-information ...  v  checking DESCRIPTION meta-information
    ##       -  checking for LF line-endings in source and make files and shell scripts
    ##       -  checking for empty or unneeded directories
    ##       -  looking to see if a 'data/datalist' file should be added
    ##       -  building 'textreadr_0.9.4.tar.gz'
    ##      
    ## 

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
    ## [1] " Townsend v. Sain"        " Simpson v. Florida"      "McNally v. United States" "United States v. Gray"   
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
    ##  [1] " United States v. Knox"                                            "Lassiter v. Department of Social Services"                        
    ##  [3] "Arkansas v. Tennessee"                                             "Utah v. United States"                                            
    ##  [5] "Johnson v. United States"                                          "Baldonado v. California"                                          
    ##  [7] "Conway v. California Adult Authority"                              "Wheaton v. California"                                            
    ##  [9] "Maxwell v. Bishop"                                                 "National Labor Relations Board v. United Insurance Co. of America"
    ## [11] "United States v. King"                                             "National Labor Relations Board v. United Insurance Co. of America"
    ## [13] "United States v. King"                                            
    ## 
    ## $`44`
    ## [1] "Grisham v. Hagan"                   "McElroy v. Guagliardo"              "Virginia Supreme Court v. Friedman"
    ## 
    ## $`48`
    ## [1] "Baker v. Carr"                     "Gray v. Sanders"                   " Patterson v. McLean Credit Union"
    ## 
    ## $`53`
    ## [1] "Bates v. Arizona State Bar"
    ## 
    ## $`57`
    ## [1] "New York Gaslight Club, Inc. v. Carey" "Pruneyard Shopping Center v. Robins"  
    ## 
    ## $`58`
    ## [1] "Mobile v. Bolden"                             "Williams v. Brown"                            "United States v. Havens"                     
    ## [4] "Parratt v. Taylor"                            "Dougherty County Board of Education v. White" "Jenkins v. Anderson"