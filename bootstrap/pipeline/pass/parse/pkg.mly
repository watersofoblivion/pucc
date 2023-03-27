%{
  let make_pkg_library sloc name env =
    let loc = make_loc sloc in
    let (env, name) = name env in
    (env, Syntax.pkg_library loc name)

  let make_pkg_executable sloc name env =
    let loc = make_loc sloc in
    let (env, name) = name env in
    (env, Syntax.pkg_executable loc name)
%}

/* Entry Point (for Testing) */
%type <ParseEnv.env -> (ParseEnv.env * Syntax.pkg)> pkg_test
%start pkg_test

%%

/* Test */

%public pkg_test:
| pkg = pkg; EOF { pkg }

/* Package Statements */

%public pkg:
| "library";    id = name { make_pkg_library $sloc id }
| "executable"; id = name { make_pkg_executable $sloc id }
