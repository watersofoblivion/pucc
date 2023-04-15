#include <gtest/gtest.h>

#include "verilated-bus-test.h"
#include "verilated-signal-test.h"

int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}