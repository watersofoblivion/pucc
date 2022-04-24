%{
  [@@@coverage exclude_file]

  let make_file kontinue =
    Syntax.file []
      |> kontinue
%}

%type <(Syntax.file -> 'a) -> 'a> file
%start file

%%

/* Source Files */

%public file:
| EOF { make_file }
