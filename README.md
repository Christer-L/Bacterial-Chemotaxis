# Modelling bacterial chemotaxis (Biomedical Modelling, 2019)

Run and tumble numerical models simulate bacterial motion, and interaction with environment. Here we built a model based on Berg and Brown work published in 1972. In this article, they demonstrated particular behavior of Escherichia Coli regarding randomness in linear displacement length (called run phase) and in motion direction (a new angular orientation chosen in tumble phase). According to their results, run length was influenced by nutrients concentration in environment, as they observed the impact of Serine and Aspartate to different strains of E coli.

Our model simulates Serine gradient and its effect on bacterium behaviour. We developed two approaches to simulate change of angle in tumble process by utilizing data from article by Berg and Brown. Additionally, Gamma distribution-based model for run behaviour is demonstrated and tested in different conditions. We confirm that numerical models can be used to analyze stochastic processes in bacterium movement and provide a framework for simulating bacterium behaviour. Therefore new submodels can be created as further development and applied in combination with functionalities built in this project.

## Model framework: environment and agents

Simulation environment (file: environment.m; Fig.1, A), and agent function (file: agent.m; Fig.1, B) were designed to allow flexible application of different submodels for bacterium run and tumble behaviour. Model functionalities are segmented into functions that can be used as input parameters for submodules part of the main framework (Fig. 1, marked in yellow). Given approach reduces interdependency between model components and simplifies further development of additional submodels responsible for gradient, run and tumble functionalities (Fig 1, marked in green).

![](https://github.com/Christer-L/Bacterial-Chemotaxis/blob/master/img/dependencies.png?raw=true)
**Figure 1. Modular dependencies**

## Environment

Environment submodule is responsible for the initiation of simulation environment and agents. First, concmap function (file: concmap.m; Fig. 3, C) is called out to generate Serine gradient matrix with p[Ser] values (p[Ser] as log10 of Serine concentration). Concmap needs to be provided with a function responsible for generating a normalized gradient map (with values in range between 0 and 1). For following experiments, we designed a normgrad function (file: normgrad.m, Fig. 3, D), which generates circular gradient originating from the middle of the map. Additional gradient submodules can be implemented by following the design pattern of normgrad.
After gradient setup, agents are initiated to provide environment submodule a trajectory plot. When agents have finished simulating the motion of bacteria, a figure is presented where all trajectories are plotted on the gradient to better visualize the relationship between agent behaviour and environment.

## Agent

Agent is a function/submodule responsible for simulating the behaviour of bacterium with provided concentration map and submodels for run and tumble. Additionally, amount of iterations is taken as a parameter. Agent utilizes tumble after every run to change the angle of movement. Run termination or continuation is determined through run submodel by providing it information about concentration and run length in progress.

## Models for bacterium tumble

First, we implemented two potential models for tumble angle generation that could be used in combination with other functionalities to simulate the behaviour of bacterium. Two types of approaches were applied to develop a model capable of describing change in angle of the movement during tumble process.

### Beta distribution-based model

In first case, we relied on experimental data provided by Berg et al., to develop a Beta distribution-based model. We collected data points from Figure 3 (Berg et al.) describing amounts of tumbles ending with different change in angles (summed into 18 intervals, Fig 2. A) with a goal to construct a Cumulative Density Function (CDF) describing probability for a tumble change of angle to be smaller than given angle in range of 0 to 180 degrees (Fig. 2, B). Brute force approach was implemented in curve fitting to find optimal parameters for Beta distribution (Figure 2. C). We took a step of 0.1 in a region of 0 to 10 for both a and b to test out the fit for different curves by applying least squares function. Fitting of Beta distribution was carried out in local Jupyter Notebook using Python with scipy, numpy and matplotlib packages.


![](https://github.com/Christer-L/Bacterial-Chemotaxis/blob/master/img/curve_fitting.png?raw=true)
**Figure 2. Curve fitting |** (**A**) Probability mass function of experimental data. (**B**) Cumulative density function of based on PMF of experimental data. (**C**) Comparison of CDF from live experiment and generated Beta function distribution.  

Using received parameters from fitting we implemented a function tumble (file: tumble.m; Fig. 3, E) for generating random angle values for tumble process. In given function betainv method from statistics package is utilized to map Beta distributed angles back from uniform random distribution.

![](https://github.com/Christer-L/Bacterial-Chemotaxis/blob/master/img/5k_iterations.png?raw=true)
**Figure 1. Simulation results on 401x401 map** 

### Maxwell distribution-based model

Second approach relied on the curve suggested by Berg et al. on their figure 3. Data points were collected from the distribution curve. We used fitting algorithm provided to us by Prof. Robert Kuszelewicz (Paris University) to find optimal parameters for Maxwell distribution through gradient descent. Based on received parameters from fitting algorithm, we implemented a function maxwell_tumble (file: tumble_maxwell.m; Fig. 3, F) to calculate probability according to Maxwell distribution for any given angle as an input parameter.

## References
Berg H., Brown D.A., Chemotaxis in Escherichia coli analysed by three-dimensional tracking. Nature, 239. 1972
