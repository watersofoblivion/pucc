/* Entry Point (for testing) */
%type <Syntax.import> parse_import
%start parse_import

%%

/*
 * Testing
 */

%public parse_import:
| import = import; EOF { import }

/*
 * Implementation
 */

/* Import Statements */
%public import:
| "import"; pkgs = pkgs { Actions.import $sloc pkgs }

pkgs:
| "|"?; aliases = separated_nonempty_list("|", alias) { Actions.pkgs $sloc aliases }

alias:
| local = local_name?; path = path { Actions.alias $sloc local path }

local_name:
| id = name; "->" { id }

path:
| path = LIT_STRING { Actions.path $sloc path }