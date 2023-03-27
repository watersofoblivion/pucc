#include "gate-not-test.h"

#include <memory>
#include <iostream>

#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include <verilated.h>

#include "VGateNotTop.h"

using ::testing::Eq;

namespace hdub::core::logic::gate {
    void GateNotTest::SetUp() {
        model = std::unique_ptr<VGateNotTop>(new VGateNotTop("Top"));
    }

    void GateNotTest::TearDown() {
        model->final();
    }

    TEST_F(GateNotTest, Zero) {
        model->operand = 0;
        model->eval();

        EXPECT_THAT(model->result, Eq(1));
    }

    TEST_F(GateNotTest, One) {
        model->operand = 1;
        model->eval();

        EXPECT_THAT(model->result, Eq(0));
    }
}