---
layout: default
---

Miscellanea
-------

### Code

A mix of vignettes for little `R` packages I make as part of my research and statistical musings, i.e. things I thought about for a while but are not publishable or notes to myself that I thought could also be helpful to others.


<!--* Three Gibbs Samplers for the Bayesian Lasso -->
* [Getting Started with Github and RStudio](https://maryclare.github.io/gitr.html)
* [Working With the Exponential Power Distribution Using `gnorm`](http://htmlpreview.github.com/?https://github.com/maryclare/gnorm/blob/master/inst/doc/gnormUse.html)
* [Solving Regression Problems with Power Penalties Using `powopt`](http://htmlpreview.github.com/?https://github.com/maryclare/powopt/blob/master/inst/doc/powoptUse.html)

### Papers I Want To Read and Would Probably Love

* 1/4/2024-1/11/2024
  * [Jana, Fan, and Kulkarni, "A General Theory for Robust Clustering via Trimmed Mean"](https://arxiv.org/pdf/2401.05574.pdf) addresses the important problem of clustering when the data have Gaussian or heavier-than-Gaussian tails, which seems of great practical importance!
  * [Dobriban, Su, Yang, and Zhang, "Robust Inference Under Heteroskedasticity via the Hadamard Estimator"](https://arxiv.org/pdf/1807.00347.pdf) looks like a super interesting paper about properties of an alternative to Whit's sandwich estimator!
  * [Sun, "Do we need to estimate the variance in robust mean estimation?"](https://arxiv.org/pdf/2107.00118.pdf) introduces a new method for obtaining an efficient estimator of the mean in the presence of heavy tails without having to estimate the unknown variance parameter, which is needed for tuning!
  * [Rodriguez-Alvarez, Inacio, and Klein, "Density regression via Dirichlet process mixtures of normal structured additive regression models"](https://arxiv.org/pdf/2401.03881.pdf) is an interesting paper introducing a new model that can relate the distribution of a continuous variable to covariates!
  * [Sanz-Alonso and Waniorek, "Hierarchical Bayesian Inverse Problems"](https://arxiv.org/pdf/2401.03074.pdf) is an interesting paper exploring the properties of the posterior mode for Bayesian penalized regression problems.
  * [Hallin and Konen, "Multivariate Quantiles: Geometric and Measure-Transportation-Based Contours"](https://arxiv.org/pdf/2401.02499.pdf) addresses the important problem of defining and computing quantiles of multivariate distributions!
  * [Craiu and Meng, "Perfecting MCMC Sampling: Recipes and Reservations"](https://arxiv.org/pdf/2401.02518.pdf) looks like a fantastic review of coupling methods in MCMC methodology!
  * [Pearse, Cressie, and Gunawan, "Optimal prediction of positive-valued spatial processes: asymmetric power-divergence loss"](https://arxiv.org/pdf/2401.02828.pdf) is an interesting paper about the use of alternative measures of loss when working with positive valued data, which considers log-Gaussian progesses as a special case!
  
* 12/31/2023-1/3/2024
  * [Deliu and Liseo, "Alternative Approaches for Computing Highest-Density Regions"](https://arxiv.org/pdf/2401.00245.pdf) addresses the important problem of computing highest-density regions for multivariate data, which seems relevant to characterizing the MCMC output in high dimensional problems!
  * [Korte-Stapff, Karvonen, and Moulines, "Smoothness Estimation for Whittle-Matern Processes on Closed Riemannian Manifolds"](https://arxiv.org/pdf/2401.00510.pdf) examines estimation of the smoothness parameter of the Matern covariance function, which is something I think is important!
  * [Soloff, Guntuboyina, and Sen, "Multivariate, Heteroscedastic Empirical Bayes via Nonparametric Maximum Likelihood"](https://arxiv.org/pdf/2109.03466.pdf) addresses the problem of multivariate mean estimation from heteroscedastic data using the nonparametric maximum likelihood estimator for Gaussian location mixtures, which is something I've been meaning to learn more about!
  * [Muehlebach and Jordan, "Accelerated First-Order Optimization under Nonlinear Constrants"](https://arxiv.org/pdf/2302.00316.pdf) introduces new accelerated first order algorithms that apply to $\ell_q$ penalized regression, which is of great interest to me!
  * [Kent, "Penalty Parameter Selection in Deconvolution by Estimating the Risk for a Smaller Sample Size"](https://arxiv.org/pdf/2401.01478.pdf) is an interesting paper about the deconvolution problem, which is a problem I would like to learn more about!
  * [Kubal, Campbell, and Robeva "Log-concave Density Estimation with Independent Components"](https://arxiv.org/pdf/2401.01500.pdf) addresses the challenging problem of performing log-concave density estimation for a multivariate density.
  * [Kanagawa, Barp, Gretton, and Mackey, "Controlling Moments with Kernel Stein Discrepencies"](https://arxiv.org/pdf/2211.05408.pdf) examines the performance of Kernel Stein discepancies, which are quantities that can be used to measure the quality of an approximation. Specifically, it addresses how/when Kernel Stein discrepancies can be interpreted in terms of convergence of moments of the distribution that is being approximated, which seems very valuable!
  
