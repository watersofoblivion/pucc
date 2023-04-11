###
# Providers
###

### Libraries ###

VerilogLibraryInfo = provider(
  doc = "A library of SystemVerilog files.",
  fields = {
    "hdrs": "The collected headers of this library and all its dependencies.",
    "srcs": "The collected sources of this library and all its dependencies.",
  }
)

### Parameters ###

VerilogParamIntEnumInfo = provider(
  doc = "An SystemVerilog parameter that is an integer enumeration",
  fields = {
    "id": "The parameter identifier.",
    "doc": "A description of the parameter.",
    "values": "The allowed values of the parameter.",
    "default": "The default value of the parameter.",
  },
)

VerilogParamIntInfo = provider(
  doc = "An SystemVerilog parameter that is an integer",
  fields = {
    "id": "The parameter identifier.",
    "doc": "A description of the parameter.",
    "min": "The minimum allowed value.",
    "max": "The maximum allowed value.",
  },
)

### Ports ###

VerilogPortInfo = provider(
  doc = "A port in a SystemVerilog module or interface.",
  fields = {
    "id": "The name of the port.",
    "doc": "A description of the port.",
    "width": "The width of the port."
  },
)

### Clocks ###

VerilogClockInfo = provider(
  doc = "Information about a Verilog clock",
  fields = {

  },
)

### Resets ###

VerilogResetInfo = provider(
  doc = "Information about a Verilog reset signal",
  fields = {

  },
)

### Cores ###

VerilogCoreInterfaceInfo = provider(
  doc = "The interface to a core.",
  fields = {
    "id": "The name of the interface.",
    "doc": "A description of the core",
    "params": "The parameters to the core.",
    "clock": "The primary clock of the core.",
    "reset": "The reset for the core.",
    "inputs": "The import ports for the core.",
    "outputs": "The output ports for the core.",
    "deps": "The cores this core depends on.",
    "hdrs": "The shared headers for implementations of this core.",
  },
)

VerilogCoreImplementationInfo = provider(
  doc = "Information about an implementation of a core",
  fields = {
    "doc": "A description of this implementation.",
    "iface": "The interface this is an implementation of.",
    "module": "The main implementation module.",
    "hdrs": "The set of headers this implementation relies on.",
    "srcs": "The set of sources this implementation relies on.",
  },
)

VerilogCoreInfo = provider(
  doc = "",
  fields = {
    "iface": "The interface of the core.",
    "impls": "The implementation of the core.",
    "hdrs": "The headers that implement the core.",
    "srcs": "The sources that implement the core.",
  },
)

### Unit Tests ###

VerilogCoreGTestUnitTestInfo = provider(
  doc = "",
  fields = {
    "hdrs": "The headers for the test.",
    "srcs": "The sources for the test.",
  }
)

VerilogCoreGTestIntegTestInfo = provider(
  doc = "",
  fields = {
    "hdrs": "The headers for the test.",
    "srcs": "The sources for the test.",
  }
)
### Formal Verification ###

VerilogFormalInfo = provider(
  doc = "",
  fields = {

  },
)
