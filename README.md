PU/CC
===

PU/CC is a CPU for functional languages compiled for stackless execution with Continuation Passing Style and a language compiling to that CPU.

The CPU is simple, 5-stage scalar RISC pipeline based on the RISC-V ISA, but with three novel changes:

* A scratchpad memory has been added and the [closure conversion algorithm](https://flint.cs.yale.edu/flint/publications/escc.pdf) has been extended to use it.
* Flow control has been moved from being individual instructions to being a function header and branching has been moved into a dedicated component.
* Automated garbage collection has been implemented in hardware

The language is a Go-flavored dialect of ML.

Building
===

The codebase is written in a variety of languages:

* The CPU is written SystemVerilog
* The CPU tests are written in C++
* The bootstrap PU/CC compiler is written in OCaml
* The main PU/CC compiler and its supporting libraries and utilities are written in PU/CC

In order build all this in a single build system, [Bazel](https://bazel.build/) was chosen.

Dependencies
---

To get started, You need to install a few packages using your favorite package manager:

* Bazil - Build System
* OPAM - OCaml Package Manager

On MacOS, you can install these with [Homebrew](https://brew.sh/):

```bash
# Install Bazelisk (Bazel version manager) and OPAM
brew install bazelisk opam

# Initialize OPAM
opam init
```

Once you install those, you need to install all of the OCaml dependencies for the bootstrap compiler.  In the root of this repo, run:

```bash
# Refresh your package list
opam update

# Install all packages into a local OPAM switch.  This will take a while
# because it has to build the full OCaml compiler from source and then install
# all of the dependency packages, also from source.
opam switch import .obazl.d/opam/local.manifest --switch .

# Sync Bazel with OPAM
bazel run @obazl//coswitch
```

Building
---

Then just use Bazel to build all the things and run all the tests:

```bash
# Build everything
bazel build //...

# Test Everything
bazel test //...
```

### A Note on Build and Test Times

While this is fully automated, it is *not* speedy.

All of the hardware tests use [Verilator](https://www.veripool.org/verilator/), which is a software simulator for hardware.  It compiles a top-level SystemVerilog `module` to a heavily optimized C++ simulator and is compiled with a high optimizer setting.  Compilation is slow and memory intensive.  And because each test suite is a separate top-level SystemVerilog `module`, there's a *lot* of compilation to do.

Execution is also slow.  When going full throttle and using all available CPU cores, it emulates what is a 100MHz clock on hardware at about 25kHz, which is about 0.025% (or 1/4,000-th) of real-time.  And most of the tests are not going *anywhere close* to full throttle.

Despite all of this, Verilator is still the fastest simulator out there which is why I'm using it.

Sources
===

There are both Hardware and Software sources.  All follow the general pattern that tests are kept in-line with the sources they are testing but are built separately.

Hardware
---

All of the hardware sources are written in SystemVerilog, and tested in C++ using Verilator and GoogleTest.

* `hdub` - A library of shared cores for building and testing softcore CPUs.
* `riscv` - A straight RISC-V softcore CPU to serve as a baseline for comparison against PU/CC
* `pucc` - The PU/CC softcore CPU

Software
---

Only one thing is written in OCaml:

* `bootstrap` - The bootstrap PU/CC compiler

The rest of the sources are a few libraries and programs written in PU/CC that are compiled with the bootstrap compiler and can be run on both the RISC-V and PU/CC CPUs:

* `lex` - A Lexical analyzer generator
* `yacc` - A LR(1) parser generator, augmented with some of the niceties of Menhir
* `punit` - A xUnit test framework
* `cmdline` - A command-line arguments parsing library
* `format` - A formatting library based on OCaml's `Format` module
* `pu/cc` - A self-hosted optimizing PU/CC compiler

Other
---

There are a few miscelaneous sources:

* `rules` - Bazel build rules used to make the `BUILD.bazel` files cleaner
