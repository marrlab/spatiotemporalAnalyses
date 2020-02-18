%createFigure1Plots
%% Figure 1K
rng(37)
%load data
[D,NSCs,sPhase1,~,~,~]=loadData('PCNA','F:\Brains');
%create distance matrix between S-phase cells
sPhase1Ids=ismember(NSCs(:,4),1);
DsP=D(sPhase1Ids,sPhase1Ids);
%calculate discrete Ripley's K values
%K = observed K values, Krand = K values from random sampling
[K,Krand]=calculateRipleysK(NSCs, D, DsP);
%% Plot K values
r=1:150; % define time steps
K=K/10000;Krand=Krand/10000; % reduce numbers for nicer y-axis in plot.
figure('Position',[680,582,750,500]); % create figure
plot(r,K,'k','lineWidth',2); %plot observd K value
hold on;
patch([r fliplr(r)], [quantile(Krand,0.05) fliplr(quantile(Krand,0.95))],...
    [0.5,0.5,0.5],'FaceAlpha',.5,'EdgeColor','k'); % plot sampled K CIs
plot(r,mean(Krand),'k--','lineWidth',2) % plot mean of sampled K values
xlabel('Radius [\mum]','Fontsize', 24)
ylabel('Discrete Ripley''s K','Fontsize', 24)
set(gca,'FontSize',24);
legend('Observed NSCs in S-phase','Random sampling','Location','northwest');