%{
  let make_name sloc id env =
    let loc = make_loc sloc in
    let (env, sym) = id env in
    (env, Syntax.name loc sym)
%}

/* Entry Point (for Testing) */
%type <ParseEnv.env -> (ParseEnv.env * Syntax.name)> name_test
%start name_test

%%

/* Test */

%public name_test:
| name = name; EOF { name }

/* Names */

%public name:
| name = ident { make_name $sloc name }