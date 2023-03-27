#include "gate-and-test.h"

#include <memory>
#include <iostream>

#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include <verilated.h>

#include "VGateAndTop.h"

using ::testing::Eq;

namespace hdub::core::logic::gate {
    void GateAndTest::SetUp() {
        model = std::unique_ptr<VGateAndTop>(new VGateAndTop("Top"));
    }

    void GateAndTest::TearDown() {
        model->final();
    }

    TEST_F(GateAndTest, ZeroZero) {
        model->lhs = 0;
        model->rhs = 0;
        model->eval();

        EXPECT_THAT(model->result, Eq(0));
    }

    TEST_F(GateAndTest, ZeroOne) {
        model->lhs = 0;
        model->rhs = 1;
        model->eval();

        EXPECT_THAT(model->result, Eq(0));
    }

    TEST_F(GateAndTest, OneZero) {
        model->lhs = 1;
        model->rhs = 0;
        model->eval();

        EXPECT_THAT(model->result, Eq(0));
    }

    TEST_F(GateAndTest, OneOne) {
        model->lhs = 1;
        model->rhs = 1;
        model->eval();

        EXPECT_THAT(model->result, Eq(1));
    }
}