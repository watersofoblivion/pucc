%{
  let make_header pkg imports env =
    let (env, pkg) = pkg env in
    let fold (env, acc) import =
      let (env, import) = import env in
      (env, import :: acc)
    in
    let (env, imports) = List.fold_left fold (env, []) imports in
    let imports = List.rev imports in
    (env, Syntax.file pkg imports)

  let make_file pkg imports env =
    let (env, pkg) = pkg env in
    let fold (env, acc) import =
      let (env, import) = import env in
      (env, import :: acc)
    in
    let (env, imports) = List.fold_left fold (env, []) imports in
    let imports = List.rev imports in
    (env, Syntax.file pkg imports)
%}

%type <ParseEnv.env -> (ParseEnv.env * Syntax.file)> file
%start file

%type <ParseEnv.env -> (ParseEnv.env * Syntax.file)> header
%start header

%%

%public header:
| pkg = pkg; imports = list(import); end_of_header { make_header pkg imports }

end_of_header:
| end_of_file { () }

%public file:
| pkg = pkg; imports = list(import); end_of_file { make_file pkg imports }

end_of_file:
| EOF { () }
