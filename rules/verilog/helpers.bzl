###
# Constants
###

VERILOG_HEADER_FILES = [".svh"]
VERILOG_SOURCE_FILES = VERILOG_HEADER_FILES + [".v", ".sv"]

CPP_HEADER_FILES = [".h", ".hh", ".hpp", ".hxx", ".h++"]
CPP_SOURCE_FILES = CPP_HEADER_FILES + [".c", ".cc", ".cpp", ".cxx", ".c++"]

###
# Inflection
###

# Convert a dasherized name to upper camel case.
# 
# Example: foo-bar -> FooBar
def camelize(str):
  return "".join([str.capitalize() for str in str.split("-")])

# Convert a dasherized name into underscore.
#
# Example: foo-bar -> foo_bar
def underscore(str):
  return "_".join(str.split("-"))

# Convert a dasherized name into a constant name.
#
# Example: foo-bar -> FOO_BAR
def constantize(str):
  return "_".join([str.upper() for str in str.split("-")])

# Convert a name into a package-relative label
# 
# Example: foo-bar -> :foo-bar
def labelize(name):
  return native.package_relative_label(name)
