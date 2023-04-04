(* Abstract Syntax *)

open OUnit2

(* Constructors *)

(* Names *)

let test_name ctxt =
  let loc = CoreTest.fresh_loc () in
  let lexeme = "testname" in
  let expected = Syntax.name loc lexeme in
  match expected with
    | Syntax.Name name ->
        CoreTest.assert_loc_equal ~ctxt loc name.loc;
        assert_equal ~ctxt ~msg:"Name lexemes are not equal" ~printer:Fun.id lexeme name.lexeme
    | actual -> SyntaxTest.fail_name_constr ~ctxt expected actual


let test_dotted ctxt =
  let loc = CoreTest.fresh_loc () in
  let lhs = SyntaxTest.fresh_name () in
  let rhs = SyntaxTest.fresh_name () in
  let expected = Syntax.dotted loc lhs rhs in
  match expected with
    | Syntax.Dotted name ->
        CoreTest.assert_loc_equal ~ctxt loc name.loc;
        SyntaxTest.assert_name_equal ~ctxt lhs name.lhs;
        SyntaxTest.assert_name_equal ~ctxt rhs name.rhs
    | actual -> SyntaxTest.fail_name_constr ~ctxt expected actual

let suite_constr_name =
  "Names" >::: [
    "Simple" >:: test_name;
    "Dotted" >:: test_dotted;
  ]

(* Types *)

(* Visibilities *)

let test_ty_vis_readonly ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.ty_vis_readonly loc in
  match expected with
    | Syntax.TyVisReadonly vis ->
        CoreTest.assert_loc_equal ~ctxt loc vis.loc
    | actual -> SyntaxTest.fail_ty_vis_constr ~ctxt expected actual

let test_ty_vis_abstract ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.ty_vis_abstract loc in
  match expected with
    | Syntax.TyVisAbstract vis ->
        CoreTest.assert_loc_equal ~ctxt loc vis.loc
    | actual -> SyntaxTest.fail_ty_vis_constr ~ctxt expected actual

let suite_constr_ty_vis =
  "Visibilities" >::: [
    "Read-Only" >:: test_ty_vis_readonly;
    "Abstract"  >:: test_ty_vis_abstract;
  ]

(* Types *)

let test_ty_constr ctxt =
  let loc = CoreTest.fresh_loc () in
  let name = SyntaxTest.fresh_name () in
  let expected = Syntax.ty_constr loc name in
  match expected with
    | Syntax.TyConstr ty ->
        CoreTest.assert_loc_equal ~ctxt loc ty.loc;
        SyntaxTest.assert_name_equal ~ctxt name ty.name
    | actual -> SyntaxTest.fail_ty_constr ~ctxt expected actual

let test_ty_fun ctxt =
  let loc = CoreTest.fresh_loc () in
  let param = SyntaxTest.fresh_ty_constr () in
  let res = SyntaxTest.fresh_ty_constr () in
  let expected = Syntax.ty_fun loc param res in
  match expected with
    | Syntax.TyFun ty ->
        CoreTest.assert_loc_equal ~ctxt loc ty.loc;
        SyntaxTest.assert_ty_equal ~ctxt param ty.param;
        SyntaxTest.assert_ty_equal ~ctxt res ty.res
    | actual -> SyntaxTest.fail_ty_constr ~ctxt expected actual

let test_ty_sig ctxt =
  let loc = CoreTest.fresh_loc () in
  let elems =
    let elem = SyntaxTest.fresh_sig_ty () in
    let elem' = SyntaxTest.fresh_sig_val () in
    [elem; elem']
  in
  let expected = Syntax.ty_sig loc elems in
  match expected with
    | Syntax.TySig ty ->
        CoreTest.assert_loc_equal ~ctxt loc ty.loc;
        List.iter2 (SyntaxTest.assert_sig_elem_equal ~ctxt) elems ty.elems
    | actual -> SyntaxTest.fail_ty_constr ~ctxt expected actual

let test_ty_with ctxt =
  let loc = CoreTest.fresh_loc () in
  let name = SyntaxTest.fresh_name () in
  let tys =
    let ty = SyntaxTest.fresh_ty_binding () in
    let ty' = SyntaxTest.fresh_ty_binding () in
    [ty; ty']
  in
  let expected = Syntax.ty_with loc name tys in
  match expected with
    | Syntax.TyWith ty ->
        CoreTest.assert_loc_equal ~ctxt loc ty.loc;
        SyntaxTest.assert_name_equal ~ctxt name ty.name;
        List.iter2 (SyntaxTest.assert_ty_binding_equal ~ctxt) tys ty.tys
    | actual -> SyntaxTest.fail_ty_constr ~ctxt expected actual

let suite_constr_ty_ty =
  "Types" >::: [
    "Constructors"      >:: test_ty_constr;
    "Functions"         >:: test_ty_fun;
    "Module Signatures" >:: test_ty_sig;
    "With Statements"   >:: test_ty_with;
  ]

(* Signature Elements *)

let test_sig_ty ctxt =
  let loc = CoreTest.fresh_loc () in
  let name = SyntaxTest.fresh_name () in
  let params =
    let param = SyntaxTest.fresh_mod_param () in
    let param' = SyntaxTest.fresh_mod_param () in
    [param; param']
  in
  let ty = Some (SyntaxTest.fresh_ty_constr ()) in
  let expected = Syntax.sig_ty loc name params ty in
  match expected with
    | Syntax.SigTy elem ->
        CoreTest.assert_loc_equal ~ctxt loc elem.loc;
        SyntaxTest.assert_name_equal ~ctxt name elem.name;
        List.iter2 (SyntaxTest.assert_mod_param_equal ~ctxt) params elem.params;
        CoreTest.assert_optional_equal ~ctxt "Type" (SyntaxTest.assert_ty_equal ~loc:true) ty elem.ty
    | actual -> SyntaxTest.fail_sig_elem_constr ~ctxt expected actual

let test_sig_val ctxt =
  let loc = CoreTest.fresh_loc () in
  let name = SyntaxTest.fresh_name () in
  let ty = SyntaxTest.fresh_ty_constr () in
  let expected = Syntax.sig_val loc name ty in
  match expected with
    | Syntax.SigVal elem ->
        CoreTest.assert_loc_equal ~ctxt loc elem.loc;
        SyntaxTest.assert_name_equal ~ctxt name elem.name;
        SyntaxTest.assert_ty_equal ~ctxt ty elem.ty
    | actual -> SyntaxTest.fail_sig_elem_constr ~ctxt expected actual

let test_sig_def ctxt =
  let loc = CoreTest.fresh_loc () in
  let name = SyntaxTest.fresh_name () in
  let ty = SyntaxTest.fresh_ty_fun () in
  let expected = Syntax.sig_def loc name ty in
  match expected with
    | Syntax.SigDef elem ->
        CoreTest.assert_loc_equal ~ctxt loc elem.loc;
        SyntaxTest.assert_name_equal ~ctxt name elem.name;
        SyntaxTest.assert_ty_equal ~ctxt ty elem.ty
    | actual -> SyntaxTest.fail_sig_elem_constr ~ctxt expected actual

let test_sig_mod ctxt =
  let loc = CoreTest.fresh_loc () in
  let name = SyntaxTest.fresh_name () in
  let params = 
    let param = SyntaxTest.fresh_mod_param () in
    let param' = SyntaxTest.fresh_mod_param () in
    [param; param']
  in
  let ty = SyntaxTest.fresh_ty_fun () in
  let expected = Syntax.sig_mod loc name params ty in
  match expected with
    | Syntax.SigMod elem ->
        CoreTest.assert_loc_equal ~ctxt loc elem.loc;
        SyntaxTest.assert_name_equal ~ctxt name elem.name;
        List.iter2 (SyntaxTest.assert_mod_param_equal ~ctxt) params elem.params;
        SyntaxTest.assert_ty_equal ~ctxt ty elem.ty
    | actual -> SyntaxTest.fail_sig_elem_constr ~ctxt expected actual
    
let suite_constr_sig_elem =
  "Signature Elements" >::: [
    "Types"                >:: test_sig_ty;
    "Value Bindings"       >:: test_sig_val;
    "Function Definitions" >:: test_sig_def;
    "Module Defintiions"   >:: test_sig_mod;
  ]

(* Type Bindings *)

let test_ty_binding ctxt =
  let loc = CoreTest.fresh_loc () in
  let name = SyntaxTest.fresh_name () in
  let params =
    let param = SyntaxTest.fresh_mod_param () in
    let param' = SyntaxTest.fresh_mod_param () in
    [param; param']
  in
  let vis = Some (SyntaxTest.fresh_ty_vis_readonly ()) in
  let ty = SyntaxTest.fresh_ty_constr () in
  let expected = Syntax.ty_binding loc name params vis ty in
  match expected with
    | Syntax.TyBinding binding ->
        CoreTest.assert_loc_equal ~ctxt loc binding.loc;
        SyntaxTest.assert_name_equal ~ctxt name binding.name;
        List.iter2 (SyntaxTest.assert_mod_param_equal ~ctxt) params binding.params;
        CoreTest.assert_optional_equal ~ctxt "Type visibilies" (SyntaxTest.assert_ty_vis_equal ~loc:true) vis binding.vis;
        SyntaxTest.assert_ty_equal ~ctxt ty binding.ty

let suite_constr_ty_binding = 
  "Type Bindings" >:: test_ty_binding

(* Module Parameters *)

let test_mod_param ctxt =
  let loc = CoreTest.fresh_loc () in
  let name = SyntaxTest.fresh_name () in
  let ty = Some (SyntaxTest.fresh_ty_constr ()) in
  let expected = Syntax.mod_param loc name ty in
  match expected with
    | Syntax.ModParam param ->
        CoreTest.assert_loc_equal ~ctxt loc param.loc;
        SyntaxTest.assert_name_equal ~ctxt name param.name;
        CoreTest.assert_optional_equal ~ctxt "Parameter type" (SyntaxTest.assert_ty_equal ~loc:true) ty param.ty

let suite_constr_mod_param =
  "Module Parameters" >:: test_mod_param

let suite_constr_ty =
  "Types" >::: [
    suite_constr_ty_vis;
    suite_constr_ty_ty;
    suite_constr_sig_elem;
    suite_constr_ty_binding;
    suite_constr_mod_param;
  ]

(* Primitive Operations *)

(* Unary Operators *)

let test_un_neg ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.un_neg loc in
  match expected with
    | Syntax.UnNeg op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_un_constr ~ctxt expected actual

let test_un_lnot ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.un_lnot loc in
  match expected with
    | Syntax.UnLNot op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_un_constr ~ctxt expected actual

let test_un_bnot ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.un_bnot loc in
  match expected with
    | Syntax.UnBNot op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_un_constr ~ctxt expected actual
            
let suite_constr_un =
  "Unary" >::: [
    "Negation"    >:: test_un_neg;
    "Logical" >::: [
      "NOT" >:: test_un_lnot;
    ];
    "Bitwise" >::: [
      "NOT" >:: test_un_bnot;
    ];
  ]

(* Binary Operators *)

let test_bin_add ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_add loc in
  match expected with
    | Syntax.BinAdd op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_sub ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_sub loc in
  match expected with
    | Syntax.BinSub op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_mul ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_mul loc in
  match expected with
    | Syntax.BinMul op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_div ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_div loc in
  match expected with
    | Syntax.BinDiv op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_mod ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_mod loc in
  match expected with
    | Syntax.BinMod op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_land ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_land loc in
  match expected with
    | Syntax.BinLAnd op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_lor ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_lor loc in
  match expected with
    | Syntax.BinLOr op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_band ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_band loc in
  match expected with
    | Syntax.BinBAnd op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_bor ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_bor loc in
  match expected with
    | Syntax.BinBOr op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_bxor ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_bxor loc in
  match expected with
    | Syntax.BinBXor op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_ssl ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_ssl loc in
  match expected with
    | Syntax.BinSsl op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_ssr ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_ssr loc in
  match expected with
    | Syntax.BinSsr op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_usl ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_usl loc in
  match expected with
    | Syntax.BinUsl op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_usr ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_usr loc in
  match expected with
    | Syntax.BinUsr op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_seq ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_seq loc in
  match expected with
    | Syntax.BinSeq op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_peq ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_peq loc in
  match expected with
    | Syntax.BinPeq op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_sneq ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_sneq loc in
  match expected with
    | Syntax.BinSneq op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_pneq ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_pneq loc in
  match expected with
    | Syntax.BinPneq op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_lte ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_lte loc in
  match expected with
    | Syntax.BinLte op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_lt ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_lt loc in
  match expected with
    | Syntax.BinLt op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_gte ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_gte loc in
  match expected with
    | Syntax.BinGte op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_gt ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_gt loc in
  match expected with
    | Syntax.BinGt op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual

let test_bin_rfa ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.bin_rfa loc in
  match expected with
    | Syntax.BinRfa op -> CoreTest.assert_loc_equal ~ctxt loc op.loc
    | actual -> SyntaxTest.fail_bin_constr ~ctxt expected actual
        
let suite_constr_bin =
  "Binary" >::: [
    "Arithmetic" >::: [
      "Addition"       >:: test_bin_add;
      "Subtraction"    >:: test_bin_sub;
      "Multiplication" >:: test_bin_mul;
      "Division"       >:: test_bin_div;
      "Modulus"        >:: test_bin_mod;
    ];
    "Logical" >::: [
      "AND" >:: test_bin_land;
      "OR"  >:: test_bin_lor;
    ];
    "Bitwise" >::: [
      "AND" >:: test_bin_band;
      "OR"  >:: test_bin_bor;
      "XOR" >:: test_bin_bxor;
    ];
    "Shifts" >::: [
      "Signed" >::: [
        "Left"  >:: test_bin_ssl;
        "Right" >:: test_bin_ssr;
      ];
      "Unsigned" >::: [
        "Left"  >:: test_bin_usl;
        "Right" >:: test_bin_usr;
      ];
    ];
    "Equality" >::: [
      "Structural" >:: test_bin_seq;
      "Physical"   >:: test_bin_peq;
      "Inequality" >::: [
        "Structural" >:: test_bin_sneq;
        "Physical"   >:: test_bin_pneq;
      ];
    ];
    "Comparison" >::: [
      "Less Than or Equal"    >:: test_bin_lte;
      "Less Than"             >:: test_bin_lt;
      "Greater Than or Equal" >:: test_bin_gte;
      "Greater Than"          >:: test_bin_gt;
    ];
    "Reverse Function Application" >:: test_bin_rfa
  ]

let suite_constr_op =
  "Operators" >::: [
    suite_constr_un;
    suite_constr_bin;
  ]

let suite_constr_prim =
  "Primitive Operations" >::: [
    suite_constr_op;
  ]

(* Patterns *)

let test_patt_ground ctxt =
  let loc = CoreTest.fresh_loc () in
  let expected = Syntax.patt_ground loc in
  match expected with
    | Syntax.PattGround patt -> CoreTest.assert_loc_equal ~ctxt loc patt.loc
    | actual -> SyntaxTest.fail_patt_constr ~ctxt expected actual

let test_patt_bool ctxt =
  let loc = CoreTest.fresh_loc () in
  let value = true in
  let expected = Syntax.patt_bool loc value in
  match expected with
    | Syntax.PattBool patt ->
        CoreTest.assert_loc_equal ~ctxt loc patt.loc;
        assert_equal ~ctxt ~msg:"Boolean literals are not equal" ~printer:string_of_bool value patt.value
    | actual -> SyntaxTest.fail_patt_constr ~ctxt expected actual

let test_patt_int ctxt =
  let loc = CoreTest.fresh_loc () in
  let lexeme = "42" in
  let expected = Syntax.patt_int loc lexeme in
  match expected with
    | Syntax.PattInt patt ->
        CoreTest.assert_loc_equal ~ctxt loc patt.loc;
        assert_equal ~ctxt ~msg:"Integer lexemes are not equal" ~printer:Fun.id lexeme patt.lexeme
    | actual -> SyntaxTest.fail_patt_constr ~ctxt expected actual

let test_patt_var ctxt =
  let loc = CoreTest.fresh_loc () in
  let lexeme = "x" in
  let expected = Syntax.patt_var loc lexeme in
  match expected with
    | Syntax.PattVar patt ->
        CoreTest.assert_loc_equal ~ctxt loc patt.loc;
        assert_equal ~ctxt ~msg:"Variable lexemes are not equal" ~printer:Fun.id lexeme patt.lexeme
    | actual -> SyntaxTest.fail_patt_constr ~ctxt expected actual

let test_patt_fun ctxt =
  let loc = CoreTest.fresh_loc () in
  let name = SyntaxTest.fresh_name () in
  let params =
    let param = SyntaxTest.fresh_param () in
    let param' = SyntaxTest.fresh_param () in
    [param; param']
  in
  let expected = Syntax.patt_fun loc name params in
  match expected with
    | Syntax.PattFun patt ->
        CoreTest.assert_loc_equal ~ctxt loc patt.loc;
        SyntaxTest.assert_name_equal ~ctxt name patt.name;
        List.iter2 (SyntaxTest.assert_param_equal ~ctxt) params patt.params
    | actual -> SyntaxTest.fail_patt_constr ~ctxt expected actual

let suite_constr_patt =
  "Patterns" >::: [
    "Ground" >:: test_patt_ground;
    "Literal" >::: [
      "Booleans" >:: test_patt_bool;
      "Integers" >:: test_patt_int;
    ];
    "Variables" >:: test_patt_var;
    "Functions" >:: test_patt_fun;
  ]

(* Parameters *)

let test_param ctxt =
  let loc = CoreTest.fresh_loc () in
  let patt = SyntaxTest.fresh_patt_ground () in
  let ty = Some (SyntaxTest.fresh_ty_constr ()) in
  let expected = Syntax.param loc patt ty in
  match expected with
    | Syntax.Param param ->
        CoreTest.assert_loc_equal ~ctxt loc param.loc;
        SyntaxTest.assert_patt_equal ~ctxt patt param.patt;
        CoreTest.assert_optional_equal ~ctxt "Parameter types" (SyntaxTest.assert_ty_equal ~loc:true) ty param.ty

let suite_constr_param =
  "Parameters" >:: test_param

(* Expressions *)

let test_expr_bool ctxt =
  let loc = CoreTest.fresh_loc () in
  let value = true in
  let expected = Syntax.expr_bool loc value in
  match expected with
    | Syntax.ExprBool expr ->
        CoreTest.assert_loc_equal ~ctxt loc expr.loc;
        assert_equal ~ctxt ~msg:"Boolean literal values are not equal" ~printer:string_of_bool value expr.value
    | actual -> SyntaxTest.fail_expr_constr ~ctxt expected actual

let test_expr_int ctxt =
  let loc = CoreTest.fresh_loc () in
  let lexeme = "42" in
  let expected = Syntax.expr_int loc lexeme in
  match expected with
    | Syntax.ExprInt expr ->
        CoreTest.assert_loc_equal ~ctxt loc expr.loc;
        assert_equal ~ctxt ~msg:"Integer literal lexemes are not equal" ~printer:Fun.id lexeme expr.lexeme
    | actual -> SyntaxTest.fail_expr_constr ~ctxt expected actual

let test_expr_id ctxt =
  let loc = CoreTest.fresh_loc () in
  let name = SyntaxTest.fresh_name () in
  let expected = Syntax.expr_id loc name in
  match expected with
    | Syntax.ExprId expr ->
        CoreTest.assert_loc_equal ~ctxt loc expr.loc;
        SyntaxTest.assert_name_equal ~ctxt name expr.name
    | actual -> SyntaxTest.fail_expr_constr ~ctxt expected actual

let test_expr_un ctxt =
  let loc = CoreTest.fresh_loc () in
  let op = SyntaxTest.fresh_un_neg () in
  let operand = SyntaxTest.fresh_expr_int () in
  let expected = Syntax.expr_un loc op operand in
  match expected with
    | Syntax.ExprUn expr ->
        CoreTest.assert_loc_equal ~ctxt loc expr.loc;
        SyntaxTest.assert_un_equal ~ctxt op expr.op;
        SyntaxTest.assert_expr_equal ~ctxt operand expr.operand
    | actual -> SyntaxTest.fail_expr_constr ~ctxt expected actual

let test_expr_bin ctxt =
  let loc = CoreTest.fresh_loc () in
  let op = SyntaxTest.fresh_bin_add () in
  let lhs = SyntaxTest.fresh_expr_int () in
  let rhs = SyntaxTest.fresh_expr_int () in
  let expected = Syntax.expr_bin loc op lhs rhs in
  match expected with
    | Syntax.ExprBin expr ->
        CoreTest.assert_loc_equal ~ctxt loc expr.loc;
        SyntaxTest.assert_bin_equal ~ctxt op expr.op;
        SyntaxTest.assert_expr_equal ~ctxt lhs expr.lhs;
        SyntaxTest.assert_expr_equal ~ctxt rhs expr.rhs
    | actual -> SyntaxTest.fail_expr_constr ~ctxt expected actual

let test_expr_cond ctxt =
  let loc = CoreTest.fresh_loc () in
  let cond = SyntaxTest.fresh_expr_bool () in
  let tru = SyntaxTest.fresh_expr_int () in
  let fls = SyntaxTest.fresh_expr_int () in
  let expected = Syntax.expr_cond loc cond tru fls in
  match expected with
    | Syntax.ExprCond expr ->
        CoreTest.assert_loc_equal ~ctxt loc expr.loc;
        SyntaxTest.assert_expr_equal ~ctxt cond expr.cond;
        SyntaxTest.assert_expr_equal ~ctxt tru expr.tru;
        SyntaxTest.assert_expr_equal ~ctxt fls expr.fls
    | actual -> SyntaxTest.fail_expr_constr ~ctxt expected actual

let test_expr_let ctxt =
  let loc = CoreTest.fresh_loc () in
  let recur = true in
  let bindings =
    let binding = SyntaxTest.fresh_binding () in
    let binding' = SyntaxTest.fresh_binding () in
    [binding; binding']
  in
  let scope = SyntaxTest.fresh_expr_int () in
  let expected = Syntax.expr_let loc recur bindings scope in
  match expected with
    | Syntax.ExprLet expr ->
        CoreTest.assert_loc_equal ~ctxt loc expr.loc;
        assert_equal ~ctxt ~msg:"Recursive markings are not equal" ~printer:string_of_bool recur expr.recur;
        List.iter2 (SyntaxTest.assert_binding_equal ~ctxt) bindings expr.bindings;
        SyntaxTest.assert_expr_equal ~ctxt scope expr.scope
    | actual -> SyntaxTest.fail_expr_constr ~ctxt expected actual

let test_expr_abs ctxt =
  let loc = CoreTest.fresh_loc () in
  let params = 
    let param = SyntaxTest.fresh_param () in
    let param' = SyntaxTest.fresh_param () in
    [param; param']
  in
  let ret = Some (SyntaxTest.fresh_ty_constr ()) in
  let body = SyntaxTest.fresh_expr_int () in
  let expected = Syntax.expr_abs loc params ret body in
  match expected with
    | Syntax.ExprAbs expr ->
        CoreTest.assert_loc_equal ~ctxt loc expr.loc;
        List.iter2 (SyntaxTest.assert_param_equal ~ctxt) params expr.params;
        CoreTest.assert_optional_equal ~ctxt "Return type" (SyntaxTest.assert_ty_equal ~loc:true) ret expr.ret;
        SyntaxTest.assert_expr_equal ~ctxt body expr.body
    | actual -> SyntaxTest.fail_expr_constr ~ctxt expected actual

let test_expr_app ctxt =
  let loc = CoreTest.fresh_loc () in
  let fn = SyntaxTest.fresh_expr_abs () in
  let args =
    let arg = SyntaxTest.fresh_expr_int () in
    let arg' = SyntaxTest.fresh_expr_bool () in
    [arg; arg']
  in
  let expected = Syntax.expr_app loc fn args in
  match expected with
    | Syntax.ExprApp expr ->
        CoreTest.assert_loc_equal ~ctxt loc expr.loc;
        SyntaxTest.assert_expr_equal ~ctxt fn expr.fn;
        List.iter2 (SyntaxTest.assert_expr_equal ~ctxt) args expr.args
    | actual -> SyntaxTest.fail_expr_constr ~ctxt expected actual

let suite_constr_expr =
  "Expressions" >::: [
    "Literals" >::: [
      "Booleans" >:: test_expr_bool;
      "Integers" >:: test_expr_int;
    ];
    "Identifiers" >:: test_expr_id;
    "Primitive Operations" >::: [
      "Operators" >::: [
        "Unary"  >:: test_expr_un;
        "Binary" >:: test_expr_bin;
      ];
    ];
    "Conditionals"   >:: test_expr_cond;
    "Value Bindings" >:: test_expr_let;
    "Functions" >::: [
      "Abstraction" >:: test_expr_abs;
      "Application" >:: test_expr_app;
    ];
  ]

(* Bindings *)

let test_binding ctxt =
  let loc = CoreTest.fresh_loc () in
  let patt = SyntaxTest.fresh_patt_ground () in
  let ty = Some (SyntaxTest.fresh_ty_constr ()) in
  let value = SyntaxTest.fresh_expr_int () in
  let expected = Syntax.binding loc patt ty value in
  match expected with
    | Syntax.Binding binding ->
        CoreTest.assert_loc_equal ~ctxt loc binding.loc;
        SyntaxTest.assert_patt_equal ~ctxt patt binding.patt;
        CoreTest.assert_optional_equal ~ctxt "Parameter type" (SyntaxTest.assert_ty_equal ~loc:true) ty binding.ty;
        SyntaxTest.assert_expr_equal ~ctxt value binding.value

let suite_constr_binding =
  "Bindings" >:: test_binding

(* Package Statements *)

let test_pkg_library ctxt =
  let loc = CoreTest.fresh_loc () in
  let name = SyntaxTest.fresh_name () in
  let expected = Syntax.pkg_library loc name in
  match expected with
    | Syntax.Library pkg ->
        CoreTest.assert_loc_equal ~ctxt loc pkg.loc;
        SyntaxTest.assert_name_equal ~ctxt name pkg.name
    | actual -> SyntaxTest.fail_pkg_constr ~ctxt expected actual

let test_pkg_executable ctxt =
  let loc = CoreTest.fresh_loc () in
  let name = SyntaxTest.fresh_name () in
  let expected = Syntax.pkg_executable loc name in
  match expected with
    | Syntax.Executable pkg ->
        CoreTest.assert_loc_equal ~ctxt loc pkg.loc;
        SyntaxTest.assert_name_equal ~ctxt name pkg.name
    | actual -> SyntaxTest.fail_pkg_constr ~ctxt expected actual

let suite_constr_pkg =
  "Package Statements" >::: [
    "Libraries"   >:: test_pkg_library;
    "Executables" >:: test_pkg_executable;
  ]

(* Imports *)

let test_path ctxt =
  let loc = CoreTest.fresh_loc () in
  let pkgpath = "path/to/package" in
  let expected = Syntax.path loc pkgpath in
  match expected with
    | Syntax.Path path ->
        CoreTest.assert_loc_equal ~ctxt loc path.loc;
        assert_equal ~ctxt ~msg:"Package paths are not equal" ~printer:Fun.id pkgpath path.path

let test_alias ctxt =
  let loc = CoreTest.fresh_loc () in
  let local = Some (SyntaxTest.fresh_name ()) in
  let path = SyntaxTest.fresh_path () in
  let expected = Syntax.alias loc local path in
  match expected with
    | Syntax.Alias alias ->
        CoreTest.assert_loc_equal ~ctxt loc alias.loc;
        CoreTest.assert_optional_equal ~ctxt "Local alias" (SyntaxTest.assert_name_equal ~loc:true) local alias.alias;
        SyntaxTest.assert_path_equal ~ctxt path alias.path

let test_pkgs ctxt =
  let loc = CoreTest.fresh_loc () in
  let aliases = 
    let alias = SyntaxTest.fresh_alias () in
    let alias' = SyntaxTest.fresh_alias () in
    [alias; alias']
  in
  let expected = Syntax.pkgs loc aliases in
  match expected with
    | Syntax.Packages pkgs ->
        CoreTest.assert_loc_equal ~ctxt loc pkgs.loc;
        List.iter2 (SyntaxTest.assert_alias_equal ~ctxt) aliases pkgs.aliases

let test_import ctxt =
  let loc = CoreTest.fresh_loc () in
  let pkgs =
    let aliases = 
      let alias = SyntaxTest.fresh_alias () in
      let alias' = SyntaxTest.fresh_alias () in
      [alias; alias']
    in  
    SyntaxTest.fresh_pkgs ~aliases ()
  in
  let expected = Syntax.import loc pkgs in
  match expected with
    | Syntax.Import import ->
        CoreTest.assert_loc_equal ~ctxt loc import.loc;
        SyntaxTest.assert_pkgs_equal ~ctxt pkgs import.pkgs
        
let suite_constr_import =
  "Imports" >::: [
    "Package Paths"       >:: test_path;
    "Local Aliases"       >:: test_alias;
    "Package Alias Lists" >:: test_pkgs;
    "Imports"             >:: test_import;
  ]

(* Top-Level Bindings *)

let test_top_ty ctxt =
  let loc = CoreTest.fresh_loc () in
  let local = true in
  let bindings =
    let binding = SyntaxTest.fresh_ty_binding () in
    let binding' = SyntaxTest.fresh_ty_binding () in
    [binding; binding']
  in
  let expected = Syntax.top_ty loc local bindings in
  match expected with
    | Syntax.TopTy top ->
        CoreTest.assert_loc_equal ~ctxt loc top.loc;
        assert_equal ~ctxt ~msg:"Local markings are not equal" ~printer:string_of_bool local top.local;
        List.iter2 (SyntaxTest.assert_ty_binding_equal ~ctxt) bindings top.bindings
    | actual -> SyntaxTest.fail_top_constr ~ctxt expected actual

let test_top_val ctxt =
  let loc = CoreTest.fresh_loc () in
  let binding = SyntaxTest.fresh_binding () in
  let expected = Syntax.top_val loc binding in
  match expected with
    | Syntax.TopVal top ->
        CoreTest.assert_loc_equal ~ctxt loc top.loc;
        SyntaxTest.assert_binding_equal ~ctxt binding top.binding
    | actual -> SyntaxTest.fail_top_constr ~ctxt expected actual

let test_top_def ctxt =
  let loc = CoreTest.fresh_loc () in
  let binding = SyntaxTest.fresh_binding () in
  let expected = Syntax.top_def loc binding in
  match expected with
    | Syntax.TopDef top ->
        CoreTest.assert_loc_equal ~ctxt loc top.loc;
        SyntaxTest.assert_binding_equal ~ctxt binding top.binding
    | actual -> SyntaxTest.fail_top_constr ~ctxt expected actual

let test_top_let ctxt =
  let loc = CoreTest.fresh_loc () in
  let recur = true in
  let bindings =
    let binding = SyntaxTest.fresh_binding () in
    let binding' = SyntaxTest.fresh_binding () in
    [binding; binding']
  in
  let expected = Syntax.top_let loc recur bindings in
  match expected with
    | Syntax.TopLet top ->
        CoreTest.assert_loc_equal ~ctxt loc top.loc;
        assert_equal ~ctxt ~msg:"Recursive markings are not equal" ~printer:string_of_bool recur top.recur;
        List.iter2 (SyntaxTest.assert_binding_equal ~ctxt) bindings top.bindings
    | actual -> SyntaxTest.fail_top_constr ~ctxt expected actual

let test_top_mod ctxt =
  let loc = CoreTest.fresh_loc () in
  let name = SyntaxTest.fresh_name () in
  let params =
    let param = SyntaxTest.fresh_mod_param () in
    let param' = SyntaxTest.fresh_mod_param () in
    [param; param']
  in
  let elems =
    let elem = SyntaxTest.fresh_top_val () in
    let elem' = SyntaxTest.fresh_top_def () in
    [elem; elem']
  in
  let expected = Syntax.top_mod loc name params elems in
  match expected with
    | Syntax.TopMod top ->
        CoreTest.assert_loc_equal ~ctxt loc top.loc;
        SyntaxTest.assert_name_equal ~ctxt name top.name;
        List.iter2 (SyntaxTest.assert_mod_param_equal ~ctxt) params top.params;
        List.iter2 (SyntaxTest.assert_top_equal ~ctxt) elems top.elems
    | actual -> SyntaxTest.fail_top_constr ~ctxt expected actual


let suite_constr_top =
  "Top-Level Bindings" >::: [
    "Type Bindings"        >:: test_top_ty;
    "Value Bindings"       >:: test_top_val;
    "Function Definitions" >:: test_top_def;
    "Local Bindings"       >:: test_top_let;
    "Module Bindings"      >:: test_top_mod;
  ]

(* Files *)

let test_file ctxt =
  let loc = CoreTest.fresh_loc () in
  let pkg = SyntaxTest.fresh_pkg_library () in
  let imports =
    let import = SyntaxTest.fresh_import () in
    let import' = SyntaxTest.fresh_import () in
    [import; import']
  in
  let tops = 
    let top = SyntaxTest.fresh_top_val () in
    let top' = SyntaxTest.fresh_top_def () in
    [top; top']
  in
  let expected = Syntax.file loc pkg imports tops in
  match expected with
    | Syntax.File file ->
        CoreTest.assert_loc_equal ~ctxt loc file.loc;
        SyntaxTest.assert_pkg_equal ~ctxt pkg file.pkg;
        List.iter2 (SyntaxTest.assert_import_equal ~ctxt) imports file.imports;
        List.iter2 (SyntaxTest.assert_top_equal ~ctxt) tops file.tops

let suite_constr_file =
  "Files" >:: test_file

let suite_constr =
  "Constructors" >::: [
    suite_constr_name;
    suite_constr_ty;
    suite_constr_prim;
    suite_constr_patt;
    suite_constr_param;
    suite_constr_expr;
    suite_constr_binding;
    suite_constr_pkg;
    suite_constr_import;
    suite_constr_top;
    suite_constr_file;
  ]

(* Suite *)

let suite =
  "Abstract Syntax" >::: [
    suite_constr;
  ]
