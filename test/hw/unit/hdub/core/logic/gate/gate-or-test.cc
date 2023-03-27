#include "gate-or-test.h"

#include <memory>
#include <iostream>

#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include <verilated.h>

#include "VGateOrTop.h"

using ::testing::Eq;

namespace hdub::core::logic::gate {
    void GateOrTest::SetUp() {
        model = std::unique_ptr<VGateOrTop>(new VGateOrTop("Top"));
    }

    void GateOrTest::TearDown() {
        model->final();
    }

    TEST_F(GateOrTest, ZeroZero) {
        model->lhs = 0;
        model->rhs = 0;
        model->eval();

        EXPECT_THAT(model->result, Eq(0));
    }

    TEST_F(GateOrTest, ZeroOne) {
        model->lhs = 0;
        model->rhs = 1;
        model->eval();

        EXPECT_THAT(model->result, Eq(1));
    }

    TEST_F(GateOrTest, OneZero) {
        model->lhs = 1;
        model->rhs = 0;
        model->eval();

        EXPECT_THAT(model->result, Eq(1));
    }

    TEST_F(GateOrTest, OneOne) {
        model->lhs = 1;
        model->rhs = 1;
        model->eval();

        EXPECT_THAT(model->result, Eq(1));
    }
}