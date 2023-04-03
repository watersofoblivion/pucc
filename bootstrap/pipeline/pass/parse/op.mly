/* Entry Points for Testing */
%type <Syntax.un> parse_op_un
%type <Syntax.bin> parse_op_bin

%start parse_op_un
%start parse_op_bin

%%

/*
 * Testing
 */

%public parse_op_un:
| op = op_un; EOF { op }

%public parse_op_bin:
| op = op_bin; EOF { op }

/*
 * Implementation
 */

/* Unary Operators */
%public %inline op_un:
| "-" { Actions.un_neg  $sloc }
| "!" { Actions.un_lnot $sloc }
| "~" { Actions.un_bnot $sloc }

/* Binary Operators */
%public %inline op_bin:
| "+"   { Actions.bin_add  $sloc }
| "-"   { Actions.bin_sub  $sloc }
| "*"   { Actions.bin_mul  $sloc }
| "/"   { Actions.bin_div  $sloc }
| "%"   { Actions.bin_mod  $sloc }
| "&&"  { Actions.bin_land $sloc }
| "||"  { Actions.bin_lor  $sloc }
| "&"   { Actions.bin_band $sloc }
| "|"   { Actions.bin_bor  $sloc }
| "^"   { Actions.bin_bxor $sloc }
| "<<"  { Actions.bin_ssl  $sloc }
| ">>"  { Actions.bin_ssr  $sloc }
| "<<<" { Actions.bin_usl  $sloc }
| ">>>" { Actions.bin_usr  $sloc }
| "=="  { Actions.bin_seq  $sloc }
| "===" { Actions.bin_peq  $sloc }
| "!="  { Actions.bin_sneq $sloc }
| "!==" { Actions.bin_pneq $sloc }
| "<="  { Actions.bin_lte  $sloc }
| "<"   { Actions.bin_lt   $sloc }
| ">="  { Actions.bin_gte  $sloc }
| ">"   { Actions.bin_gt   $sloc }
| "|>"  { Actions.bin_rfa  $sloc }
