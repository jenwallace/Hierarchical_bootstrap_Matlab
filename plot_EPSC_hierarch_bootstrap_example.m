%Demonstrates 3 ways of plotting and statistical testing for hierarchical
%data comparing 2 groups (100s-1000s of EPSCs recorded from ~30 neurons):
%the cumulative probability distribution, summarized distribution, and the
%hierarchical boostrap distribution

%Load the data
%Each row is one neuron and each column is the amplitude of one EPSC
folder = 'D:\Dropbox (Murthy Lab)\Jenelle\Electrophysiology Matlab analysis\';
load([folder 'group1.mat']);
load([folder 'group2.mat']);

%General constants
group_names = {'Ctrl','Drug'};
cmp = [0.713725490196078,0.427450980392157,1;1,0.600000000000000,0];
cmp_dark = [0.356862745098039,0.213725490196078,0.500000000000000;0.500000000000000,0.300000000000000,0];
gap = [0.1 0.1];
marg = [0.1 0.1];
%Bootstrap constants
num_reps = 1000;
num_epscs = 5000;
param = 'median';
max_events = 10000;

%Cumulative prob of all EPSCs from all cells
figure; hold on;
ax = subtightplot(1,3,1,gap,marg,marg); hold on;
make_cdf_plot(group1(:),cmp(1,:));
make_cdf_plot(group2(:),cmp(2,:));
legend(group_names)
make_plot_pretty(gcf,gca,'All','Amplitude (pA)','Cumulative probability','','',0)
title(''); yticks([0 0.2 0.4 0.6 0.8 1]); xlim([0 200]);
ax.FontSize = 11;
[~,p_dist,~] = kstest2(group1(:),group2(:));

%Median per cell
ax_2 = subtightplot(1,3,2,gap, marg,marg);
scatterbargraph2_withcolor_median(nanmedian(group1,2),nanmedian(group2,2),cmp);
make_plot_pretty(gcf,gca,'All','','Amplitude (pA)','','',0);xticklabels('');xlim([0.5 2.5]);ylim([0 25]);
[p_summary,~,stats] = ranksum(nanmedian(group1,2),nanmedian(group2,2)); z_amp = stats.zval;
ax_2.FontSize = 11;

%Hierarch bootstrap
ax_3 = subtightplot(1,3,3,gap, marg, marg); hold on;
[p_boot_amp, bootstats_amp,bootstats_median_amp, bootstats_sem_amp] = get_bootstrap_results_equalsamples(group1,group2,num_reps,num_epscs,param);
median_amp = NaN(2,1);
for i = 1:2
    h = histogram(bootstats_amp(i,:),'Normalization','probability','FaceColor',cmp(i,:),'EdgeColor','none');
    median_amp(i) = median(bootstats_median_amp(i));
    line([median_amp(i) median_amp(i)],[0 max(h.Values)],'Color',cmp_dark(i,:),'LineWidth',2); %have to use line instead of plot with hist
end
xlabel('Amplitude');
ylabel('Probability');
ax_3.FontSize = 11;