/*****************************************************************************
 * ANTLR v4 implementation of ODLv2 as defined here:
 *      http://pds.nasa.gov/documents/sr/Chapter12.pdf
 * Work in progress.
 *****************************************************************************/

grammar ODLv21;

label
  : (statement|COMMENT|NEWLINE)* ('END'|'end')
  ;

statement
  : assignment_stmt (COMMENT)? NEWLINE
  ;

assignment_stmt
  : IDENTIFIER '=' value
  | namespace_identifier ':' IDENTIFIER '=' value
  ;

value
  : scalar_value
  | sequence_value
  | set_value
  ;

sequence_value
  : sequence_1D
  | sequence_2D
  ;

sequence_1D
  : '(' scalar_value (',' scalar_value)* ')'
  ;

sequence_2D
  : '(' sequence_1D (',' sequence_1D)* ')'
  ;

// NOTE: Despite the grammar accepting any scalar value in sets, the PDS only
//       accepts SYMBOL and INTEGER values in sets. See 12.5.6.1
set_value
  : '{' scalar_value (',' scalar_value) '}'
  | '{' '}'
  ;

scalar_value
  : INTEGER (units_expression)?
  | FLOAT (units_expression)?
  | IDENTIFIER
  | SYMBOL_STRING
  | STRING
  ;

units_expression
  : '<' units_factor ( ('*'|'/') units_factor )* '>'
  ;

units_factor
  : IDENTIFIER ('**' INTEGER)?
  ;

namespace_identifier
  : IDENTIFIER
  ;

IDENTIFIER
  : [A-Za-z][A-Za-z0-9'_']*[A-Za-z0-9]*
  ;

// STRING corresponds to quoted_text
// FIXME: Use Lexer Mode to handle formatting inside string
STRING
  : '"' ~["]*? '"'
  ;

// Symbol String 12.3.3.2 or quoted_symbol
SYMBOL_STRING
  : '\'' ~['\r\n\f\v]+? '\''
  ;

INTEGER
  : ('-')? DIGIT+
  ;

// FIXME: Handle valid exponential notation.
FLOAT
  : ('-')? DIGIT+ '.' DIGIT*  // 1.23 1. 1.123123
  | ('-')? '.' DIGIT+         // .1 .123123
  ;

fragment
DIGIT
  : [0-9]
  ;

NEWLINE
  : '\r\n'
  ;

COMMENT
  : '/*' ~[\r\n\f\v]*? '*/'
  ;

WS
  : [ \t]+ -> channel(HIDDEN)
  ;
