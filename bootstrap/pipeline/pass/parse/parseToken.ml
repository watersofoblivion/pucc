type token =
  | EOF             
  | PUNCT_PIPE      
  | PUNCT_ARROW     
  | PUNCT_EQ        
  | PUNCT_DOT       
  | PUNCT_COMMA     
  | PUNCT_COLON     
  (*
  | PUNCT_SEMICOLON 
  *)
  | PUNCT_GROUND    
  | PUNCT_LPAREN    
  | PUNCT_RPAREN
  (*    
  | PUNCT_LBRACKET  
  | PUNCT_RBRACKET  
  | PUNCT_LBRACE    
  | PUNCT_RBRACE    
  *)
  | OP_LAND         
  | OP_LOR          
  | OP_LNOT         
  | OP_ADD          
  | OP_SUB          
  | OP_MUL          
  | OP_DIV          
  | OP_MOD          
  | OP_BAND         
  | OP_BXOR         
  | OP_BNOT         
  | OP_SSL          
  | OP_SSR          
  | OP_USL          
  | OP_USR          
  | OP_SEQ          
  | OP_PEQ          
  | OP_SNEQ         
  | OP_PNEQ         
  | OP_LTE          
  | OP_LT           
  | OP_GTE          
  | OP_GT           
  | OP_RFA  
  (*        
  | OP_BIND         
  *)
  | KWD_LIBRARY     
  | KWD_EXECUTABLE  
  | KWD_IMPORT      
  | KWD_TYPE        
  | KWD_READONLY
  | KWD_ABSTRACT
  | KWD_VAL         
  | KWD_DEF         
  | KWD_LET         
  | KWD_REC  
  | KWD_AND       
  | KWD_IN          
  (*
  | KWD_CASE        
  | KWD_OF          
  *)
  | KWD_MOD
  | KWD_END    
  | KWD_WITH     
  | KWD_IF          
  | KWD_THEN        
  | KWD_ELSE        
  | KWD_FUN 
  (*   
  | KWD_DO          
  *)
  (*
  | LIT_UNIT        
  *)
  | LIT_TRUE        
  | LIT_FALSE       
  | LIT_INT of string
  | LIT_STRING of string     
  | LIT_IDENT of string

(* Unprintable *)
let eof = EOF

(* Punctuation *)
let punct_pipe = PUNCT_PIPE
let punct_arrow = PUNCT_ARROW
let punct_eq = PUNCT_EQ
let punct_dot = PUNCT_DOT
let punct_comma = PUNCT_COMMA
let punct_colon = PUNCT_COLON
(*
let punct_semicolon = PUNCT_SEMICOLON
*)
let punct_ground = PUNCT_GROUND
let punct_lparen = PUNCT_LPAREN
let punct_rparen = PUNCT_RPAREN
(*
let punct_lbracket = PUNCT_LBRACKET
let punct_rbracket = PUNCT_RBRACKET
let punct_lbrace = PUNCT_LBRACE
let punct_rbrace = PUNCT_RBRACE
*)

(* Operators *)
let op_land = OP_LAND
let op_lor = OP_LOR
let op_lnot = OP_LNOT
let op_add = OP_ADD
let op_sub = OP_SUB
let op_mul = OP_MUL
let op_div = OP_DIV
let op_mod = OP_MOD
let op_band = OP_BAND
let op_bxor = OP_BXOR
let op_bnot = OP_BNOT
let op_ssl = OP_SSL
let op_ssr = OP_SSR
let op_usl = OP_USL
let op_usr = OP_USR
let op_seq = OP_SEQ
let op_peq = OP_PEQ
let op_sneq = OP_SNEQ
let op_pneq = OP_PNEQ
let op_lte = OP_LTE
let op_lt = OP_LT
let op_gte = OP_GTE
let op_gt = OP_GT
let op_rfa = OP_RFA
(*
let op_bind = OP_BIND
*)

(* Keywords *)
let kwd_library = KWD_LIBRARY
let kwd_executable = KWD_EXECUTABLE
let kwd_import = KWD_IMPORT
let kwd_type = KWD_TYPE
let kwd_readonly = KWD_READONLY
let kwd_abstract = KWD_ABSTRACT
let kwd_val = KWD_VAL
let kwd_def = KWD_DEF
let kwd_let = KWD_LET
let kwd_rec = KWD_REC
let kwd_and = KWD_AND
let kwd_in = KWD_IN
(*
let kwd_case = KWD_CASE
let kwd_of = KWD_OF
*)
let kwd_mod = KWD_MOD
let kwd_end = KWD_END
let kwd_with = KWD_WITH
let kwd_if = KWD_IF
let kwd_then = KWD_THEN
let kwd_else = KWD_ELSE
let kwd_fun = KWD_FUN
(*
let kwd_do = KWD_DO
*)

(*
let lit_unit = LIT_UNIT
*)
let lit_true = LIT_TRUE
let lit_false = LIT_FALSE
let lit_int lexbuf =
  let lexeme = Lexing.lexeme lexbuf in
  LIT_INT lexeme
let lit_string buf = 
  let lexeme = Buffer.contents buf in
  Buffer.clear buf;
  LIT_STRING lexeme
let lit_ident lexbuf =
  let lexeme = Lexing.lexeme lexbuf in
  LIT_IDENT lexeme
