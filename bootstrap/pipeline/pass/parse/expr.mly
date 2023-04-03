/* Entry Points for Testing */
%type <Syntax.expr> parse_expr
%type <Syntax.binding> parse_binding_list
%type <Syntax.binding> parse_binding

%start parse_expr
%start parse_binding_list
%start parse_binding

%%

/*
 * Testing
 */

%public parse_expr:
| expr = expr; EOF { expr }

%public parse_binding_list:
| bindings = binding_list; EOF { bindings }

%public parse_binding:
| binding = binding; EOF { binding }

/*
 * Implementation
 */

/* Expressions */
%public expr:
| "if"; cond = expr; "then"; tru = expr; "else"; fls = expr                  { Actions.expr_cond $sloc cond tru fls }
| "let"; recur = "rec"?; bindings = binding_list; "in"; scope = expr         { Actions.expr_let  $sloc recur bindings scope }
| "fun"; "("; params = param_list; ")"; ret = ascription?; "->"; body = expr { Actions.expr_abs  $sloc params ret body }
| fn = expr_lit; args = nonempty_list(expr_lit)                              { Actions.expr_app  $sloc fn args }
| op = op_un; operand = expr_lit                                             { Actions.expr_un   $sloc op operand }
| lhs = expr_lit; op = op_bin; rhs = expr                                    { Actions.expr_bin  $sloc op lhs rhs }
| expr = expr_lit                                                            { expr }

expr_lit:
| value = LIT_TRUE      { Actions.expr_bool $sloc true  }
| value = LIT_FALSE     { Actions.expr_bool $sloc false }
| value = LIT_INT       { Actions.expr_int  $sloc value }
| name = name           { Actions.expr_id   $sloc name }
| "("; expr = expr; ")" { expr }

/* Bindings */
%public binding_list:
| bindings = separated_nonempty_list("and", binding) { bindings }

%public binding:
| patt = patt; ty = ascription?; "="; value = expr { Actions.binding $sloc patt ty value }
