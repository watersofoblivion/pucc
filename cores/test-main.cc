#include <gtest/gtest.h>

#include "port-test.h"
#include "input-port-test.h"
#include "output-port-test.h"

int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}