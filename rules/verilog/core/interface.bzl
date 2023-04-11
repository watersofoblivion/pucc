load("@//rules:verilog/helpers.bzl", "camelize")
load("@//rules:verilog/providers.bzl", "VerilogPortInfo", "VerilogClockInfo", "VerilogResetInfo", "VerilogParamIntEnumInfo", "VerilogParamIntInfo", "VerilogCoreInterfaceInfo", "VerilogCoreInfo")

def _generate_banner(text):
  stars = "*" * (len(text) + 4)
  return "/%s\n * %s *\n %s/" % (stars, text, stars)

def _generate_doc_comment(doc):
  if doc == None:
    return ""

  return "/**\n%s\n */" % "\n".join([" * %s" % line for line in doc.splitlines()])

def _module_name(ctx):
  name = ctx.attr.module
  if name == None:
    name = camelize(ctx.label.name)

  return name

def _generate_param_id(param):
  if param[VerilogParamIntEnumInfo]:
    return param[VerilogParamIntEnumInfo].id
  elif param[VerilogParamIntInfo]:
    return param[VerilogParamIntInfo].id
  else:
    fail("Unknown parameter type")

def _generate_param_default(param):
  if param[VerilogParamIntEnumInfo]:
    return "%d" % param[VerilogParamIntEnumInfo].default
  elif param[VerilogParamIntInfo]:
    return "%d" % param[VerilogParamIntInfo].default
  else:
    fail("Unknown parameter type")

def _generate_parameters(ctx):
  elems = [_generate_banner("Parameters")]

  for param in ctx.attr.params:
    doc = _generate_doc_comment(ctx.attr.doc)
    id = _generate_param_id(param)
    default = _generate_param_default(param)
    elems.append("%sparameter %s = %s;" % (doc, id, default))
  
  return "\n\n".join(elems)

def _generate_port_width(port_info):
  width = ""

  if port_info.width != None:
    if port_info.width[VerilogParamIntEnumInfo]:
      width = "[%s-1:0]" % port_info.width[VerilogParamIntEnumInfo].id
    elif port_info.width[VerilogParamIntInfo]:
      width = "[%s-1:0]" % port_info.width[VerilogParamIntInfo].id
  elif port_info.width > 1:
      width = "[%d:0]" % (port_info.width - 1)

  return width

def _generate_port(port_info):
  id = port_info.id
  doc = _generate_doc_comment(port_info.doc)
  width = _generate_port_width(port_info)
  return "%slogic%s %s;" % (doc, width, id)

def _generate_ports(ctx):
  elems = [_generate_banner("Ports")]

  for port in ctx.attr.inputs:
    port = _generate_port(port[VerilogPortInfo])
    elems.append(port)

  for port in ctx.attr.outputs:
    port = _generate_port(port[VerilogPortInfo])
    elems.append(port)

  return "\n\n".join(elems)

def _generate_modports(ctx):
  banner = _generate_banner("ModPorts")

  inputs = ", ".join([input[VerilogPortInfo].id for input in ctx.attr.inputs])
  outputs = ", ".join([output[VerilogPortInfo].id for output in ctx.attr.outputs])

  impl = "modport Impl (input %s, output %s);" % (inputs, outputs)
  injected = "modport Injected (output %s, input %s);" % (inputs, outputs)

  return "%s\n\n%s\n%s\n" % (banner, impl, injected)

def _generate_verilog_interface(ctx):
  file = ctx.actions.declare_file(ctx.label.name + ".interf.sv")

  name = _module_name(ctx)
  params = _generate_parameters(ctx)
  ports = _generate_ports(ctx)
  modports = _generate_modports(ctx)

  contents = "interface %s;\n%s\n%s\n%s\nendinterface;\n" % (name, params, ports, modports)

  ctx.actions.write(file, contents)
  return file

def _generate_test_harness(ctx):
  file = ctx.actions.declare_file(ctx.label.name + ".test.harness.sv")

  contents = ""

  ctx.actions.write(file, contents)

def _generate_cc_unit_test_interface(ctx):
  file = ctx.actions.declare_file(ctx.label.name + ".test.unit.h")

  contents = ""

  ctx.actions.write(file, contents)


def _generate_cc_integ_test_interface(ctx):
  file = ctx.actions.declare_file(ctx.label.name + ".test.integ.h")

  contents = ""

  ctx.actions.write(file, contents)

def _verilog_core_interface_impl(ctx):
  id = _module_name(ctx)

  interface = _generate_verilog_interface(ctx)
  _generate_test_harness(ctx)

  _generate_cc_unit_test_interface(ctx)
  _generate_cc_integ_test_interface(ctx)

  transitive = [dep[VerilogCoreInfo].deps for dep in ctx.attr.deps]

  return [
    VerilogCoreInterfaceInfo(
      id = id,
      doc = ctx.attr.doc,
      params = ctx.attr.params,
      clock = ctx.attr.clock,
      reset = ctx.attr.reset,
      inputs = ctx.attr.inputs,
      outputs = ctx.attr.outputs,
      deps = depset(direct = ctx.attr.deps, transitive = transitive),
      hdrs = depset(direct = [interface])
    ),
  ]

verilog_core_interface = rule(
  implementation = _verilog_core_interface_impl,
  doc = "Declare a System Verilog core.  This is the abstract interface to the core, not the implementation of it.",
  attrs = {
    "module": attr.string(
      doc = "The name for the core's interface.  If not given, defaults to the UpperCamelCase version of the target name.",
    ),
    "doc": attr.string(
      doc = "A description of the core",
    ),
    "params": attr.label_list(
      doc = "The set of parameters for the design.",
      allow_empty = True,
      default = [],
      providers = [
        [VerilogParamIntInfo],
        [VerilogParamIntEnumInfo],
      ]
    ),
    "clock": attr.label(
      doc = "The clock for the design",
      providers = [VerilogClockInfo],
    ),
    "reset": attr.label(
      doc = "The reset signal for the design",
      providers = [VerilogResetInfo],
    ),
    "inputs": attr.label_list(
      doc = "The set of input ports for the design.",
      allow_empty = True,
      default = [],
      providers = [VerilogPortInfo],
    ),
    "outputs": attr.label_list(
      doc = "The output ports for the design",
      allow_empty = True,
      default = [],
      providers = [VerilogPortInfo],
    ),
    "deps": attr.label_list(
      doc = "The cores this core depends on",
      allow_empty = True,
      default = [],
      providers = [VerilogCoreInfo],
    ),
  },
)
