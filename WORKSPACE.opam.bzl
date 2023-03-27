## generated file - DO NOT EDIT

def bootstrap():
    native.local_repository(
        name       = "astring",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/astring",
    )

    native.local_repository(
        name       = "bigarray",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/bigarray",
    )

    native.local_repository(
        name       = "bos",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/bos",
    )

    native.local_repository(
        name       = "bytes",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/bytes",
    )

    native.local_repository(
        name       = "cmdliner",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/cmdliner",
    )

    native.local_repository(
        name       = "compiler-libs",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/compiler-libs",
    )

    native.local_repository(
        name       = "dune",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/dune",
    )

    native.local_repository(
        name       = "dune-configurator",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/dune-configurator",
    )

    native.local_repository(
        name       = "dynlink",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/dynlink",
    )

    native.local_repository(
        name       = "findlib",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/findlib",
    )

    native.local_repository(
        name       = "fpath",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/fpath",
    )

    native.local_repository(
        name       = "menhir",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/menhir",
    )

    native.local_repository(
        name       = "menhirLib",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/menhirLib",
    )

    native.local_repository(
        name       = "menhirSdk",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/menhirSdk",
    )

    native.local_repository(
        name       = "ocaml",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/ocaml",
    )

    native.local_repository(
        name       = "ocamlbuild",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/ocamlbuild",
    )

    native.local_repository(
        name       = "ocamldoc",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/ocamldoc",
    )

    native.local_repository(
        name       = "opam-format",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/opam-format",
    )

    native.local_repository(
        name       = "ounit2",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/ounit2",
    )

    native.local_repository(
        name       = "seq",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/seq",
    )

    native.local_repository(
        name       = "stdlib",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/stdlib",
    )

    native.local_repository(
        name       = "stdlib-shims",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/stdlib-shims",
    )

    native.local_repository(
        name       = "str",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/str",
    )

    native.local_repository(
        name       = "stublibs",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/stublibs",
    )

    native.local_repository(
        name       = "threads",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/threads",
    )

    native.local_repository(
        name       = "topkg",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/topkg",
    )

    native.local_repository(
        name       = "toplevel",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/toplevel",
    )

    native.local_repository(
        name       = "unix",
        path       = "/Users/jonathan/projects/pucc/_opam/lib/unix",
    )

    native.register_toolchains("@ocaml//toolchain/selectors/local:vmvm")
    native.register_toolchains("@ocaml//toolchain/selectors/local:vmsys")
    native.register_toolchains("@ocaml//toolchain/selectors/local:sysvm")
    native.register_toolchains("@ocaml//toolchain/selectors/local:syssys")
    native.register_toolchains("@ocaml//toolchain/selectors/local:_vm")
    native.register_toolchains("@ocaml//toolchain/selectors/local:__")
    native.register_toolchains("@ocaml//toolchain/profiles:sys-dev")
    native.register_toolchains("@ocaml//toolchain/profiles:sys-dbg")
    native.register_toolchains("@ocaml//toolchain/profiles:sys-opt")
    native.register_toolchains("@ocaml//toolchain/profiles:vm-dev")
    native.register_toolchains("@ocaml//toolchain/profiles:vm-dbg")
    native.register_toolchains("@ocaml//toolchain/profiles:vm-opt")
    native.register_toolchains("@ocaml//toolchain/profiles:default-dev")
    native.register_toolchains("@ocaml//toolchain/profiles:default-dbg")
    native.register_toolchains("@ocaml//toolchain/profiles:default-opt")
