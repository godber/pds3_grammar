# ANTLR4 PDSv3 Grammar

This is an ANTLR v4 grammar for the NASA PDSv3 ODL v2.1 label.

This grammar is defined in
[Chapter 12](https://pds.jpl.nasa.gov/documents/sr/Chapter12.pdf) of the
[PDS Standards Reference](https://pds.jpl.nasa.gov/tools/standards-reference.shtml).

It is BDS licensed, see the following LICENSE file for details:
https://github.com/godber/pds3_grammar/blob/master/LICENSE

Visit the Github repo:
https://github.com/godber/pds3_grammar

## Known Bugs

* Strings are not properly parsed by this grammar.  They will still
  contain any spacing and line feed characters from the original label.
  See: https://github.com/godber/pds3_grammar/issues/2

## Dependencies

The supporting scripts assume you have ANTLR 4.4 installed at the
following location:

`/usr/local/lib/antlr-4.4-complete.jar`

You must also have `make` installed and `java`.  I am using the JDK that
comes with Ubuntu 14.04:

```
java version "1.7.0_65"
OpenJDK Runtime Environment (IcedTea 2.5.3) (7u71-2.5.3-0ubuntu0.14.04.1)
OpenJDK 64-Bit Server VM (build 24.65-b04, mixed mode)
```

## Building

To build both the python and java parsers do the following:

```
cd antlr_grammar
make
```

You will find a `build-java` and `build-python` directory containing the
ANTLR generated output.  See the `Makefile` for details.

## Testing

This project includes a simple `test.sh` script that will loop over all
`*.lbl` files in the `data/` directory, excluding files with `invalid`
in the name.  It will run the TestRig diagnostics function.  If there
are no lexing or parsing errors, this will generate no output.  Only
errors will generate output.  See more in the **Developing** section.

**Note** that this is just a simple 'smoke test', it only indicates whether
or not the sample inputs lex and parse cleanly.  It does not guarantee
that the parse trees or tokens are what they should be.  More rigorous
testing could use the `tokenrun` and `treerun` functions.  I will
probably be doing my testing at a higher level, at the python parser
level, where better testing tools are available.

## Releasing

At this point, I consider the generated Python code to be the release
product.  However, these are not stored in the repo since they are
entirely generated products.

```
# Finish work and commit changes
# Update VERSION.txt
# Generates python code and makes the release tarball
make release
# Tag repo with version
git tag `cat VERSION.txt`
# Push repo and tags
git push --tags
# Manually upload tarball to github.
```

## Developing

The general development workflow is

* Setup with `cd antlr_grammar/; source sourceme.sh`
* modify and save `ODLv21.g4`
* run `make`
* examine sample input of input: `guirun data/dates.lbl
* run the test script: `./test.sh`

added a few things to make development easier.  First off, one
should source the `sourceme.sh` file.  It will define the following
helper functions and aliases:

* `grun` - Runs the ANTLR TestRig
* TestRig commands
  * `diagrun` - Shows diagnostic output from lexer and parser if any
  * `guirun` - Shows GUI parse tree browser
  * `psrun` - Generates a PS of the parsetree
  * `tokenrun` - Shows tokens detected by lexer
  * `treerun` - Prints text tree output of parse tree
  * `tracerun` - Shows trace information when parsing input file

All of the TestRig commands above are run by specifying a sample data
file, usually from within the `data/` directory.  Of course they assume
you have already run the `make` file and have a `build-java` directory.

Running the following:

```
guirun data/dates.lbl
```

will yield:

![Dates Parse Tree](/antlr_grammar/dates_gui.png?raw=true)
