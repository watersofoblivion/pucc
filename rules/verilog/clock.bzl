load("@//rules:verilog/providers.bzl", "VerilogClockInfo")

def _verilog_clock_impl(ctx):
  return [
    VerilogClockInfo(),
  ]

verilog_clock = rule(
  implementation = _verilog_clock_impl,
  doc = "Declare a System Verilog clock signal.",
  attrs = {

  },
)
