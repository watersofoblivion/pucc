/* Top-Level Entry Points */
%type <Syntax.file> file
%type <Syntax.file> header
%start file
%start header

%%

/* Header-Only */
%public header:
| pkg = pkg; imports = import*; end_of_header { Actions.file $sloc pkg imports [] }

end_of_header:
| "type"      { () }
| "val"       { () }
| "def"       { () }
| "let"       { () }
| "mod"       { () }
| end_of_file { () }

/* Full File */
%public file:
| pkg = pkg; imports = import*; tops = top*; end_of_file { Actions.file $sloc pkg imports tops }

end_of_file:
| EOF { () }
