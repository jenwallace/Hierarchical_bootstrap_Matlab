function [bootstats] = get_bootstrapped_equalsamples(data,nruns,num_trials,param)
%perform bootstrapping n_runs times with an equal sample size of num_trials
%at the lower level

bootstats = NaN(nruns,1);
for i =1:nruns
    a = size(data);
    num_lev1 = a(1);
    temp = NaN(num_lev1,num_trials);
    rand_lev1 = randi(num_lev1,num_lev1,1);
    for j = 1:length(rand_lev1)
        num_lev2 = find(~isnan(data(rand_lev1(j),:)),1,'last'); %We need to calculate this again here because there is a different number of trials for each neuron
        rand_lev2 = randi(num_lev2,1,num_trials); %Resample only from trials with data but same number of sample trials for all
        temp(j,:) = data(rand_lev1(j),rand_lev2);
    end
    
    %Note that there should be no nans in these measures if sampling was
    %done correctly
    if strcmp(param,'mean')
        bootstats(i) = mean(temp(:));
    elseif strcmp(param,'median')
        bootstats(i) = median(temp(:));
    else
        disp('Unknown parameter. Use mean or median or write a new one.')
        return
    end
    disp(['Sample ' num2str(i) ' completed.']);
end
end