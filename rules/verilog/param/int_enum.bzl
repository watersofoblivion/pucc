load("@//rules:verilog/providers.bzl", "VerilogParamIntEnumInfo")
load("@//rules:verilog/param/helpers.bzl", "set_default_param_id")

def _verify_valid_default(ctx):
  if ctx.attr.default not in ctx.attr.values:
    fail("SystemVerilog integer enum parameter default value is not in the list of allowed values")

def _verilog_param_int_enum_impl(ctx):
  set_default_param_id(ctx)
  _verify_valid_default(ctx)

  return [
    VerilogParamIntEnumInfo(
      id = ctx.attr.id,
      doc = ctx.attr.doc,
      values = ctx.attr.values,
      default = ctx.attr.default,
    ),
  ]

verilog_param_int_enum = rule(
  implementation = _verilog_param_int_enum_impl,
  doc = "Declare a System Verilog design parameter whose values are an integer enumeration.",
  attrs = {
    "id": attr.string(
      doc = "The parameter identifier.  If not given, defaults to the constantized version of the name.",
    ),
    "doc": attr.string(
      doc = "A description of the parameter.",
    ),
    "values": attr.int_list(
      doc = "The allowed values of the enum.  Must not be empty.",
      mandatory = True,
      allow_empty = False,
    ),
    "default": attr.int(
      doc = "The default value.  Must be an element of the values array.",
      mandatory = True,
    )
  }
)
