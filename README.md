PU/CC
===

PU/CC is:

* A softcore CPU designed for pure functional languages compiled for stackless execution with Continuation Passing Style (CPS)
* A pure functional language compiled for stackless execution with CPS that targets that softcore CPU
* An incomplete work in progress :)

CPU
---

The core CPU is a typical 5-stage scalar RISC pipeline based on the RISC-V ISA.  Instead of extending the primary computational pipeline, PU/CC introduces a few novel extensions around this standard core:

1. Flow control (jumps and branches) has been moved from being individual instructions in the main instruction stream to a combination of a function header and tagged ALU/Load instructions.  Branching logic has been moved into a dedicated pipeline Flow Control stage (`FC`) containing the PC.  This stage is placed before Instruction Fetch, effectively extending the pipeline "backwards".  The instruction cache is also bifurcated into non-flow control and flow control caches.  A specific compiler optimization has been implemented to take advantage of this configuration and largely obviate the need for branch prediction.
1. Generational garbage collection has been implemented in hardware and integrated into the virtual memory system.
1. A scratchpad memory has been added and the [closure conversion algorithm](https://flint.cs.yale.edu/flint/publications/escc.pdf) has been extended to use it automatically with no user intervention.
1. A L4-inspired microkernel has been implemented in hardware and controls thread and process scheduling as well as IPC using [CML](http://cml.cs.uchicago.edu/)-like channels.  It is implemented by further extending the pipeline backwards with new Threading (`TH`) and Process (`PR`) management stages.  In simulations (though not on real hardware) this microkernel has been given a dedicated RAM, Flash based "swap", and separate virtual memory to offload the functioning of the microkernel onto its own dedicated, isolated hardware resources.

A second, straight RISC-V implementation has been included so it can be used as a baseline for comparison against PU/CC.  Both CPUs have been verified to work on [Xilinx Artix-7 100T FPGAs](https://www.xilinx.com/products/silicon-devices/fpga/artix-7.html), specifically on the [Alchitry Au+](https://www.sparkfun.com/products/17514) and [Digilent Arty 7](https://digilent.com/shop/arty-a7-100t-artix-7-fpga-development-board/) boards.

Language
---

The language is a Go-flavored dialect of the pure core of ML that can target both PU/CC and RISC-V.

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

* `cores` - A library of shared cores for building and testing softcore CPUs.
* `riscv` - A straight RISC-V softcore CPU to serve as a baseline for comparison against PU/CC
* `pucc` - The PU/CC softcore CPU

Software
---

Only one thing is written in OCaml:

* `bootstrap` - An unoptimizing bootstrap PU/CC compiler, executable on non-PU/CC architectures (anything that OCaml can run on, such as x86_64, ARM, etc.) and generating either vanilla RISC-V or PU/CC executables.

The rest of the sources are a few libraries and programs written in PU/CC that are compiled with the bootstrap compiler and can be run on both the RISC-V and PU/CC softcore CPUs:

* `lex` - A Lexical analyzer generator
* `yacc` - A LR(1) parser generator, augmented with some of the niceties of Menhir
* `punit` - A xUnit test framework
* `cmdline` - A command-line arguments parsing library
* `format` - A formatting library based on OCaml's `Format` module
* `pu/cc` - A self-hosted, optimizing PU/CC compiler

Other
---

There are a few miscelaneous sources:

* `rules` - Bazel build rules used to make the `BUILD.bazel` files cleaner
