# Single-Cycle RISC-V Processor (RV32I) – RTL Design & Simulation

This project implements a **single-cycle RISC-V processor** supporting a subset of the RV32I instruction set. The processor is designed in **SystemVerilog**, simulated using **Icarus Verilog**, and validated using **GTKWave** for waveform visualization.

> This project is part of my **RTL Design portfolio** and demonstrates strong understanding of processor architecture, testbench design, and waveform-based validation.


## Features

- **ISA:** RV32I (subset)
- **Architecture:** Single-cycle
- **Language:** SystemVerilog
- **Simulation Tool:** Icarus Verilog (`iverilog`)
- **Waveform Viewer:** GTKWave
- **Testbench:** Custom directed tests
- **Validation:** Waveform screenshots attached


## Instructions Implemented & Validated

Each of the following instructions was tested using directed assembly test cases and validated using GTKWave:

| Instruction | Operation                | Status |
|------------|--------------------------|--------|
| `addi`     | Add immediate            | ✅     |
| `or`       | Bitwise OR               | ✅     |
| `sw`       | Store word               | ✅     |
| `lw`       | Load word                | ✅     |
| `beq`      | Branch if equal          | ✅     |
| `jal`      | Jump and link            | ✅     |

Waveform screenshots demonstrating each instruction’s behavior are included.
