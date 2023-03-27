# OCaml helpers

load("@rules_ocaml//build:rules.bzl", "ocaml_module", "ocaml_test")

def ocaml_package(name,
                  label,
                  modules = [],
                  deps = [],
                  test_deps = [],
                  suite_deps = [],
                  visibility = ["//visibility:public"]):

    real_src_deps = []
    real_src_deps.extend(deps)

    real_test_deps = ["@ounit2//lib/ounit2"]
    real_test_deps.extend(deps)
    real_test_deps.extend(test_deps)
    real_test_deps.extend([
        ":%s" % name
    ])

    real_suite_deps = []
    real_suite_deps.extend(deps)
    real_suite_deps.extend(test_deps)
    real_suite_deps.extend(suite_deps)
    real_suite_deps.extend([
        ":%s" % name,
        ":%sTest" % name,
    ])

    for module in modules:
        src_module = module
        test_module = "%sTest" % module
        suite_module = "%sSuite" % module

        src_label = ":%s" % src_module
        test_label = ":%s" % test_module
        suite_label = ":%s" % suite_module

        ocaml_module(
            name = src_module,
            struct = "%s.ml" % src_module,
            deps = real_src_deps,
            visibility = ["//visibility:private"],
        )

        ocaml_module(
            name = test_module,
            struct = "%s.ml" % test_module,
            deps = real_test_deps,
            visibility = ["//visibility:private"],
        )

        ocaml_module(
            name = suite_module,
            struct = "%s.ml" % suite_module,
            deps = real_suite_deps,
            visibility = ["//visibility:private"],
        )

        real_src_deps.extend([src_label])
        real_test_deps.extend([test_label])
        real_suite_deps.extend([suite_label])
    
    mod_names = [mod[0].capitalize() + mod[1:len(mod)] for mod in modules]
    src_includes = "\n".join(["echo 'include %s' >> $@" % mod for mod in mod_names])
    test_includes = "\n".join(["echo 'include %sTest' >> $@" % mod for mod in mod_names])

    native.genrule(
        name = "gensrc",
        outs = ["%s.ml" % name],
        cmd = "\n".join([
            "echo -n > $@",
            src_includes,
        ]),
    )

    native.genrule(
        name = "gentest",
        outs = ["%sTest.ml" % name],
        cmd = "\n".join([
            "echo -n > $@",
            test_includes,
        ]),
    )

    suites = "; ".join(["%sSuite.suite" % mod for mod in mod_names])
    native.genrule(
        name = "gensuite",
        outs = ["%sSuite.ml" % name],
        cmd = "\n".join([
            "echo -n > $@",
            "echo 'open OUnit2' >> $@",
            '''echo 'let _ = run_test_tt_main ("%s" >::: [%s])' >> $@''' % (label, suites),
        ]),
    )
    
    ocaml_module(
        name = name,
        sig = "%s.mli" % name,
        struct = "%s.ml" % name,
        deps = real_src_deps,
        visibility = visibility,
    )

    ocaml_module(
        name = "%sTest" % name,
        sig = "%sTest.mli" % name,
        struct = "%sTest.ml" % name,
        deps = real_test_deps,
        visibility = visibility,
    )

    ocaml_module(
        name = "%sSuite" % name,
        struct = "%sSuite.ml" % name,
        deps = real_suite_deps,
        visibility = ["//visibility:private"],
    )

    ocaml_test(
        name = "%s-test" % name,
        main = ":%sSuite" % name,
        visibility = ["//visibility:private"],
    )
