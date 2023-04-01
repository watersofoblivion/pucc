%{
  let make_name sloc id env =
    let loc = make_loc sloc in
    let (env, sym) = id env in
    (env, Syntax.name loc sym)
%}

/* Entry Point (for Testing) */
%type <ParseEnv.env -> (ParseEnv.env * Syntax.name)> parse_name
%start parse_name

%%

/* Test */

%public parse_name:
| name = name; EOF { name }

/* Names */

%public name:
| name = ident { make_name $sloc name }