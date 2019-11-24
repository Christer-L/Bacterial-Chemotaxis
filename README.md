# Bacterial-Chemotaxis (Biomedical Modelling, 2019)

Run and tumble numerical models simulate bacterial motion, and interaction with environment. Here we built a model based on Berg and Brown work published in 1972. In this article, they demonstrated particular behavior of Escherichia Coli regarding randomness in linear displacement length (called run phase) and in motion direction (a new angular orientation chosen in tumble phase). According to their results, run length was influenced by nutrients concentration in environment, as they observed the impact of Serine and Aspartate to different types of E coli.

Our model simulates Serine gradient and its effect on bacterium behaviour. We developed two approaches to simulate change of angle in tumble process by utilizing data from article by Berg and Brown. Additionally, Gamma distribution-based model for run behaviour is demonstrated and tested in different conditions. We confirm that numerical models can be used to analyze stochastic processes in bacterium movement and provide a framework for simulating bacterium behaviour. Therefore new submodels can be created as further development and applied in combination with functionalities built in this project.

## Model framework: environment and agents

Simulation environment (file: environment.m; Fig.1, A), and agent function (file: agent.m; Fig.1, B) were designed to allow flexible application of different submodels for bacterium run and tumble behaviour. Model functionalities are segmented into functions that can be used as input parameters for submodules part of the main framework (Fig. 1, marked in yellow). Given approach reduces interdependency between model components and simplifies further development of additional submodels responsible for gradient, run and tumble functionalities (Fig 1, marked in green).

![](https://github.com/Christer-L/Bacterial-Chemotaxis/blob/master/img/5k_iterations.png?raw=true)


![](https://github.com/Christer-L/Bacterial-Chemotaxis/blob/master/img/5k_iterations.png?raw=true)
**Figure 1. Simulation results on 401x401 map** 
