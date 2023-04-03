/*
 * Names
 */

/* Entry Point for Testing */
%type <Syntax.name> parse_name
%start parse_name

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
| id = LIT_IDENT              { Actions.name   $sloc id }
| lhs = name; "."; rhs = name { Actions.dotted $sloc lhs rhs }