clear variables;
rng(3);

params.mu = 0.005; % natural death rate
params.beta = 0.2; % transmission rate
params.alpha = 0.01;  % death rate due to infection
params.gamma = 0.03;  % rate of recovery
params.sigma = 0.2; % inverse of latent period 


initial.S = 99;  % number of susceptible 
initial.I = 1;   % number of infected 
initial.R = 0;   % number of recovered 
initial.E = 0 ;  % number of exposed 

end_time = 300;  % end of simulation time span starting a 0
run_count = 1; % number of runs of stochastic simulation
running_average=1; % number of samples in the average

model='SEIR';


% simulate extinction for stochastic models
%extinction_simulation(model, params,initial,10,end_time,run_count,running_average)

figure(1);
[result,processed_result, prob_extinction]=simulation(model,params, initial,end_time,run_count,running_average,'both');
figure(2);
[result_sir,processed_result_sir, prob_extinction_sir]=simulation('SIR',params, initial,end_time,run_count,running_average,'both');






% basic reproduction number
%R0=params.sigma*params.beta/(params.sigma+params.mu)/(params.gamma+params.mu+params.alpha);




figure(3);
compare_models(processed_result(:,5),processed_result_sir(:,4),processed_result(:,1:4),processed_result_sir(:,1:4));


% fprintf('prob of extinction: %f\n',prob_extinction)



