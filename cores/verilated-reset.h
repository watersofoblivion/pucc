#include "cores/cores.h"

#include "verilated-input-port.h"

#pragma once

namespace cores {
  class VerilatedReset : public VerilatedInputPort<bool> {
  };
}