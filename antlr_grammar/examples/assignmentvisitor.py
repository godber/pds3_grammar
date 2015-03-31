#!/usr/bin/env python

from antlr4 import FileStream, CommonTokenStream
from ODLv21Visitor import ODLv21Visitor
from ODLv21Parser import ODLv21Parser
from ODLv21Lexer import ODLv21Lexer


class AssignmentVisitor(ODLv21Visitor):
    """Walks the Parse Tree and Prints out nodes and types"""

    def __init__(self):
        super(AssignmentVisitor, self).__init__()

    def visitAssignment_stmt(self, ctx):
        val = self.visitChildren(ctx)
        print "%s = %s" % (ctx.IDENTIFIER().getText(), val)
        return val

    def visitValue(self, ctx):
        return ODLv21Visitor.visitChildren(self, ctx)

    def visitScalarFloat(self, ctx):
        ODLv21Visitor.visitScalarFloat(self, ctx)
        return float(ctx.FLOAT().getText())

    def visitScalarInteger(self, ctx):
        ODLv21Visitor.visitScalarInteger(self, ctx)
        return int(ctx.INTEGER().getText())

    def visitScalarString(self, ctx):
        ODLv21Visitor.visitScalarString(self, ctx)
        return ctx.STRING().getText()

    def visitScalarSymbol(self, ctx):
        ODLv21Visitor.visitScalarSymbol(self, ctx)
        return ctx.SYMBOL_STRING().getText()

    def visitScalarIdentifier(self, ctx):
        ODLv21Visitor.visitScalarIdentifier(self, ctx)
        return ctx.IDENTIFIER().getText()


def node_types(infile):
    input_stream = FileStream(infile)
    lexer = ODLv21Lexer(input_stream)
    tokens = CommonTokenStream(lexer)

    parser = ODLv21Parser(tokens)
    parse_tree = parser.label()

    visitor = AssignmentVisitor()

    return visitor, parse_tree


if __name__ == '__main__':
    import sys
    visitor, parse_tree = node_types(sys.argv[1])

    visitor.visit(parse_tree)
