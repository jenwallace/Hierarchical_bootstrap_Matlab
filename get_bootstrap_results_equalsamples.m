function [p_boot, bootstats, bootstats_center, bootstats_sem] = get_bootstrap_results_equalsamples(data1,data2,n_runs,num_trials,param)
%Perform hierarchical bootstrapping on a 2-level dataset with two groups to be compared following the
%method described in Saravanan et al. 2019
%data1 and data2 are the data for each group (rows = level 1, columns =
%level 2). These may have NaN in case the upper level units have different
%numbers of lower level units, but these must be at the end
%n_runs = number of bootstrap samples
%num_trials = sample size for lower level. Samples will be drawn with
%replacement from the actual data points in level 2 (NaNs will not be
%included)
%param = 'mean' or 'median'

bootstats = NaN(2,n_runs);

%Calculate bootstrapped samples:
bootstats(1,:) = get_bootstrapped_equalsamples(data1,n_runs,num_trials,param);
bootstats(2,:) = get_bootstrapped_equalsamples(data2,n_runs,num_trials,param);

%Calculate probability of bootstats2 >= bootstats1:
p_boot = get_direct_prob(bootstats(1,:),bootstats(2,:));

%Get mean and SEM of bootstrapped samples:
bootstats_sem = std(bootstats,'',2);
bootstats_center = mean(bootstats,2);
%Intentially not using nanmean here because if you get any NaNs in your bootstats, you will know that there was an issue with setting up matrices for sampling

if isnan(bootstats_center(1))||isnan(bootstats_center(2))
    disp('NaN values are messing up sampling - check matrices and try again.');
end
