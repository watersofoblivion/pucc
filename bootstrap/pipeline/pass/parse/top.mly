/* Entry Points for Testing */
%type <Syntax.top> parse_top
%start parse_top

%%

/*
 * Testing
 */

%public parse_top:
| top = top; EOF { top }

/*
 * Implementation
 */

/* Top-Level Bindings */
%public top:
| "let"?; "type"; id = name; params = mod_param_list?; "="; modifier = top_val_ty?; ty = ty { make_top_ty  $sloc id params modifier ty } 
| "val"; id = ident; ty = ascription?; "="; value = expr                                 { make_top_val $sloc id ty value }
| "def"; id = ident; "("; params = param_list; ")"; ty = ascription?; "="; body = expr   { make_top_def $sloc id params res body }
| "mod"; id = i
| "let"; bindings = binding_list;                                                        { make_top_let $sloc bindings }

top_val_ty:
| "private"  { make_topvalty_private  $sloc }
| "abstract" { make_topvalty_abstract $sloc }