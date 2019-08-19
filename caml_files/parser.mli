type token =
  | IDENTIFIER of (string)
  | BCONSTANT of (bool)
  | INTCONSTANT of (int)
  | FST
  | SND
  | ADD
  | SUB
  | MUL
  | DIV
  | MOD
  | EQ
  | GE
  | GT
  | LE
  | LT
  | NE
  | BLAND
  | BLOR
  | LPAREN
  | RPAREN
  | LBRACE
  | RBRACE
  | COMMA
  | SEMICOLON
  | COLON
  | QMARK
  | IF
  | THEN
  | ELSE
  | WHILE
  | FOR
  | RETURN
  | AND
  | ARROW
  | FUN
  | IN
  | LET
  | REC
  | TYPE
  | EOF

val start :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Miniml.prog
