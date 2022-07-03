function plot_model(model,t, y,kind, t_det,y_det)
% model: SEIR or SIR
% t: time interval
% y: solutions of model at each t
% kind: deterministic , stochastic or both plotted on the same graph
% t_det: time interval for deterministic model
% y_det: solutions of deterministic model at each t

if(strcmp(model,'SEIR'))
   plot(t, y(:,1),'b','LineWidth',1.3)
   hold on
   plot(t, y(:,2), 'm','LineWidth',1.3);
   plot(t,y(:,3),'r','LineWidth',1.3);
   plot(t,y(:,4),'k','LineWidth',1.3);
   if(strcmp(kind,'both')) % plot deterministic solution
       plot(t_det, y_det(:,1),'--b','LineWidth',1)
       plot(t_det, y_det(:,2), '--m','LineWidth',1);
       plot(t_det,y_det(:,3),'--r','LineWidth',1);
       plot(t_det,y_det(:,4),'--k','LineWidth',1);
       hold off;
       legend('susceptible-stoch','exposed-stoch','infectious-stoch','recovered-stoch', ...
           ...
           'susceptible-det','exposed-det','infectious-det','recovered-det','FontSize',10);
   else
       legend('susceptible','exposed','infectious','recovered','FontSize',12);
   end
   hold off
   xlabel('Time','FontSize',16);
   ylabel('Size','FontSize',16);
   
else
   plot(t, y(:,1),'b','LineWidth',1.3)
   hold on
   plot(t,y(:,2),'r','LineWidth',1.3);
   plot(t,y(:,3),'k','LineWidth',1.3);
   if(strcmp(kind,'both'))
       plot(t_det, y_det(:,1),'--b','LineWidth',1)
       plot(t_det,y_det(:,2),'--r','LineWidth',1);
       plot(t_det,y_det(:,3),'--k','LineWidth',1);
       hold off;
       legend('susceptible-stoch','infectious-stoch','recovered-stoch', ...
           ...
           'susceptible-det','infectious-det','recovered-det','FontSize',10);
   else
       legend('susceptible','infectious','recovered','FontSize',12);
   end

   hold off
   xlabel('Time','FontSize',16);
   ylabel('Size','FontSize',16);
   
end


end