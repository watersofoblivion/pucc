#include <gtest/gtest.h>

#include "device-port-test.h"
#include "device-input-port-test.h"
#include "device-output-port-test.h"

int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}