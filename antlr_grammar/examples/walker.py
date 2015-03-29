#!/usr/bin/env python

from collections import OrderedDict
from pprint import pprint
import json

from antlr4 import FileStream, CommonTokenStream, ParseTreeWalker
from ODLv21Visitor import ODLv21Visitor
from ODLv21Parser import ODLv21Parser
from ODLv21Lexer import ODLv21Lexer


class NodeTypeVisitor(ODLv21Visitor):
    """Walks the Parse Tree and Prints out nodes and types"""

    def __init__(self):
        super(NodeTypeVisitor, self).__init__()

    def visitAssignment_stmt(self, ctx):
        print "Inside assignment"


def node_types(infile):
    input_stream = FileStream(infile)
    lexer = ODLv21Lexer(input_stream)
    tokens = CommonTokenStream(lexer)

    parser = ODLv21Parser(tokens)
    parse_tree = parser.label()

    visitor = NodeTypeVisitor()
    p = visitor.visit(parse_tree)
    #walker = ParseTreeWalker()
    #walker.walk(listener, parse_tree)

    #print(json.dumps(listener.label, indent=4))
    return visitor


if __name__ == '__main__':
    import sys
    node_types(sys.argv[1])
