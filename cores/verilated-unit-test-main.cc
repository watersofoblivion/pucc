#include <gtest/gtest.h>

#include "verilated-input-bus-test.h"
#include "verilated-output-bus-test.h"
#include "verilated-input-signal-test.h"
#include "verilated-output-signal-test.h"

int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}