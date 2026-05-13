---
source: exercise
ingested: 2026-05-13
sha256: 679a3c91703cfbffe6d252d574e95a9e3661aa3262ebd2a6faa7e357d3f854b9
conversion: pymupdf4llm
---

## Gas Dynamics 1: Tutorial 2 Laval nozzle (MATLAB) 

## Objectives 

In this tutorial, you will learn how to: 

- Use MATLAB for basic scientific computing 

- Write and use MATLAB functions 

- Compute isentropic relations for quasi-1D flows 

- Compute and plot Mach number and pressure ratio distributions in a Laval nozzle 

No prior MATLAB experience is assumed. 

## Part 1: Isentropic relations 

As discussed during the lectures, the following relations apply to a quasi-one-dimensional isentropic flow: 

**==> picture [126 x 128] intentionally omitted <==**

where 𝑀= 𝑢/𝑎 is the Mach number and 𝛾 is the specific heat ratio 

The area ratio is related to the pressure as: 

**==> picture [138 x 76] intentionally omitted <==**

𝑝! is the stagnation (total) and 𝐴[∗] is the area at which the flow reaches the speed of sound. Starred quantities denote conditions at the sonic state (𝑀= 1). 

This relation is obtained by combining area-Mach number relation with isentropic pressure *[∗] relation. Verify expression for yourself. Start from * 

**==> picture [205 x 37] intentionally omitted <==**

**==> picture [10 x 7] intentionally omitted <==**

which was derived during the lecture and use expression for ~~.~~ + 

## Instructions 

- Download files for the tutorial. 

- In the folder with provided files, create a new MATLAB script. 

- Start your script with: 

```
clc;
clear;
close all;
```

- Define constants: 

```
gamma = 1.4;
```

- Define pressure ratio range `p_p0.` Note that so that `p<=p0` . For example 

```
p_p0         = linspace(0,1);
```

- Write functions for Mach Number and density ratio as a function of pressure ratio and specific heat ratio. Create a separate Matlab function file for each function. 

- Namely, write function 

```
function M = MofP(p_p0,gamma)
```

```
% in the body of the function write an expression to compute M
% based on p_p0 and gamma
```

```
end
```

## and function 

```
function rho_rho0 = rhoOfM(M,gamma)
```

```
% in the body of the function write an expression to compute
% rho_rho0 based on M and gamma
```

```
end
```

- Write function for pressure ratio as a function of Mach number and specific heat ratio in a separate Matlab function file. Namely, write function 

```
function p_p0 = pOfM(M, gamma)
```

```
% in the body of the function write an expression to compute
```

```
% p_p0 based on M and gamma
```

```
end
```

These functions describe the relationship between Mach number and the pressure or density ratio to the stagnation/static quantity. 

- Use corresponding functions to compute ratios 𝜌[∗] /𝜌 and 𝑝[∗] /𝑝. 

The results can be printed to the Matlab command window using in-built `disp` function. For example: 

```
disp(['density ratio rho*/rho_0 at M=1: ' num2str(rhoStar_rho_0)])
```

write text to be displayed in between `' '` and convert number(s) to string using `num2str()` 

- What are the values of 𝜌[∗] /𝜌 and 𝑝[∗] /𝑝? 

- Write function for area ratio as a function of pressure ratio and specific heat ratio as a separate Matlab function file. Namely, write function 

```
function Astar_A = Astar_AofP(p_p0,gamma)
```

```
% in the body of the function write an expression to compute
% Astar_A based on p_p0 and gamma
```

```
end
```

- Use corresponding functions to compute Mach number, density ratio, and area ratio as a function of pressure ratio. 

- Compute temperature ratio as a function of pressure ratio. Hint: instead of writing a separate function, use isentropic relations to compute temperature ratio. 

- Make plots. In the first one, plot the Mach number and area ratio as a function of pressure ratio. In the second one, plot the density and area ratios as a function of pressure ratio. In the third one, plot the temperature and area ratios as a function of pressure ratio. What behaviour of the ratios as a function of Mach number can be observed? 

Hint: two functions can be plotted in the same figure by switching between left and right axes. For example: 

```
figure
yyaxis left  %use left axis
plot()  %this will be plotted using left axis
yyaxis right %use right axis
plot() %this will be plotted using right axis
```

Hint 2: instead of creating three separate figures you can use `sublot` to create the required number of plots in the same figure. For example: 

```
figure
```

```
subplot(3,1,1) %creates a subplot in 3 by 1 layout
%(vertical by horizontal) and uses the
%first of them to plot
%here goes plot command
subplot(3,1,2) %uses the second subplot to plot
%here goes plot command
subplot(3,1,3) %uses the third subplot to plot
%here goes plot command
```

Ensure all plots include: axis labels, legends, and titles. 

## Part 2: Laval nozzle: Isentropic flows 

The nozzle geometry is given by a function: 

𝑟(𝑥) = 0.5 cos(2𝜋𝑥) + 1 + 𝑟,-. −0.1(𝑥−0.5), 

for 0 ≤𝑥≤1, 

where 𝑥 – is the streamwise coordinate and 𝑟,-. = 0.4. Note, the function above creates only the top part of the nozzle streamwise cross-section, the. Bottom part is symmetric with respect to 𝑥-axis. 

- Define the nozzle geometry in Matlab (create range of 𝑥-coordinates and compute 𝑟(𝑥)). 

- Plot nozzle geometry in a separate figure. Plot the whole nozzle, i.e., top and bottom parts, in the same figure. 

- Compute cross-sectional area of the nozzle, taking into account that it has circular shape in the cross-stream direction. 

- Set sonic area (𝐴[∗] ) to be equal to the throat area. 

- Define reservoir conditions for pressure, namely define 𝑝0 = 100000. 

- Compute both the subsonic and supersonic solutions of the quasi-1D nozzle equations downstream of the throat. Use the provided function `calcPMofA` with correct inputs. Note, function `calcPMofA` uses M `ofP` function created in the first part of this practical class. 

- Compute Mach number and pressure ratio distribution in the nozzle assuming sonic conditions at the throat and supersonic solution in the divergent part. Use the provided function `calcPMofA` with correct inputs. 

   - `[p_p0, M] = calcPMofA(r, Astar, p0, gamma, subsonic)` Open and read the content of this function file to understand required inputs. Note, function `calcPMofA` uses `MofP` function created in the first part of this practical class. 

- Plot results. 

- What are values of Mach number and pressure ratio at the entrance, throat and exit of the nozzle for subsonic and supersonic solutions? 

- Compute and plot a fully subsonic solution. Hint: to obtain a fully subsonic flow * 

- throughout the nozzle, use 𝐴[∗] < 𝐴,-.  so that > 1 everywhere in the nozzle. *[∗] 

