# Universal Shift Register in Verilog

## 📌 Project Overview

This project implements a **parameterized Universal Shift Register** using Verilog HDL.

The register supports four operations:

- Hold the current value
- Shift right
- Shift left
- Parallel load

The design also includes an **asynchronous active-low reset**.

The main purpose of this project is to practice sequential circuit design, combinational logic, and basic functional verification using a self-checking testbench.

## ⚙️ Features

- Parameterized data width (`N`, default = 4 bits)
- Bidirectional shifting
- Parallel data loading
- Hold operation
- Asynchronous active-low reset
- Two-block RTL coding style
- Self-checking Verilog testbench

## 🧠 Design Architecture

The design uses two separate `always` blocks.

**1. Sequential Logic**

```verilog
always @(posedge clk or negedge reset)
```

This block stores the register value on each rising clock edge and handles asynchronous reset.

**2. Combinational Logic**

```verilog
always @(*)
```

This block calculates `q_next` based on the selected operation.

The design separates the current state (`q_reg`) from the next state (`q_next`).

## 🔄 Operation Table

| sel | Operation | Description |
|-----|-----------|-------------|
| 00 | Hold | Keep the previous value |
| 01 | Shift Right | Insert MSB and shift right |
| 10 | Shift Left | Shift left and insert LSB |
| 11 | Parallel Load | Load input data I |

## 🔌 Input and Output Signals

| Signal | Direction | Description |
|--------|-----------|-------------|
| clk | Input | Clock signal |
| reset | Input | Active-low asynchronous reset |
| sel[1:0] | Input | Operation selector |
| I[N-1:0] | Input | Parallel input data |
| MSB | Input | Serial input for right shift |
| LSB | Input | Serial input for left shift |
| q[N-1:0] | Output | Register output |

## 🧪 Verification

A basic self-checking testbench was developed to verify the functionality of the shift register.

The testbench includes:

- Clock generation
- Parallel load testing
- Shift-right testing
- Shift-left testing
- Hold operation testing
- Asynchronous reset testing
- Expected-output comparisons using `!==`

The testbench compares the actual output against manually calculated expected values and reports failures using `$display`.

## 🛠️ Tools

- Verilog HDL
- EDA Playground (simulation)

## 🎯 Learning Outcomes

Through this project, I practiced:

- Designing parameterized sequential circuits
- Separating combinational and sequential logic
- Using blocking and nonblocking assignments correctly
- Implementing shift operations using concatenation
- Understanding asynchronous reset behavior
- Writing basic self-checking testbenches
- Debugging RTL and testbench code

## 🚀 Future Improvements

- Add more test cases and edge cases
- Introduce automatic reference-model checking
- Add randomized test inputs
- Improve test reporting with PASS/FAIL summaries

## 📚 Project Status

**Learning Project — RTL Design and Basic Verification**

This project was developed as part of my Verilog HDL learning journey to strengthen my understanding of digital circuit design and simulation.
