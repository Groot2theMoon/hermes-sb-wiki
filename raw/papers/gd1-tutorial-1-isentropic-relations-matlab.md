---
source_url: ""  # PDF from Telegram
ingested: 2026-04-29
sha256: 47cfbe500ada107b6404cf37876ad9d75b83cbc5f8026693ab9f856e631c99e2
type: tutorial
course: "Gas Dynamics 1"
---

Gas Dynamics 1: Tutorial 1 Isentropic Flow Relations (MATLAB) 

## Objectives 

In this tutorial, you will learn how to: 

- Use MATLAB for basic scientific computing 

- Compute thermodynamic and flow relations 

- Plot engineering data 

- Understand isentropic flow behaviour 

No prior MATLAB experience is assumed. 

## Part 1: Speed of Sound vs Temperature 

Theory 

For a perfect gas: 

𝑎= #𝛾𝑅!𝑇 

Where: 

- γ = 1.4 (air) – specific heat ratio 

- R = 287 J/(kg·K) – specific gas constant 

- T –  temperature (K) 

## Instructions 

- Open MATLAB. In case this is the first time you are using Matlab familiarise yourself with interface layout. In the Command Window, you can type commands directly but for this tutorial, we will create a script 

- Click **New Script** 

- Save it as: `isentropic_relations.m` 

- Start your script with: 

```
clc;
clear;
close all;
```

These lines ensure a clean start. 

`clc` - clears command window `clear` - Clears variables in the workspace `close all` - Closes all figures 

- Define constants: 

```
gamma = 1.4;
R = 287;
```

- Create temperature range: 

```
T = linspace(200, 1000, 100);
```

`x=linspace(x1,x2,n)` – creates a row vector (x) of n linearly spaced points between two specified end points (x1 and x2) 

- Compute speed of sound: 

```
a = sqrt(gamma * R .* T);
```

## `.*` - elementwise multiplication 

- Plot result: 

```
figure;
plot(T, a, 'k', 'LineWidth', 2);
grid on;
xlabel('Temperature (K)');
ylabel('Speed of Sound (m/s)');
title('Speed of Sound vs Temperature');
```

`figure` – creates a figure 

`plot(x,y)` – creates a 2-D line plot in the figure of the data in y versus values in x `'k' –` specifies colour of the line ( `k` – black colour). Colour can be specified using words, e.g., `red` , `green` , `blue` , `yellow` , `magenta` , `cyan` ; using first letter of the corresponding colour, e.g., `r` for red, `g` for green, `b` for blue, etc. Alternatively, colours can be specified using property `'color'` followed by RGB triplet, e.g., `'color', [1 0 0]` for red, `'color', [0 0.5 0]` for green, `'color', [1 0 1]` for magenta, etc. In case no colour is specified, Matlab will use default colours. There are 7 default colours in Matlab: 

**==> picture [115 x 124] intentionally omitted <==**

In case you plot 8 curves using default colours, the colour of the 8[th] curve will be the same as those of the first one. 

`'LineWidth', 2` – specifies width of the line in the plot 

`grid on` – turns on grid on the plot `xlabel('name')` – specifies name of for x-axis `ylabel('name')` – specifies name of for y-axis `title('plot title')` – specifies title of the plot 

- Now as you plotted speed of sound in air as a function temperature 

   - Is the speed of sound constant? 

   - `o` How does speed of sound behaves as the temperature increases? 

## Part 2: Isentropic Flow Relations 

For isentropic flow: 

**==> picture [149 x 120] intentionally omitted <==**

Derive relation for speed of sound 

> *! (Tip use definition of the speed of sound for ideal gas). * 

## Instructions 

In the same script compute isentropic relations and plot them 

- Define Mach number range from 0 to 10 

- + 

- • Compute 

**==> picture [9 x 8] intentionally omitted <==**

- , 

- • Compute 

   - ,! 

- 

- • Compute 

- -! * 

- • Compute 

   - *! 

- Plot results in one figure. Tip: use `hold on` after plotting the first curve to keep all curves 

- Add legend to the plot `legend('name of the first curve', 'name of the second curve', <add all names>)` 

- As the Mach number increases how temperature, pressure, density, and speed of sound behave? 

- Why does the speed of sound decrease in accelerating flow? 

## Part 3: Use Functions to Compute Isentropic Flow Relations 

## Instructions 

- Instead of computing all relations in the same script create separate functions (one function for each relation) to compute them. Functions can be added either to the end of the existing script or saved as separate Matlab files in the same folder. 

- Once you wrote functions for computing isentropic relations, call these functions in the script and plot the results. 

Function syntax 

```
function [output1,…,outputN] = myfunction(input1,...,inputM)
```

```
output1 = input1 + input2;
```

```
end
```

`myfunction` – name of the function `input1,...,inputM` – inputs to the function `myfunction output1,…,outputN` – outputs of the function `myfunction` 

Inside the body of the function write code to compute output based on the input. 

