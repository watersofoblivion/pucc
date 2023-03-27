###############
# Alchitry Cu #
###############

## 100MHz Clocks
set_property PACKAGE_PIN P7 [get_ports { clk }]
create_clock -name clk -period 10.0 [get_ports { clk }]

## Reset Button
set_property PACKAGE_PIN P8 [get_ports { rst }]

## LEDs
set_property PACKAGE_PIN J11 [get_ports { led[0] }]
set_property PACKAGE_PIN K11 [get_ports { led[1] }]
set_property PACKAGE_PIN K12 [get_ports { led[2] }]
set_property PACKAGE_PIN K14 [get_ports { led[3] }]
set_property PACKAGE_PIN L12 [get_ports { led[4] }]
set_property PACKAGE_PIN L14 [get_ports { led[5] }]
set_property PACKAGE_PIN M12 [get_ports { led[6] }]
set_property PACKAGE_PIN N14 [get_ports { led[7] }]

## UART over USB
set_property PACKAGE_PIN P14 [get_ports { uart_rx }]
set_property PACKAGE_PIN M9  [get_ports { uart_tx }]

####################
# Io Element Board #
####################

## LEDs
set_property PACKAGE_PIN G14 [get_ports { io_led[0]  }]
set_property PACKAGE_PIN F14 [get_ports { io_led[1]  }]
set_property PACKAGE_PIN E12 [get_ports { io_led[2]  }]
set_property PACKAGE_PIN E14 [get_ports { io_led[3]  }]
set_property PACKAGE_PIN D14 [get_ports { io_led[4]  }]
set_property PACKAGE_PIN C14 [get_ports { io_led[5]  }]
set_property PACKAGE_PIN B14 [get_ports { io_led[6]  }]
set_property PACKAGE_PIN A12 [get_ports { io_led[7]  }]

set_property PACKAGE_PIN C10 [get_ports { io_led[8]  }]
set_property PACKAGE_PIN C9  [get_ports { io_led[9]  }]
set_property PACKAGE_PIN A11 [get_ports { io_led[10] }]
set_property PACKAGE_PIN A10 [get_ports { io_led[11] }]
set_property PACKAGE_PIN A7  [get_ports { io_led[12] }]
set_property PACKAGE_PIN A6  [get_ports { io_led[13] }]
set_property PACKAGE_PIN A4  [get_ports { io_led[14] }]
set_property PACKAGE_PIN A3  [get_ports { io_led[15] }]

set_property PACKAGE_PIN A2  [get_ports { io_led[16] }]
set_property PACKAGE_PIN A1  [get_ports { io_led[17] }]
set_property PACKAGE_PIN C3  [get_ports { io_led[18] }]
set_property PACKAGE_PIN D3  [get_ports { io_led[19] }]
set_property PACKAGE_PIN B1  [get_ports { io_led[20] }]
set_property PACKAGE_PIN C1  [get_ports { io_led[21] }]
set_property PACKAGE_PIN D1  [get_ports { io_led[22] }]
set_property PACKAGE_PIN E1  [get_ports { io_led[23] }]

## DIP Switches
set_property PACKAGE_PIN G12 [get_ports { io_dip[0]  }]
set_property PACKAGE_PIN F12 [get_ports { io_dip[1]  }]
set_property PACKAGE_PIN F11 [get_ports { io_dip[2]  }]
set_property PACKAGE_PIN E11 [get_ports { io_dip[3]  }]
set_property PACKAGE_PIN D12 [get_ports { io_dip[4]  }]
set_property PACKAGE_PIN D11 [get_ports { io_dip[5]  }]
set_property PACKAGE_PIN C12 [get_ports { io_dip[6]  }]
set_property PACKAGE_PIN C11 [get_ports { io_dip[7]  }]

set_property PACKAGE_PIN D10 [get_ports { io_dip[8]  }]
set_property PACKAGE_PIN D9  [get_ports { io_dip[9]  }]
set_property PACKAGE_PIN D7  [get_ports { io_dip[10] }]
set_property PACKAGE_PIN D6  [get_ports { io_dip[11] }]
set_property PACKAGE_PIN C7  [get_ports { io_dip[12] }]
set_property PACKAGE_PIN C6  [get_ports { io_dip[13] }]
set_property PACKAGE_PIN A5  [get_ports { io_dip[14] }]
set_property PACKAGE_PIN C5  [get_ports { io_dip[15] }]

set_property PACKAGE_PIN D5  [get_ports { io_dip[16] }]
set_property PACKAGE_PIN C4  [get_ports { io_dip[17] }]
set_property PACKAGE_PIN D4  [get_ports { io_dip[18] }]
set_property PACKAGE_PIN E4  [get_ports { io_dip[19] }]
set_property PACKAGE_PIN F4  [get_ports { io_dip[20] }]
set_property PACKAGE_PIN F3  [get_ports { io_dip[21] }]
set_property PACKAGE_PIN H4  [get_ports { io_dip[22] }]
set_property PACKAGE_PIN G4  [get_ports { io_dip[23] }]

## Buttons
set_property PACKAGE_PIN G11 [get_ports { io_btn[0] }]
set_property PACKAGE_PIN H11 [get_ports { io_btn[1] }]
set_property PACKAGE_PIN H12 [get_ports { io_btn[2] }]
set_property PACKAGE_PIN J12 [get_ports { io_btn[3] }]
set_property PACKAGE_PIN P2 [get_ports { io_btn[4] }]

## Seven-Segment Displays
set_property PACKAGE_PIN G3 [get_ports { io_7seg_sel[0] }]
set_property PACKAGE_PIN G1 [get_ports { io_7seg_sel[1] }]
set_property PACKAGE_PIN H1 [get_ports { io_7seg_sel[2] }]
set_property PACKAGE_PIN H3 [get_ports { io_7seg_sel[3] }]

set_property PACKAGE_PIN J1 [get_ports { io_7seg[0] }]
set_property PACKAGE_PIN J3 [get_ports { io_7seg[1] }]
set_property PACKAGE_PIN N1 [get_ports { io_7seg[2] }]
set_property PACKAGE_PIN K4 [get_ports { io_7seg[3] }]
set_property PACKAGE_PIN K3 [get_ports { io_7seg[4] }]
set_property PACKAGE_PIN L1 [get_ports { io_7seg[5] }]
set_property PACKAGE_PIN M1 [get_ports { io_7seg[6] }]
set_property PACKAGE_PIN P1 [get_ports { io_7seg[7] }]
