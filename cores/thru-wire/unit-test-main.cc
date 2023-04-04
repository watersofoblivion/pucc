#include <gtest/gtest.h>

#include "thru-wire-unit-test.h"

int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}