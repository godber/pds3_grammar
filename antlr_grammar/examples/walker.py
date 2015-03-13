#!/usr/bin/env python

from collections import OrderedDict
from pprint import pprint
import json

from antlr4 import FileStream, CommonTokenStream, ParseTreeWalker
from ODLv21Listener import ODLv21Listener
from ODLv21Parser import ODLv21Parser
from ODLv21Lexer import ODLv21Lexer


class NodeTypeListener(ODLv21Listener):
    """Walks the Parse Tree and Prints out nodes and types"""

    def __init__(self):
        self.label = OrderedDict()
        super(NodeTypeListener, self).__init__()

    def enterStatement(self, ctx):
        pass

    def enterAssignment_stmt(self, ctx):
        self.label[ctx.IDENTIFIER().getText()] = ctx.value().getText()

def node_types(infile):
    input_stream = FileStream(infile)
    lexer = ODLv21Lexer(input_stream)
    tokens = CommonTokenStream(lexer)

    parser = ODLv21Parser(tokens)
    parse_tree = parser.label()

    listener = NodeTypeListener()
    walker = ParseTreeWalker()
    walker.walk(listener, parse_tree)

    print(json.dumps(listener.label, indent=4))


if __name__ == '__main__':
    import sys
    node_types(sys.argv[1])
