load("@//rules:verilog/providers.bzl", "VerilogResetInfo")

def _verilog_reset_impl(ctx):
  return [
    VerilogResetInfo(),
  ]

verilog_reset = rule(
  implementation = _verilog_reset_impl,
  doc = "Declare a System Verilog reset signal.",
  attrs = {

  },
)
