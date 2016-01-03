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

-   [Function Usage](#function-usage)
-   [Installation](#installation)
-   [Contact](#contact)
-   [Demonstration](#demonstration)
    -   [Load the Packages/Data](#load-the-packagesdata)
    -   [Read Transcripts](#read-transcripts)
    -   [Read .docx](#read-.docx)
    -   [Read .pdf](#read-.pdf)
    -   [Read Directory Contents](#read-directory-contents)
    -   [Download](#download)

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

You are welcome to:   - submit suggestions and bug-reports at: <https://github.com/trinker/textreadr/issues>   - send a pull request on: <https://github.com/trinker/textreadr/>  

- compose a friendly e-mail to: <tyler.rinker@gmail.com>

Demonstration
=============

Load the Packages/Data
----------------------

    if (!require("pacman")) install.packages("pacman")
    pacman::p_load(textreadr, magrittr)
    pacman::p_load_gh("trinker/pathr")

Read Transcripts
----------------

Read .docx
----------

Read .pdf
---------

Read Directory Contents
-----------------------

Download
--------