antlr4 := java -jar /usr/local/lib/antlr-4.4-complete.jar

all: clean build-python build-java/ODLv21Lexer.java
	javac build-java/*.java

build-python: ODLv21.g4
	$(antlr4) ODLv21.g4 -o build-python -Dlanguage=Python2

build-java/ODLv21Lexer.java: ODLv21.g4
	$(antlr4) ODLv21.g4 -o build-java


.PHONY: clean
clean:
	rm -rf build-java build-python
