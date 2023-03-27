PU/CC
===

PU/CC is a CPU for functional languages compiled for stackless execution with Continuation Passing Style and a language compiling to that CPU.

The CPU is simple, 5-stage scalar RISC pipeline based on the RISC-V ISA, but with three novel changes:

* A scratchpad memory has been added and the [closure conversion algorithm](https://flint.cs.yale.edu/flint/publications/escc.pdf) has been extended to use it.
* Flow control has been moved from being individual instructions to being a function header and branching has been moved into a dedicated component.
* Automated garbage collection has been implemented in hardware

The language is a Go-flavored dialect of ML.

Building
---

The codebase is written in a variety of languages:

* The CPU is written SystemVerilog
* The CPU tests are written in C++
* The bootstrap PU/CC compiler is written in OCaml
* The main PU/CC compiler and its supporting libraries and utilities are written in PU/CC

In order build all this in a single build system, [Bazel](https://bazel.build/) was chosen.

### Dependencies

To get started, You need to install a few packages using yor favorite package manager:

* Bazil - Build System
* OPAM - OCaml Package Manager

Once you install those, you need to install all of the OCaml dependencies for the bootstrap compiler.  In the root of this repo, run:

```bash
# Refresh your package list
opam update

# Install all packages into a local OPAM switch.  This will take a while
# because it has to build the full OCaml compiler and then install all of the
# packages.
opam switch import .obazl.d/opam/local.manifest --switch .

# Sync Bazel with OPAM
bazel run @opam//local:refresh
```

### Building

Then just use Bazel to build all the things and run all the tests:

```bash
# Build everything
bazel build //...

# Test Everything
bazel test //...
```

Sources
---

The sources include:

* `bootstrap` - The bootstrap PU/CC compiler, written in OCaml

There are also a few libraries and programs written in PU/CC that are compiled with the bootstrap compiler and can be run on the generated PU/CC CPU:

* `lex` - A Lexical analyzer generator
* `yacc` - A LR(1) parser generator
* `punit` - A xUnit test framework
* `cmdline` - A command-line arguments parsing library
* `puccc` - An optimizing PU/CC compiler