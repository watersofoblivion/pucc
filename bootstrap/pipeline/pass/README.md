Passes
===

The various passes in the PU/CC compiler.

* **Parse** - Parse the concrete syntax into the abstract syntax
* **Desug** - Desugar the abstract syntax into the annotated syntax
* **Norm** - Normalize the annotated syntax into A-Normal form
* **Monomorph** - Monomorphize the A-Normal form
* **Kont** - CPS convert the Monomorphized A-Normal form 
* **Close** - Closure convert the CPS form into Closure Passing Style
* **Flatten** - Flatten the closure passing style into Static Single-Assignment form

The following passes have one version each for the various PU/CC assembly languages:

* **Codegen** - Generate assembly language from the SSA form 
* **Link** - Link the assembly language into a PU/CC executable