/*
 * Tokens
 */

/* Non-Printable */
%token EOF

/* Punctuation */
%token PUNCT_PIPE "|"
%token PUNCT_ARROW "->"
/*
%token PUNCT_EQ "="
%token PUNCT_DOT "."
%token PUNCT_COMMA ","
%token PUNCT_COLON ":"
%token PUNCT_SEMICOLON ";"
%token PUNCT_GROUND "_"
%token PUNCT_LPAREN "("
%token PUNCT_RPAREN ")"
%token PUNCT_LBRACKET "["
%token PUNCT_RBRACKET "]"
%token PUNCT_LBRACE "{"
%token PUNCT_RBRACE "}"
*/

/* Operators */
/*
%token OP_LAND "&&"
%token OP_LOR  "||"
%token OP_LNOT "!"
%token OP_ADD  "+"
%token OP_SUB  "-"
%token OP_MUL  "*"
%token OP_DIV  "/"
%token OP_MOD  "%"
%token OP_BAND "&"
%token OP_BXOR "^"
%token OP_BNOT "~"
%token OP_SSL  "<<"
%token OP_SSR  ">>"
%token OP_USL  "<<<"
%token OP_USR  ">>>"
%token OP_SEQ  "=="
%token OP_PEQ  "==="
%token OP_SNEQ "!="
%token OP_PNEQ "!=="
%token OP_LTE  "<="
%token OP_LT   "<"
%token OP_GTE  ">="
%token OP_GT   ">"
%token OP_RFA  "|>"
%token OP_BIND ">>="
*/

/* Associativity */
/*
%left OP_LAND OP_LOR
%right OP_LNOT
%left OP_ADD OP_SUB OP_MUL OP_DIV OP_MOD
%left OP_BAND OP_BXOR
%right OP_BNOT
%left OP_SSL OP_SSR OP_USL OP_USR
%left OP_SEQ OP_PEQ OP_SNEQ OP_PNEQ
%left OP_LTE OP_LT OP_GTE OP_GT
%left OP_RFA OP_BIND
*/

/* Keywords */
%token KWD_LIBRARY "library"
%token KWD_EXECUTABLE "executable"
%token KWD_IMPORT "import"
/*
%token KWD_TYPE "type"
%token KWD_VAL "val"
%token KWD_DEF "def"
%token KWD_LET "let"
%token KWD_REC "rec"
%token KWD_IN "in"
%token KWD_CASE "case"
%token KWD_OF "of"
%token KWD_END "end"
%token KWD_IF "if"
%token KWD_THEN "then"
%token KWD_ELSE "else"
%token KWD_LAMBDA "lambda"
%token KWD_DO "do"
*/

/* Value Literals */
/*
%token LIT_UNIT "()"
%token LIT_TRUE "true"
%token LIT_FALSE "false"
%token <string> LIT_INT
*/
%token <string> LIT_STRING
%token <string> LIT_IDENT

%%
