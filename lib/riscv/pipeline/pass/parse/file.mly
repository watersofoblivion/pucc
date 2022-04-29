%{
  [@@@coverage exclude_file]

  let make_file tops kontinue =
    Syntax.file tops
      |> kontinue
%}

%type <(Syntax.file -> 'a) -> 'a> file
%start file

%%

/* Source Files */

%public file:
| EOF { make_file [] }
