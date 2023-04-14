#include <gtest/gtest.h>

#include "input-bus-test.h"
#include "output-bus-test.h"
#include "input-signal-test.h"
// #include "output-signal-test.h"

int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}