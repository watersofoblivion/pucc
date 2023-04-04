#include "thru-wire-unit-test.h"

#include <memory>
#include <iostream>

#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include <verilated.h>

#include "VUnitTestTop.h"

using ::testing::Eq;

namespace hdub::core {
    void ThruWireUnitTest::SetUp() {
        model = std::unique_ptr<VUnitTestTop>(new VUnitTestTop("UnitTestTop"));
    }

    void ThruWireUnitTest::TearDown() {
        model->final();
    }

    TEST_F(ThruWireUnitTest, Zero) {
        model->in = 0;
        model->eval();

        EXPECT_THAT(model->out, Eq(0));
    }

    TEST_F(ThruWireUnitTest, One) {
        model->in = 1;
        model->eval();

        EXPECT_THAT(model->out, Eq(1));
    }
}