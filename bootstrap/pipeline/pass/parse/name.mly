/*
 * Names
 */

/* Entry Point for Testing */
%type <Syntax.name> parse_name
%type <Syntax.name> parse_dotted

%start parse_name
%start parse_dotted

%%

/*
 * Testing
 */

%public parse_name:
| name = name; EOF { name }

/*
 * Implementation
 */

/* A simple name */
%public name:
| id = LIT_IDENT { Actions.name $sloc id }

/* A dotted name */
%public dotted:
| lhs = name; "."; rhs = name { Actions.dotted $sloc lhs rhs }