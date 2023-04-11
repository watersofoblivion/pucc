load("@//rules:verilog/helpers.bzl", "VERILOG_HEADER_FILES", "VERILOG_SOURCE_FILES")
load("@//rules:verilog/providers.bzl", "VerilogLibraryInfo", "VerilogCoreInterfaceInfo", "VerilogCoreImplementationInfo")

###
# Implementations
###

_VERILOG_CORE_IMPLEMENTATION_FILE_IMPL = ".impl."
_VERILOG_CORE_IMPLEMENTATION_FILE_VERILATOR_UNIT_TEST_TOP = ".test.unit.verilator.sv"
_VERILOG_CORE_IMPLEMENTATION_FILE_VERILATOR_INTEG_TEST_TOP = ".test.integ.verilator.sv"
_VERILOG_CORE_IMPLEMENTATION_FILE_DEVICE_UNIT_TEST_TOP = ".test.unit.device.sv"
_VERILOG_CORE_IMPLEMENTATION_FILE_DEVICE_INTEG_TEST_TOP = ".test.integ.device.sv"
_VERILOG_CORE_IMPLEMENTATION_FILE_VERILATOR_UNIT_TEST_MAIN = ".test.unit.verilator.cc"
_VERILOG_CORE_IMPLEMENTATION_FILE_VERILATOR_INTEG_TEST_MAIN = ".test.integ.verilator.cc"
_VERILOG_CORE_IMPLEMENTATION_FILE_DEVICE_UNIT_TEST_MAIN = ".test.unit.device.cc"
_VERILOG_CORE_IMPLEMENTATION_FILE_DEVICE_INTEG_TEST_MAIN = ".test.integ.device.cc"

def _verilog_core_implementation_impl(ctx):
  trans_hdrs = [dep[VerilogLibraryInfo].hdrs for dep in ctx.attr.deps]
  trans_srcs = [dep[VerilogLibraryInfo].srcs for dep in ctx.attr.deps]
  srcs = ctx.attr.deps

  return [
    VerilogCoreImplementationInfo(
      doc = ctx.attr.doc,
      iface = ctx.attr.iface,
      module = ctx.attr.module,
      hdrs = depset(transitive = trans_hdrs),
      srcs = depset(direct = srcs, transitive = trans_srcs)
    ),
  ]

verilog_core_implementation = rule(
  implementation = _verilog_core_implementation_impl,
  doc = "An implementation of a core's interface.",
  attrs = {
    "doc": attr.string(
      doc = "A description of this implementation."
    ),
    "iface": attr.label(
      doc = "The interface this is an implementation of.",
      mandatory = True,
      providers = [VerilogCoreInterfaceInfo],
    ),
    "module": attr.string(
      doc = "The main implementation module.  If not given, defaults to the UpperCamelCase version of the rule's name."
    ),
    "srcs": attr.label_list(
      doc = "The source files of this implementation.",
      allow_empty = True,
      default = [],
      allow_files = VERILOG_SOURCE_FILES,
    ),
    "deps": attr.label_list(
      doc = "SystemVerilog libraries this implementation relies on.",
      allow_empty = True,
      default = [],
      providers = [VerilogLibraryInfo],
    ),
  }
)
