function compare_models(t_seir,t_sir, y_seir,y_sir)
% Compare stochastic simulation trajectories for SEIR and SIR model.


plot(t_seir, y_seir(:,1),'b','LineWidth',1.3)
hold on
plot(t_seir, y_seir(:,2), 'm','LineWidth',1.3);
plot(t_seir,y_seir(:,3),'r','LineWidth',1.3);
plot(t_seir,y_seir(:,4),'k','LineWidth',1.3);

plot(t_sir, y_sir(:,1),'b','LineWidth',0.3)
plot(t_sir, y_sir(:,2), 'r','LineWidth',0.3);
plot(t_sir,y_sir(:,3),'k','LineWidth',0.3);

hold off
xlabel('Time','FontSize',16);
ylabel('Size','FontSize',16);
legend('susceptible-SEIR','exposed-SEIR','infectious-SEIR','recovered-SEIR','susceptible-SIR','infectious-SIR','recovered-SIR','FontSize',12);

end