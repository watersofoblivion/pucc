load("@//rules:verilog/providers.bzl", "VerilogParamIntInfo", "VerilogParamIntEnumInfo", "VerilogPortInfo")
load("@//rules:verilog/helpers.bzl", "underscore")

def _default_id(ctx):
  if ctx.attr.id == None:
    ctx.attr.id = underscore(ctx.label.name)

  return ctx.attr.id

def _verify_width(ctx):
  if ctx.attr.width != 0 and ctx.attr.width_param != None:
    fail("Exactly one of 'width' or 'width_param' can be provided.")

  if ctx.attr.width == 0 and ctx.attr.width_param == None:
    ctx.attr.witdh = 1
  
  return ctx.attr.width or ctx.attr.width_param

def _verilog_port_impl(ctx):
  return [
    VerilogPortInfo(
      id = _default_id(ctx),
      doc = ctx.attr.doc,
      width = _verify_width(ctx),
    ),
  ]

verilog_port = rule(
  implementation = _verilog_port_impl,
  doc = "A port in a SystemVerilog module or interface.",
  attrs = {
    "id": attr.string(
      doc = "The port name in generated SystemVerilog code.  If not given, defaults to the underscore version of the name.",
    ),
    "doc": attr.string(
      doc = "A description of the port.",
    ),
    "width": attr.int(
      doc = "The width of the port, in bits.",
    ),
    "width_param": attr.label(
      doc = "The width of the port if given by a parameter.",
      providers = [
        [VerilogParamIntInfo],
        [VerilogParamIntEnumInfo],
      ],
    ),
  }
)
