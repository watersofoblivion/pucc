Languages
===

This contains all of the internal languages used by the compiler.

* **Syntax** - Abstract Syntax
* **Annot** - Desugared Syntax
* **Ir** - A-Normal Form
* **Mono** - Monomorphic A-Normal Form
* **Cps** - Continuation Passing Style
* **Clo** - Closure Passing Style
* **Ssa** - Static Single Assignment
* **Asm** - Assembly Languages for various flavors of PU/CC.  They are:
  * **RiscV** - Bare RISC-V Assembly

Each language module contains a few common functions:

* **Constructors** for constructing values in the language
* A **Pretty Printer** for displaying the language in a human-readable form
