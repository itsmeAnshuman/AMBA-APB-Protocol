# AMBA-APB-Protocol
The APB protocol is a low-cost interface, optimized for low power consumption and reduced interface 
complexity protocol used in AMBA. 

# key features.
- It is primarily designed for connecting low-speed peripherals such as timers, UARTs, and GPIOs to the 
high-performance system bus. 
- The APB interface is “non-pipelined” means only one transaction happened at a time. The next read or 
write cannot begin until the current transfer is completely finished. 
- APB is simpler compared to AXI and AHB, supporting single cycle transfers with minimal power 
consumption.

## Block Diagram
![Block Diagram](https://github.com/itsmeAnshuman/AMBA-APB-Protocol/blob/main/Screenshot%202025-11-23%20000615.png)

### 🧩 APB Working Principle (3-State Transfer)

The AMBA APB protocol performs each data transfer in three simple states:

1. **IDLE**
   - No active transfer
   - `PSEL = 0`, `PENABLE = 0`

2. **SETUP**
   - Master selects the slave and drives address & control signals
   - `PSEL = 1`, `PENABLE = 0`

3. **ACCESS**
   - Actual read/write data transfer occurs
   - `PSEL = 1`, `PENABLE = 1`
   - Transfer completes when `PREADY = 1`

After ACCESS, the bus either returns to **IDLE** or begins another **SETUP** for back-to-back transfers.

