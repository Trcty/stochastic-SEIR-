function a = SIR_rates (state, params)

n=state.S + state.I + state.R;
a(1) = params.mu * n; % host birth
a(2) = params.mu * state.S; % death of susceptible host
a(3) = params.mu * state.I; % death of infected host (unrelated to infection)
a(4) = params.mu * state.R; % death of recovered host
a(5) = params.beta * state.S * state.I/n; % infection
a(6) = params.alpha * state.I; % death due to infection
a(7) = params.gamma * state.I; % recovery
end