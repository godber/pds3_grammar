export CLASSPATH=".:/usr/local/lib/antlr-4.5-complete.jar:$CLASSPATH"
alias antlr4='java -jar /usr/local/lib/antlr-4.5-complete.jar'
alias grun='java org.antlr.v4.runtime.misc.TestRig'

export GRUN_CMD='java org.antlr.v4.runtime.misc.TestRig'

diagrun() {
  testfile=`readlink -f $1`
  cd build-java/ && $GRUN_CMD ODLv21 label -diagnostics < $testfile
  cd ..
}

guirun() {
  testfile=`readlink -f $1`
  cd build-java/ && $GRUN_CMD ODLv21 label -gui < $testfile
  cd ..
}

psrun() {
  testfile=`readlink -f $1`
  cd build-java/ && $GRUN_CMD ODLv21 label -ps $testfile.ps < $testfile
  cd ..
}

tokenrun() {
  testfile=`readlink -f $1`
  cd build-java/ && $GRUN_CMD ODLv21 label -tokens < $testfile
  cd ..
}

treerun() {
  testfile=`readlink -f $1`
  cd build-java/ && $GRUN_CMD ODLv21 label -tree < $testfile
  cd ..
}

tracerun() {
  testfile=`readlink -f $1`
  cd build-java/ && $GRUN_CMD ODLv21 label -trace < $testfile
  cd ..
}
