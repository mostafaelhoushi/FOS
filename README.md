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
For a system that produces, at epoch `n`, output `y[n]` for input `x[n]`, FOS tries to model the output as a summation of polynomial terms:

<a href="https://www.codecogs.com/eqnedit.php?latex=y_{1}[n]&space;=&space;\sum_{m=0}^{M}&space;a_{m}p_{m}[n]" target="_blank"><img src="https://latex.codecogs.com/svg.latex?y_{1}[n]&space;=&space;\sum_{m=0}^{M}&space;a_{m}p_{m}[n]" title="y_{1}[n] = \sum_{m=0}^{M} a_{m}p_{m}[n]" /></a>

where each polyomial term, <a href="https://www.codecogs.com/eqnedit.php?latex=p_{m}[n]" target="_blank"><img src="https://latex.codecogs.com/svg.latex?p_{m}[n]" title="p_{m}[n]" /></a> is expressed as:



The FOS algorithm aims to minimize the error `e[n] = y1[n] - y[n]` between the actual output, `y[n]` and the predicted output, `y1[n]`.
- `L` and `K` are paremeters invoked by the user



## Getting Started

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
