function dydt=SEIR(y, params)

    s=y(1);
    e=y(2);
    i=y(3);
    r=y(4);
    n=s+e+r+i;
    dsdt= params.mu*n- params.mu*s-params.beta*s*i/n;
    dedt= params.beta*s*i/n-(params.mu+params.sigma)*e;
    didt= params.sigma*e-(params.mu+params.gamma+params.alpha)*i;
    drdt=params.gamma*i-params.mu*r;
    dydt=[dsdt;dedt;didt;drdt];

end