function [result,processed_result,prob_extinction]=simulation(model,params, initial,end_time,run_count,running_average,plot)
% input
% model: SEIR or SIR 
% params: values of parameters in model
% initial: initial value for compartment in model
% end_time: end of simulation time span starting a 0
% run_count: number of runs of stochastic model simulation
% running_average: number of samples in the average, larger values
%   indicates smoother graph
% plot: plot stochastic solution or deterministic solution or both or no
%   plot (stochastic, deterministic, both)

% output
% result:  outcomes from all simulations at each time step
% processed_result: processed result arrays and time steps using running_average
% prob_extinction: proportion of simulations that epidemic reaches extinction

result.time = []; 
result.S = [];    
result.I = [];   
result.R = [];
if(strcmp(model,'SEIR'))
    result.E = [];
end


extinction=0;

% simulate several stochastic SIR models and collect all outcomes and get
% times of extinction among all simulations
for n=1:run_count

    out = stoch (model,params, initial, end_time);
    result.time = [result.time out.time];
    result.S = [result.S out.S];
    result.I = [result.I out.I];
    result.R = [result.R out.R];
    if(strcmp(model,'SEIR'))
        result.E = [result.E out.E];
    end

    extinction=extinction+out.extinct;
end

% extract unique times and the corresponding data
[time, m, ~] = unique(result.time);
S = result.S(m);
I = result.I(m);
R = result.R(m);
if(strcmp(model,'SEIR'))
    E = result.E(m);
end

% calculate running averages
N = running_average; 
j = 1;


for i=1:N:length(time)-N+1
    meanTime(j) = mean(time(i:i+N-1));
    meanS(j) = mean(S(i:i+N-1));
    meanI(j) = mean(I(i:i+N-1));
    meanR(j) = mean(R(i:i+N-1));
    if(strcmp(model,'SEIR'))
        meanE(j) = mean(E(i:i+N-1));
    end
  
    j = j + 1;
end

if(strcmp(model,'SEIR'))
    processed_result=transpose([meanS;meanE;meanI;meanR;meanTime]);
else
    processed_result=transpose([meanS;meanI;meanR;meanTime]);

end
  
dim=size(processed_result);
prob_extinction=extinction/run_count;

% get deterministic solution 
if(strcmp(plot,'no'))
else
    trange=[0,end_time];
    if(strcmp(model,'SEIR'))
        y0=[initial.S, initial.E , initial.I , initial.R ];
        [t,y]=ode45(@(t,y)SEIR(y, params),trange,y0);
    else
        y0=[initial.S, initial.I , initial.R ];
        [t,y]=ode45(@(t,y)SIR(y, params),trange,y0);
    end  
end

% plot stochastic simulation or corresponding deterministic solution  trajectory or both
if(strcmp(plot,'stochastic'))
    plot_model(model,processed_result(:,dim(2)),processed_result(:,1:dim(2)),plot,t,y);
elseif(strcmp(plot,'deterministic'))
    plot_model(model,t,y,plot,t,y);
elseif(strcmp(plot,'both'))
    plot_model(model,processed_result(:,dim(2)),processed_result(:,1:dim(2)),plot,t,y)
end



end
