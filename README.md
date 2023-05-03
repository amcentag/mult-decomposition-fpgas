# mult-decomposition-fpgas
Vivado project files for different 64x64-bit multiplication decomposition strategies. Created for ECE Senior Capstone Design project, spring 2023.

Each folder in master is its own Vivado project, implementing a different solution method to decompose 64x64-bit multiplication using the 27x18-bit multipliers in the DSP blocks of the Xilinx Ultrascale+. All designs should be implemented close to the maximum clock frequency, except for implemented-toom-7.

"implemented-karatsuba-9dsp" uses the Karatsuba algorithm recursively, splitting inputs into two pieces twice, using 9 DSPs.
"implemented-karatsuba-10dsp" uses the Karatsuba algorithm with splitting inputs into four pieces each, using 10 DSPs.
"implemented-toom-multiplier" contains our proposed Toom-2.5 method, using 8 DSPs.
"implemented-toom-7" is the implementation of Toom-2.5 on the Kintex-7, used for a comparison of hardware area requirements to the literature.
