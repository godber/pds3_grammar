export CLASSPATH=".:/usr/local/lib/antlr-4.4-complete.jar:$CLASSPATH"
alias antlr4='java -jar /usr/local/lib/antlr-4.4-complete.jar'
alias grun='java org.antlr.v4.runtime.misc.TestRig'


guirun() {
  testfile=`readlink -f $1`
  cd build-java/ && grun ODLv21 label -gui < $testfile && cd ..
}

tokenrun() {
  testfile=`readlink -f $1`
  cd build-java/ && grun ODLv21 label -tokens < $testfile && cd ..
}

treerun() {
  testfile=`readlink -f $1`
  cd build-java/ && grun ODLv21 label -tree < $testfile && cd ..
}

tracerun() {
  testfile=`readlink -f $1`
  cd build-java/ && grun ODLv21 label -trace < $testfile && cd ..
}
