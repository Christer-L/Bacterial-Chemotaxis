# Modelling bacterial chemotaxis (Biomedical Modelling, 2019)

**Authors:** Christer LOHK & Emmanuelle RENOUL

Run and tumble numerical models simulate bacterial motion, and interaction with environment. Here we built a model based on Berg and Brown work published in 1972. In this article, they demonstrated particular behavior of Escherichia Coli regarding randomness in linear displacement length (called run phase) and in motion direction (a new angular orientation chosen in tumble phase). According to their results, run length was influenced by nutrients concentration in environment, as they observed the impact of Serine and Aspartate to different strains of E coli.

Our model simulates Serine gradient and its effect on bacterium behaviour. We developed two approaches to simulate change of angle in tumble process by utilizing data from article by Berg and Brown. Additionally, Gamma distribution-based model for run behaviour is demonstrated and tested in different conditions. We confirm that numerical models can be used to analyze stochastic processes in bacterium movement and provide a framework for simulating bacterium behaviour. Therefore new submodels can be created as further development and applied in combination with functionalities built in this project.

## Model framework: environment and agents

Simulation environment (**file: environment.m; Fig.1, A**), and agent function (**file: agent.m; Fig.1, B**) were designed to allow flexible application of different submodels for bacterium run and tumble behaviour. Model functionalities are segmented into functions that can be used as input parameters for submodules part of the main framework (**Fig. 1, marked in yellow**). Given approach reduces interdependency between model components and simplifies further development of additional submodels responsible for gradient, run and tumble functionalities (**Fig 1, marked in green**).

![](https://github.com/Christer-L/Bacterial-Chemotaxis/blob/master/img/dependencies.png?raw=true)
**Figure 1. Modular dependencies**

## Environment

Environment submodule is responsible for the initiation of simulation environment and agents. First, concmap function (**file: concmap.m; Fig. 1, C**) is called out to generate Serine gradient matrix with p[Ser] values (p[Ser] as log10 of Serine concentration). Concmap needs to be provided with a function responsible for generating a normalized gradient map (with values in range between 0 and 1). For following experiments, we designed a normgrad function (**file: normgrad.m, Fig. 1, D**), which generates circular gradient originating from the middle of the map. Additional gradient submodules can be implemented by following the design pattern of normgrad.
After gradient setup, agents are initiated to provide environment submodule a trajectory plot. When agents have finished simulating the motion of bacteria, a figure is presented where all trajectories are plotted on the gradient to better visualize the relationship between agent behaviour and environment.

## Agent

Agent is a function/submodule responsible for simulating the behaviour of bacterium with provided concentration map and submodels for run and tumble. Additionally, amount of iterations is taken as a parameter. Agent utilizes tumble after every run to change the angle of movement. Run termination or continuation is determined through run submodel by providing it information about concentration and run length in progress.

## Models for bacterium tumble

First, we implemented two potential models for tumble angle generation that could be used in combination with other functionalities to simulate the behaviour of bacterium. Two types of approaches were applied to develop a model capable of describing change in angle of the movement during tumble process.

### Beta distribution-based model

In first case, we relied on experimental data provided by Berg et al., to develop a Beta distribution-based model. We collected data points from Figure 3 (Berg et al.) describing amounts of tumbles ending with different change in angles (summed into 18 intervals, **Fig 2. A**) with a goal to construct a Cumulative Density Function (**CDF**) describing probability for a tumble change of angle to be smaller than given angle in range of 0 to 180 degrees (**Fig. 2, B**). Brute force approach was implemented in curve fitting to find optimal parameters for Beta distribution (**Figure 2. C**). We took a step of 0.1 in a region of 0 to 10 for both a and b to test out the fit for different curves by applying least squares function. Fitting of Beta distribution was carried out in local Jupyter Notebook using Python with scipy, numpy and matplotlib packages.


![](https://github.com/Christer-L/Bacterial-Chemotaxis/blob/master/img/curve_fitting.png?raw=true)
**Figure 2. Curve fitting |** (**A**) Probability mass function of experimental data. (**B**) Cumulative density function of based on PMF of experimental data. (**C**) Comparison of CDF from live experiment and generated Beta function distribution.  

Using received parameters from fitting we implemented a function tumble (**file: tumble.m; Fig. 3, E**) for generating random angle values for tumble process. In given function betainv method from statistics package is utilized to map Beta distributed angles back from uniform random distribution.

### Maxwell distribution-based model

Second approach relied on the curve suggested by Berg et al. on their figure 3. Data points were collected from the distribution curve. We used fitting algorithm provided to us by Prof. Robert Kuszelewicz to find optimal parameters for Maxwell distribution through gradient descent. Based on received parameters from fitting algorithm, we implemented a function maxwell_tumble (**file: tumble_maxwell.m; Fig. 3, F**) to calculate probability according to Maxwell distribution for any given angle as an input parameter.

## Models for bacterium run
In our approach, run functions are designed to return boolean value, which lets agent know if it should stop the run currently in process or continue moving forward for one more time step. Information required for decision-making is provided to the run models by agent implementing the function.

### Simplified model

Simplified model simple_run (**file: simple_run.m; Fig. 3G**) requires only one input parameter: boolean, which is true if next step is towards higher concentration and false when towards lower concentration. No information about the length of run in process is required. If moving forward would result in environment with higher food concentration then bacterium has 80% probability to continue run. When the next step is towards lower concentration, only 50% chance is given for continuation.

### Gamma distribution-based concentration dependent model

Gamma distribution based model gamrun (**file: gamrun.m; Fig 3, H**) applies distribution adopted from Figure 5. of Berg et al. to change the mean of run continuation probability according to the Serine concentration. In addition to the gradient direction parameter mentioned in simplified model, given function requires length of run in progress and concentration in current bacterium location. Termination or continuation of run is determined by the CDF of Gamma distribution. 

When developing a model for bacterium run, we had to take under consideration its dependence on nutrient concentration. Berg et al. describe in their article how the mean run length changes in relation to the change in concentration (**Fig. 3**). Change function (**file: gamrun.m; Fig 3, I**) is used to modify Gamma distribution k-value, which allows shifting the mean according to the Figure 5 in Berg et al.



## Results

### Comparison of tumble models and experimental data
A simulation inspired by the experiment described in figure 3 from Berg et al. was carried out to study the behaviour of models (tumble and maxwell_tumble) for 1166 tumble events. For both models, output angles were summed into 18 intervals and compared with experimental data (See Supplementary Fig. 1)

Beta distribution-based model resulted in a mean and standard deviation of 66.02 ± 34.92 degrees and Maxwell-based model in 61.89 ± 25.27 degrees. It is important to bring out that Beta-based model was fitted to experimental data points (mean and standard deviation 68 ± 36 degrees; Berg et al., Table 1) and Maxwell-based statistical model to distribution suggested by Berg et al (mean and standard deviation 62 ± 26 degrees; Berg et al., Fig 3).

### Comparison of agents with different submodels for tumble and run

Run and tumble models were compared in simulation on circular Serine gradient. Two run models (Gamma and Simple) and two tumble models (Maxwell and Beta) were combined to set up 4 different agents: Beta-Simple (BS), Beta-Gamma (BG), Maxwell-Simple (MS) and Maxwell- Gamma (MG).

In first experiment, agents were placed in the right corner of the 4001x4001 sized gradient map (coordinates: X, Y = 200). Their movement was simulated for 50 000 iterations (5 000 seconds) each. First initiation resulted an agent exiting bounds coordinates. Simulation was terminated and started over. Second run of simulation gave results for all agents (Fig 6). For every agent position in time, concentration was measured on its location to see in which concentration regions agents spend most time (Fig. 8).

Second experiment was carried out on smaller 2001x2001 map with agents BG and MG. Iterations were reduced to 5000. Starting location was same for both agents and uniformly randomized. Two tests out of five ended up with termination due to out of bounds error. For three times concentrations were recorded for every position in time (Table 1; Fig. 7).

![](https://github.com/Christer-L/Bacterial-Chemotaxis/blob/master/img/5k_iterations.png?raw=true)
**Figure 1. Simulation results on 401x401 map** 


## References
Berg H., Brown D.A., Chemotaxis in Escherichia coli analysed by three-dimensional tracking. Nature, 239. 1972
