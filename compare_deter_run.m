% Compare deterministic solution trajectories for SEIR and SIR model

end_time=300;
trange=[0,end_time];
initial.S = 99;  % number of susceptible 
initial.I = 1;   % number of infected 
initial.R = 0;   % number of recovered 
initial.E = 0 ;  % number of exposed 
params.mu = 0.005; % natural death rate
params.beta = 0.2; % transmission rate
params.alpha = 0.01;  % death rate due to infection
params.gamma = 0.03;  % rate of recovery
params.sigma = 0.2; % inverse of latent period 
y0_SEIR=[initial.S, initial.E , initial.I , initial.R ];
 [t_seir,y_SEIR]=ode45(@(t,y)SEIR(y, params),trange,y0_SEIR);

y0_SIR=[initial.S, initial.I , initial.R ];
[t_sir,y_SIR]=ode45(@(t,y)SIR(y, params),trange,y0_SIR);

compare_models(t_seir,t_sir,y_SEIR,y_SIR);