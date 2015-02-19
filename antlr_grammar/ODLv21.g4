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
  | pointer_stmt (COMMENT)? NEWLINE
  | object_stmt (COMMENT)? NEWLINE
  | group_stmt (COMMENT)? NEWLINE
  ;

assignment_stmt
  : IDENTIFIER '=' value
  | namespace_identifier ':' IDENTIFIER '=' value
  ;

pointer_stmt
  : '^' IDENTIFIER '=' value
  ;

object_stmt
  : 'OBJECT' '=' IDENTIFIER (COMMENT)? NEWLINE
    (statement|COMMENT|NEWLINE)*
    'END_OBJECT' ('=' IDENTIFIER)?
  ;

group_stmt
  : 'GROUP' '=' IDENTIFIER (COMMENT)? NEWLINE
    (statement|COMMENT|NEWLINE)*
    'END_GROUP' ('=' IDENTIFIER)?
  ;

value
  : scalar_value
  | sequence_value
  | set_value
  | date_time_value
  ;

date_time_value
  : DATE
  | TIME
  | DATE_TIME
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
  : '{' scalar_value (NEWLINE)? (',' (NEWLINE)? scalar_value (NEWLINE)? )* '}'
  | '{' '}'
  ;

scalar_value
  : INTEGER (units_expression)?         # ScalarInteger
  | BASED_INTEGER (units_expression)?   # ScalarBasedInteger
  | FLOAT (units_expression)?           # ScalarFloat
  | SCALED_REAL (units_expression)?     # ScalarScaledReal
  | IDENTIFIER                          # ScalarIdentifier
  | SYMBOL_STRING                       # ScalarSymbol
  | STRING                              # ScalarString
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


DATE
  : YEAR_MONTH_DAY
  | YEAR_DOY
  ;

TIME
  : HH_MM_SS               // HH:MM(:SS)
  | HH_MM_SS 'Z'           // HH:MM(:SS)Z
  | HH_MM_SS SIGN DIGIT+   // HH:MM(:SS)+N
  ;

YEAR_MONTH_DAY
  : DIGIT DIGIT DIGIT DIGIT '-' DIGIT+ '-' DIGIT+    // YYYY-MM-DD
  ;

YEAR_DOY
  : DIGIT DIGIT DIGIT DIGIT '-' DIGIT+               // YYYY-DOY
  ;

HH_MM_SS
  : DIGIT DIGIT ':' DIGIT DIGIT (':' DIGIT DIGIT)?             // HH:MM(:SS)
  | DIGIT DIGIT ':' DIGIT DIGIT (':' DIGIT DIGIT '.' DIGIT+)?  // HH:MM(:SS.FF)
  ;

DATE_TIME
  : DATE 'T' TIME
  ;

SIGN
  : ('+'|'-')
  ;

IDENTIFIER
  : [A-Za-z][A-Za-z0-9'_']*[A-Za-z0-9]*
  ;

// STRING corresponds to quoted_text
// NOTE: This rule will return strings that contain newlines and spaces which
//       are not compliant with 12.5.3.1.  Strings must be massaged at the
//       application level to make them compliant with 12.5.3.1.
STRING
  : '"' ~["]*? '"'
  ;

// Symbol String 12.3.3.2 or quoted_symbol
SYMBOL_STRING
  : '\'' ~['\r\n\f\v]+? '\''
  ;

// Unscaled Real: 12.3.1.3
FLOAT
  : (SIGN)? DIGIT+ '.' DIGIT*      // 1.23 1. 1.123123
  | (SIGN)? '.' DIGIT+             // .1 .123123
  ;

SCALED_REAL
  : FLOAT ('E'|'e') INTEGER        // 1.0E5, .5e3
  | INTEGER ('E'|'e') INTEGER      // 3145e3 - Handling an integer mantissa
  ;

BASED_INTEGER
  : DIGIT+ '#' (SIGN)? (DIGIT|[a-zA-Z])+ '#'
  ;

INTEGER
  : (SIGN)? DIGIT+
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
