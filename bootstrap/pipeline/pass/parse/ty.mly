/*
 * Types
 */

/* Entry Points for Testing */
%type <Syntax.ty> parse_ty
%type <Syntax.ty> parse_sig_ty
%type <Syntax.ty> parse_term_ty
%type <Syntax.ty_binding list> parse_ty_binding_list
%type <Syntax.param list> parse_mod_params_list
%type <Syntax.ty> parse_ascription

%start parse_ty
%start parse_sig_ty
%start parse_term_ty
%start parse_ty_binding_list
%start parse_mod_params_list
%start parse_ascription

%%

/*
 * Testing
 */

%public parse_ty:
| ty = ty; EOF { ty }

%public parse_ty_binding_list:
| tys = ty_binding_list; EOF { ty }

%public parse_mod_params_list:
| params = mod_params_list; EOF { params }

%public parse_ascription:
| ty = ascription; EOF { ty }

/*
 * Implementation
 */

/* Types */
%public ty:
| constr = name                                     { Actions.ty_constr $sloc constr tys }
| param = ty; "->"; res = ty                        { Actions.ty_fun    $sloc param res }
| "mod"; elems = sig_elem*; "end";                  { Actions.ty_sig    $sloc elems }
| mod = name; "with"; "type"; tys = ty_binding_list { Actions.ty_with $sloc name tys }
| "("; ty = ty; ")"                                 { ty }

/* Module Signature Elements */
sig_elem:
| "type"; name = name; params = mod_params_list?; "="; ty = ty   { Actions.sig_ty $sloc name params ty }
| "val"; name = name; ty = ascription                            { Actions.sig_val $sloc name ty }
| "def"; name = name; ty = ascription                            { Actions.sig_def $sloc name ty }
| "mod"; name = name; params = mod_params_list?; ty = ascription { Actions.sig_mod $sloc name params ty }

/* Type Bindings */
%public ty_binding_list:
| tys = separated_nonempty_list("and", ty_binding) { tys }

ty_binding:
| name = name; "="; vis = ty_vis?; ty = ty { Actions.ty_binding $sloc name vis ty }

ty_vis:
| "readonly" { Actions.ty_vis_readonly $sloc }
| "abstract" { Actions.ty_vis_abstract $sloc }

/* Module Parameters List */
%public mod_params_list:
| "("; params = param_list; ")" { params }

mod_param:
| name = name; ty = ascription { Actions.mod_param $sloc name ty }

/* Type Ascription */
%public ascription:
| ":"; ty = ty { ty }
