# intervention-estimation

This code is for intervention estimaton paper preprint using Python as a programming language to estimate interventions using simulated data.

## Abstract
Large-scale models require huge computational resources for analysis and studying interventions. Specifically, estimating intervention effects using simulations may require a lot of resources that are infeasible to allocate at every treatment condition, and therefore, it is important to come up with efficient methods to allocate computational resources for estimating intervention effects. Agent-based simulation allows us to generate highly realistic simulation samples. FRED (A
Framework for Reconstructing Epidemiological Dynamics) is an agent-based modeling system with a geospatial perspective using a synthetic population that is constructed based on the U.S. census data. Given its synthetic population, FRED simulations present a baseline to get comparable results from different treatment conditions and interventions. In this paper, we show three different methods for estimating intervention effects. In the first method, we resort to the brute-force allocation where all interventions have an equal number of sampling with a relatively large number of simulation runs. In the second method, we try to optimize the number of simulation runs by customizing individual samples required for each intervention effect based on a the width of confidence intervals around the mean estimates. Finally, in the third method, we use a regression model which allow us to lean across the treatment conditions such that simlation samples allocated for an treatment condition will help in better estimating intervention effects in other (especially nearly) treatments. We show the latter method results in a comparable estimate of intervention effects with less computational resources. The reduced variability and faster convergence of model-based estimates come at the cost of increased biased and the bias-variance tradeoff can be controlled by adjusting the number of model parameters (e.g., including higher order interaction terms in the regression model). 