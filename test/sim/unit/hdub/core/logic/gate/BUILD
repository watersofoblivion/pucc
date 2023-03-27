load("@rules_cc//cc:defs.bzl", "cc_test")
load("@rules_verilog//verilog:defs.bzl", "verilog_module")
load("@rules_verilator//verilator:defs.bzl", "verilator_cc_library")

verilog_module(
    name = "gate-and-top",
    top = "GateAndTop",
    srcs = [
        "BinGateHarness.sv",
        "GateAndTop.sv",
    ],
    deps = [
        "//lib/hdub/core/logic/gate:srcs"
    ]
)

verilator_cc_library(
    name = "gate-and-verilated",
    module = ":gate-and-top"
)

verilog_module(
    name = "gate-or-top",
    top = "GateOrTop",
    srcs = [
        "BinGateHarness.sv",
        "GateOrTop.sv",
    ],
    deps = [
        "//lib/hdub/core/logic/gate:srcs"
    ]
)

verilator_cc_library(
    name = "gate-or-verilated",
    module = ":gate-or-top"
)

verilog_module(
    name = "gate-not-top",
    top = "GateNotTop",
    srcs = [
        "UnGateHarness.sv",
        "GateNotTop.sv",
    ],
    deps = [
        "//lib/hdub/core/logic/gate:srcs"
    ]
)

verilator_cc_library(
    name = "gate-not-verilated",
    module = ":gate-not-top"
)

verilog_module(
    name = "gate-xor-top",
    top = "GateXorTop",
    srcs = [
        "BinGateHarness.sv",
        "GateXorTop.sv",
    ],
    deps = [
        "//lib/hdub/core/logic/gate:srcs"
    ]
)

verilator_cc_library(
    name = "gate-xor-verilated",
    module = ":gate-xor-top"
)

verilog_module(
    name = "gate-factory-top",
    top = "GateFactoryTop",
    srcs = [
        "UnGateHarness.sv",
        "BinGateHarness.sv",
        "GateFactoryTop.sv",
    ],
    deps = [
        "//lib/hdub/core/logic/gate:srcs"
    ]
)

verilator_cc_library(
    name = "gate-factory-verilated",
    module = ":gate-factory-top"
)

cc_test(
    name = "test",
    size = "small",
    srcs = [
        "gate-and-test.h",
        "gate-and-test.cc",
        "gate-or-test.h",
        "gate-or-test.cc",
        "gate-not-test.h",
        "gate-not-test.cc",
        "gate-xor-test.h",
        "gate-xor-test.cc",
        "gate-factory-test.h",
        "gate-factory-test.cc",
        "main.cc",
    ],
    deps = [
        ":gate-and-verilated",
        ":gate-or-verilated",
        ":gate-not-verilated",
        ":gate-xor-verilated",
        ":gate-factory-verilated",
        "@com_google_googletest//:gtest",
        "@com_google_fruit//third_party/fruit"
    ],
    visibility = ["//visibility:public"]
)
