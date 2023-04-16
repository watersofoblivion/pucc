#include <gtest/gtest.h>

#include "verilator-bus-test.h"
#include "verilator-signal-test.h"
#include "verilator-combinatorial-design-test.h"
#include "verilator-clocked-design-test.h"

int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}