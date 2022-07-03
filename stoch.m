function result = stoch (model, params, initial, end_time)
% Simulation of the stochastic models (SEIR OR SIR)

% input
% model: SEIR or SIR 
% params: values of parameters in model
% initial: initial value for compartment in model
% end_time: end of simulation time span starting a 0


state = initial; % holds the state variables 

result.time = []; % receives the time results
result.S = [];    % receives the S results
result.I = [];    % receives the I results
result.R = [];     % receives the R results
if(strcmp(model,'SEIR'))
    result.E = [];    % get E
end
result.extinct =0;

time = 0;
while (time < end_time && state.I > 0)
        
    % calculate process rate for current state
    if(strcmp(model,'SEIR'))
        lambs = SEIR_rates(state, params);
    else
        lambs = SIR_rates(state, params);
    end
    
    tau = exprnd(1/sum(lambs));
    time = time + tau;
    which = process(lambs);
    
    % update state
   if(strcmp(model,'SEIR'))
        switch which
            case 1
                state.S = state.S + 1;
            case 2
                state.S = state.S - 1;
            case 3
                state.I = state.I - 1;
            case 4
                state.E = state.E-1;
            case 5
                state.R = state.R - 1;
            case 6
                state.S = state.S - 1;
                state.E = state.E + 1;
            case 7
                state.E = state.E -1;
                state.I = state.I + 1;
            case 8
                state.I = state.I - 1;
                state.R = state.R + 1;
            case 9
                state.I = state.I - 1;
        end
   else
        switch which
            case 1
                state.S = state.S + 1;
            case 2
                state.S = state.S - 1;
            case 3
                state.I = state.I - 1;
            case 4
                state.R = state.R - 1;
            case 5
                state.S = state.S - 1;
                state.I = state.I + 1;
            case 6
                state.I = state.I - 1;
            case 7
                state.I = state.I - 1;
                state.R = state.R + 1;
        end

   end

    
    % store results
    result.time = [result.time time];
    result.S = [result.S state.S];
    result.I = [result.I state.I];
    result.R = [result.R state.R];
    if(strcmp(model,'SEIR'))
         result.E = [result.E state.E];
    end
 
    
end

if(sum(result.I==0)>0)
    result.extinct =1;
end

end

