textreadr
============

![](tools/textreadr_logo/r_textreadr.png)

[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Build
Status](https://travis-ci.org/trinker/textreadr.svg?branch=master)](https://travis-ci.org/trinker/textreadr)
[![Coverage
Status](https://coveralls.io/repos/trinker/textreadr/badge.svg?branch=master)](https://coveralls.io/github/trinker/textreadr)
[![](http://cranlogs.r-pkg.org/badges/textreadr)](https://cran.r-project.org/package=textreadr)


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
    -   [Basic Readers](#basic-readers)
        -   [Read .doc](#read-.doc)
        -   [Read .docx](#read-.docx)
        -   [Read .html](#read-.html)
        -   [Read .odt](#read-.odt)
        -   [Read .pdf](#read-.pdf)
        -   [Read .pptx](#read-.pptx)
        -   [Read .rtf](#read-.rtf)
    -   [Read Transcripts](#read-transcripts)
        -   [doc](#doc)
        -   [docx Simple](#docx-simple)
        -   [docx With Skip](#docx-with-skip)
        -   [docx With Dash Separator](#docx-with-dash-separator)
        -   [odt](#odt)
        -   [rtf](#rtf)
        -   [xls and xlsx](#xls-and-xlsx)
        -   [Reading Text](#reading-text)
        -   [Authentic Interview](#authentic-interview)
    -   [Pairing textreadr](#pairing-textreadr)
-   [Other Implementations](#other-implementations)


**textreadr** is a small collection of convenience tools for reading
text documents into R. This is not meant to be an exhaustive collection;
for more see the [**tm**](https://CRAN.R-project.org/package=tm)
package.


# Functions

Most jobs in my workflow can be completed with `read_document` and
`read_dir`. The former generically reads in a .docx, .doc, .pdf, .html,
.pptx, or .txt file without specifying the extension. The latter reads
in multiple .docx, .doc, .html, .odt .pdf, .pptx, .rtf, or .txt files
from a directory as a `data.frame` with a file and text column. This
workflow is effective because most text documents I encounter are stored
as a .docx, .doc, .html, .odt .pdf, .pptx, .rtf, or .txt file. The
remaining common storage formats I encounter include .csv, .xlsx, XML,
structured .html, and SQL. For these first 4 forms the
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
<td><code>read_odt</code></td>
<td>reading</td>
<td>Read .odt</td>
</tr>
<tr class="odd">
<td><code>read_dir</code></td>
<td>reading</td>
<td>Read and format multiple .doc, .docx, .rtf, .txt, .pdf, .pptx, .odt files</td>
</tr>
<tr class="even">
<td><code>read_dir_transcript</code></td>
<td>reading</td>
<td>Read and format multiple transcript files</td>
</tr>
<tr class="odd">
<td><code>download</code></td>
<td>downloading</td>
<td>Download documents</td>
</tr>
<tr class="even">
<td><code>peek</code></td>
<td>viewing</td>
<td>Truncated viewing of <code>data.frame</code>s</td>
</tr>
</tbody>
</table>

# Installation

To download the development version of **textreadr**:

Download the [zip
ball](https://github.com/trinker/textreadr/zipball/master) or [tar
ball](https://github.com/trinker/textreadr/tarball/master), decompress
and run `R CMD INSTALL` on it, or use the **pacman** package to install
the development version:

    if (!require("pacman")) install.packages("pacman")
    pacman::p_load_gh("trinker/textreadr")

# Contact

You are welcome to:

-   submit suggestions and bug-reports at:
    <https://github.com/trinker/textreadr/issues>  
-   send a pull request on: <https://github.com/trinker/textreadr/>  
-   compose a friendly e-mail to: <tyler.rinker@gmail.com>

# Demonstration

## Load the Packages/Data

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
    odt_doc <- system.file('docs/Hello_World.odt', package = "textreadr") 
      
    rtf_doc <- download(
        'https://raw.githubusercontent.com/trinker/textreadr/master/inst/docs/trans7.rtf'
    )

    pdf_doc_img <- system.file("docs/McCune2002Choi2010.pdf", package = "textreadr")

## Download & Browse

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

    ## pres.deb1.docx read into C:\Users\TYLERR~1\AppData\Local\Temp\RtmpMHmz2b

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

## Generic Document Reading

The `read_document` is a generic wrapper for `read_docx`, `read_doc`,
`read_html`, `read_odt`, `read_pdf`, `read_rtf`, and `read_pptx` that
detects the file extension and chooses the correct reader. For most
tasks that require reading a .docx, .doc, .html, .odt, .pdf, .pptx, .rtf
or .txt file this is the go-to function to get the job done. Below I
demonstrate reading each of these five file formats with
`read_document`.

    doc_doc %>%
        read_document() %>%
        head(3)

    ## [1] "JRMC2202 Audio Project"      "Interview Transcript"       
    ## [3] "Interviewer: Yasmine Hassan"

    docx_doc %>%
        read_document() %>%
        head(3)

    ## [1] "JRMC2202 Audio Project"      "Interview Transcript"       
    ## [3] "Interviewer: Yasmine Hassan"

    html_doc %>%
        read_document() %>%
        head(3)

    ## [1] "textreadr Creed"                                                                                                
    ## [2] "The textreadr package aims to be a lightweight tool kit that handles 80% of an analyst’s text reading in needs."
    ## [3] "The package handles .docx, .doc, .pdf, .html, .pptx, and .txt."

    odt_doc %>%
        read_document() %>%
        head(3)

    ## [1] "Hello World"                     "I am Open Document Text Format!"

    pdf_doc %>%
        read_document() %>%
        head(3)

    ## [1] "Interview with Mary Waters Spaulding, August 8, 2013\n\nCRAIG BREADEN: My name is Craig Breaden. I’m the audiovisual archivist at Duke University,\nand I’m with Kirston Johnson, the curator of the Archive of Documentary Arts at Duke. The date\nis August 8, 2013, and we are in Lexington, NC, talking with Mary Waters Spaulding about her\nlife and family, and particularly about her father, H. Lee Waters. For the recording, please state\nyour full name, date of birth, and place of birth.\n\nMARY WATERS SPAULDING: My name is Mary Elizabeth Waters Spaulding, and my place of\nbirth was Lexington, NC, on May 14, 1942.\n\nBREADEN: Can you describe what Lexington was like when you were growing up in the\n1940’s?\n\nSPAULDING: I remember it as a small town, but a thriving small town. Probably the reason it\nwas thriving was because of all the furniture factories in town, and that employed a lot of people\nand kept the town going. Of course, they’re no longer here, but at that time, it was thriving with\nthose. It was a very friendly town. My brother and I felt like we actually pretty much knew\neverybody in town, and a lot of that has to do with the fact that we saw so many photographs\nfrom our father, and we went with him on location to take photographs, and we got to meet a lot\nof people. It was just a very friendly town, and people were very kind, very thoughtful, and were\nalways very cordial with our father, H. Lee. One thing is, I don’t think any of us ever felt unsafe\nin this town; it was a very safe town to be in. We never felt threatened by anything. It was a very\nhappy childhood living in Lexington.\n\nBREADEN: Tell us about the rest of your family.\n\nSPAULDING: My older brother is eight years older than I am. His name is Tom Waters. We had\nan older sister, who would have been thirteen years older than I. My brother is 8 years older\nthan I. She was their firstborn, and she had an illness, she was epileptic at a very young age.\nShe probably started having seizures at --\n\nTOM WATERS: About six months.\n\nSPAULDING: -- about six months old, and they progressively got worse. At that time in the ‘30s,\nthey didn’t have the medication to help with that. Probably just the phenobarb was all she was\ngiven. Her seizures became more severe as she grew. She got to be a larger person, and very\ndifficult to handle this, my parents had difficulty with that. The seizures got so severe that they\njust could not manage it, so they took her to a state institution in Raleigh, the state hospital, and\nthat’s where she stayed until she died. We were allowed to visit her, like only once a month,\nbecause they wanted that to be her home, and they didn’t want her to want to go back home\nwith us. So, if our visits were more frequent, she would get more used to our being there and\nmiss us more, I guess. She contracted tuberculosis while she was there, and died at the age of\ntwenty-four. I can’t remember how old she was when she went there. I would say she was a"
    ## [2] "teenager, like fourteen or fifteen, so she was there that long. I think it was ‘53 when she died\nthere. I don’t remember, but she was twenty-four when she died. Our mother, who played a\nlarge part in our family, she was H. Lee’s, our father’s, partner in many ways. They worked\ntogether, she worked at the studio. She helped him with the photographs. She helped him with\nthe sittings. She would help pose the brides in their dresses and their veils, and fix their hair,\nand help them get their makeup just right. She would also retouch the films by hand. She would\nalso color-tint photographs to make them look like color, with oil. And later in years, she learned\nhow to do the heavy oil application to the large portraits, that actually looked more like paintings\nthan they did photographs. They were quite a team.\n\nKIRSTON JOHNSON: What was your mother’s name?\n\nSPAULDING: Mabel Elizabeth Jarrell was her maiden name, and of course, Waters. I have my\nElizabeth is from my mom. Mary Elizabeth is from Mabel Elizabeth.\n\nBREADEN: How did they come to meet?\n\nSPAULDING: That’s an interesting story, rather comical. She was actually trained to be a nurse,\nand she was doing some training there in Lexington hospital. Our father’s mother, Gertrude\nWaters, was in the hospital for pneumonia, and they were in the same room, and I guess it was\na warm summer day, and they had a fan in the room, and the fan needed to be plugged in. Well,\nboth of them got under the bed at one time to plug this fan in, and that’s where they met. And\nthe rest is history. (laughter) I think that’s a cute story.\n\nJOHNSON: Were they both from Lexington?\n\nSPAULDING: No. Where was she from? He was from South Carolina, wasn’t he?\n\nWATERS: South Carolina.\n\nSPAULDING: He was from Greer, Gaffney, that area. And he moved to Erlanger with his mom\nand dad in the thriving Erlanger Mill days. She grew up in the orphanage in Thomasville,\nbecause her parents died like a year apart while she was still small. She had older brothers and\nsisters who didn’t have to, I think there were only three that actually went to the orphanage. So\nthat’s -- (Waters interrupts) Excuse me?\n\nWATERS: Mills Home.\n\nSPAULDING: Mills Home, okay. That’s in Thomasville. She graduated from high school there,\nand then she went into nurse’s training. Where they came from was... Wilmington area?\n\nWATERS: Wilmington area.\n\nSPAULDING: Wilmington area. That’s where her family was from. And that’s really pretty much"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
    ## [3] "all I know about the background. I’m working on that.\n\nBREADEN: Between them meeting and H. Lee Waters getting interested in photography and\nsetting up his studio in Lexington, how did that come together?\n\nSPAULDING: Actually our dad was an assistant or like an apprentice to another photographer\nwho was in the same building at... 118 ½?\n\nWATERS: 118 ½.\n\nSPAULDING: 118 ½ Main Street.\n\nWATERS: The whole top floor.\n\nSPAULDING: The whole top floor of that building on the corner of Second Avenue and Main\nStreet. I can’t remember the gentleman’s first name.\n\nWATERS: Hitchcock.\n\nSPAULDING: Hitchcock was the last name. Mr. Hitchcock was a photographer, and he kind of\ntook our dad under his wing and offered him an assistantship or apprenticeship, and he loved it\nso much that he wanted to be a photographer on his own. So, when Mr. Hitchcock retired, which\nwas shortly after that --\n\nWATERS: About a year.\n\nSPAULDING: -- about a year after that, my father’s mother helped him buy the studio, so that\nthe two of them financially went together and bought the studio.\n\nWATERS: Financial documents of that transaction are down here in the archives (indiscernible).\n\nSPAULDING: All the equipment, and -- now, of course that top floor they rented, they didn’t own\nthe building, but he bought the photography business from him.\n\nJOHNSON: So all the equipment, everything…\n\nSPAULDING: Everything, all the cameras and everything, darkroom, chemicals, so it was\nalready pretty much set up, and then it grew from there.\n\nBREADEN: Did you ever work with your father in his studio?\n\nSPAULDING: Yes, I did. I can’t say I spent numerous hours there as a small child, but I\nremember going up and just enjoying being in the atmosphere of the photographs and all the\nhustle bustle of taking the sittings, down to developing the negatives, to printing, drying the"

    pptx_doc %>%
        read_document() %>%
        head(3)

    ## [1] "Hello World"  "Tyler Rinker" "Slide 1"

    rtf_doc %>%
        read_document() %>%
        head(3)

    ## [1] "Researcher 2:\tOctober 7, 1892."          
    ## [2] "Teacher 4:\tStudents it’s time to learn." 
    ## [3] "[Student discussion; unintelligible]"

    txt_doc %>%
        read_document() %>%
        paste(collapse = "\n") %>%
        cat()

    ## The textreadr package aims to be a lightweight
    ## tool kit that handles 80% of an analyst's text
    ## reading in needs.
    ## The package handles .docx, .doc, .pdf, .html, .pptx, and .txt.
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

## Read Directory Contents

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

## Basic Readers

### Read .doc

A .doc file is a bit trickier to read in than .docx but is made easy by
the **antiword** package which wraps the
[Antiword](http://www.winfield.demon.nl) program in an OS independent
way.

    doc_doc %>%
        read_doc() %>%
        head()

    ## [1] "JRMC2202 Audio Project"      "Interview Transcript"       
    ## [3] "Interviewer: Yasmine Hassan" "Narrator: Ahmad Abd Rabou"  
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

### Read .docx

A .docx file is nothing but a fancy container. It can be parsed via XML.
The `read_docx` function allows the user to read in a .docx file as
plain text. Elements are essentially the p tags (explicitly `//w:t` tags
collapsed with `//w:p` tags) in the markup.

    docx_doc %>%
        read_docx() %>%
        head(3)

    ## [1] "JRMC2202 Audio Project"      "Interview Transcript"       
    ## [3] "Interviewer: Yasmine Hassan"

    docx_doc %>%
        read_docx(15) %>%
        head(3)

    ## [1] "Hassan:           Could you please tell me your name, your title, your age, and your place of ref,                                   umm, residence?"
    ## [2] "Abd Rabou:   My name is Ahmad Abd Rabou. I’m assistant professor of comparative politics at"                                                         
    ## [3] "both Cairo University and The American University in Cairo. I’m 34 years old. I"

### Read .html

Often a researcher only wishes to grab the text from the body of .html
files. The `read_html` function does exactly this task. For finer
control over .html scraping the user may investigate the **xml2** &
**rvest** packages for parsing .html and .xml files. Here I read in HTML
with `read_html`.

    html_doc %>%
        read_html() 

    ##  [1] "textreadr Creed"                                                                                                                                                                                                                                                                                                                                             
    ##  [2] "The textreadr package aims to be a lightweight tool kit that handles 80% of an analyst’s text reading in needs."                                                                                                                                                                                                                                             
    ##  [3] "The package handles .docx, .doc, .pdf, .html, .pptx, and .txt."                                                                                                                                                                                                                                                                                              
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

### Read .odt

Open Document Texts (.odt) are rather similar to .docx files in how they
behave. The `read_odt` function reads them in in a similar way.

    odt_doc %>%
        read_odt() 

    ## [1] "Hello World"                     "I am Open Document Text Format!"

### Read .pdf

Like .docx a .pdf file is simply a container. Reading PDF’s is made
easier with a number of command line tools. A few methods of PDF reading
have been incorporated into R. Here I wrap **pdftools** `pdf_text` to
produce `read_pdf`, a function with sensible defaults that is designed
to read PDFs into R for as many folks as possible right out of the box.

Here I read in a PDF with `read_pdf`. Notice the result is a data frame
with meta data, including page numbers and element (row) ids.

    pdf_doc %>%
        read_pdf() 

    ## Table: [19 x 3]
    ## 
    ##    page_id element_id text                                      
    ## 1  1       1          Interview with Mary Waters Spaulding, Au  
    ## 2  2       1          teenager, like fourteen or fifteen, so s  
    ## 3  3       1          all I know about the background. I’m wor  
    ## 4  4       1          photographs, proofing. And when I got to  
    ## 5  5       1          the people --\n\nSPAULDING: He was just a 
    ## 6  6       1          JOHNSON: No, the initial idea to even ma  
    ## 7  7       1          WATERS: Sometimes on the steps of the co  
    ## 8  8       1          the white communities. Did he ever share  
    ## 9  9       1          have on stage a professional photographe  
    ## 10 10      1          times with him to do that. And he would   
    ## .. ...     ...        ...

#### Image Based .pdf: OCR

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

### Read .pptx

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

### Read .rtf

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

## Read Transcripts

Many researchers store their dialogue data (including interviews and
observations) as a .docx or .xlsx file. Typically the data is a two
column format with the person in the first column and the text in the
second separated by some sort of separator (often a colon). The
`read_transcript` wraps up many of these assumptions into a reader that
will extract the data as a data frame with a person and text column. The
`skip` argument is very important for correct parsing.

Here I read in and parse the different formats `read_transcript`
handles. These are the files that will be read in:

    base_name(trans_docs)

    ## [1] "trans1.docx" "trans2.docx" "trans3.docx" "trans4.xlsx" "trans5.xls" 
    ## [6] "trans6.doc"  "trans7.rtf"  "trans8.odt"  "transcripts"

### doc

    read_transcript(trans_docs[6], skip = 1)

    ## Table: [3 x 2]
    ## 
    ##   Person            Dialogue                                
    ## 1 Teacher 4         Students it's time to learn. [Student di
    ## 2 Multiple Students Yes teacher we're ready to learn.       
    ## 3 Teacher 4         Let's read this terrific book together. 
    ## . ...               ...

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

### odt

    read_transcript(trans_docs[8])

    ## Table: [4 x 2]
    ## 
    ##   Person            Dialogue                                
    ## 1 Researcher 2      October 7,1892.                         
    ## 2 Teacher4          Students it's time to learn. [Student di
    ## 3 Multiple Students Yes teacher we're ready to learn.       
    ## 4 Teacher4          Let's read this terrific book together. 
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

## Pairing textreadr

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
[**dplyr**](https://github.com/tidyverse/dplyr).

    library(dplyr)
    library(qdapRegex)
    library(textreadr)
    library(textshape)
    library(textclean)

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

    ## $`25`
    ## [1] " Townsend v. Sain"        " Simpson v. Florida"     
    ## [3] "McNally v. United States" "United States v. Gray"   
    ## 
    ## $`31`
    ## [1] "Edward V. Heck"
    ## 
    ## $`36`
    ## [1] "State of Colorado v. Western Alfalfa Corporation"
    ## 
    ## $`38`
    ## [1] "Pulliam v. Allen"   "Burnett v. Grattan"
    ## 
    ## $`40`
    ##  [1] " United States v. Knox"                                           
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
    ## 
    ## $`41`
    ## [1] "National Labor Relations Board v. United Insurance Co. of America"
    ## [2] "United States v. King"                                            
    ## 
    ## $`45`
    ## [1] "Grisham v. Hagan"                   "McElroy v. Guagliardo"             
    ## [3] "Virginia Supreme Court v. Friedman"
    ## 
    ## $`49`
    ## [1] "Baker v. Carr"                     "Gray v. Sanders"                  
    ## [3] " Patterson v. McLean Credit Union"
    ## 
    ## $`54`
    ## [1] "Bates v. Arizona State Bar"
    ## 
    ## $`58`
    ## [1] "New York Gaslight Club, Inc. v. Carey"
    ## [2] "Pruneyard Shopping Center v. Robins"  
    ## 
    ## $`59`
    ## [1] "Mobile v. Bolden"                            
    ## [2] "Williams v. Brown"                           
    ## [3] "United States v. Havens"                     
    ## [4] "Parratt v. Taylor"                           
    ## [5] "Dougherty County Board of Education v. White"
    ## [6] "Jenkins v. Anderson"

# Other Implementations

Some other implementations of text readers in R:

1.  [tm](https://CRAN.R-project.org/package=tm)
2.  [readtext](https://CRAN.R-project.org/package=readtext)

