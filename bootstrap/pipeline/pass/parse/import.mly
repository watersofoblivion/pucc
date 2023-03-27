%{
  let make_path sloc path =
    let loc = make_loc sloc in
    Syntax.path loc path
  
  let make_alias sloc local path env =
    let loc = make_loc sloc in
    let (env, local) = match local with
      | None -> (env, None)
      | Some local ->
        let (env, name) = local env in
        (env, Some name)
    in
    let path = path in
    (env, Syntax.alias loc local path)

  let make_pkgs sloc aliases env =
    let loc = make_loc sloc in
    let fold (env, acc) alias =
      let (env, alias) = alias env in
      (env, alias :: acc)
    in
    let (env, aliases) = List.fold_left fold (env, []) aliases in
    let aliases = List.rev aliases in
    (env, Syntax.pkgs loc aliases)
  
  let make_import sloc pkgs env =
    let loc = make_loc sloc in
    let (env, pkgs) = pkgs env in
    (env, Syntax.import loc pkgs)
%}

/* Entry Point (for testing) */
%type <ParseEnv.env -> (ParseEnv.env * Syntax.import)> import_test
%start import_test

%%

/* Test */

%public import_test:
| import = import; EOF { import }

/* Import Statements */

%public import:
| "import"; pkgs = pkgs { make_import $sloc pkgs }

pkgs:
| "|"?; aliases = separated_nonempty_list("|", alias) { make_pkgs $sloc aliases }

alias:
| local = local_name?; path = path { make_alias $sloc local path }

local_name:
| id = name; "->" { id }

path:
| path = LIT_STRING { make_path $sloc path }