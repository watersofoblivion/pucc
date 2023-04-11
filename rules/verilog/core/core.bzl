load("@//rules:verilog/providers.bzl", "VerilogCoreInterfaceInfo", "VerilogCoreImplementationInfo", "VerilogCoreInfo")

def _verilog_core_impl(ctx):
  trans_hdrs = [ctx.attr.iface[VerilogCoreInterfaceInfo].hdrs] + [impl[VerilogCoreImplementationInfo].hdrs for impl in ctx.attr.impls]
  trans_srcs = [impl[VerilogCoreImplementationInfo].srcs for impl in ctx.attr.impls]

  return [
    VerilogCoreInfo(
      iface = ctx.attr.iface,
      impls = ctx.attr.impls,
      hdrs = depset(transitive = trans_hdrs),
      srcs = depset(transitive = trans_srcs),
    ),
  ]

verilog_core = rule(
  implementation = _verilog_core_impl,
  doc = "A core with ",
  attrs = {
    "iface": attr.label(
      doc = "The interface of this core.",
      mandatory = True,
    ),
    "impls": attr.label_list(
      doc = "The implementations of this core.",
      allow_empty = False,
      mandatory = True,
    ),
  },
)
