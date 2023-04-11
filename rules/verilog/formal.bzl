load("@//rules:verilog/providers.bzl", "VerilogFormalInfo")

_VERILOG_FORMAL_DOC_ATTR_CORE = "The core to formally verify."
_VERILOG_FORMAL_DOC_ATTR_PROPS = "The source files containing the properties."
_VERILOG_FORMAL_DOC_ATTR_ABSTR = "The source files continaing the abstractions."


def _verilog_formal_impl(ctx):
  return [
    VerilogFormalInfo(),
  ]

verilog_formal = rule(
  implementation = _verilog_formal_impl,
  doc = "Formal properties for a core.",
  attrs = {
    "core": attr.label(
      doc = _VERILOG_FORMAL_DOC_ATTR_CORE,
      mandatory = True,
      # providers = [VerilogCoreInfo],
    ),
    "props": attr.label(
      doc = _VERILOG_FORMAL_DOC_ATTR_PROPS,
      mandatory = True,
      allow_files = _VERILOG_SRCS,
    ),
    "abstr": attr.label(
      doc = _VERILOG_FORMAL_DOC_ATTR_ABSTR,
      allow_files = _VERILOG_SRCS,
    ),
  }
)
