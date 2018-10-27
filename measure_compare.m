clear 

load('cals.mat')
load('sleep.mat')
load('steps.mat')
load('Resting_HR.mat');

%%

figure; plot(length(mean_cals):-1:1,(mean_cals-nanmean(mean_cals))/nanstd(mean_cals));
hold on; plot(length(mean_RHRs):-1:1,(mean_RHRs-nanmean(mean_RHRs))/nanstd(mean_RHRs));
hold on; plot(length(mean_sleep):-1:1,(mean_sleep-nanmean(mean_sleep))/nanstd(mean_sleep));
hold on; plot(length(mean_steps):-1:1,(mean_steps-nanmean(mean_steps))/nanstd(mean_steps));
ax = gca;
ax.YRuler.Exponent = 0;

xlabel('Days before today');
ylabel('Normalized values (z-score)');
title('Kyle Measure Comparison');


hold on; line([365 365],[.5 1.5],'color','k')
hold on; line([730 730],[.5 1.5],'color','k')
legend({'Calories','Resting HR','Sleep','Steps'});
