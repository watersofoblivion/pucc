load("@rules_verilog//verilog:defs.bzl", "verilog_module")
load("@rules_cc//cc:defs.bzl", "cc_library", "cc_test")
load("@rules_verilator//verilator:defs.bzl", "verilator_cc_library")

load("@//rules:verilog/providers.bzl", "VerilogParamIntInfo", "VerilogParamIntEnumInfo", "VerilogPortInfo")

# Convert a dasherized name to upper camel case.
# 
# Example: foo-bar -> FooBar
def camelize(str):
  return "".join([str.capitalize() for str in str.split("-")])

# Convert a dasherized name into underscore.
#
# Example: foo-bar -> foo_bar
def underscore(str):
  return "_".join(str.split("-"))

# Convert a dasherized name into a constant name.
#
# Example: foo-bar -> FOO_BAR
def constantize(str):
  return "_".join([str.upper() for str in str.split("-")])

# Convert a name into a package-relative label
# 
# Example: foo-bar -> :foo-bar
def labelize(name):
  return native.package_relative_label(name)

################################

def build_all_the_things(name, impls = []):
  # Camel-cased name
  camel_name = camelize(name)

  # SystemVerilog Interface
  # ===
  #
  # A SystemVerilog header file that contains the interface for the core.  The
  # file should be named "<name>.interf.svh" and the interface should be named
  # "<name-camelized>".
  interface_name = "interface"
  interface_file = "%s.interf.sv" % name
  interface_module = camelize(name)
  interface_label = labelize(interface_name)
  verilog_module(
    name = interface_name,
    top = interface_module,
    srcs = [interface_file],
    visibility = ["//visibility:public"],
  )

  # SystemVerilog Test Harness
  # ===
  #
  # A SystemVerilog module that wrires raw ports to the appropriate interface.
  # The file should be named "<name>.test.harness.sv" and the interface should
  # be named "<name-camelized>TestHarness".
  test_harness_name = "test-harness"
  test_harness_file = "%s.test.harness.sv" % name
  test_harness_module = camelize(test_harness_name)
  test_harness_label = labelize(test_harness_name)
  verilog_module(
    name = test_harness_name,
    top = test_harness_module,
    srcs = [interface_file, test_harness_file],
    deps = [interface_label],
    visibility = ["//visibility:private"],
  )

  # Unit Test Library
  # ===
  #
  # A header file that contains the unit testing interface and tests against
  # that interface.  All implementations should pass these same unit tests.
  #
  # The header file should be named "<name>.test.unit.h" and the implementation
  # should be named "<name>.test.unit.cc".
  test_unit_lib_name = "test-unit-lib"
  test_unit_lib_label = labelize(test_unit_lib_name)
  test_unit_header_file = "%s.test.unit.h" % name
  test_unit_impl_file = "%s.test.unit.cc" % name
  cc_library(
    name = test_unit_lib_name,
    hdrs = [test_unit_header_file],
    srcs = [test_unit_impl_file],
    deps = [
        "@com_google_googletest//:gtest",
        "//cores:cores",
    ],
    visibility = ["//visibility:private"],
  )

  # Integration Test Library
  # ===
  #
  # A header file that contains the integration testing interface and tests
  # against that interface.  All implementation should pass these same
  # integration tests.
  #
  # The header file should be named "<name>.test.integ.h" and the
  # implementation should be named "<name>.test.integ.cc".
  test_integ_lib_name = "test-integ-lib"
  test_integ_lib_label = labelize(test_integ_lib_name)
  test_integ_header_file = "%s.test.integ.h" % name
  test_integ_impl_file = "%s.test.integ.cc" % name
  cc_library(
    name = test_integ_lib_name,
    hdrs = [test_integ_header_file],
    srcs = [test_integ_impl_file],
    deps = [
        "@com_google_googletest//:gtest",
        "//cores:cores",
    ],
    visibility = ["//visibility:private"],
  )

  # Implementation
  for impl in impls:
    # Implementation
    # ===
    #
    # A SystemVerilog file that contains a particular implementation of the
    # interface.  The file should be named "<name>.impl.<impl>.sv" and the
    # module should be named "<name-camelized>Impl<impl-camelized>".
    impl_name = "impl-%s" % impl
    impl_file_prefix = "%s.impl.%s" % (name, impl)
    impl_file = "%s.sv" % impl_file_prefix
    impl_module = camelize(impl_name)
    impl_label = labelize(impl_name)
    verilog_module(
      name = impl_name,
      top = impl_module,
      srcs = [interface_file, impl_file],
      deps = [
        interface_label,
      ],
      visibility = ["//visibility:public"],
    )

    # Verilator Unit Tests
    # ===
    # 
    # Comprises
    #
    # A top-level module that exposes the ports of the DUT and the ports of the
    # supporting injected cores.

    # Top
    test_unit_verilator_name = "%s-test-unit-verilator" % impl_name
    test_unit_verilator_file = "%s.test.unit.verilator.sv" % impl_file_prefix
    test_unit_verilator_module = camelize(test_unit_verilator_name)
    test_unit_verilator_label = labelize(test_unit_verilator_name)
    verilog_module(
      name = test_unit_verilator_name,
      top = test_unit_verilator_module,
      srcs = [interface_file, test_unit_verilator_file],
      deps = [
        interface_label,
        test_harness_label,
        impl_label,
      ],
      visibility = ["//visibility:private"],
    )

    # Verilated
    test_unit_verilated_name = "%s-test-unit-verilated" % impl_name
    test_unit_verilated_label = labelize(test_unit_verilated_name)
    verilator_cc_library(
      name = test_unit_verilated_name,
      module = test_unit_verilator_label,
      vopts = [],
      visibility = ["//visibility:private"],
    )

    # Tests
    test_unit_test = "%s-test-unit" % impl_name
    test_unit_impl_file = "%s.test.unit.verilator.cc" % impl_file_prefix
    test_unit_main_file = "%s.test.unit.verilator.main.cc" % impl_file_prefix
    cc_test(
      name = test_unit_test,
      srcs = [
        test_unit_impl_file,
        test_unit_main_file,
      ],
      deps = [
        "@com_google_googletest//:gtest",
        "//cores:cores",
        test_unit_lib_label,
        test_unit_verilated_label,
      ],
      visibility = ["//visibility:public"],
    )

    # 
    # Verilator Integration Tests
    #

    # Top
    test_integ_verilator_name = "%s-test-integ-verilator" % impl_name
    test_integ_verilator_file = "%s.test.integ.verilator.sv" % impl_file_prefix
    test_integ_verilator_module = camelize(test_integ_verilator_name)
    test_integ_verilator_label = labelize(test_integ_verilator_name)
    verilog_module(
      name = test_integ_verilator_name,
      top = test_integ_verilator_module,
      srcs = [interface_file, test_integ_verilator_file],
      deps = [
        interface_label,
        test_harness_label,
        impl_label,
      ],
      visibility = ["//visibility:private"],
    )

    # Verilated
    test_integ_verilated_name = "%s-test-integ-verilated" % impl_name
    test_integ_verilated_label = labelize(test_integ_verilated_name)
    verilator_cc_library(
      name = test_integ_verilated_name,
      module = test_integ_verilator_label,
      vopts = [],
      visibility = ["//visibility:private"],
    )

    # Tests
    test_integ_test = "%s-test-integ" % impl_name
    test_integ_impl_file = "%s.test.integ.verilator.cc" % impl_file_prefix
    test_integ_main_file = "%s.test.integ.verilator.main.cc" % impl_file_prefix
    cc_test(
      name = test_integ_test,
      srcs = [
        test_integ_impl_file,
        test_integ_main_file,
      ],
      deps = [
        "@com_google_googletest//:gtest",
        "//cores:cores",
        test_integ_lib_label,
        test_integ_verilated_label,
      ],
      visibility = ["//visibility:public"],
    )

    #
    # Device Unit Tests
    #

    # Top
    test_unit_device_name = "%s-test-unit-device" % impl_name
    test_unit_device_file = "%s.test.unit.device.sv" % impl_file_prefix
    test_unit_device_module = camelize(test_unit_device_name)
    test_unit_device_label = labelize(test_unit_device_name)
    verilog_module(
      name = test_unit_device_name,
      top = test_unit_device_module,
      srcs = [interface_file, test_unit_device_file],
      deps = [
        interface_label,
        test_harness_label,
        impl_label,
      ],
      visibility = ["//visibility:private"],
    )

    #
    # Device Integration Tests
    #

    # Top
    test_integ_device_name = "%s-test-integ-device" % impl_name
    test_integ_device_file = "%s.test.integ.device.sv" % impl_file_prefix
    test_integ_device_module = camelize(test_integ_device_name)
    test_integ_device_label = labelize(test_integ_device_name)
    verilog_module(
      name = test_integ_device_name,
      top = test_integ_device_module,
      srcs = [interface_file, test_integ_device_file],
      deps = [
        interface_label,
        test_harness_label,
        impl_label,
      ],
      visibility = ["//visibility:private"],
    )
