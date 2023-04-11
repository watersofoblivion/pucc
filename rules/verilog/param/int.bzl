load("@//rules:verilog/providers.bzl", "VerilogParamIntInfo")
load("//rules:verilog/param/helpers.bzl", "set_default_param_id")

def _verilog_param_int_impl(ctx):
  set_default_param_id(ctx)

  if min != None and max != None and min > max:
    fail("SystemVerilog int parameter minimum value cannot be greater than the maximum value")

  return [
    VerilogParamIntInfo(
      id = ctx.attr.id,
      doc = ctx.attr.doc,
      min = ctx.attr.min,
      max = ctx.attr.max,
    ),
  ]

verilog_param_int = rule(
  implementation = _verilog_param_int_impl,
  doc = "Declare a System Verilog design parameter whose values are an integer.",
  attrs = {
    "id": attr.string(
      doc = "The parameter identifier.  If not given, defaults to the constantized version of the name.",
    ),
    "doc": attr.string(
      doc = "A description of the parameter.",
    ),
    "min": attr.int(
      doc = "The minimum allowed value for this parameter.",
    ),
    "default": attr.int(
      doc = "The maximum allowed value for this parameter.",
    )
  }
)
