load("@//rules:verilog/helpers.bzl", "CPP_HEADER_FILES", "CPP_SOURCE_FILES")
load("@//rules:verilog/providers.bzl", "VerilogCoreInfo", "VerilogCoreGTestUnitTestInfo")

def _verilog_core_gtest_unit_spec_impl(ctx):
  return [
    DefaultInfo(),
    CcInfo(),
    VerilogCoreGTestUnitTestInfo(),
  ]

verilog_core_gtest_unit_spec = rule(
  implementation = _verilog_core_gtest_unit_spec_impl,
  doc = "GoogleTest-based unit tests for a core",
  attrs = {
    "core": attr.label(
      doc = "The core this tests.",
      mandatory = True,
      providers = [VerilogCoreInfo],
    ),
    "hdrs": attr.label_list(
      doc = "The headers for this spec.",
      allow_files = CPP_HEADER_FILES,
      allow_empty = True,
      default = [],
    ),
    "srcs": attr.label_list(
      doc = "The sources for this spec.",
      allow_files = CPP_SOURCE_FILES,
      allow_empty = True,
      default = [],
    ),
    "deps": attr.label_list(
      doc = "The dependencies for this spec.",
      allow_empty = True,
      default = [],
      providers = [
        [DefaultInfo, CcInfo],
      ]
    ),
  }
)
