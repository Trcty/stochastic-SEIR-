function extinction_simulation(model,params,initial,n_betas,end_time,run_count,running_average)
% Simulate extinction for stochastic models

% input
% model: SEIR or SIR or both
% params: values of parameters in model
% initial: initial value for compartment in model
% n_betas: number of betas used to generate corresponding R0
% end_time: end of simulation time span starting a 0
% run_count: number of runs of stochastic model simulation
% running_average: number of samples in the average, larger values indicates smoother graph


betas=linspace(0,0.5,n_betas);
r0s=zeros(1,n_betas);
probs=zeros(1,n_betas);

if(strcmp(model,'SEIR'))
    for i=1:n_betas
        params.beta=betas(i);
        R0=params.sigma*params.beta/(params.sigma+params.mu)/(params.gamma+params.mu+params.alpha);
        [~,~, prob_extinction]=simulation('SEIR',params, initial,end_time,run_count,running_average,'no');
        r0s(i)=R0;
        probs(i)=prob_extinction;
    end
        
elseif(strcmp(model,'SIR'))
    for i= 1:n_betas
        params.beta=betas(i);
        R0=params.beta/(params.mu+params.alpha+params.gamma);
        [~,~, prob_extinction]=simulation('SIR',params, initial,end_time,run_count,running_average,'no');
        r0s(i)=R0;
        probs(i)=prob_extinction;
    end
       
else
    r0s_sir=zeros(1,n_betas);
    probs_sir=zeros(1,n_betas);
    for i=1:n_betas
        params.beta=betas(i);
        R0=params.sigma*params.beta/(params.sigma+params.mu)/(params.gamma+params.mu+params.alpha);
        R0_sir=params.beta/(params.mu+params.alpha+params.gamma);
        [~,~, prob_extinction]=simulation('SEIR',params, initial,end_time,run_count,running_average,'no');
        [~,~, prob_extinction_SIR]=simulation('SIR',params, initial,end_time,run_count,running_average,'no');
        r0s(i)=R0;
        r0s_sir(i)=R0_sir;
        probs(i)=prob_extinction;
        probs_sir(i)=prob_extinction_SIR;
    end
end

plot(r0s,probs,'LineWidth',1.2);

if(strcmp(model,'both'))
    hold on ;
    plot(r0s_sir,probs_sir,'LineWidth',1.2)
    hold off;
    legend('SEIR','SIR','FontSize',12);
else
    legend(model,'FontSize',12);
end

xlabel('R0');
ylabel('probability of extinction');

end