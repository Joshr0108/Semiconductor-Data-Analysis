# MATLAB Project
## Overview

These MATLAB scripts are used to automate the calculations, regression and representation of semiconductor data.
Scripts were written in MATLAB 2024b.

## Files

### [HallVoltage_Temp.m]
This file takes experimentally gathered, hall voltage and temperature, data and fits data to 3rd-order polynomial
Analysis uses polynomial fit to determine how much temperature variation is allowed around $80\degree$ and $30\degree$ to maintain a $\pm 10%$ accuracy in hall voltage

![image](https://github.com/user-attachments/assets/cffe608b-3aeb-4d14-9ea9-af61ee899dd7)


### [Mobility_Temp.m]
This file takes experimentally gathered temperature data and calculated mobility data then fits it to 3rd-order polynomial
Analysis uses the polynomial fit to determine what temperature sees a $20%$ drop in mobility compared to room temperature ($\approx 299.4K$)

![image](https://github.com/user-attachments/assets/296b98a9-9cad-42ac-a578-9776acea1a2f)


### [logCC_T.m]
This file uses experimentally gathered temperature data and carrier concentration data calculated with other measured variables
Analysis of data determines the crossover point between intrinsic and extrinsic carrier concentration dominances

![image](https://github.com/user-attachments/assets/50ac9eab-3e89-4c76-8d46-01538de65eeb)


### [GraphAnalysis.m]
The I-V data was collected from different diodes A -> J with a range of threshold voltage to near-saturation voltage
This file loads in each file and the first half of the script allows for the linear region voltage range to be determined. The second half takes the range, fits a line and uses the gradient to determine ideality factor. e.g. Diode C...

![image](https://github.com/user-attachments/assets/85cfd172-3dac-481b-9764-7cf8ea168b19)
  
  

### [BandgapCalc.m]
Given the equation, $$J=J_0  \exp⁡(\frac{(e(V-V_g))}{ηkT})$$
I took the known bandgap value for two diodes and calculated a mean value for $J_0$ 
Assuming the different in $J_0$ to be neglible between each diode compared to the exponential term, it was treated as a constant in calculating bandgap for the other diodes

Rearranging the orignal equation, $$V_g=V-\frac{ηkT}{e} \ln⁡(\frac{J}{J_0} )$$
  Other variables are gathered experimentally, known constants or calculated - similar to previous scripts.


## Usage

To use any of the scripts or functions, ensure you have MATLAB installed. Clone this repository and run the desired `.m` file in MATLAB.
