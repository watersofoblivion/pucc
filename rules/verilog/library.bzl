load("@//rules:verilog/providers.bzl", "VerilogLibraryInfo")
load("@//rules:verilog/helpers.bzl", "VERILOG_HEADER_FILES", "VERILOG_SOURCE_FILES")

def _verilog_library_impl(ctx):
  dir_hdrs = ctx.attrs.hdrs
  trans_hdrs = [hdr[VerilogLibraryInfo].hdrs for hdr in ctx.attrs.hdrs]

  dir_srcs = ctx.attrs.srcs
  trans_srcs = [hdr[VerilogLibraryInfo].srcs for hdr in ctx.attrs.srcs]

  return [
    VerilogLibraryInfo(
      hdrs = depset(direct = dir_hdrs, transitive = trans_hdrs),
      srcs = depset(direct = dir_srcs, transitive = trans_srcs),
    ),
  ]

verilog_library = rule(
  implementation = _verilog_library_impl,
  doc = "A library of SystemVerilog code.",
  attrs = {
    "hdrs": attr.label_list(
      doc = "Header files that will be available to both this target and downstream targets that depend it.",
      allow_empty = True,
      default = [],
      allow_files = VERILOG_HEADER_FILES, 
    ),
    "srcs": attr.label_list(
      doc = "Sources and internal header files.",
      allow_empty = True,
      default = [],
      allow_files = VERILOG_SOURCE_FILES,
    ),
    "deps": attr.label_list(
      doc = "Libraries this library depends on.",
      allow_empty = True,
      default = [],
      providers = [VerilogLibraryInfo],
    ),
  }
)
