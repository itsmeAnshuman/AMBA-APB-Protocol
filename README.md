# AMBA-APB-Protocol
The APB protocol is a low-cost interface, optimized for low power consumption and reduced interface 
complexity protocol used in AMBA. 
#key features.
- It is primarily designed for connecting low-speed peripherals such as timers, UARTs, and GPIOs to the 
high-performance system bus. 
- The APB interface is “non-pipelined” means only one transaction happened at a time. The next read or 
write cannot begin until the current transfer is completely finished. 
- APB is simpler compared to AXI and AHB, supporting single cycle transfers with minimal power 
consumption. 
