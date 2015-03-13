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
        if ctx.COMMENT():
            print ctx.COMMENT()

    def enterLabel(self, ctx):
        if ctx.COMMENT():
            print ctx.COMMENT()

    def enterGroup_stmt(self, ctx):
        if ctx.COMMENT():
            print ctx.COMMENT()

    def enterObject_stmt(self, ctx):
        if ctx.COMMENT():
            print ctx.COMMENT()


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
