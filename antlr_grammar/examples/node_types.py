#!/usr/bin/env python

from antlr4 import FileStream, CommonTokenStream, ParseTreeWalker
from ODLv21Listener import ODLv21Listener
from ODLv21Parser import ODLv21Parser
from ODLv21Lexer import ODLv21Lexer


class NodeTypeListener(ODLv21Listener):
    """Walks the Parse Tree and Prints out nodes and types"""

    def __init__(self):
        super(NodeTypeListener, self).__init__()

    def enterStatement(self, ctx):
        print "enterStatement"
        print ctx.getText(),
        #print dir(ctx)
        #print ctx.COMMENT()
        #print "Obj: ", ctx.object_stmt()
        #print ctx.parentCtx
        #print "\t" + str(ctx.depth())
        print

    def enterAssignment_stmt(self, ctx):
        print "\tenterAssignmentStatement"
        print "\t" + ctx.getText()
        print "\t" + ctx.IDENTIFIER().getText()
        print "\t" + ctx.value().getText()
        if ctx.value().scalar_value():
            print "\t" + ctx.value().scalar_value().getText()
        if ctx.value().sequence_value():
            print "\t" + str(ctx.value().sequence_value())
        if ctx.value().set_value():
            print "\t" + str(ctx.value().set_value())
        #print "\t" + str(dir(ctx.value().sequence_value()))
        #print "\t" + str(dir(ctx.value()))
        #print "\t" + str(dir(ctx))
        #print "\t" + str(dir(ctx))
        #print "\t" + str(ctx.parentCtx)
        #print "\t" + str(ctx.depth())
        #print "\t" + str(ctx.toStringTree())
        print


def node_types(infile):
    input_stream = FileStream(infile)
    lexer = ODLv21Lexer(input_stream)
    tokens = CommonTokenStream(lexer)

    parser = ODLv21Parser(tokens)
    parse_tree = parser.label()

    listener = NodeTypeListener()
    walker = ParseTreeWalker()
    walker.walk(listener, parse_tree)


if __name__ == '__main__':
    import sys
    node_types(sys.argv[1])
