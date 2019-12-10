function [medians] = scatterbargraph2_withcolor_median(group1,group2,cmp)

%xvalues = vertcat(repmat(1,length(group1),1), repmat(2,length(group2),1));
medians = [nanmedian(group1) nanmedian(group2)];
%sem = [nanstd(group1)/sum(~isnan(group1)) nanstd(group2)/sum(~isnan(group2))];
superbar([1 2],medians,'BarFaceColor', [1 1 1], 'BarEdgeColor', cmp)
plotSpread({group1 group2},'distributionMarkers','o','distributionColors',cmp);
f = findall(gca,'type','line');
% f(1).MarkerSize = 4;
% f(2).MarkerSize = 4;



end