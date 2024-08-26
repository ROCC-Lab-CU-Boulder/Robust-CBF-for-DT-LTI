# Building Robust Control Barrier Functions from Robust Maximal Output Admissible Sets
This repository contains MATLAB source code for the paper [Building Robust Control Barrier Functions from
Robust Maximal Output Admissible Sets].


For more information about our work, please visit [ROCC Team@CU Boulder](https://www.colorado.edu/faculty/nicotra/robotics-optimization-and-constrained-control).

## MATLAB
### Dependencies & Installation
The following MATLAB toolboxes are required:
* [Optimization Toolbox](https://www.mathworks.com/products/optimization.html)
* [Control Systems Toolbox](https://www.mathworks.com/products/control.html)

The following tools are recommended:
* [MPT3](https://www.mpt3.org/) for visualizing the RMOAS.
* [YALMIP](https://yalmip.github.io/) to streamline the QP formulation.
* [MOSEK](https://www.mosek.com/) as a specialized convex QP solver. Free [academic licenses](https://www.mosek.com/products/academic-licenses/) are available 

The package is lightweight and there is no installation beyond adding the folder to
your path:
```
addpath(userpath+"\Robust-CBF-for-DT-LTI")
```
We included two example files `rdcbf_example1.mlx` and `rdcbf_example2.mlx` as MATLAB Live Scripts that will guide you in using the
package. They solve Examples 1 and 2, respectively, of our paper.

## Acknowledgements
This work was supported by the University of Colorado Boulder and the NSF-CMMI Award #2411667.
