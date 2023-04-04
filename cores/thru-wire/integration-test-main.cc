#include <gtest/gtest.h>

#include "thru-wire-integration-test.h"

int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}