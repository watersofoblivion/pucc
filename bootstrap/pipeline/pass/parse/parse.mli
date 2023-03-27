(** {1 Parsing} *)

(**
 * {2 Environment}
 *)

type env
(** A parsing environment *)

val env : ?seq:(int Core.seq) -> unit -> env
(**
 * Construct an empty parsing environment
 *
 * @param ?seq The sequence to use for symbolizing identifiers.  Defaults to
 *   {{!the sequence of natural numbers} Core.seq_nat}
 * @param _ A dummy parameter for when the optional arguments are not given
 * @return An empty parsing environment
 *)

val symbolize : env -> string -> (env * Core.sym)
(**
 * Convert the string into a symbol.  If a symbol for that string already
 * exists, it is returned and the environment is not updated.  If a symbol for
 * that string does not exist, a fresh symbol is generated and the environment
 * is updated.
 *
 * @param env The environment to symbolize the identifier in
 * @param id The identifier to symbolize
 * @return An updated environment and a symbol representing for the identifier
 *)

(**
 * {2 Lexer}
 *)

(**
 * {3 Tokens}
 *)

type token = private
  | EOF             (** End Of File *)
  | PUNCT_PIPE      (** Pipe Character ([|], also bitwise OR) *)
  | PUNCT_ARROW     (** Arrow ([->]) *)
  (*
  | PUNCT_EQ        (** Equals ([=]) *)
  | PUNCT_DOT       (** Dot ([.]) *)
  | PUNCT_COMMA     (** Comma ([,]) *)
  | PUNCT_COLON     (** Colon ([:]) *)
  | PUNCT_SEMICOLON (** Semicolon ([;]) *)
  | PUNCT_GROUND    (** Ground ([_]) *)
  | PUNCT_LPAREN    (** Left Parenthesis ([]) *)
  | PUNCT_RPAREN    (** Right Parenthesis ([)]) *)
  | PUNCT_LBRACKET  (** Left Bracket ([]) *)
  | PUNCT_RBRACKET  (** Right Bracket ([]) *)
  | PUNCT_LBRACE    (** Left Brace ([]) *)
  | PUNCT_RBRACE    (** Right Brace ([}]) *)
  *)
  (*
  | OP_LAND         (** Logical AND ([&&]) *)
  | OP_LOR          (** Logical OR ([||]) *)
  | OP_LNOT         (** Logical NOT ([!]) *)
  | OP_ADD          (** Addition ([+]) *)
  | OP_SUB          (** Subtraction ([-]) *)
  | OP_MUL          (** Multiplication ([*]) *)
  | OP_DIV          (** Division ([/]) *)
  | OP_MOD          (** Modulus ([%]) *)
  | OP_BAND         (** Bitwise AND ([&]) *)
  | OP_BXOR         (** Bitwise XOR ([^]) *)
  | OP_BNOT         (** Bitwise NOT ([~]) *)
  | OP_SSL          (** Signed Shift Left ([<<]) *)
  | OP_SSR          (** Signed Shift Right ([>>]) *)
  | OP_USL          (** Unsigned Shift Left ([<<<]) *)
  | OP_USR          (** Unsigned Shift Right ([>>>]) *)
  | OP_SEQ          (** Structural Equality ([==]) *)
  | OP_PEQ          (** Physical Equality ([===]) *)
  | OP_SNEQ         (** Structural Inequality ([!=]) *)
  | OP_PNEQ         (** Physical Inequality ([!==]) *)
  | OP_LTE          (** Less Than or Equals ([<=]) *)
  | OP_LT           (** Less Than ([<]) *)
  | OP_GTE          (** Greater Than or Equals ([>=]) *)
  | OP_GT           (** Greater Than ([>]) *)
  | OP_RFA          (** Reverse Function Application ([|>|]) *)
  | OP_BIND         (** Monadic Bind ([>>=]) *)
  *)
  | KWD_LIBRARY     (** Library Package ([library]) *)
  | KWD_EXECUTABLE  (** Executable Package ([executable]) *)
  | KWD_IMPORT      (** Package Imports ([import]) *)
  (*
  | KWD_TYPE        (** Top-Level Type Definition ([type]) *)
  | KWD_VAL         (** Top-Level Value Binding ([val]) *)
  | KWD_DEF         (** Top-Level Function Definition ([def]) *)
  | KWD_LET         (** Let Binding ([let]) *)
  | KWD_REC         (** Recursive Bindings ([rec]) *)
  | KWD_IN          (** End Local Scope ([in]) *)
  | KWD_CASE        (** Pattern Match ([case]) *)
  | KWD_OF          (** Match Cases ([of]) *)
  | KWD_END         (** End Pattern Match ([end]) *)
  | KWD_IF          (** Conditional ([if]) *)
  | KWD_THEN        (** True Case ([then]) *)
  | KWD_ELSE        (** False Case ([else]) *)
  | KWD_LAMBDA      (** Anonymous Function ([lambda]) *)
  | KWD_DO          (** Monadic Do ([do]) *)
  *)
  (*
  | LIT_UNIT        (** Unit Literal ([()]) *)
  | LIT_TRUE        (** True Literal ([true]) *)
  | LIT_FALSE       (** False Literal ([false]) *)
  | LIT_INTEGER     (** Integer Literal ([42], [-97], [0xCAFEBABE], etc.) *)
  *)
  | LIT_STRING      (** String Literal (["foobar"]) *)
  | LIT_IDENT       (** Identifier Literal ([myIdent]) *)
(** Tokens *)

(**
 * {3 Lexing Buffers}
 *
 * Construct lexing buffers from strings or channels with position tracking
 * enabled, as is required by the parser.
 *)

val lexbuf_from_string : string -> Lexing.lexbuf
(**
 * Construct a lexing buffer from a string.
 * 
 * @param src The string containing the data to lex
 * @return A lexing buffer
 *)

val lexbuf_from_in_channel : in_channel -> Lexing.lexbuf
(**
 * Construct a lexing buffer from an input channel, most likely constructed by
 * opening a file.
 *
 * @param ic The input channel to lex
 * @return A lexing buffer
 *)

(**
 * {3 Tokens}
 *
 * Functions for constructing tokens.
 *)

(**
 * {4 Unprintable}
 *)

val eof : token
(** The End-Of-File token. *)

(**
 * {4 Punctuation}
 *)

val punct_pipe : token
(** Pipe Character ([|], also Binary OR) *)

val punct_arrow : token
(** Arrow ([->]) *)
(*
val punct_eq : token
(** Equals ([=]) *)

val punct_dot : token
(** Dot ([.]) *)

val punct_comma : token
(** Comma ([,]) *)

val punct_colon : token
(** Colon ([:]) *)

val punct_semicolon : token
(** Semicolon ([;]) *)

val punct_ground : token
(** Ground ([_]) *)

val punct_lparen : token
(** Left Parenthesis ([]) *)

val punct_rparen : token
(** Right Parenthesis ([)]) *)

val punct_lbracket : token
(** Left Bracket ([]) *)

val punct_rbracket : token
(** Right Bracket ([]) *)

val punct_lbrace : token
(** Left Brace ([]) *)

val punct_rbrace : token
(** Right Brace ([}]) *)
*)
(**
 * {4 Operators}
 *)
(*
val op_land : token
(** Logical AND ([&&]) *)

val op_lor : token
(** Logical OR ([||]) *)

val op_lnot : token
(** Logical NOT ([!]) *)

val op_add : token
(** Addition ([+]) *)

val op_sub : token
(** Subtraction ([+]) *)

val op_mul : token
(** Multiplication ([*]) *)

val op_div : token
(** Division ([/]) *)

val op_mod : token
(** Modulus ([%]) *)

val op_band : token
(** Binary AND ([&]) *)

val op_bxor : token
(** Binary XOR ([^]) *)

val op_bnot : token
(** Binary NOT ([~]) *)

val op_ssl : token
(** Signed Shift Left ([<<]) *)

val op_ssr : token
(** Signed Shift Right ([>>]) *)

val op_usl : token
(** Unsigned Shift Left ([<<<]) *)

val op_usr : token
(** Unsigned Shift Right ([>>>]) *)

val op_seq : token
(** Structural Equality ([==]) *)

val op_peq : token
(** Physical Equality ([===]) *)

val op_sneq : token
(** Structural Inequality ([!=]) *)

val op_pneq : token
(** Physical Inequality ([!==]) *)

val op_lte : token
(** Less Than or Equal ([<=]) *)

val op_lt : token
(** Less Than ([<]) *)

val op_gte : token
(** Greater Than or Equal ([>=]) *)

val op_gt : token
(** Greater Than ([>]) *)

val op_rfa : token
(** Reverse Function Application ([|>]) *)

val op_bind : token
(** Monadic Bind ([>>=]) *)
*)
(**
 * {4 Keywords}
 *)

 val kwd_library : token
(** Library Package ([library]) *)

val kwd_executabl : token
(** Executable Package ([executable]) *)

val kwd_import : token
(** Package Imports ([import]) *)
(*
val kwd_type : token
(** Top-Level Type Definition ([type]) *)

val kwd_val : token
(** Top-Level Value Binding ([val]) *)

val kwd_def : token
(** Top-Level Function Definition ([def]) *)

val kwd_let : token
(** Let Binding ([let]) *)

val kwd_rec : token
(** Recursive Bindings ([rec]) *)

val kwd_in : token
(** End of Local Scope ([in]) *)

val kwd_case : token
(** Pattern Match ([case]) *)

val kwd_of : token
(** Match Cases ([of]) *)

val kwd_end : token
(** End Pattern Match ([end]) *)

val kwd_if : token
(** Conditional ([if]) *)

val kwd_then : token
(** True Case ([then]) *)

val kwd_else : token
(** False Case ([else]) *)

val kwd_lambda : token
(** Anonymous Function ([lambda]) *)

val kwd_do : token
(** Monadic Do ([do]) *)
*)
(**
 * {4 Literals}
 *)
(*
val lit_unit : token
(** Unit Literal ([()]) *)

val lit_true : token
(** True Literal ([true]) *)

val lit_false : token
(** False Literal ([false]) *)

val lit_int : Lexing.lexbuf -> token
(**
 * Construct an integer literal from the current lexeme matched in the lexing
 * buffer.
 * 
 * @param lexbuf A lexing buffer that has matched a value
 * @return An integer literal token
 *)
*)
val lit_string : Buffer.t -> token
(**
 * Construct a string literal from the contents of the buffer.  The opening and
 * closing quotes are not included in the buffer's contents.
 * 
 * @param buf A {!Buffer.t} containing the contents of the string
 * @return A string literal token
 *)

val lit_ident : Lexing.lexbuf -> token
(**
 * Construct an identifier literal from the current lexeme matched in the
 * lexing buffer.
 *
 * @param lexbuf A lexing buffer that has matched a value
 * @return An identifier literal token
 *)

(**
 * {2 Parser Entry Points}
 *
 * These are the main entry points for the parser
 *)

val parse_file_from_channel : in_channel -> env -> (env * Syntax.file)
(**
 * Parse a file from an input channel.
 *
 * @param ic The input channel to parse
 * @param env The environment to parse in
 * @return An updated environment and the parsed file
 *)

(**
 * {3 Testing Entry Points}
 *
 * The parser entry points below are only used for testing.
 *)

val parse_file : ?env:env -> string -> (env * Syntax.file)
(**
 * Parse a file.
 *
 * @param ?env The environment to parse in.  Defaults to the empty environment.
 * @param src The source to parse
 * @return An updated environment and the parsed file
 *)

val parse_pkg : ?env:env -> string -> Syntax.pkg
(**
 * Parse a package statement.
 * 
 * @param ?env The environment to parse in.  Defaults to the empty environment.
 * @param src The source to parse
 * @return The parsed package statement
 *)


val parse_import : ?env:env -> string -> (env * Syntax.import)
(**
 * Parse a package statement.
 * 
 * @param ?env The environment to parse in.  Defaults to the empty environment.
 * @param src The source to parse
 * @return An updated environment and the parsed import statement
 *)