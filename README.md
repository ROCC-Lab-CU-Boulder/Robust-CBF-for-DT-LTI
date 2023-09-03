# RMOAS-RDCBF: Systematic Design of Robust Discrete-time Control Barrier Functions for Linear Systems
This repository contains MATLAB source code for the paper [Robust Constrained Control using
Discrete-time Control Barrier Functions].


For more information about our work, please visit [ROCC Team@CU Boulder](https://www.colorado.edu/faculty/nicotra/robotics-optimization-and-constrained-control).

## MATLAB
### Dependencies & Installation
The MATLAB implementation requires a working installation of [MPT3](https://www.mpt3.org/) and
we recommend using [YALMIP](https://yalmip.github.io/) to instantiate the quadratic program
(QP) and [MOSEK](https://www.mosek.com/) to solve it (note that you will need a license, but free academic licenses are available).

You might also find the following MATHWORKS toolboxes useful/necessary:
* Optimization Toolbox
* Symbolic Math Toolbox
* Control Systems Toolbox

The package is lightweight and there is no installation beyond adding the following folders to
your path:
```
addpath(userpath+"\RMOAS-RDCBF")
```
The example file `rdcbf_example.mlx` is a MATLAB Live Script that will guide you in using the
package and solves the Example 1 of our paper.

### Example
For a quick-start, inspect the file `matlab/vcp_bk/vcp_bk_example.m` and run it.
You should see the following plots.

<p align="center">
  <img src="https://github.com/ARC-Lab-Research-Group/FlatVCP/blob/master/img/bk_matlab_example_path.png" width="500" alt="Bicycle MATLAB Example Path">
</p>
<p float="center">
  <img src="https://github.com/ARC-Lab-Research-Group/FlatVCP/blob/master/img/bk_matlab_example_state.png" width="400" alt="Bicycle MATLAB Example State">
  <img src="https://github.com/ARC-Lab-Research-Group/FlatVCP/blob/master/img/bk_matlab_example_input.png" width="400" alt="Bicycle MATLAB Example Input">
</p>

## Acknowledgements
This work was supported by the University of Colorado Boulder.
