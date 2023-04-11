load("@//rules:verilog/helpers.bzl", "constantize")

###
# Helpers
###

def set_default_param_id(ctx):
  if ctx.attr.id == None:
    ctx.attr.id = constantize(ctx.label.name)
