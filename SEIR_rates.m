function a = SEIR_rates (state, params)

n=state.S + state.I + state.R+ state.E;
a(1) = params.mu * n; %  birth
a(2) = params.mu * state.S; % death of susceptible host
a(3) = params.mu * state.I; % death of infected host (unrelated to infection)
a(4) = params.mu * state.E; % death of exposed 
a(5) = params.mu * state.R; % death of recovered
a(6) = params.beta * state.S * state.I/n; % exposure
a(7) = params.sigma * state.E; %  infection
a(8) = params.gamma * state.I; % recovery
a(9) = params.alpha * state.I; % death due to infection
end