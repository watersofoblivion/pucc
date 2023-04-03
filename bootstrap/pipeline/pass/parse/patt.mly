/* Entry Points for Testing */
%type <Syntax.patt> parse_patt
%start parse_patt

%%

/*
 * Testing
 */

%public parse_patt:
| patt = patt; EOF { patt }

/*
 * Implementation
 */

/* Patterns */
%public patt:
| "_"                                        { Actions.patt_ground $sloc }
| LIT_TRUE                                   { Actions.patt_bool   $sloc true }
| LIT_FALSE                                  { Actions.patt_bool   $sloc false }
| value = LIT_INT                            { Actions.patt_int    $sloc value }
| id = LIT_IDENT                             { Actions.patt_var    $sloc id }
| name = name; "("; params = param_list; ")" { Actions.patt_fun    $sloc name params }

%public param_list:
| params = separated_nonempty_list(",", param) { params }

param:
| patt = patt; ty = ascription? { Actions.param $sloc patt ty }
