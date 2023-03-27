#include "gate-xor-test.h"

#include <memory>
#include <iostream>

#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include <verilated.h>

#include "VGateXorTop.h"

using ::testing::Eq;

namespace hdub::core::logic::gate {
    void GateXorTest::SetUp() {
        model = std::unique_ptr<VGateXorTop>(new VGateXorTop("Top"));
    }

    void GateXorTest::TearDown() {
        model->final();
    }

    TEST_F(GateXorTest, ZeroZero) {
        model->lhs = 0;
        model->rhs = 0;
        model->eval();

        EXPECT_THAT(model->result, Eq(0));
    }

    TEST_F(GateXorTest, ZeroOne) {
        model->lhs = 0;
        model->rhs = 1;
        model->eval();

        EXPECT_THAT(model->result, Eq(1));
    }

    TEST_F(GateXorTest, OneZero) {
        model->lhs = 1;
        model->rhs = 0;
        model->eval();

        EXPECT_THAT(model->result, Eq(1));
    }

    TEST_F(GateXorTest, OneOne) {
        model->lhs = 1;
        model->rhs = 1;
        model->eval();

        EXPECT_THAT(model->result, Eq(0));
    }
}