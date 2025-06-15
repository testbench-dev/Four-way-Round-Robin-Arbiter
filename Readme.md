# 4-Way Round-Robin Arbiter (rr_arbiter)

A minimal, pure-Verilog arbitration core that fairly grants one of four requesters access on a rotating basis. Includes a self-checking testbench and end-to-end Vivado 2024.2 WebPACK flow with PPA reports.

---

## Features

- **One-hot grant** for four requesters  
- **Round-robin priority** rotation to prevent starvation  
- **Zero external dependencies** (pure Verilog-2001)  
- **Self-checking testbench** verifies single-grant and request-only rules  
- **Vivado scripts** for batch simulation, synthesis, and implementation  
- **Ultra-compact PPA** on Artix-7 (xc7a35t):  
  - **Slice LUTs:** 8  
  - **Slice Registers:** 2  
  - **Bonded IOBs:** 10  
  - **BUFGCTRL:** 1  
  - **No BRAM / DSP blocks**  
  - **Meets 250 MHz timing** (positive slack)

---



