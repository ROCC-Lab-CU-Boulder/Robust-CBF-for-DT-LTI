# Building Robust Control Barrier Functions from Robust Maximal Output Admissible Sets
This repository contains MATLAB source code for the paper [Building Robust Control Barrier Functions from
Robust Maximal Output Admissible Sets].


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
We included two example files `rdcbf_example1.mlx` and `rdcbf_example2.mlx` as MATLAB Live Scripts that will guide you in using the
package. They solve Examples 1 and 2, respectively, of our paper.

## Acknowledgements
This work was supported by the University of Colorado Boulder.
