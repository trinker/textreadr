NEWS
====

Versioning
----------

Releases will be numbered with the following semantic versioning format:

&lt;major&gt;.&lt;minor&gt;.&lt;patch&gt;

And constructed with the following guidelines:

* Breaking backward compatibility bumps the major (and resets the minor
  and patch)
* New additions without breaking backward compatibility bumps the minor
  (and resets the patch)
* Bug fixes and misc changes bumps the patch



textreadr 0.4.0 -
----------------------------------------------------------------

**BUG FIXES**

* The README.md called for `ex_` functions from **qdapRegex**.  This was the dev
  version of **qdapRegex**.  This is now the CRAN version and now works for users.

* `check_antiword_installed` failed for Linux and Mac users.  It now works on
  Windows, Linux, and Mac.  Thanks to José de Jesus Filho for catching this and
  working through the process on Linux (see <a href="https://github.com/trinker/textreadr/issues/5">issue #5</a>).

**NEW FEATURES**

**MINOR FEATURES**

**IMPROVEMENTS**

**CHANGES**

* The logo has been moved to tools to conform to CRAN standards.



textreadr 0.3.1
----------------------------------------------------------------

**NEW FEATURES**

* `read_dir_transcript` added to complement `read-dir` aimed at a directory of
  transcripts.



textreadr 0.0.1 - 0.3.0
----------------------------------------------------------------

This package is a  collection of convenience tools for reading text documents
into R.