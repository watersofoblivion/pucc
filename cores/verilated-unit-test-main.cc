#include <gtest/gtest.h>

#include "verilated-port-test.h"
#include "verilated-input-port-test.h"
#include "verilated-output-port-test.h"

int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}