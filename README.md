[//]: # (Image References)

[fos_model]: ./docs/fos_model.png "FOS Model"

# Fast Orthogonal Search (FOS) Algorithm
Implementation of Fast Orthogonal Search (FOS) Algorithm as described in this paper:
```
@article{Korenberg:1989:ROA:2733743.2733908,
 author = {Korenberg, M. J.},
 title = {A Robust Orthogonal Algorithm for System Identification and Time-series Analysis},
 journal = {Biol. Cybern.},
 issue_date = {February  1989},
 volume = {60},
 number = {4},
 month = feb,
 year = {1989},
 issn = {0340-1200},
 pages = {267--276},
 numpages = {10},
 url = {http://dx.doi.org/10.1007/BF00204124},
 doi = {10.1007/BF00204124},
 acmid = {2733908},
 publisher = {Springer-Verlag New York, Inc.},
 address = {Secaucus, NJ, USA},
} 
```

## What is FOS?

![FOS Model][fos_model]

FOS tries to provide a mathematical model to map the input signal of a system to its output signal, using a time-series polynomail equation. 
For a system that produces, at epoch <a href="https://www.codecogs.com/eqnedit.php?latex=n" target="_blank"><img src="https://latex.codecogs.com/svg.latex?n" title="n" /></a>, output <a href="https://www.codecogs.com/eqnedit.php?latex=y[n]" target="_blank"><img src="https://latex.codecogs.com/svg.latex?y[n]" title="y[n]" /></a> for input <a href="https://www.codecogs.com/eqnedit.php?latex=x[n]" target="_blank"><img src="https://latex.codecogs.com/svg.latex?x[n]" title="x[n]" /></a>, FOS tries to model the output as a summation of polynomial terms:

<a href="https://www.codecogs.com/eqnedit.php?latex=y_{1}[n]&space;=&space;\sum_{m=0}^{M}&space;a_{m}p_{m}[n]" target="_blank"><img src="https://latex.codecogs.com/svg.latex?y_{1}[n]&space;=&space;\sum_{m=0}^{M}&space;a_{m}p_{m}[n]" title="y_{1}[n] = \sum_{m=0}^{M} a_{m}p_{m}[n]" /></a>

where each polyomial term, <a href="https://www.codecogs.com/eqnedit.php?latex=p_{m}[n]" target="_blank"><img src="https://latex.codecogs.com/svg.latex?p_{m}[n]" title="p_{m}[n]" /></a> 
is a product of inputs and/or outputs, possibly at different epochs:

<a href="https://www.codecogs.com/eqnedit.php?latex=p_{m}[n]=\prod_{o=1}^{O}c_{o}[n]" target="_blank"><img src="https://latex.codecogs.com/svg.latex?p_{m}[n]=\prod_{o=1}^{O}c_{o}[n]" title="p_{m}[n]=\prod_{o=1}^{O}c_{o}[n]" /></a>

such that:

<a href="https://www.codecogs.com/eqnedit.php?latex=c_{o}[n]=\left\{\begin{matrix}&space;1&space;&&space;\\&space;x[n-l]&space;&&space;l=0,1,2,...,L&space;\\&space;y[n-k]&space;&&space;k=1,2,...,K&space;\end{matrix}\right." target="_blank"><img src="https://latex.codecogs.com/svg.latex?c_{o}[n]=\left\{\begin{matrix}&space;1&space;&&space;\\&space;x[n-l]&space;&&space;l=0,1,2,...,L&space;\\&space;y[n-k]&space;&&space;k=1,2,...,K&space;\end{matrix}\right." title="c_{o}[n]=\left\{\begin{matrix} 1 & \\ x[n-l] & l=0,1,2,...,L \\ y[n-k] & k=1,2,...,K \end{matrix}\right." /></a>



The FOS algorithm aims to minimize the error <a href="https://www.codecogs.com/eqnedit.php?latex=e[n]&space;=&space;y_{1}[n]&space;-&space;y[n]" target="_blank"><img src="https://latex.codecogs.com/svg.latex?e[n]&space;=&space;y_{1}[n]&space;-&space;y[n]" title="e[n] = y_{1}[n] - y[n]" /></a> between the actual output, <a href="https://www.codecogs.com/eqnedit.php?latex=y[n]" target="_blank"><img src="https://latex.codecogs.com/svg.latex?y[n]" title="y[n]" /></a> and the predicted output, <a href="https://www.codecogs.com/eqnedit.php?latex=y_{1}[n]" target="_blank"><img src="https://latex.codecogs.com/svg.latex?y_{1}[n]" title="y_{1}[n]" /></a>.

<a href="https://www.codecogs.com/eqnedit.php?latex=O" target="_blank"><img src="https://latex.codecogs.com/svg.latex?O" title="O" /></a>, <a href="https://www.codecogs.com/eqnedit.php?latex=L" target="_blank"><img src="https://latex.codecogs.com/svg.latex?L" title="L" /></a> and <a href="https://www.codecogs.com/eqnedit.php?latex=K" target="_blank"><img src="https://latex.codecogs.com/svg.latex?K" title="K" /></a> are paremeters to the FOS algorithm and are therefore determined by the user:
- <a href="https://www.codecogs.com/eqnedit.php?latex=O" target="_blank"><img src="https://latex.codecogs.com/svg.latex?O" title="O" /></a> is the maximum order of the polynomial
- <a href="https://www.codecogs.com/eqnedit.php?latex=L" target="_blank"><img src="https://latex.codecogs.com/svg.latex?L" title="L" /></a> is the maximum lag in input that the current output can depend on
- <a href="https://www.codecogs.com/eqnedit.php?latex=K" target="_blank"><img src="https://latex.codecogs.com/svg.latex?K" title="K" /></a> is the maximum lag in output that the current output can depend on

If, <a href="https://www.codecogs.com/eqnedit.php?latex=L" target="_blank"><img src="https://latex.codecogs.com/svg.latex?L" title="L" /></a> and <a href="https://www.codecogs.com/eqnedit.php?latex=K" target="_blank"><img src="https://latex.codecogs.com/svg.latex?K" title="K" /></a> are set to zero, then FOS will aim to find the relationship between the input and output for a time-independent system.



## Getting Started
We advise you to run tests `test1.m` and `test2.m` and go through their code to understand how to train and evaluate a model using FOS.

## Citing Author
If you find this code useful in your work, please cite the following paper by the author of the code:
```
@article{ElhoushiSurvvey2017,
  author = {Elhoushi, Mostafa and Georgy, Jacques and Noureldin, Aboelmagd and Korenberg, Michael J.},
  title = {A Survey on Approaches of Motion Mode Recognition Using Sensors},
  journal = {IEEE Trans. Intelligent Transportation Systems},
  keywords = {activity_recognition},
  number = 7,
  pages = {1662-1686},
  url = {https://ieeexplore.ieee.org/document/7726001},
  volume = 18,
  year = 2017
}
```
