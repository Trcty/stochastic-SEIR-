function dydt=SIR(y, params)

    s=y(1);
    i=y(2);
    r=y(3);
    n=s+r+i;
    dsdt= params.mu*n- params.mu*s-params.beta*s*i/n;
    didt= params.beta*s*i/n-(params.mu+params.gamma+params.alpha)*i;
    drdt=params.gamma*i-params.mu*r;
    dydt=[dsdt;didt;drdt];

end