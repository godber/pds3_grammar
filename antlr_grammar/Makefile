antlr4 := java -jar /usr/local/lib/antlr-4.4-complete.jar

PYTARGETS = build-python/ODLv21Lexer.py build-python/ODLv21Lexer.tokens \
	build-python/ODLv21Listener.py build-python/ODLv21Parser.py \
	build-python/ODLv21.tokens

# Release version used by release targets
VERSION = $(strip $(shell cat VERSION.txt))
PYVERSIONDIR = pds3_python-$(VERSION)
PYBUILDDIR = build/$(PYVERSIONDIR)

all: clean $(PYTARGETS) build-java/ODLv21Lexer.java
	javac build-java/*.java

$(PYTARGETS): ODLv21.g4
	$(antlr4) ODLv21.g4 -o build-python -visitor -Dlanguage=Python2

build-java/ODLv21Lexer.java: ODLv21.g4
	$(antlr4) ODLv21.g4 -o build-java

pds3_python.tar.gz: $(PYTARGETS)
	mkdir -p $(PYBUILDDIR)
	cp $(PYTARGETS) $(PYBUILDDIR)
	cp ../README.md $(PYBUILDDIR)/README.md
	cp ../LICENSE $(PYBUILDDIR)
	cd build; tar -czf $@ $(PYVERSIONDIR); cd ..

release: pds3_python.tar.gz
	mkdir -p release
	mv build/pds3_python.tar.gz release/pds3_python-$(VERSION).tar.gz

.PHONY: clean
clean:
	rm -rf build-java build-python build
