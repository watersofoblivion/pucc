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
| local = "let"?; "type"; bindings = ty_binding_list                                 { Actions.top_ty  $sloc local bindings } 
| "val"; binding = binding                                                           { Actions.top_val $sloc binding }
| "def"; binding = binding                                                           { Actions.top_def $sloc binding }
| "let"; recur = "rec"?; bindings = binding_list                                     { Actions.top_let $sloc recur bindings }
| "mod"; name = name; params = mod_params_list; "="; elems = struct_elem_list; "end" { Actions.top_mod $sloc name params elems }

struct_elem_list:
| elems = top* { elems }
